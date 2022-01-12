Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D18148C5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354106AbiALO1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 09:27:08 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:40592 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239105AbiALO1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 09:27:05 -0500
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Jan 2022 09:27:05 EST
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id AF483FB03;
        Wed, 12 Jan 2022 15:20:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id a970IfYtB6-K; Wed, 12 Jan 2022 15:20:35 +0100 (CET)
Date:   Wed, 12 Jan 2022 15:20:27 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: freescale: i.MX8 PHYs should depend on ARCH_MXC &&
 ARM64
Message-ID: <Yd7jqwG/qmkSXfPz@qwark.sigxcpu.org>
References: <393868affd830016d35f0d9aba32ccd7098c8073.1641987369.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <393868affd830016d35f0d9aba32ccd7098c8073.1641987369.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Jan 12, 2022 at 12:40:38PM +0100, Geert Uytterhoeven wrote:
> The Freescale/NXP i.MX8 USB3, MIPI DSI, and PCIE PHYs are only present
> on the NXP i.MX8 family of SoCs.  Hence wrap the config symbols for
> these PHYs inside a check for ARCH_MXC && ARM64, to prevent asking the
> user about these drivers when configuring a kernel without NXP i.MX SoC
> family support.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Sounds good to me:

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido

> ---
>  drivers/phy/freescale/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/phy/freescale/Kconfig b/drivers/phy/freescale/Kconfig
> index c3669c28ea9fe83a..856cbec7057d9e54 100644
> --- a/drivers/phy/freescale/Kconfig
> +++ b/drivers/phy/freescale/Kconfig
> @@ -1,4 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +
> +if (ARCH_MXC && ARM64) || COMPILE_TEST
> +
>  config PHY_FSL_IMX8MQ_USB
>  	tristate "Freescale i.MX8M USB3 PHY"
>  	depends on OF && HAS_IOMEM
> @@ -22,3 +25,5 @@ config PHY_FSL_IMX8M_PCIE
>  	help
>  	  Enable this to add support for the PCIE PHY as found on
>  	  i.MX8M family of SOCs.
> +
> +endif
> -- 
> 2.25.1
> 
