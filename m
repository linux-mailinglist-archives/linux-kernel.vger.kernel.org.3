Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F406754DE60
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 11:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359463AbiFPJrM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jun 2022 05:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiFPJrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 05:47:08 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9295A2C8;
        Thu, 16 Jun 2022 02:47:03 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o1m5O-0004rx-Ut; Thu, 16 Jun 2022 11:46:46 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management operations
Date:   Thu, 16 Jun 2022 11:46:45 +0200
Message-ID: <1752040.TLkxdtWsSY@diego>
In-Reply-To: <20220615174910.GA26607@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <110361853.nniJfEyVGO@diego> <20220615174910.GA26607@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Mittwoch, 15. Juni 2022, 19:49:10 CEST schrieb Christoph Hellwig:
> On Wed, Jun 15, 2022 at 06:56:40PM +0200, Heiko Stübner wrote:
> > If I'm reading things correctly [0], the default for those functions
> > is for those to be empty - but defined in the coherent case.
> 
> That's not the point.
> 
> Zicbom is just an extension that allows the CPU to support managing
> cache state.  Non-coherent DMA is just one of the use cases there
> are others like persistent memory.  And when a CPU core supports
> Zicbom it might or might not have any non-coherent periphals.  Or
> even some coherent and some non-coherent ones, something that
> is pretty common in arm/arm64 CPUs, where PCIe is usually cache
> coherent, but some other cheap periphals might not be.
> 
> That is why Linux ports require the plaform (usually through
> DT or ACPI) to mark which devices are coherent and which ones
> are not.

I "get" it now I think. I was somewhat struggling what you were aiming
at, but that was something of not seeing "the forest for the trees" on
my part. And of course you were right in recognizing that issue :-) .

Without CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and friends
dev_is_dma_coherent() will always return true otherwise the dma_coherent
attribute. Hence the "coherent" value for every system not managing things
will suddenly show as non-coherent where it showed as coherent before.


As we already have detection-points for non-coherent systems (zicbom
detection, t-head errata detection) I guess just also switching some boolean
might solve that, so that arch_setup_dma_ops() will set the dma_coherent
attribute to true always except when some non-coherent system is detected.


void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
                const struct iommu_ops *iommu, bool coherent)
{
        /* only track coherent attributes, if cache-management is available */
        if (enable_noncoherency)
                dev->dma_coherent = coherent;
        else
                dev->dma_coherent = true;
}


Heiko


