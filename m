Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D2554EDCD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379344AbiFPXNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiFPXNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:13:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE715D648;
        Thu, 16 Jun 2022 16:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA7DB612E3;
        Thu, 16 Jun 2022 23:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C38C34114;
        Thu, 16 Jun 2022 23:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655421231;
        bh=Ejx2DTxm/7UIK+VC+L1RteDR9DsxwnAj5eYVDoMkO4Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=eaA7OMkSsxkf1sWe94biqKhLOdZAJNvCqlCufdt04pueooz+KhapEvI2RSVqaKGuL
         AIiDRWSqe/kkFL4d6TRx/xAyYAnbP9gZhqSO5WY169uHl4aRjU3TKHb94QlcQxNitj
         orb+TbBIoSSnTPsFRbvNT4thWIdFL/qeOAyKXJnBE2e3+o/Kb+FU8xYc2pB6BJ2ssg
         jwlRA4yCaomvIjmQRRjXWrG1fjLsvljLLdfrrihO93mGrzBBZyBOl+nG8MQto28D/Z
         UYBvFv0auHw6hxwTSf/RJKzuqWatwgeco/wVAA3EwGfQvmaDkqIx6IuTKtMASDBvIA
         ibPJM7CD3G26Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id C6D8F5C1363; Thu, 16 Jun 2022 16:13:50 -0700 (PDT)
Date:   Thu, 16 Jun 2022 16:13:50 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        arnd@arndb.de, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 1/2] asm-generic: Add memory barrier dma_mb()
Message-ID: <20220616231350.GA1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220523113126.171714-1-wangkefeng.wang@huawei.com>
 <20220523113126.171714-2-wangkefeng.wang@huawei.com>
 <CANpmjNNPf5J2OcVxoMgVtFYjWJhJ2JE+UBFyqnt6+WrPobPOHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNPf5J2OcVxoMgVtFYjWJhJ2JE+UBFyqnt6+WrPobPOHQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 01:35:27PM +0200, Marco Elver wrote:
> On Mon, 23 May 2022 at 13:21, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >
> > The memory barrier dma_mb() is introduced by commit a76a37777f2c
> > ("iommu/arm-smmu-v3: Ensure queue is read after updating prod pointer"),
> > which is used to ensure that prior (both reads and writes) accesses
> > to memory by a CPU are ordered w.r.t. a subsequent MMIO write.
> >
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de> # for asm-generic
> > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>

Just checking...  Did these ever get picked up?  It was suggested
that they go up via the arm64 tree, if I remember correctly.

							Thanx, Paul

> > ---
> >  Documentation/memory-barriers.txt | 11 ++++++-----
> >  include/asm-generic/barrier.h     |  8 ++++++++
> >  2 files changed, 14 insertions(+), 5 deletions(-)
> >
> > diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> > index b12df9137e1c..832b5d36e279 100644
> > --- a/Documentation/memory-barriers.txt
> > +++ b/Documentation/memory-barriers.txt
> > @@ -1894,6 +1894,7 @@ There are some more advanced barrier functions:
> >
> >   (*) dma_wmb();
> >   (*) dma_rmb();
> > + (*) dma_mb();
> >
> >       These are for use with consistent memory to guarantee the ordering
> >       of writes or reads of shared memory accessible to both the CPU and a
> > @@ -1925,11 +1926,11 @@ There are some more advanced barrier functions:
> >       The dma_rmb() allows us guarantee the device has released ownership
> >       before we read the data from the descriptor, and the dma_wmb() allows
> >       us to guarantee the data is written to the descriptor before the device
> > -     can see it now has ownership.  Note that, when using writel(), a prior
> > -     wmb() is not needed to guarantee that the cache coherent memory writes
> > -     have completed before writing to the MMIO region.  The cheaper
> > -     writel_relaxed() does not provide this guarantee and must not be used
> > -     here.
> > +     can see it now has ownership.  The dma_mb() implies both a dma_rmb() and
> > +     a dma_wmb().  Note that, when using writel(), a prior wmb() is not needed
> > +     to guarantee that the cache coherent memory writes have completed before
> > +     writing to the MMIO region.  The cheaper writel_relaxed() does not provide
> > +     this guarantee and must not be used here.
> >
> >       See the subsection "Kernel I/O barrier effects" for more information on
> >       relaxed I/O accessors and the Documentation/core-api/dma-api.rst file for
> > diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> > index fd7e8fbaeef1..961f4d88f9ef 100644
> > --- a/include/asm-generic/barrier.h
> > +++ b/include/asm-generic/barrier.h
> > @@ -38,6 +38,10 @@
> >  #define wmb()  do { kcsan_wmb(); __wmb(); } while (0)
> >  #endif
> >
> > +#ifdef __dma_mb
> > +#define dma_mb()       do { kcsan_mb(); __dma_mb(); } while (0)
> > +#endif
> > +
> >  #ifdef __dma_rmb
> >  #define dma_rmb()      do { kcsan_rmb(); __dma_rmb(); } while (0)
> >  #endif
> > @@ -65,6 +69,10 @@
> >  #define wmb()  mb()
> >  #endif
> >
> > +#ifndef dma_mb
> > +#define dma_mb()       mb()
> > +#endif
> > +
> >  #ifndef dma_rmb
> >  #define dma_rmb()      rmb()
> >  #endif
> > --
> > 2.35.3
> >
