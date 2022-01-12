Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9135C48BFC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351547AbiALIWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 03:22:15 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:65007 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237658AbiALIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 03:22:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641975732; x=1673511732;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=e4PH/8pPaWkVSx9l4GBMokP5iB38ZSbAguBHf53RKXM=;
  b=VVlMaNXQqQbMpgSa3HkEzQ8Pr6C/eeIjUiU3kslpAOK30q48oF4sFdNn
   YHXbLuR5rJHrK9guALuI/ahNgHjyemYBbijuYxWW6kxJJINdixBnbVUbe
   ONJpS2c969FUNj8M4qC1WOFjljo5M//3zxLAFxn27q/NDJiHK1rLacR9L
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Jan 2022 00:22:12 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 00:22:04 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 00:22:03 -0800
Received: from [10.216.41.197] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 12 Jan
 2022 00:21:59 -0800
Subject: Re: [PATCH v3 RESEND] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
To:     Mark Hemment <markhemm@googlemail.com>
CC:     <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>, <vbabka@suse.cz>,
        <rientjes@google.com>, <mhocko@suse.com>, <surenb@google.com>,
        <shakeelb@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Charan Teja Reddy <charante@codeaurora.org>
References: <1641488717-13865-1-git-send-email-quic_charante@quicinc.com>
 <CANe_+UipVZRZeWqzXezacPaVb9UeC6a_ZhQp8GkrvftbRktotg@mail.gmail.com>
 <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
Message-ID: <61212ffd-3505-04d7-5403-932a10d676e7@quicinc.com>
Date:   Wed, 12 Jan 2022 13:51:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2c66ba2e-1c65-3bdd-b91e-eb8391ec6dbf@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On 1/10/2022 3:51 PM, Charan Teja Kalla wrote:
>>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>>> +                                pgoff_t start, pgoff_t long end)
>>> +{
>>> +       XA_STATE(xas, &mapping->i_pages, start);
>>> +       struct page *page;
>>> +
>>> +       rcu_read_lock();
>>> +       xas_for_each(&xas, page, end) {
>>> +               if (!xa_is_value(page))
>>> +                       continue;
>>> +               xas_pause(&xas);
>>> +               rcu_read_unlock();
>>> +
>>> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
>>> +               if (!IS_ERR(page))
>>> +                       put_page(page);
>>> +
>>> +               rcu_read_lock();
>>> +               if (need_resched()) {
>>> +                       xas_pause(&xas);
>>> +                       cond_resched_rcu();
>>> +               }
>>> +       }
>>> +       rcu_read_unlock();
>>> +
>>> +       return 0;
>> I have a doubt on referencing xa_index after calling xas_pause().
>> xas_pause() walks xa_index forward, so will not be the value expected
>> for the current page.
> Agree here. I should have the better test case to verify my changes.
> 
>> Also, not necessary to re-call xas_pause() before cond_resched (it is
>> a no-op).
> In the event when CONFIG_DEBUG_ATOMIC_SLEEP is enabled users may still
> need to call the xas_pause(), as we are dropping the rcu lock. NO?
> 
> static inline void cond_resched_rcu(void)
> {
> #if defined(CONFIG_DEBUG_ATOMIC_SLEEP) || !defined(CONFIG_PREEMPT_RCU)
>         rcu_read_unlock();
>         cond_resched();
>         rcu_read_lock();
> #endif
> }
> 
>> Would be better to check need_resched() before
>> rcu_read_lock().
> Okay, I can directly use cond_resched() if used before rcu_read_lock().
> 
>> As this loop may call xas_pause() for most iterations, should consider
>> using xa_for_each() instead (I *think* - still getting up to speed
>> with XArray).
> Even the xarray documentation says that: If most entries found during a
> walk require you to call xas_pause(), the xa_for_each() iterator may be
> more appropriate.
> 
> Since every value entry found in the xarray requires me to do the
> xas_pause(), I do agree that xa_for_each() is the appropriate call here.
> Will switch to this in the next spin. Waiting for further review
> comments on this patch.

I also found the below documentation:
xa_for_each() will spin if it hits a retry entry; if you intend to see
retry entries, you should use the xas_for_each() iterator instead.

Since retry entries are expected, I should be using the xas_for_each()
with the corrections you had pointed out. Isn't it?

> 
