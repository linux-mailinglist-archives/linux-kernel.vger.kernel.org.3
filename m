Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D89495BCE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbiAUIWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:22:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33800 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbiAUIWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642753329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D9mdAv+RGyUKYnJ0+MKBg/z6MNrIHJ34Co79nofBzHk=;
        b=b03gPrHMb8CPW5we4tstdp1WnQx3u0pCgzpBF01Jy9RXZchHf9sM6Lk46RSyHw8ISq29k9
        D2NAx5MFJ1gTDOswEOeA8u8V4kREXtW7llIFPe83uCf53jE81aDIqKK9TfqdaWRK1x/6bd
        3HpFtF1VQAueWLdnFtdNQYTs5MLNaSY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-7rgy0Bb9PBSf8PTIIoxohA-1; Fri, 21 Jan 2022 03:22:05 -0500
X-MC-Unique: 7rgy0Bb9PBSf8PTIIoxohA-1
Received: by mail-ed1-f69.google.com with SMTP id z6-20020a50eb46000000b00403a7687b5bso8366156edp.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:22:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=D9mdAv+RGyUKYnJ0+MKBg/z6MNrIHJ34Co79nofBzHk=;
        b=LQxWSmYPzEmZZN/WUVjPTzKITDy2KEQh9N01JeMiA1+aX02dKW1a9Ujm99kFKqriCx
         yY2Due64NZXEsh6nVOrNFh1rWU2zECnwOPIXgZ9nDkNMw7q69Jm22B4OnxnXGo5J+KLz
         yFpNLhD5DBTn1E1lW7vVOG3m6X+Wz+n7x49svWtOCn+EkIgJX5omW4eA9y9thH2Ga0QI
         jWFvZv48nZiX04akwyP5nOA7gM9kWMAYb2216WLVUE2s3PqbaBOIT/hrgqF44bLgYftg
         bZhv115rwbaefepzu1pNl2SwzxNOY9feJXEZl4dUYat9IElglvyQcAliiKUQeTNt1ltn
         CV4A==
X-Gm-Message-State: AOAM5313wcmE7L1AVJiJAY1TerQCLWZaBSAIGSqLOVbM1u0+mxfDcx6x
        oAe8A/oRpnJh8ZGTprDhDpgG5SYbt9euJ0ACxnHXKZSLiP2XkViJJjB6NIOKrs9NZl7/zNwUqaC
        9w/W0m3nJFXruiZwmQKfxoJnl
X-Received: by 2002:a50:c388:: with SMTP id h8mr3204208edf.218.1642753324595;
        Fri, 21 Jan 2022 00:22:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzS9IjjdHldk1kkb0qxc2wFwJ7jyRsVwzm9rBQtq3xnVw8D2Ka+Wo01tcLEQp9LA/P2/jo67w==
X-Received: by 2002:a50:c388:: with SMTP id h8mr3204176edf.218.1642753324288;
        Fri, 21 Jan 2022 00:22:04 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a200:adf9:611a:39a8:435a? (p200300cbc709a200adf9611a39a8435a.dip0.t-ipconnect.de. [2003:cb:c709:a200:adf9:611a:39a8:435a])
        by smtp.gmail.com with ESMTPSA id g7sm2321532edr.71.2022.01.21.00.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 00:22:03 -0800 (PST)
Message-ID: <a84aa488-4fe9-36e5-72b8-ed6a5387020e@redhat.com>
Date:   Fri, 21 Jan 2022 09:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <ffb88819-a392-84f3-d40f-7406be8e3165@redhat.com>
 <20220121075157.GA20638@worktop.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
In-Reply-To: <20220121075157.GA20638@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.01.22 08:51, Peter Zijlstra wrote:
> On Thu, Jan 20, 2022 at 07:25:08PM +0100, David Hildenbrand wrote:
>> On 20.01.22 16:55, Peter Zijlstra wrote:
>>> Add a guarantee for Anon pages that pin_user_page*() ensures the
>>> user-mapping of these pages stay preserved. In order to ensure this
>>> all rmap users have been audited:
>>>
>>>  vmscan:	already fails eviction due to page_maybe_dma_pinned()
>>>
>>>  migrate:	migration will fail on pinned pages due to
>>> 		expected_page_refs() not matching, however that is
>>> 		*after* try_to_migrate() has already destroyed the
>>> 		user mapping of these pages. Add an early exit for
>>> 		this case.
>>>
>>>  numa-balance:	as per the above, pinned pages cannot be migrated,
>>> 		however numa balancing scanning will happily PROT_NONE
>>> 		them to get usage information on these pages. Avoid
>>> 		this for pinned pages.
>>
>> page_maybe_dma_pinned() can race with GUP-fast without
>> mm->write_protect_seq. This is a real problem for vmscan() with
>> concurrent GUP-fast as it can result in R/O mappings of pinned pages and
>> GUP will lose synchronicity to the page table on write faults due to
>> wrong COW.
> 
> Urgh, so yeah, that might be a problem. Follow up code uses it like
> this:
> 
> +/*
> + * Pinning a page inhibits rmap based unmap for Anon pages. Doing a load
> + * through the user mapping ensures the user mapping exists.
> + */
> +#define umcg_pin_and_load(_self, _pagep, _member)                              \
> +({                                                                             \
> +       __label__ __out;                                                        \
> +       int __ret = -EFAULT;                                                    \
> +                                                                               \
> +       if (pin_user_pages_fast((unsigned long)(_self), 1, 0, &(_pagep)) != 1)  \
> +               goto __out;                                                     \
> +                                                                               \
> +       if (!PageAnon(_pagep) ||                                                \
> +           get_user(_member, &(_self)->_member)) {                             \
> +               unpin_user_page(_pagep);                                        \
> +               goto __out;                                                     \
> +       }                                                                       \
> +       __ret = 0;                                                              \
> +__out: __ret;                                                                  \
> +})
> 
> And after that hard assumes (on the penalty of SIGKILL) that direct user
> access works. Specifically it does RmW ops on it. So I suppose I'd
> better upgrade that load to a RmW at the very least.
> 
> But is that sufficient? Let me go find that race you mention...
> 

It's described in [1] under point 3.

After we put the page into the swapcache, it's still mapped into the
page tables, where GUP can find it. Only after that, we try to unmap the
page (placing swap entries). So it's racy.


Note also point 2. in [1], which is related to O_DIRECT that does
currently not yet use FOLL_PIN but uses FOLL_GET.


[1]
https://lore.kernel.org/r/3ae33b08-d9ef-f846-56fb-645e3b9b4c66@redhat.com

-- 
Thanks,

David / dhildenb

