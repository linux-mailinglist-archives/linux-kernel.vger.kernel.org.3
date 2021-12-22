Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6D47D515
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 17:23:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241756AbhLVQX3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Dec 2021 11:23:29 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:53741 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbhLVQX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 11:23:28 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 48046200005;
        Wed, 22 Dec 2021 16:23:25 +0000 (UTC)
Date:   Wed, 22 Dec 2021 17:23:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 4/4] mtd: rawnand: gpmi: validate controller clock
 rate
Message-ID: <20211222172323.1bc565c0@xps13>
In-Reply-To: <20211217155512.1877408-5-dario.binacchi@amarulasolutions.com>
References: <20211217155512.1877408-1-dario.binacchi@amarulasolutions.com>
        <20211217155512.1877408-5-dario.binacchi@amarulasolutions.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

dario.binacchi@amarulasolutions.com wrote on Fri, 17 Dec 2021 16:55:12
+0100:

> What to do when the real rate of the gpmi clock is not equal to the
> required one? The solutions proposed in [1] did not lead to a conclusion
> on how to validate the clock rate, so, inspired by the document [2], I
> consider the rate correct only if not greater than the rate of the
> previous edo.

Not greater? what are you talking about here, if it's a rate, are you
sure "not greater" is what you mean?

> In fact, in chapter 4.16.2 (NV-DDR) of the document [2],
> it is written that "If the host selects timing mode n, then its clock
> period shall be faster than the clock period of timing mode n-1 and

faster? is that the real wording in the document? seems inaccurate when
referring to a clock period.

> slower than or equal to the clock period of timing mode n.". I thought
> that it could therefore also be used in this case, without therefore
> having to define the valid rate ranges empirically.

Can you give empirical values in your case so that we understand better
the problem that you are trying to solve and how you solve it?

Also, I don't know if the NV-DDR logic applies to SDR EDO modes, but if
it works and if Han acknowledges it, it's fine for me.

> [1] https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org
> [2] http://www.onfi.org/-/media/client/onfi/specs/onfi_3_0_gold.pdf?la=en
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>

You need Michael's Signed-off-by.

> 
> ---
> 
>  drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 70 +++++++++++++++++-----
>  1 file changed, 54 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> index 0517b81bb24c..3d37cd49abd5 100644
> --- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> +++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
> @@ -570,6 +570,27 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
>  	return ret;
>  }
>  
> +struct edo_mode {
> +	u32 tRC_min;
> +	long clk_rate;
> +	u8 wrn_dly_sel;
> +};
> +
> +static const struct edo_mode edo_modes[] = {
> +	{.tRC_min = 30000, .clk_rate = 22000000,

Do you really need to provide a tRC_min here? It is already part of the
nand_timings structure.

> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,

Not sure to get the difference between these three first modes.

> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 25000, .clk_rate = 80000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> +	{.tRC_min = 20000, .clk_rate = 100000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},

I am also tempted to say that I don't really understand what this is
all about, maybe an explanation would be good in a comment.
> +};
> +
>  /*
>   * <1> Firstly, we should know what's the GPMI-clock means.
>   *     The GPMI-clock is the internal clock in the gpmi nand controller.
> @@ -644,8 +665,8 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
>   *         RDN_DELAY = -----------------------     {3}
>   *                           RP
>   */
> -static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
> -				     const struct nand_sdr_timings *sdr)
> +static int gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
> +				    const struct nand_sdr_timings *sdr)
>  {
>  	struct gpmi_nfc_hardware_timing *hw = &this->hw;
>  	struct resources *r = &this->resources;
> @@ -657,22 +678,35 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
>  	int sample_delay_ps, sample_delay_factor;
>  	u16 busy_timeout_cycles;
>  	u8 wrn_dly_sel;
> +	long clk_rate;
> +	int i, emode = -1;
>  
> -	if (sdr->tRC_min >= 30000) {
> -		/* ONFI non-EDO modes [0-3] */
> -		hw->clk_rate = 22000000;
> -		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
> -	} else if (sdr->tRC_min >= 25000) {
> -		/* ONFI EDO mode 4 */
> -		hw->clk_rate = 80000000;
> -		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> -	} else {
> -		/* ONFI EDO mode 5 */
> -		hw->clk_rate = 100000000;
> -		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;

I would rather prefer a preparation patch which changes nothing in the
behavior, but prepares the following change where you actually do
something different so that we don't mi the wrn_dly_sel change with the
clock rate approximation.

Also, please consider using the ONFI modes now provided in the timings
structure if it helps.

> +	/* Search the required EDO mode */
> +	for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
> +		if (sdr->tRC_min >= edo_modes[i].tRC_min) {
> +			emode = i;
> +			break;
> +		}
> +	}
> +
> +	if (emode < 0) {
> +		dev_err(this->dev, "tRC_min %d not supported\n", sdr->tRC_min);
> +		return -ENOTSUPP;
> +	}
> +
> +	clk_rate = clk_round_rate(r->clock[0], edo_modes[emode].clk_rate);
> +	if (emode > 0 && !(clk_rate <= edo_modes[emode].clk_rate &&
> +			   clk_rate > edo_modes[emode - 1].clk_rate)) {
> +		dev_err(this->dev,
> +			"edo mode %d clock setting: expected %ld, got %ld\n",
> +			emode, edo_modes[emode].clk_rate, clk_rate);
> +		return -ENOTSUPP;
>  	}
>  
> -	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
> +	dev_dbg(this->dev, "edo mode %d @ %ld Hz\n", emode, clk_rate);
> +
> +	hw->clk_rate = clk_rate;
> +	wrn_dly_sel = edo_modes[emode].wrn_dly_sel;
>  
>  	/* SDR core timings are given in picoseconds */
>  	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
> @@ -714,6 +748,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
>  		hw->ctrl1n |= BF_GPMI_CTRL1_RDN_DELAY(sample_delay_factor) |
>  			      BM_GPMI_CTRL1_DLL_ENABLE |
>  			      (use_half_period ? BM_GPMI_CTRL1_HALF_PERIOD : 0);

Space

> +	return 0;
>  }
>  
>  static int gpmi_nfc_apply_timings(struct gpmi_nand_data *this)
> @@ -769,6 +804,7 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
>  {
>  	struct gpmi_nand_data *this = nand_get_controller_data(chip);
>  	const struct nand_sdr_timings *sdr;
> +	int ret;
>  
>  	/* Retrieve required NAND timings */
>  	sdr = nand_get_sdr_timings(conf);
> @@ -784,7 +820,9 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
>  		return 0;
>  
>  	/* Do the actual derivation of the controller timings */
> -	gpmi_nfc_compute_timings(this, sdr);
> +	ret = gpmi_nfc_compute_timings(this, sdr);
> +	if (ret)
> +		return ret;
>  
>  	this->hw.must_apply_timings = true;
>  


Thanks,
Miquèl
