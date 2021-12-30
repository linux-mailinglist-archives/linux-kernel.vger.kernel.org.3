Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2E4481DD4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbhL3PtG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Dec 2021 10:49:06 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:40021 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbhL3PtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:49:05 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id AF2581C0005;
        Thu, 30 Dec 2021 15:49:02 +0000 (UTC)
Date:   Thu, 30 Dec 2021 16:49:01 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL 2/2] memory: omap: drivers for v5.17
Message-ID: <20211230164901.4fbf8cc3@xps13>
In-Reply-To: <20211224111124.6097-2-krzysztof.kozlowski@canonical.com>
References: <20211224111124.6097-1-krzysztof.kozlowski@canonical.com>
        <20211224111124.6097-2-krzysztof.kozlowski@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, Arnd, Olof,

krzysztof.kozlowski@canonical.com wrote on Fri, 24 Dec 2021 12:11:24
+0100:

> Hi Arnd and Olof,
> 
> Separate topic branch for omap-gpmc driver. This includes changes to
> mtd-nand-omap2 driver (acked by Miquel) *which will conflict NAND tree*:
> 
> 1. The "of_device_id omap_nand_ids" is moved to header
>    ../platform_data/mtd-nand-omap2.h.
> 2. New compatible is added to above "of_device_id omap_nand_ids".
> 
> One way to avoid pushing this conflict to Linus, would be if Miquel would
> actually pull this request instead of soc tree.

Sorry for the mess, I didn't spot the conflict when sending my Ack to
Krysztof.

I will pull this to simplify the handling.

Thanks,
Miquèl

> 
> Proper resolution looks like:
> ----------------------------------------------------------------
> diff --git a/include/linux/platform_data/mtd-nand-omap2.h b/include/linux/platform_data/mtd-nand-omap2.h
> index 92f011805ad4..8c2f1f185353 100644
> --- a/include/linux/platform_data/mtd-nand-omap2.h
> +++ b/include/linux/platform_data/mtd-nand-omap2.h
> @@ -65,6 +65,7 @@ struct gpmc_nand_regs {
>  
>  static const struct of_device_id omap_nand_ids[] = {
>  	{ .compatible = "ti,omap2-nand", },
> +	{ .compatible = "ti,am64-nand", },
>  	{},
>  };
> ----------------------------------------------------------------
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:
> 
>   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-omap-5.17
> 
> for you to fetch changes up to dbcb124acebd8148e9e858a231f1798956dd3ca6:
> 
>   mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3 (2021-12-22 16:51:43 +0100)
> 
> ----------------------------------------------------------------
> Memory controller drivers for v5.14 - OMAP GPMC
> 
> 1. Add support for AM64 SoC.
> 2. Minor improvement: use platform_get_irq().
> 
> ----------------------------------------------------------------
> Lad Prabhakar (1):
>       memory: omap-gpmc: Use platform_get_irq() to get the interrupt
> 
> Roger Quadros (4):
>       dt-bindings: memory-controllers: ti,gpmc: Add compatible for AM64
>       memory: omap-gpmc: Add support for GPMC on AM64 SoC
>       memory: omap-gpmc: Use a compatible match table when checking for NAND controller
>       mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3
> 
>  .../bindings/memory-controllers/ti,gpmc.yaml       | 23 +++++++++-
>  drivers/memory/omap-gpmc.c                         | 50 ++++++++++++++--------
>  drivers/mtd/nand/raw/Kconfig                       |  1 +
>  drivers/mtd/nand/raw/omap2.c                       |  5 +--
>  include/linux/platform_data/mtd-nand-omap2.h       |  9 +++-
>  5 files changed, 65 insertions(+), 23 deletions(-)
