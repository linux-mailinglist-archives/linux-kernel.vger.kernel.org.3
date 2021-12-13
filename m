Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1E6472343
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbhLMIzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:55:39 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:24959 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229744AbhLMIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639385738; x=1670921738;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject;
  bh=7ng0ul4ZPZ3GB01PCjM9CeJTy4gZviUtrowiIz7woak=;
  b=SThzxoUNQoVCQ8LGo15JAd4jrbQvgDWtv8v+oQdmiaVMr1oYygAyeY0N
   aLgMbWxg+Mi4a9JLtVWddv+L1WIdBerHAK6P5N/z3PrKkMzgNYTvFLQsY
   pGXCCNvs+2LhY1EIHjBdc1n3ITqJQtOMjg+48nkFMHdE5tsuWxlCfBNTG
   Y=;
Subject: Re: [PATCH v2] rcu/nocb: Handle concurrent nocb kthreads creation
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Dec 2021 00:55:37 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 00:55:36 -0800
Received: from [10.216.8.35] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 13 Dec
 2021 00:55:33 -0800
Message-ID: <601ecb12-ae2e-9608-7127-c2cddc8038a6@quicinc.com>
Date:   Mon, 13 Dec 2021 14:25:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>, <paulmck@kernel.org>,
        <frederic@kernel.org>, <josh@joshtriplett.org>,
        <rostedt@goodmis.org>, <mathieu.desnoyers@efficios.com>,
        <jiangshanlai@gmail.com>, <joel@joelfernandes.org>
CC:     <rcu@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <urezki@gmail.com>, <boqun.feng@gmail.com>
References: <20211211170139.27711-1-quic_neeraju@quicinc.com>
 <6c184b9ffc5c641736d53bb7598f814d6b4c3fe0.camel@infradead.org>
From:   Neeraj Upadhyay <quic_neeraju@quicinc.com>
In-Reply-To: <6c184b9ffc5c641736d53bb7598f814d6b4c3fe0.camel@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for the review; some replies inline.

On 12/13/2021 1:48 PM, David Woodhouse wrote:
> On Sat, 2021-12-11 at 22:31 +0530, Neeraj Upadhyay wrote:
>> When multiple CPUs in the same nocb gp/cb group concurrently
>> come online, they might try to concurrently create the same
>> rcuog kthread. Fix this by using nocb gp CPU's spawn mutex to
>> provide mutual exclusion for the rcuog kthread creation code.
>>
>> Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
>> ---
>> Change in v2:
>>   Fix missing mutex_unlock in nocb gp kthread creation err path.
> 
> I think this ends up being not strictly necessary in the short term too
> because we aren't currently planning to run rcutree_prepare_cpu()
> concurrently anyway. But harmless and worth fixing in the longer term.
> 
> Although, if I've already added a mutex for adding the boost thread,
> could we manage to use the *same* mutex instead of adding another one?
> 

Let me think about it; the nocb-gp and nocb-cb kthreads are grouped 
based on rcu_nocb_gp_stride; whereas, boost kthreads are per rnp. So, I 
need to see how we can use a common mutex for both.


> Acked-by: David Woodhouse <dwmw@amazon.co.uk>
> +                       mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
>>                          return;
>> +               }
>>                  WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
>>          }
>> +        mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
>>
>>          /* Spawn the kthread for this CPU. */
> 
> Some whitespace damage there.

Will fix in next version.

Thanks
Neeraj

> 
