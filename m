Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A12A5A4F04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiH2OUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiH2OUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:20:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D26B7CD
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:20:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C500960F56
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:20:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300DEC433C1;
        Mon, 29 Aug 2022 14:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661782809;
        bh=5t9TYUD+7W9POaNmmtNmb01GYlGZ8fVGivHM4X+6f2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NB0+0Mwkdgsa95TVX/0Jeji1znYOMzQXT1a70l9QbWiHgxF3iwBjcGJrprerId8tQ
         n/1bto5FbCQflPk49KQ54vGgbaBr7HxI7334gQxZmoyQ72qgJjrIsETi6+mzbLdAQq
         XDjmULvnzU433k8CSsBRjjNQAfkXzhPEV6shVbUeehBKPoqdSaF0xzr1X6fN6pzV1f
         pJCnB+RCRRLcH3JPXLCD3DUig7LJxnnhFwZ1Q179TDxVn4rvuTFoF/W6ZWkQ+vsXA4
         7v2OlutPDVQ8mJoUketumtAbUM15OQCw35WOTub+w5zZeP/3lOJD/CAaFS239UkCZ6
         VNfrlhqHj95kg==
Date:   Mon, 29 Aug 2022 22:10:53 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Conor.Dooley@microchip.com
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, ajones@ventanamicro.com
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Message-ID: <YwzI7VmfFnOvYWgf@xhacker>
References: <20220827095815.698-1-jszhang@kernel.org>
 <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 27, 2022 at 09:13:03PM +0000, Conor.Dooley@microchip.com wrote:
> Hey Jisheng,

Hi Conor,

> On 27/08/2022 10:58, Jisheng Zhang wrote:
> > I have a Sipeed Lichee RV dock board which only has 512MB DDR, so
> > memory optimizations such as swap on zram are helpful. As is seen
> > in commit d0637c505f8a ("arm64: enable THP_SWAP for arm64") and
> > commit bd4c82c22c367e ("mm, THP, swap: delay splitting THP after
> > swapped out"), THP_SWAP can improve the swap throughput significantly.
> > 
> > Enable THP_SWAP for RV64, testing the micro-benchmark which is
> > introduced by commit d0637c505f8a ("arm64: enable THP_SWAP for arm64")
> > shows below numbers on the Lichee RV dock board:
> > 
> > thp swp throughput w/o patch: 66908 bytes/ms (mean of 10 tests)
> > thp swp throughput w/ patch: 322638 bytes/ms (mean of 10 tests)
> 
> I know the original commit message contains this, but it's a little
> odd. If the patch /enables/ THP then how would there be THP swap
> prior to the patch?

hmm, it's swap I'll send a v3 to correct the description.

> 
> > 
> > Improved by 382%!
> 
> I could not replicate the after numbers on my nezha, so I suspect
> I am missing something in my config/setup. zswap is enabled and is

swap on zram rather than zswap ;)

> working, TRANSPARENT_HUGEPAGE is enabled etc. Not that it matters
> for acceptance of the patch though.
> 
> I gave it a try and nothing went up in flames while using zswap so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > ---
> > Since v1:
> >  - collect reviewed-by tag
> >  - make ARCH_WANTS_THP_SWAP rely on HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >    instead
> > 
> >  arch/riscv/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index ed66c31e4655..79e52441e18b 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -45,6 +45,7 @@ config RISCV
> >  	select ARCH_WANT_FRAME_POINTERS
> >  	select ARCH_WANT_GENERAL_HUGETLB
> >  	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
> > +	select ARCH_WANTS_THP_SWAP if HAVE_ARCH_TRANSPARENT_HUGEPAGE
> >  	select BINFMT_FLAT_NO_DATA_START_OFFSET if !MMU
> >  	select BUILDTIME_TABLE_SORT if MMU
> >  	select CLONE_BACKWARDS
