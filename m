Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95C14492503
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 12:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240334AbiARLfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 06:35:50 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:33731 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234332AbiARLft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 06:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642505749; x=1674041749;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Cy0koQENvuH2stwxfYpHpozbkdaaMyCBsaJF92/LpXA=;
  b=bDvLPAyuo2b9v/TtdAKuz3iuvH0D6Ei5DpbbFGj6+XokWxF+CS5bFWW2
   wUdnx2cO2iNlTMZccqkls4q7dBD6ypEb3O87g6u1ir/bAl8FpKoNtvjqg
   2uRaKg6gVnEqOk+lROOJ4bCHYgEotlbT7SN3+fjfRG6WcNOIY3ZTWuwXB
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Jan 2022 03:35:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 03:35:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 18 Jan 2022 03:35:48 -0800
Received: from [10.216.58.242] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Tue, 18 Jan
 2022 03:35:44 -0800
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Matthew Wilcox <willy@infradead.org>
CC:     Mark Hemment <markhemm@googlemail.com>, <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, <vbabka@suse.cz>,
        <rientjes@google.com>, <mhocko@suse.com>, <surenb@google.com>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <charante@codeaurora.org>
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
 <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com>
 <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
 <Yd7VZId4IlKd4VpC@casper.infradead.org>
 <eb056201-a6e2-a58e-dd77-666f124d1896@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <a31bdd1a-0fd8-7303-dc97-a2cf156f1d83@quicinc.com>
Date:   Tue, 18 Jan 2022 17:05:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <eb056201-a6e2-a58e-dd77-666f124d1896@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Matthew,

On 1/12/2022 7:05 PM, Charan Teja Kalla wrote:
>>>>> +       rcu_read_lock();
>>>>> +       xas_for_each(&xas, page, end) {
>>>>> +               if (!xa_is_value(page))
>>>>> +                       continue;
>>>>> +               xas_pause(&xas);
>>>>> +               rcu_read_unlock();
>>>>> +
>>>>> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
>>>>> +               if (!IS_ERR(page))
>>>>> +                       put_page(page);
>>>>> +
>>>>> +               rcu_read_lock();
>>>>> +               if (need_resched()) {
>>>>> +                       xas_pause(&xas);
>>>>> +                       cond_resched_rcu();
>>>>> +               }
>>>>> +       }
>>>>> +       rcu_read_unlock();
>>> Even the xarray documentation says that: If most entries found during a
>>> walk require you to call xas_pause(), the xa_for_each() iterator may be
>>> more appropriate.
> Yes.  This should obviously be an xa_for_each() loop.

In one of your patch[1], where we used xarray iterator, though most of
the entries found requires to call xas_pause() but still endup in using
xas_for_each() rather than xa_for_each(). Then, Should this code be
changed to use xa_for_each()? The documentation also says that "The
xas_for_each() iterator will expand into more inline code than
xa_for_each()."

[1]https://patchwork.kernel.org/project/linux-mm/patch/20200819184850.24779-4-willy@infradead.org/
