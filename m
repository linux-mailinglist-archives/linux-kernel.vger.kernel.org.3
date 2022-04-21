Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96433509DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388490AbiDUKoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbiDUKoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:44:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7DA3E2611E;
        Thu, 21 Apr 2022 03:41:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B4941FB;
        Thu, 21 Apr 2022 03:41:12 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54ABA3F5A1;
        Thu, 21 Apr 2022 03:41:10 -0700 (PDT)
Date:   Thu, 21 Apr 2022 11:41:05 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
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
Subject: Re: fully convert arm to use dma-direct
Message-ID: <20220421114105.4bb06db7@donnerap.cambridge.arm.com>
In-Reply-To: <20220421074204.1284072-1-hch@lst.de>
References: <20220421074204.1284072-1-hch@lst.de>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Apr 2022 09:41:57 +0200
Christoph Hellwig <hch@lst.de> wrote:

Hi,

> arm is the last platform not using the dma-direct code for directly
> mapped DMA.  With the dmaboune removal from Arnd we can easily switch
> arm to always use dma-direct now (it already does for LPAE configs
> and nommu).  I'd love to merge this series through the dma-mapping tree
> as it gives us the opportunity for additional core dma-mapping
> improvements.
> 
> Diffstat:
>  arch/arm/common/dmabounce.c                          |  582 -------------------
>  arch/arm/include/asm/dma-mapping.h                   |  128 ----
>  b/arch/arm/Kconfig                                   |    5 
>  b/arch/arm/common/Kconfig                            |    6 
>  b/arch/arm/common/Makefile                           |    1 
>  b/arch/arm/common/sa1111.c                           |   64 --
>  b/arch/arm/include/asm/device.h                      |    3 
>  b/arch/arm/include/asm/dma-direct.h                  |   49 -
>  b/arch/arm/include/asm/memory.h                      |    2 
>  b/arch/arm/mach-footbridge/Kconfig                   |    1 
>  b/arch/arm/mach-footbridge/common.c                  |   19 
>  b/arch/arm/mach-footbridge/include/mach/dma-direct.h |    8 
>  b/arch/arm/mach-footbridge/include/mach/memory.h     |    4 
>  b/arch/arm/mach-highbank/highbank.c                  |    2 

FWIW, I applied this on top of 5.18-rc3 and pushed my Midway (the Highbank
successor) a bit with it (scp-ing GBs forth and back to a SATA SSD). Not a
really conclusive test, but so far it looks all fine.

So for the Highbank part:
Acked-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre


>  b/arch/arm/mach-mvebu/coherency.c                    |    2 
>  b/arch/arm/mm/dma-mapping.c                          |  381 ------------
>  b/drivers/usb/core/hcd.c                             |   17 
>  b/drivers/usb/host/ohci-sa1111.c                     |   25 
>  18 files changed, 84 insertions(+), 1215 deletions(-)

