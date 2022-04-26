Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8885050FD96
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346783AbiDZMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350193AbiDZMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:53:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE28237037
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:50:42 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7925B23A;
        Tue, 26 Apr 2022 05:50:42 -0700 (PDT)
Received: from lakrids (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9096C3F774;
        Tue, 26 Apr 2022 05:50:41 -0700 (PDT)
Date:   Tue, 26 Apr 2022 13:50:39 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Marco Elver <elver@google.com>, will@kernel.org
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kcsan: Fix kcsan test_barrier fail and panic
Message-ID: <Ymfqn+I5szGeB5dU@lakrids>
References: <20220426081700.1376542-1-wangkefeng.wang@huawei.com>
 <YmfhHuPDilwR/Wgp@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmfhHuPDilwR/Wgp@elver.google.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 02:10:06PM +0200, Marco Elver wrote:
> On Tue, Apr 26, 2022 at 08:17AM +0000, Kefeng Wang wrote:
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index fd7e8fbaeef1..18863c50e9ce 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -38,6 +38,10 @@
> >  #define wmb()	do { kcsan_wmb(); __wmb(); } while (0)
> >  #endif
> >  
> > +#ifdef __dma_mb
> > +#define dma_mb()	do { kcsan_mb(); __dma_mb(); } while (0)
> > +#endif
> > +
> 
> So it looks like arm64 is the only arch that defines dma_mb(). By adding
> it to asm-generic, we'd almost be encouraging other architectures to add
> it, which I don't know we want.
> 
> Documentation/memory-barriers.txt doesn't mention dma_mb() either - so
> perhaps dma_mb() doesn't belong in asm-generic/barrier.h, and you could
> only change arm64's definition of dma_mb() to add the kcsan_mb().
> 
> Preferences? Maybe arch64 maintainers have more background on why arm64
> is an anomaly here.

Looking around, there's a single user:

[mark@lakrids:~/src/linux]% git grep -w dma_mb 
arch/arm64/include/asm/barrier.h:#define dma_mb()       dmb(osh)
arch/arm64/include/asm/io.h:#define __iomb()            dma_mb()

[mark@lakrids:~/src/linux]% git grep -w __iomb 
arch/arm64/include/asm/io.h:#define __iomb()            dma_mb()
drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c:    __iomb();

... and that was introduced in commit:

  a76a37777f2c936b ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer")

... where it is used to ensure that prior (read and write) accesses to
memory by a CPU are ordered w.r.t. a subsequent MMIO write.

That seems like it could be a generic shape of problem (especially for
IOMMUs), even if arm64 is the only architecture with an implementation
today. From my PoV it would weem to make sense as a generic thing, and
should probably be added to Documentation/memory-barriers.txt.

Will, thoughts?

Thanks,
Mark.
