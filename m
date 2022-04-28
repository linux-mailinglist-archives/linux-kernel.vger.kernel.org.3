Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B2E513199
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 12:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343942AbiD1Kw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 06:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiD1Kw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 06:52:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C8189321
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 03:49:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FB9CB82919
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 10:49:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33B6C385A9;
        Thu, 28 Apr 2022 10:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651142950;
        bh=3AM7hjMP5FZp+VYPxxlIsZyIgjgdKYMnzPk2OZ7fWik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lzqcmZxRjBXAmnpf3HE3/Px6ORmTvynmeErUOAAHE2PAT1d76SYPqe4sauqX20Ml+
         kJ3fTMlJl2nwl8vsz2rEDD3GXKT7s02T+rsdFgKVAHWu0lrvcBgpfMCFg24n7XOtjF
         erGy21ZVROw0Xh/X9CilPe6RGYHjxrxq5SOvUUL2gqTVmuevyr1q9v3ntSUDXiyru7
         DMtRTWc7Ymft0cnT0Fb3zON51SLzCKoGtSXBTPEpqylCpPf3MqK2P1ySALgPTAmFo0
         VtfVcRP3rih/oLchzKnofLXwCqsqogNnxMUrpbPrBPK9nuQIXwLQ/vNaqMHAD2K0CA
         uQbcG5oKvThQg==
Date:   Thu, 28 Apr 2022 11:49:05 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Message-ID: <20220428104904.GB14515@willie-the-truck>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
 <YmfhHuPDilwR/Wgp@elver.google.com>
 <Ymfqn+I5szGeB5dU@lakrids>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ymfqn+I5szGeB5dU@lakrids>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 01:50:39PM +0100, Mark Rutland wrote:
> On Tue, Apr 26, 2022 at 02:10:06PM +0200, Marco Elver wrote:
> > On Tue, Apr 26, 2022 at 08:17AM +0000, Kefeng Wang wrote:
> > > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > > index fd7e8fbaeef1..18863c50e9ce 100644
> > > --- a/include/asm-generic/barrier.h
> > > +++ b/include/asm-generic/barrier.h
> > > @@ -38,6 +38,10 @@
> > >  #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
> > >  #endif
> > >  
> > > +#ifdef __dma_mb
> > > +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
> > > +#endif
> > > +
> > 
> > So it looks like arm64 is the only arch that defines dma_mb(). By adding
> > it to asm-generic, we'd almost be encouraging other architectures to add
> > it, which I don't know we want.
> > 
> > Documentation/memory-barriers.txt doesn't mention dma_mb() either - so
> > perhaps dma_mb() doesn't belong in asm-generic/barrier.h, and you could
> > only change arm64's definition of dma_mb() to add the kcsan_mb().
> > 
> > Preferences? Maybe arch64 maintainers have more background on why arm64
> > is an anomaly here.
> 
> Looking around, there's a single user:
> 
> [mark@lakrids:~/src/linux]% git grep -w dma_mb 
> arch/arm64/include/asm/barrier.h:#define dma_mb()       dmb(osh)
> arch/arm64/include/asm/io.h:#define __iomb()            dma_mb()
> 
> [mark@lakrids:~/src/linux]% git grep -w __iomb 
> arch/arm64/include/asm/io.h:#define __iomb()            dma_mb()
> drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:    __iomb();
> 
> ... and that was introduced in commit:
> 
>   a76a37777f2c936b ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer")
> 
> ... where it is used to ensure that prior (read and write) accesses to
> memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> 
> That seems like it could be a generic shape of problem (especially for
> IOMMUs), even if arm64 is the only architecture with an implementation
> today. From my PoV it would weem to make sense as a generic thing, and
> should probably be added to Documentation/memory-barriers.txt.
> 
> Will, thoughts?

Given that the read and write variants are generic, making the full-fat
version version as well makes sense to me.

Will
