Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6E847D4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbhLVQKf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 11:10:35 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:37997 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbhLVQKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:10:34 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id E02E91C0006;
        Wed, 22 Dec 2021 16:10:30 +0000 (UTC)
Date:   Wed, 22 Dec 2021 17:10:29 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Han Xu <han.xu@nxp.com>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 3/4] mtd: rawnand: gpmi: fix controller timings
 setting
Message-ID: <20211222171029.6e39ec4f@xps13>
In-Reply-To: <20211217155512.1877408-4-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
        <20211217155512.1877408-4-dario.binacchi@amarulasolutions.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

dario.binacchi@amarulasolutions.com wrote on Fri, 17 Dec 2021 16:55:11
+0100:

> The controller registers are now set accordling to the real clock rate.

You should use another tense (which I forgot the name) such as:

Set the controller registers according to the real clock rate.

But most importantly, you should explain why and perhaps give examples
of frequencies on your setup.

> Fixes: b1206122069a ("mtd: rawnand: gpmi: use core timings instead of an empirical derivation")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> 
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index fd935e893daf..0517b81bb24c 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -648,6 +648,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
>  				     const struct nand_sdr_timings *sdr)
>  {
>  	struct gpmi_nfc_hardware_timing *hw = &this->hw;
> +	struct resources *r = &this->resources;
>  	unsigned int dll_threshold_ps = this->devdata->max_chain_delay;
>  	unsigned int period_ps, reference_period_ps;
>  	unsigned int data_setup_cycles, data_hold_cycles, addr_setup_cycles;
> @@ -671,6 +672,8 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
>  		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
>  	}
>  
> +	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
> +
>  	/* SDR core timings are given in picoseconds */
>  	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
>  


Thanks,
Miquèl
