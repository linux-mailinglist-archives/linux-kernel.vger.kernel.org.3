Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E1365341C3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 18:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245455AbiEYQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbiEYQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 12:54:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340758A32E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 09:54:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA8F7616EF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 16:54:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D9DC385B8;
        Wed, 25 May 2022 16:54:42 +0000 (UTC)
Date:   Wed, 25 May 2022 17:54:39 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        hanchuanhua <hanchuanhua@oppo.com>,
        =?utf-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>, =?utf-8?B?6YOt5YGl?= <guojian@oppo.com>,
        Barry Song <v-songbaohua@oppo.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>, Shaohua Li <shli@kernel.org>,
        Rik van Riel <riel@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] arm64: enable THP_SWAP for arm64
Message-ID: <Yo5fTzEUFW6lbwnI@arm.com>
References: <20220524071403.128644-1-21cnbao@gmail.com>
 <YoyTWaDmSiBUkaeg@arm.com>
 <CAGsJ_4xPFkc6Kn2G5pPPk8XJ4iZV=atzan=Quq6Ljc_5vr1fnA@mail.gmail.com>
 <Yo0ufMHXPL5mJ5t6@arm.com>
 <CAGsJ_4wSmZo9+Anzq_WjF=xACRT7p0EJ86de6C=8xhGpTBOHQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4wSmZo9+Anzq_WjF=xACRT7p0EJ86de6C=8xhGpTBOHQg@mail.gmail.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 11:10:41PM +1200, Barry Song wrote:
> On Wed, May 25, 2022 at 7:14 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > I think this should work and with your other proposal it would be
> > limited to MTE pages:
> >
> > #define arch_thp_swp_supported(page)    (!test_bit(PG_mte_tagged, &page->flags))
> >
> > Are THP pages loaded from swap as a whole or are they split? IIRC the
> 
> i can confirm thp is written as a whole through:
> [   90.622863]  __swap_writepage+0xe8/0x580
> [   90.622881]  swap_writepage+0x44/0xf8
> [   90.622891]  pageout+0xe0/0x2a8
> [   90.622906]  shrink_page_list+0x9dc/0xde0
> [   90.622917]  shrink_inactive_list+0x1ec/0x3c8
> [   90.622928]  shrink_lruvec+0x3dc/0x628
> [   90.622939]  shrink_node+0x37c/0x6a0
> [   90.622950]  balance_pgdat+0x354/0x668
> [   90.622961]  kswapd+0x1e0/0x3c0
> [   90.622972]  kthread+0x110/0x120
> 
> but i have never got a backtrace in which thp is loaded as a whole though it
> seems the code has this path:
> int swap_readpage(struct page *page, bool synchronous)
> {
>         ...
>         bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
>         bio->bi_iter.bi_sector = swap_page_sector(page);
>         bio->bi_end_io = end_swap_bio_read;
>         bio_add_page(bio, page, thp_size(page), 0);
>         ...
>         submit_bio(bio);
> }
> 
> > splitting still happens but after the swapping out finishes. Even if
> > they are loaded as 4K pages, we still have the mte_save_tags() that only
> > understands small pages currently, so rejecting THP pages is probably
> > best.
> 
> as anyway i don't have a mte-hardware to do a valid test to go any
> further, so i will totally disable thp_swp for hardware having mte for
> this moment in patch v2.

It makes sense. If we decide to improve this for MTE, we'll change the
arch check.

Thanks.

-- 
Catalin
