Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE4654E04B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376982AbiFPLxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 07:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376967AbiFPLxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 07:53:48 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543F754BEC;
        Thu, 16 Jun 2022 04:53:47 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 129BB67373; Thu, 16 Jun 2022 13:53:43 +0200 (CEST)
Date:   Thu, 16 Jun 2022 13:53:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Christoph Hellwig <hch@lst.de>, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, wefu@redhat.com, guoren@kernel.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu, samuel@sholland.org,
        atishp@atishpatra.org, anup@brainfault.org, mick@ics.forth.gr,
        robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org,
        drew@beagleboard.org, Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH 2/3] riscv: Implement Zicbom-based cache management
 operations
Message-ID: <20220616115342.GA11289@lst.de>
References: <20220610004308.1903626-1-heiko@sntech.de> <110361853.nniJfEyVGO@diego> <20220615174910.GA26607@lst.de> <1752040.TLkxdtWsSY@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1752040.TLkxdtWsSY@diego>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 11:46:45AM +0200, Heiko Stübner wrote:
> Without CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and friends
> dev_is_dma_coherent() will always return true otherwise the dma_coherent
> attribute. Hence the "coherent" value for every system not managing things
> will suddenly show as non-coherent where it showed as coherent before.

Yes.

> As we already have detection-points for non-coherent systems (zicbom
> detection, t-head errata detection)

No, we don't.  There are plenty of reasons to support Zicbom without
every having any non-coherent DMA periphals.  Or just some non-coherent
ones.  So that alone is not a good indicator at all.

The proper interface for that in DT-based setups i of_dma_is_coherent(),
which looks at the dma-coherent DT property.  And given that RISC-V
started out as all coherent we need to follow the powerpc way
(CONFIG_OF_DMA_DEFAULT_COHERENT) and default to coherent with an
explcit propery for non-coherent devices, and not the arm/arm64 way
where non-coherent is the default and coherent devices need the property.
