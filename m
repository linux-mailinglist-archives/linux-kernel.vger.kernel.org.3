Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1445A5A157A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 17:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239855AbiHYPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 11:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiHYPUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 11:20:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262D2BB2C
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 08:20:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4D88615A7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E045C433D6;
        Thu, 25 Aug 2022 15:20:12 +0000 (UTC)
Date:   Thu, 25 Aug 2022 16:20:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v13 57/70] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Message-ID: <YweTKGvxzpUnbTkk@arm.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
 <20220822150128.1562046-58-Liam.Howlett@oracle.com>
 <YwbDmKyQxWHfRg97@sirena.org.uk>
 <20220825132054.ymenz4cewiemsxw7@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825132054.ymenz4cewiemsxw7@revolver>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 01:21:01PM +0000, Liam Howlett wrote:
> * Mark Brown <broonie@kernel.org> [220824 20:34]:
> > On Mon, Aug 22, 2022 at 03:06:30PM +0000, Liam Howlett wrote:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > 
> > > Handle overflow checking in count_mm_mlocked_page_nr() differently.
> > 
> > Our QA team found that since next-20220823 we're seeing a couple of test
> > failures in the check_mmap_options kselftest on arm64 platforms with MTE
> > that aren't present in mainline:
> > 
> > # # FAIL: mprotect not ignoring clear PROT_MTE property
> > # not ok 21 Check clear PROT_MTE flags with private mapping, sync error mode and mmap memory
> > # # FAIL: mprotect not ignoring clear PROT_MTE property
> > # not ok 22 Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory
> 
> Thanks.
> 
> > I bisected this using qemu[1] which landed on 4ceb4bca479d41a
> > ("mm/mprotect: use maple tree navigation instead of vma linked list"),
> > though I'm not 100% sure I trust the specific identification of the
> > commit I'm pretty confident it's at the very least in this series.  I've
> > not done any analysis of the failure beyond getting this bisect result.
> > 
> > [1] qemu -smp cpus=4 -cpu max -machine virt,gic-version=3,mte=on
> 
> This helps a lot.  I think your bisect is accurate:
> 
> ...
>         struct mmu_gather tlb;
> +       MA_STATE(mas, &current->mm->mm_mt, start, start);
>  
>         start = untagged_addr(start);
> ...
> 
> It looks like I search against the tagged address.  I should initialize
> the state to 0 and mas_set(&mas, start) after untagging the address.
> 
> I'll send out a patch once I have recreated and verified this is the
> issue.

Thanks. I did a quick test and untagging start seems to fix the issue (I
was wondering why mprotect() returned -ENOMEM when failing).

-- 
Catalin
