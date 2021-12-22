Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7184747D4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhLVQI6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 11:08:58 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56649 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232944AbhLVQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:08:57 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 96A9A60007;
        Wed, 22 Dec 2021 16:08:55 +0000 (UTC)
Date:   Wed, 22 Dec 2021 17:08:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 2/4] mtd: rawnand: gpmi: support fast edo timings
 for mx28
Message-ID: <20211222170854.7f6f91da@xps13>
In-Reply-To: <20211217155512.1877408-3-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
        <20211217155512.1877408-3-dario.binacchi@amarulasolutions.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

dario.binacchi@amarulasolutions.com wrote on Fri, 17 Dec 2021 16:55:10
+0100:

> In the mx28 reference manual there are examples of how to set up the
> GPMI controller to support fast NAND EDO timing.

... which are? I am not sure to understand what you mean here.

And what you change below is just "not refusing EDO timings with on
MX28". There is a mismatch between the the two.

Plus, it seems that this patch should come last given the fact that
you're fixing the EDO calculations.

> This patch has been tested on a 2048/64 byte NAND (Micron MT29F2G08ABAEAH4).
> Kernel mtd tests:
>  - mtd_nandbiterrs
>  - mtd_nandecctest
>  - mtd_oobtest
>  - mtd_pagetest
>  - mtd_readtest
>  - mtd_speedtest
>  - mtd_stresstest
>  - mtd_subpagetest
>  - mtd_torturetest [cycles_count = 10000000]
> run without errors.
> 
> Before this patch (mode 0):
> ---------------------------
> eraseblock write speed is 2098 KiB/s
> eraseblock read speed is 2680 KiB/s
> page write speed is 1689 KiB/s
> page read speed is 2522 KiB/s
> 2 page write speed is 1899 KiB/s
> 2 page read speed is 2579 KiB/s
> erase speed is 128000 KiB/s
> 2x multi-block erase speed is 73142 KiB/s
> 4x multi-block erase speed is 204800 KiB/s
> 8x multi-block erase speed is 256000 KiB/s
> 16x multi-block erase speed is 256000 KiB/s
> 32x multi-block erase speed is 256000 KiB/s
> 64x multi-block erase speed is 256000 KiB/s
> 
> After this patch (mode 5):
> -------------------------
> eraseblock write speed is 3390 KiB/s
> eraseblock read speed is 5688 KiB/s
> page write speed is 2680 KiB/s
> page read speed is 4876 KiB/s
> 2 page write speed is 2909 KiB/s
> 2 page read speed is 5224 KiB/s
> erase speed is 170666 KiB/s
> 2x multi-block erase speed is 204800 KiB/s
> 4x multi-block erase speed is 256000 KiB/s
> 8x multi-block erase speed is 256000 KiB/s
> 16x multi-block erase speed is 256000 KiB/s
> 32x multi-block erase speed is 256000 KiB/s
> 64x multi-block erase speed is 256000 KiB/s
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> 
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 65bcd1c548d2..fd935e893daf 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -772,8 +772,8 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
>  	if (IS_ERR(sdr))
>  		return PTR_ERR(sdr);
>  
> -	/* Only MX6 GPMI controller can reach EDO timings */
> -	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX6(this))
> +	/* Only MX28/MX6 GPMI controller can reach EDO timings */
> +	if (sdr->tRC_min <= 25000 && !GPMI_IS_MX28(this) && !GPMI_IS_MX6(this))
>  		return -ENOTSUPP;
>  
>  	/* Stop here if this call was just a check */


Thanks,
Miquèl
