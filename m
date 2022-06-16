Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FBC54E08F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiFPMKG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Jun 2022 08:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiFPMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 08:10:04 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE0928E10;
        Thu, 16 Jun 2022 05:10:02 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1o1oJo-0005ZY-OM; Thu, 16 Jun 2022 14:09:48 +0200
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
Date:   Thu, 16 Jun 2022 14:09:47 +0200
Message-ID: <2041345.KlZ2vcFHjT@diego>
In-Reply-To: <20220616115342.GA11289@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <1752040.TLkxdtWsSY@diego> <20220616115342.GA11289@lst.de>
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

Am Donnerstag, 16. Juni 2022, 13:53:42 CEST schrieb Christoph Hellwig:
> On Thu, Jun 16, 2022 at 11:46:45AM +0200, Heiko Stübner wrote:
> > Without CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and friends
> > dev_is_dma_coherent() will always return true otherwise the dma_coherent
> > attribute. Hence the "coherent" value for every system not managing things
> > will suddenly show as non-coherent where it showed as coherent before.
> 
> Yes.
> 
> > As we already have detection-points for non-coherent systems (zicbom
> > detection, t-head errata detection)
> 
> No, we don't.  There are plenty of reasons to support Zicbom without
> every having any non-coherent DMA periphals.  Or just some non-coherent
> ones.  So that alone is not a good indicator at all.
> 
> The proper interface for that in DT-based setups i of_dma_is_coherent(),
> which looks at the dma-coherent DT property.  And given that RISC-V
> started out as all coherent we need to follow the powerpc way
> (CONFIG_OF_DMA_DEFAULT_COHERENT) and default to coherent with an
> explcit propery for non-coherent devices, and not the arm/arm64 way
> where non-coherent is the default and coherent devices need the property.

I did look at the dma-coherent-property -> of_dma_is_coherent()
	 -> of_dma_configure_id() -> arch_setup_dma_ops() chain yesterday
which setups the value dev_is_dma_coherent() returns.

The Zicbom extension will only be in new platforms, so none of the currently
supported ones will have that. So my thinking was that we can default to
true in arch_setup_dma_ops() and only use the read coherency value when
actual cache-managment-operations are defined.

My guess was that new platforms implementing cache-management will want
to be non-coherent by default?

So if the kernel is running on a platform not implementing cache-management
dev_is_dma_coherent() would always return true as it does now, while on a
new platform implementing cache-management we'd default to non-coherent
and expect that new devicetree/firmware to specify the coherent devices.




