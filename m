Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E0E589FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 19:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235165AbiHDRHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiHDRHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 13:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BF3218342
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659632859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ycStJmEGwcc0keBdhDtkJ5snzEG02mRUS+UDUNsIBL4=;
        b=EmVH7DZnjIlKS9g32viL3gGpYHuQYblUmljbIGoBID8Ix6ey8DQruN6HXAN0fndsK2TY9m
        HEv/Z3FwTgwWtExT5Gc1Yjb8Hhx80h85VmID+AAVMeThKFgMV2TqVDQQ/elzr0uO6uoGQH
        +amdwkVFGUtrQ9ZxVPI7pVwP0RfTpxQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-VyQ4KfchOx6a69yJTopwyQ-1; Thu, 04 Aug 2022 13:07:38 -0400
X-MC-Unique: VyQ4KfchOx6a69yJTopwyQ-1
Received: by mail-qv1-f71.google.com with SMTP id cv14-20020ad44d8e000000b004760bec67a8so22562qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 10:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ycStJmEGwcc0keBdhDtkJ5snzEG02mRUS+UDUNsIBL4=;
        b=xxZLLL1Q3qmls5qCjcCbdoikzqi8IaIjF1hcZqzTWJzR5EqSWhxBSUbcNSkjF/sKvS
         wsnbKt+nj78WV8umE3HdNvZ934Dg5Akv4dVtbibYcYDW5gN5eScrlf8cbkpDifoOiKzV
         IuSiEUQbiBBLWj7L9ZU6MNIbKVIiW2Zkfri3O5fXt6AiHnpl0ONoh3TgrdCFCs5/Kuto
         80SI0CYL5iuaE35G1YdoipunjamMwRFizj32IKmFB0hFNHOIuYbdgIUsjN15AxFw5k1A
         cnldvVW0AzakBPYWF+nBL5gYog3I14V/oGcxFFO7NEh8HXg+RSkZ+LhRb/0RZoHjRJfX
         4i5A==
X-Gm-Message-State: ACgBeo0voVPPrJFWKprm18JjnKc14fuooK2ua8yhLlNY0djRdn8m3TVM
        tpEQb1J8Rs81kVhyTHu18+P2AWsvAQv61Pd0U2oku0nRE8YcOp9L84z4tV2krEUq3TWBDcOudFE
        HFlO1wmWl9BKOI/+AcdkLtqvw
X-Received: by 2002:a05:620a:15ae:b0:6b9:112a:a281 with SMTP id f14-20020a05620a15ae00b006b9112aa281mr8688qkk.671.1659632857710;
        Thu, 04 Aug 2022 10:07:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7B+awuNztuUVDMTYOOV4ZzJEwDLaBwo4xaalKf9vfReO9wc9Z/5ADeqCpUor/+aaoiYzuCAA==
X-Received: by 2002:a05:620a:15ae:b0:6b9:112a:a281 with SMTP id f14-20020a05620a15ae00b006b9112aa281mr8664qkk.671.1659632857374;
        Thu, 04 Aug 2022 10:07:37 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id h17-20020a05620a245100b006b568bdd7d5sm1076851qkn.71.2022.08.04.10.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 10:07:36 -0700 (PDT)
Date:   Thu, 4 Aug 2022 13:07:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Huang Ying <ying.huang@intel.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 2/2] mm: Remember young bit for page migrations
Message-ID: <Yuv811AnT9aoBxbH@xz-m1.local>
References: <20220803012159.36551-1-peterx@redhat.com>
 <20220803012159.36551-3-peterx@redhat.com>
 <EEBB9DDB-3D67-42BD-BD16-4264F40760CD@gmail.com>
 <YuqmKmVtVYnkDF7J@xz-m1.local>
 <A53E0AC4-D171-41C1-9C2D-F8145AAB4A36@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A53E0AC4-D171-41C1-9C2D-F8145AAB4A36@gmail.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2022 at 11:42:39PM -0700, Nadav Amit wrote:
> On Aug 3, 2022, at 9:45 AM, Peter Xu <peterx@redhat.com> wrote:
> 
> > On Wed, Aug 03, 2022 at 12:42:54AM -0700, Nadav Amit wrote:
> >> On Aug 2, 2022, at 6:21 PM, Peter Xu <peterx@redhat.com> wrote:
> >> 
> >> On the negative side, I am not sure whether other archs, that might require
> >> a TLB flush for resetting the access-bit, and the overhead of doing atomic
> >> operation to clear the access-bit, would not induce more overhead than they
> >> would save.
> > 
> > I think your proposal makes sense and looks clean, maybe even cleaner than
> > the new max_swapfile_size() approach (and definitely nicer than the old one
> > of mine). It's just that I still want this to happen even without page idle
> > enabled - at least Fedora doesn't have page idle enabled by default.  I'm
> > not sure whether it'll be worth it to define Young bit just for this (note:
> > iiuc we don't need Idle bit in this case, but only the Young bit).
> > 
> > The other thing is whether there's other side effect of losing pte level
> > granularity of young bit, since right after we merge them into the page
> > flags, then that granule is lost.  So far I don't worry a lot on the tlb
> > flush overhead, but hopefully nothing else we missed.
> 
> I agree with your arguments. I missed the fact that page young bit is only
> defined if PAGE_IDLE is defined. So unless it makes sense in general to have
> all pages marked as accessed if the page is young, adding the bit would
> cause additional overheads, especially for 32-bit systems.
> 
> I also agree that the solution that you provided would improve page-idle
> behavior. However, while not being wrong, users who try to clear page-idle
> indications would not succeed doing so for pages that are undergoing a
> migration.

Right.

Since I don't have a clear mind of reusing PageYoung here unconditionally,
I think I'll still stick with the current approach if nothing else jumps
in.  I still see the page idle tracking on migration entries a long
standing and relatively separate issue, so IMHO we can move one step at a
time on solving the "page idle tracking for migrated page", leaving the
"page idle reset during page migrating" to latter.

> 
> There are some additional implications that I do not remember that you or
> anyone else (including me) mentioned, specifically for MADV_COLD and
> MADV_FREE. You may want to teach madvise_cold_or_pageout_pte_range() and
> madvise_free_pte_range() to deal with these new type of entries.
> 
> On the other hand, madvise is already “broken” today in that regard, since
> IIUC, it does not even clear PageReferenced (on MADV_COLD) for migrated
> pages.

Yeah, afaict we don't handle migration pages for both madvises.

Maybe it's because it's racy to access the page knowing that it's operated
upon by the thread doing migration (when without the page lock)?  For real
migrations (not THP split), we'll also be changing the old page not new
one.  So maybe the migration entries are just not yet the major target for
both of the madvises.

For this series, I can think more of dropping the young bit for migration
entry during these madvises (which should be relatively safe with the
pgtable held, since I don't need to touch the page but just modify the swap
entry within), but probably that's not really the major problem here, so
not sure whether that matters a huge lot (e.g., for FREE we should really
drop the whole entry?).

Copying Minchan too.

> 
> >> One more unrelated point - note that remove_migration_pte() would always set
> >> a clean PTE even when the old one was dirty…
> > 
> > Correct.  Say it in another way, at least initial writes perf will still
> > suffer after migration on x86.
> > 
> > Dirty bit is kind of different in this case so I didn't yet try to cover
> > it.  E.g., we won't lose it even without this patchset but consolidates it
> > into PageDirty already or it'll be a bug.
> > 
> > I think PageDirty could be cleared during migration procedure, if so we
> > could be wrongly applying the dirty bit to the recovered pte.  I thought
> > about this before posting this series, but I hesitated on adding dirty bit
> > altogether with it at least in these initial versions since dirty bit may
> > need some more justifications.
> > 
> > Please feel free to share any further thoughts on the dirty bit.
> 
> I fully understand that the dirty-bit can stay for a different patch(-set).
> But I do not see a problem in setting the dirty-bit if the PTE is mapped as
> writable, since anyhow the page can be dirties at any given moment
> afterwards without the kernel involvement.
> 
> If you are concerned that the page will be written back in between and the
> PTE would be marked as dirty unnecessarily, you can keep the bit only if the
> both PageDirty and a new "swap entry dirty-bit” are set.

Sounds good, I'll think more of it and see whether I'll cover that too.

Thanks,

-- 
Peter Xu

