Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A855F68A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbiF2G2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiF2G2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:28:42 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292E27B2E;
        Tue, 28 Jun 2022 23:28:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3AFBD67373; Wed, 29 Jun 2022 08:28:37 +0200 (CEST)
Date:   Wed, 29 Jun 2022 08:28:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: fully convert arm to use dma-direct v3
Message-ID: <20220629062837.GA17140@lst.de>
References: <20220614092047.572235-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614092047.572235-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments or additional testing?  It would be really great to get
this off the table.

On Tue, Jun 14, 2022 at 11:20:37AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.
> 
> Changes since v2:
>  - rebased to Linux 5.19-rc2
> 
> Changes since v1:
>  - remove another unused function
>  - improve a few commit logs
>  - add three more patches from Robin
> 
> Diffstat:
>  arch/arm/common/dmabounce.c                          |  582 -----------------
>  arch/arm/include/asm/dma-mapping.h                   |  128 ---
>  b/arch/arm/Kconfig                                   |    5 
>  b/arch/arm/common/Kconfig                            |    6 
>  b/arch/arm/common/Makefile                           |    1 
>  b/arch/arm/common/sa1111.c                           |   64 -
>  b/arch/arm/include/asm/device.h                      |    3 
>  b/arch/arm/include/asm/dma-direct.h                  |   49 -
>  b/arch/arm/include/asm/memory.h                      |    2 
>  b/arch/arm/mach-footbridge/Kconfig                   |    1 
>  b/arch/arm/mach-footbridge/common.c                  |   19 
>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
>  b/arch/arm/mach-highbank/highbank.c                  |    2 
>  b/arch/arm/mach-mvebu/coherency.c                    |    2 
>  b/arch/arm/mm/dma-mapping.c                          |  649 ++-----------------
>  b/drivers/usb/core/hcd.c                             |   17 
>  b/drivers/usb/host/ohci-sa1111.c                     |   25 
>  18 files changed, 137 insertions(+), 1430 deletions(-)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
---end quoted text---
