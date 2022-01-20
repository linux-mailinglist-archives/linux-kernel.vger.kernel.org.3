Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAC449559F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377732AbiATUqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347336AbiATUqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:46:51 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88077C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:46:51 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c5so6258709pgk.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 12:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Xdm4GgxM2vwol9hbWgLkNL+FNm9vwyJiOMXoyj9ea4=;
        b=f0k4wMrhO9SaUaljrMYs75wryJvqwN/1Za9CCgkWlZe3D5DRBvPpZrRGm1mN+vwGuH
         qcXPn97nF13vTLWiaMTpYT/JzLOtgObJeE/4blpCO1Vb4rSz31+KI18LuVt6YFYJTqZT
         F0rG+/WYLHf7jFMmRhz33T+CAvQfdHYHu7MUTLRw4C/ZjIqT9SzUZ1oEvt4SMQ+mzEDF
         iydzSkhwNbxLU+BkX38Nt/WTIpkGjv31+QMVz5zsiyurL83rUuixk+r/GbEqiKyt75X6
         aHOHNrr427//2i50g/TH6jit26KWiGomUnwFzR282zZB9Q58F0xqBce33HjebPbV/eIz
         essQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6Xdm4GgxM2vwol9hbWgLkNL+FNm9vwyJiOMXoyj9ea4=;
        b=GwPGQsSP7jlOLpFj92/6lgReLIYHM4PlcHOGRIt5/jevsIexaOhMIKN00xdfpjImgJ
         F3lRkLBz0rIUaW2kWh+BrwHMzUQDo7LXwZQyTR5VOxcPeL4O2Due48x22qP6YAnVyZ99
         uWfEgenoxIMf1Jf7yVMUecwmPwXpi+VCXXTwlAzvTmoCbiFPcqK0mGj9O4oNdjpY4U9o
         uYuf4k6QUiBWKK3+RpXCxt7Yg1bXGrLv+NaB3mVKVseGbbDULmniebVjCg9QWGbeBLzr
         Jpf/7cjCffO3KNkps44Y1iNioQl8NXljkBKBR7nrE/yCi8I4lZScaXYJS7xLBfVGLbv6
         VrVw==
X-Gm-Message-State: AOAM532Ut+9jHiZ5r8i2JvT85FrmH1IDIycCVBI3RdkJ1AYIWtR6ygjB
        gjM56HbYp2vVFS4egiDxhFI=
X-Google-Smtp-Source: ABdhPJzbTMkPaszVPy9pgy4GsXfMRhy8inew+Dia/TIv/GC97S55AXeFKFGM2gCi2p5OCjnPaRrq2A==
X-Received: by 2002:aa7:80cf:0:b0:4bc:ecc1:e7f5 with SMTP id a15-20020aa780cf000000b004bcecc1e7f5mr449519pfn.11.1642711610590;
        Thu, 20 Jan 2022 12:46:50 -0800 (PST)
Received: from smtpclient.apple ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id lj3sm608723pjb.37.2022.01.20.12.46.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jan 2022 12:46:50 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <42a9b72d-093e-c35c-f4b5-b321a666e67d@redhat.com>
Date:   Thu, 20 Jan 2022 12:46:48 -0800
Cc:     Matthew Wilcox <willy@infradead.org>,
        "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <288FB900-A688-4EDB-95C6-E63B6E0A15D1@gmail.com>
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
To:     David Hildenbrand <david@redhat.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2022, at 12:37 PM, David Hildenbrand <david@redhat.com> =
wrote:
>=20
> On 20.01.22 21:09, David Hildenbrand wrote:
>> On 20.01.22 21:07, Matthew Wilcox wrote:
>>> On Thu, Jan 20, 2022 at 08:55:12PM +0100, David Hildenbrand wrote:
>>>>>>> David, does any of it regards the lru_cache_add() reference =
issue that I
>>>>>>> mentioned? [1]
>>>=20
>>>> +++ b/mm/memory.c
>>>> @@ -3291,19 +3291,28 @@ static vm_fault_t do_wp_page(struct =
vm_fault *vmf)
>>>>        if (PageAnon(vmf->page)) {
>>>>                struct page *page =3D vmf->page;
>>>>=20
>>>> -               /* PageKsm() doesn't necessarily raise the page =
refcount */
>>>> -               if (PageKsm(page) || page_count(page) !=3D 1)
>>>> +               /*
>>>> +                * PageKsm() doesn't necessarily raise the page =
refcount.
>>>> +                *
>>>> +                * These checks are racy as long as we haven't =
locked the page;
>>>> +                * they are a pure optimization to avoid trying to =
lock the page
>>>> +                * and trying to free the swap cache when there is =
little hope
>>>> +                * it will actually result in a refcount of 1.
>>>> +                */
>>>> +               if (PageKsm(page) || page_count(page) > 1 + =
PageSwapCache(page))
>>>>                        goto copy;
>>>>                if (!trylock_page(page))
>>>>                        goto copy;
>>>> -               if (PageKsm(page) || page_mapcount(page) !=3D 1 || =
page_count(page) !=3D 1) {
>>>> +               if (PageSwapCache(page))
>>>> +                       try_to_free_swap(page);
>>>> +               if (PageKsm(page) || page_count(page) !=3D 1) {
>>>>                        unlock_page(page);
>>>>                        goto copy;
>>>>                }
>>>>                /*
>>>> -                * Ok, we've got the only map reference, and the =
only
>>>> -                * page count reference, and the page is locked,
>>>> -                * it's dark out, and we're wearing sunglasses. Hit =
it.
>>>> +                * Ok, we've got the only page reference from our =
mapping
>>>> +                * and the page is locked, it's dark out, and we're =
wearing
>>>> +                * sunglasses. Hit it.
>>>>                 */
>>>>                unlock_page(page);
>>>>                wp_page_reuse(vmf);
>>>>=20
>>>>=20
>>>> I added some vmstats that monitor various paths. After one run of
>>>> 	./forceswap 2 1000000 1
>>>> I'm left with a rough delta (including some noise) of
>>>> 	anon_wp_copy_count 1799
>>>> 	anon_wp_copy_count_early 1
>>>> 	anon_wp_copy_lock 983396
>>>> 	anon_wp_reuse 0
>>>>=20
>>>> The relevant part of your reproducer is
>>>>=20
>>>> 	for (i =3D 0; i < nops; i++) {
>>>> 		if (madvise((void *)p, PAGE_SIZE * npages, =
MADV_PAGEOUT)) {
>>>> 			perror("madvise");
>>>> 			exit(-1);
>>>> 		}
>>>>=20
>>>> 		for (j =3D 0; j < npages; j++) {
>>>> 			c =3D p[j * PAGE_SIZE];
>>>> 			c++;
>>>> 			time -=3D rdtscp();
>>>> 			p[j * PAGE_SIZE] =3D c;
>>>> 			time +=3D rdtscp();
>>>> 		}
>>>> 	}
>>>>=20
>>>> For this specific reproducer at least, the page lock seems to be =
the thingy that prohibits
>>>> reuse if I interpret the numbers correctly. We pass the initial =
page_count() check.
>>>>=20
>>>> Haven't looked into the details, and I would be curious how that =
performs with actual
>>>> workloads, if we can reproduce similar behavior.
>>>=20
>>> I don't see how that patch addresses the lru issue.  Wouldn't we =
need
>>> something like ...
>>>=20
>>> 	if (!PageLRU(page))
>>> 		lru_add_drain_all();
>>>=20
>=20
> lru_add_drain_all() takes a mutex ... best we can do I guess is drain
> the local CPU using lru_add_drain(). I'll go play with it and see what
> breaks :)
>=20

I did hack something similar and it solved the problem, but I felt it is
a hack. If the thread is scheduled on another core, or if the write =
fault
is triggered by another thread it wouldn=E2=80=99t work.

If you look for a real-world workload that behaves similarly, you can =
try
memcached with memory pressure and low latency device (I used=20
pmem-emulated). This is the workload in which I encountered the issue
first.


