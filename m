Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107D95897D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 08:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiHDGmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 02:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiHDGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 02:42:42 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9FBCB0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 23:42:42 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so5180387pjg.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 23:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t0hVpaX67O5peLQKyTWorSsJEziUO3Aa/9O4XXseo2g=;
        b=RUr0dTDQnZ8mwg+7mveG7DJmZS2Vs3pHHhTi+q1WegmR0jqmlyMwAg5ZMTIcZkaGjA
         ylUI57PJpNGf3+axQl4eZ0sJrMxJOZmJkGmKwtBB8OZor3MCZ4Nnboc3BESNCizAu3zY
         kLMxrWyR9kMEw8X+pw0cSND3x+m5qIXKXYW8YCWTnMw1jqfr33Jf4e07wB0+fBBLSZcr
         8qzzrQFJSpG/0u17d5osxVUNOdTXKuHP6b99Uwo95EzgNiMpYSXVc7dKGyd6Ir6nhoqu
         uRrFrphubelLGIjoW3RISlcD7IVAPqGkQ1O44BJimOg3y1kaHFIHhLsnhMxdPzowDyWd
         zlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=t0hVpaX67O5peLQKyTWorSsJEziUO3Aa/9O4XXseo2g=;
        b=0ersqT7xID2+zmr6d8phXQvJX6+KP3wKQotJ31j5t3j2eAgWTdYerpWpX+OkzLGydK
         AB5EBtiLRh3jPL8AJWs5PGHHzn/y6y0UQTlIolU0tXmukSpoL7XQOGrKm4xc+sVUuttE
         w638w5Y3AHMmSnBPNdJzjKecvCh3P4cyrPTrrtSoB9cjd678QhXC750vSPHzkxu4PBPb
         yz0EsSiHigIQWvZ1o+bYyaw4id+/WHJAoq1xMHu+Yd1Oh/0Smx9n+kDQ5yIw4cdvmpq2
         eseJ5IYqr87FsNNSyhixe2t59tyTaG670QF58rV4xcND0T3oDvTZYbH5nS0XTa8jY9Bc
         GAPQ==
X-Gm-Message-State: ACgBeo2VQsCKwY//rlJFj1qGHvrEF6pP2+Ju19eiv56Wx2ANS/QdDk9S
        QLCj0HK9l9XXApmtzCO1rvo=
X-Google-Smtp-Source: AA6agR73NIrOxmIl9LnO95/01NaFEAFZpy4KIi1ifnULXkctNLzW60kvGiOiLSKK/BI7W3qh7HSajA==
X-Received: by 2002:a17:90a:c70d:b0:1f3:2a3a:24d4 with SMTP id o13-20020a17090ac70d00b001f32a3a24d4mr8852622pjt.16.1659595361464;
        Wed, 03 Aug 2022 23:42:41 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id pb15-20020a17090b3c0f00b001f31776ccf3sm268185pjb.12.2022.08.03.23.42.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Aug 2022 23:42:41 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <YuqmKmVtVYnkDF7J@xz-m1.local>
Date:   Wed, 3 Aug 2022 23:42:39 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A53E0AC4-D171-41C1-9C2D-F8145AAB4A36@gmail.com>
References: <20220803012159.36551-1-peterx@redhat.com>
 <20220803012159.36551-3-peterx@redhat.com>
 <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
 <YuqmKmVtVYnkDF7J@xz-m1.local>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 3, 2022, at 9:45 AM, Peter Xu <peterx@redhat.com> wrote:

> On Wed, Aug 03, 2022 at 12:42:54AM -0700, Nadav Amit wrote:
>> On Aug 2, 2022, at 6:21 PM, Peter Xu <peterx@redhat.com> wrote:
>>=20
>> On the negative side, I am not sure whether other archs, that might =
require
>> a TLB flush for resetting the access-bit, and the overhead of doing =
atomic
>> operation to clear the access-bit, would not induce more overhead =
than they
>> would save.
>=20
> I think your proposal makes sense and looks clean, maybe even cleaner =
than
> the new max_swapfile_size() approach (and definitely nicer than the =
old one
> of mine). It's just that I still want this to happen even without page =
idle
> enabled - at least Fedora doesn't have page idle enabled by default.  =
I'm
> not sure whether it'll be worth it to define Young bit just for this =
(note:
> iiuc we don't need Idle bit in this case, but only the Young bit).
>=20
> The other thing is whether there's other side effect of losing pte =
level
> granularity of young bit, since right after we merge them into the =
page
> flags, then that granule is lost.  So far I don't worry a lot on the =
tlb
> flush overhead, but hopefully nothing else we missed.

I agree with your arguments. I missed the fact that page young bit is =
only
defined if PAGE_IDLE is defined. So unless it makes sense in general to =
have
all pages marked as accessed if the page is young, adding the bit would
cause additional overheads, especially for 32-bit systems.

I also agree that the solution that you provided would improve page-idle
behavior. However, while not being wrong, users who try to clear =
page-idle
indications would not succeed doing so for pages that are undergoing a
migration.

There are some additional implications that I do not remember that you =
or
anyone else (including me) mentioned, specifically for MADV_COLD and
MADV_FREE. You may want to teach madvise_cold_or_pageout_pte_range() and
madvise_free_pte_range() to deal with these new type of entries.

On the other hand, madvise is already =E2=80=9Cbroken=E2=80=9D today in =
that regard, since
IIUC, it does not even clear PageReferenced (on MADV_COLD) for migrated
pages.

>> One more unrelated point - note that remove_migration_pte() would =
always set
>> a clean PTE even when the old one was dirty=E2=80=A6
>=20
> Correct.  Say it in another way, at least initial writes perf will =
still
> suffer after migration on x86.
>=20
> Dirty bit is kind of different in this case so I didn't yet try to =
cover
> it.  E.g., we won't lose it even without this patchset but =
consolidates it
> into PageDirty already or it'll be a bug.
>=20
> I think PageDirty could be cleared during migration procedure, if so =
we
> could be wrongly applying the dirty bit to the recovered pte.  I =
thought
> about this before posting this series, but I hesitated on adding dirty =
bit
> altogether with it at least in these initial versions since dirty bit =
may
> need some more justifications.
>=20
> Please feel free to share any further thoughts on the dirty bit.

I fully understand that the dirty-bit can stay for a different =
patch(-set).
But I do not see a problem in setting the dirty-bit if the PTE is mapped =
as
writable, since anyhow the page can be dirties at any given moment
afterwards without the kernel involvement.

If you are concerned that the page will be written back in between and =
the
PTE would be marked as dirty unnecessarily, you can keep the bit only if =
the
both PageDirty and a new "swap entry dirty-bit=E2=80=9D are set.


