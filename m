Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FDA3495C75
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237558AbiAUJBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:01:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35119 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232303AbiAUJBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642755681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DIBKgVb122cd+imTMSb5fkOXwRpek4LueWHbXO5Yzk4=;
        b=gOQrr5PEYkgz01qVufOjDpuUCavkqxSE2w896R3pXMDIH/MhtYfwBmulFDyUzPPYwqs7OM
        tPKURhcdXl3jH9USkHeLVhn4muN2ImqTfceIluC65J+nd8ZwjESJbSFdwQEc2ZRviqUHbN
        sWgRYpNIbWedJQ7lCa4TPenIosz6QEc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-121-Y5Ck3wS2PheC654Jb5YnHA-1; Fri, 21 Jan 2022 04:01:20 -0500
X-MC-Unique: Y5Ck3wS2PheC654Jb5YnHA-1
Received: by mail-wm1-f70.google.com with SMTP id z2-20020a05600c220200b0034d2eb95f27so5846244wml.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 01:01:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:from:to:cc:references:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=DIBKgVb122cd+imTMSb5fkOXwRpek4LueWHbXO5Yzk4=;
        b=WH5l7XNCZK6+KnEzWKI15O3h08V65xWxreilS1amonv020uYWC4EL4N08RZP/bLWWH
         PxF1eNYVp7q61ERCMtqF0VSVX6iB4ssOhXqgtpaNpCYYuvb40ObermdAZYRWHcrW2Bpt
         Gk96obKFDRTbh4J9XByw3eZXTwA8NmotvQLSH6xi0iuCLq5bMzG9tRu7KJ3oA0hXR2lM
         ggSflCzKIB9mg6yC6dNac+CLzywA6gsb8H9vyWwDH3uQGL+9R8RwW/T15dGP0KsJqz45
         NZ5/v+Ub+zdryS6EueMsfpuQe+8z97S3bZLfROuBg2+p6t/c7svuqYSXfYk/RLsntzZZ
         2sEQ==
X-Gm-Message-State: AOAM532qIgwlhlFcU55SVl59xYEQxAPMFXDfw+Bh/ZoA1grts9cWpoGx
        bxojBOBikhqAjF+XzkUt7aVk9nmzJS4C+53VbGM33rBr7kfKdWKqujY6hJx6wnj6OfZwiLFxSP/
        G9uL2yUYvL5f7mbDhlTXKqDfF
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr2946631wrs.466.1642755679204;
        Fri, 21 Jan 2022 01:01:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyivgjgWOHftgfSfkxXCdmFwXNsRs+FJ0mvbmGG0Gm5jybpEkQNhZQH7dacyAa8vHJ1oqAWrw==
X-Received: by 2002:a5d:6dac:: with SMTP id u12mr2946609wrs.466.1642755678984;
        Fri, 21 Jan 2022 01:01:18 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:a200:adf9:611a:39a8:435a? (p200300cbc709a200adf9611a39a8435a.dip0.t-ipconnect.de. [2003:cb:c709:a200:adf9:611a:39a8:435a])
        by smtp.gmail.com with ESMTPSA id l15sm9456888wmh.6.2022.01.21.01.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 01:01:18 -0800 (PST)
Message-ID: <03b0ed0c-51af-1e68-350c-19a3b38a6e48@redhat.com>
Date:   Fri, 21 Jan 2022 10:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <a93988da-80fb-dd32-4717-a6a0bae9e4ee@huawei.com>
 <dc415c4a-63aa-19b0-0fbc-795989970f6d@redhat.com>
 <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <C8734D0B-B855-4323-A7DF-2D96245951B2@gmail.com>
 <8931808d-db61-0f06-ceb3-f48a83b1f74c@redhat.com>
 <6225EAFF-B323-4DC5-AC4C-885B29ED7261@gmail.com>
 <9071d5a8-ed2d-5cf5-5526-43fe7dd377ec@redhat.com>
 <YenA7Xzd2G2OYvqz@casper.infradead.org>
 <da2846a1-f950-d330-7ada-ad3c9abfde74@redhat.com>
 <42a9b72d-093e-c35c-f4b5-b321a666e67d@redhat.com>
 <288FB900-A688-4EDB-95C6-E63B6E0A15D1@gmail.com>
 <7a18f74f-9dc2-f23d-4f1c-c7a9217f8317@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
In-Reply-To: <7a18f74f-9dc2-f23d-4f1c-c7a9217f8317@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> I did hack something similar and it solved the problem, but I felt it is
>> a hack. If the thread is scheduled on another core, or if the write fault
>> is triggered by another thread it wouldn’t work.
> 
> Yes, it will not match easily. One question would be how often it would
> help in practice and if it would be worth the price.
> 


I did some more testing and I have to admit that your reproducer is
really good at finding corner cases.

Assume we try to handle LRU as discussed ... what I get is a delta
during the test: ./forceswap 2 100000 1


anon_wp_reuse 920
-> we were able to reuse
anon_wp_copy_count 0
-> we failed the final page_count() == 1 check
anon_wp_copy_count_early 634
-> we failed the early page_count() check considering swapcache and lru
anon_wp_copy_lock 1
-> we failed trylock
anon_wp_copy_lru 19
-> we failed to clear the lru cache reference
anon_wp_copy_writeback 99974
-> we failed to clear the swapcache reference due to concurrent
   writeback
anon_wp_copy_swapcache 0
-> we failed to clear the swapcache reference for other reasons

So, yeah, we mostly always hit writeback in forceswap.c.
reuse_swap_page() would have been able to reuse the page if the swap
backend would have supported concurrent writes during writeback (IIUC,
zswap doesn't).

But I think triggering that case that often really is an oddity about
the test case.

-- 
Thanks,

David / dhildenb

