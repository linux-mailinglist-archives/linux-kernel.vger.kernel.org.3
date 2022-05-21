Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE83952FE23
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 18:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245615AbiEUQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 12:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiEUQgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 12:36:37 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745486005B
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:36:36 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id a38so7323395pgl.9
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 09:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6s6WVdCnyStqPvDqluR9cvNh+3kAmaoZbyO+JNs1GmM=;
        b=Al/GqXg2rNQzNcq9/YItA5F3eVvUj/PxLIjH5mdQkLudgxEg1H5uAbeyeN0H8F9GW9
         NAF3hoTJ9y98I84MLc4fEPBTIZWcf5wUmoWoUioxzv496J9IyjFFX3Gmr/x1SGkFRcx+
         QiwGkMjvQgk2FnEXyrPMA+iitH6DQtre4xS09Y084oIv9mnJrfA/a/6+w9AfDpLd2zUl
         xfuq1r3Yfa7vxx6+1BomjhDgyNuBZ9x3Vnyd7eNypjtXhYT1uwpg+9ctJTEdxHo8UUTS
         is/rnNkvwdR++z5iW7h3nxWggS36RTUJ9MOX0BWvQER4cP8UWOQnN5CvKqu+PJGp1Bj0
         jMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=6s6WVdCnyStqPvDqluR9cvNh+3kAmaoZbyO+JNs1GmM=;
        b=6rPEILYlZm4x+8+Ihe348LLdkXly5SDKGwqnFM9pyf2BWV48mxEGAr5PSgmORGnZOd
         ebTSPJ/xaZXpj2V3K2S7JwaghmwlM/O6XCVj1HCFIZY0r2dXDUCly7M2ropUy7YaeiIj
         XrvsZKJRIunPINP1zNIeMQGXstpcLt7cggPEne9Mr1z9tiu4/uTWTHiA/jnOZhjxzoBt
         B2eBntefjVKsUg6rmeiuNlCL0PDf5S4QQAbpEAdxGYNWN3OkJj9N/YzlWTSg6mDtdYaW
         tSLhJ/ITK+YixvkCTEr7nyuFBSIDmHFg7Jd7R9C9KTDJbMO96K0Zb59T0uMTLt/e3HFm
         3NaQ==
X-Gm-Message-State: AOAM531BTCjxux1ED0sHn7dCduEYRt7N3gAcdWiY3T381YFBufCTt5u5
        eipYXApvlFFBteaz2fTmjMXRt1fMYMQ=
X-Google-Smtp-Source: ABdhPJy8e97IxMQLA6KpgQRTomU5Pn68A/IFn9Q0caJur8XXJ5uHGGzJbcbA0zFnKB8TzwytSI4Tzw==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr15287548pfb.59.1653150995896;
        Sat, 21 May 2022 09:36:35 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:ef57:ac0e:cc3e:9974])
        by smtp.gmail.com with ESMTPSA id l17-20020a629111000000b0050dc76281ccsm3816690pfe.166.2022.05.21.09.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 09:36:35 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Sat, 21 May 2022 09:36:33 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        syzbot <syzbot+acf65ca584991f3cc447@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com,
        Matthew Wilcox <willy@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [syzbot] WARNING in follow_hugetlb_page
Message-ID: <YokVEZbOayed5hBb@google.com>
References: <Yn73Hz7LkSUv7ycw@google.com>
 <d97d8a00-e9e0-278f-0c3f-71162afa48b1@nvidia.com>
 <6d281052-485c-5e17-4f1c-ef5689831450@oracle.com>
 <YogT9AwVclxAnyvs@google.com>
 <0be9132d-a928-9ebe-a9cf-6d140b907d59@nvidia.com>
 <a455c6b1-b9ef-39ab-879e-80e13fd13c10@oracle.com>
 <YognlSdHAKgnkPPY@google.com>
 <b36a728c-03a1-0e07-b6d2-9515e647416f@oracle.com>
 <YokEEAemXTwTSZh5@google.com>
 <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b025ddd5-aca2-f3e2-6a4f-24a1b4eda985@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 21, 2022 at 05:51:58PM +0200, David Hildenbrand wrote:
> On 21.05.22 17:24, Minchan Kim wrote:
> > On Fri, May 20, 2022 at 05:04:22PM -0700, Mike Kravetz wrote:
> >> On 5/20/22 16:43, Minchan Kim wrote:
> >>> On Fri, May 20, 2022 at 04:31:31PM -0700, Mike Kravetz wrote:
> >>>> On 5/20/22 15:56, John Hubbard wrote:
> >>>>> On 5/20/22 15:19, Minchan Kim wrote:
> >>>>>> The memory offline would be an issue so we shouldn't allow pinning of any
> >>>>>> pages in *movable zone*.
> >>>>>>
> >>>>>> Isn't alloc_contig_range just best effort? Then, it wouldn't be a big
> >>>>>> problem to allow pinning on those area. The matter is what target range
> >>>>>> on alloc_contig_range is backed by CMA or movable zone and usecases.
> >>>>>>
> >>>>>> IOW, movable zone should be never allowed. But CMA case, if pages
> >>>>>> are used by normal process memory instead of hugeTLB, we shouldn't
> >>>>>> allow longterm pinning since someone can claim those memory suddenly.
> >>>>>> However, we are fine to allow longterm pinning if the CMA memory
> >>>>>> already claimed and mapped at userspace(hugeTLB case IIUC).
> >>>>>>
> >>>>>
> >>>>> From Mike's comments and yours, plus a rather quick reading of some
> >>>>> CMA-related code in mm/hugetlb.c (free_gigantic_page(), alloc_gigantic_pages()), the following seems true:
> >>>>>
> >>>>> a) hugetlbfs can allocate pages *from* CMA, via cma_alloc()
> >>>>>
> >>>>> b) while hugetlbfs is using those CMA-allocated pages, it is debatable
> >>>>> whether those pages should be allowed to be long term pinned. That's
> >>>>> because there are two cases:
> >>>>>
> >>>>>     Case 1: pages are longterm pinned, then released, all while
> >>>>>             owned by hugetlbfs. No problem.
> >>>>>
> >>>>>     Case 2: pages are longterm pinned, but then hugetlbfs releases the
> >>>>>             pages entirely (via unmounting hugetlbfs, I presume). In
> >>>>>             this case, we now have CMA page that are long-term pinned,
> >>>>>             and that's the state we want to avoid.
> >>>>
> >>>> I do not think case 2 can happen.  A hugetlb page can only be changed back
> >>>> to 'normal' (buddy) pages when ref count goes to zero.
> >>>>
> >>>> It should also be noted that hugetlb code sets up the CMA area from which
> >>>> hugetlb pages can be allocated.  This area is never unreserved/freed.
> >>>>
> >>>> I do not think there is a reason to disallow long term pinning of hugetlb
> >>>> pages allocated from THE hugetlb CMA area.
> 
> Hm. We primarily use CMA for gigantic pages only IIRC. Ordinary huge
> pages come via the buddy.
> 
> Assume we allocated a (movable) 2MiB huge page ordinarily via the buddy
> and it ended up on that CMA area by pure luck (as it's movable). If we'd
> allow to pin it long-term, allocating a gigantic page from the
> designated CMA area would fail.

If we allow the longterm pin against the hugetlb page come via buddy,
it should be migrated out of CMA before the longterm pinning by
check_and_migrate_movable_pages, IIUC.
If so, what the allocating a giganitc page from the designated CMA area
would fail?

> 
> So we'd want to allow long-term pinning a gigantic page but we'd not
> want to allow long-term pinning an ordinary huge page. We'd want to
> migrate the latter away.

Sure. Gigantic page was already CMA claimed page so there is no user
in the future to claim the memory again so fine to allow longterm pin
but ordinary huge page shouldn't be allowed since CMA owner could
claim the memory some day.

> 
> 
> The general rules are:
> 
> ZONE_MOVABLE: nobody is allowed to place unmovable allocations there; it
> could prevent memory offlining/unplug.
> 
> CMA: nobody *but the designated owner* is allowed to place unmovable
> memory there; it could prevent the actual owner to allocate contiguous
> memory.

I am confused what's the meaning of designated owner and actuall owner
in your context.

What I thought about the issue based on you explanation:

HugeTLB allocates its page by two types of allocation

1. alloc_pages(GFP_MOVABLE)
 
It could allocate the hugetlb page from CMA area but longterm pin
should migrate them out of cma before the pinning so allowing
the pinning on the page is no problem and current code works like
that.

    check_and_migrate_movable_pages

2. cma_alloc

The cma_alloc is used only for *gigantic page* and the hugetlbfs
is the very owner of the page. IOW, if the hugetlbfs was succeeded
to allocate the gigantic page by cma_alloc, there is no other
owner to be able to claim the page any longer so it's fine to
allow longterm pinning againt the gingantic page but current.
However, current code doesn't work like that due to
is_pinnable_page. IOW, hugetlbfs need a way to distinguish 
whether the page owner is hugetlbfs or not.

Are we on same page?
