Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3D548C4F0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353638AbiALNgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:36:06 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5826 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240715AbiALNf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641994556; x=1673530556;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=K4rrwv6mpFxo7bA4XMu6Y2QERsiVNIVMJqQ+UwJxNsc=;
  b=Askv4qTKB8j3DR/jcSsxClbtX6IBk89AD+BVLyBBZOQcdVjoA5YR0CY7
   vN+eWG2sgRmR8BN07ImRcWas51iwSZHiCqEeiXjhxBgetNnYKu5H4nlbT
   59HZWr8mm/1yBdcDKHZ+z+g1wMDFXFGowaRwdxaCt24J3F5fvuthsvNqE
   U=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 12 Jan 2022 05:35:55 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:35:55 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 05:35:55 -0800
Received: from [10.216.41.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 12 Jan
 2022 05:35:50 -0800
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
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <eb056201-a6e2-a58e-dd77-666f124d1896@quicinc.com>
Date:   Wed, 12 Jan 2022 19:05:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yd7VZId4IlKd4VpC@casper.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Matthew for the review.

On 1/12/2022 6:49 PM, Matthew Wilcox wrote:
> On Wed, Jan 12, 2022 at 01:51:55PM +0530, Charan Teja Kalla wrote:
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
> 
> Yes.  This should obviously be an xa_for_each() loop.
> 

ACK.

>>> Since every value entry found in the xarray requires me to do the
>>> xas_pause(), I do agree that xa_for_each() is the appropriate call here.
>>> Will switch to this in the next spin. Waiting for further review
>>> comments on this patch.
>>
>> I also found the below documentation:
>> xa_for_each() will spin if it hits a retry entry; if you intend to see
>> retry entries, you should use the xas_for_each() iterator instead.
>>
>> Since retry entries are expected, I should be using the xas_for_each()
>> with the corrections you had pointed out. Isn't it?
> 
> No.  You aren't handling retry entries at all; you clearly don't
> expect to see them.  Just let the XArray code handle them itself.

ACK.

> 
