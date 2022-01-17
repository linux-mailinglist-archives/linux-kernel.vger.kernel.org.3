Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FBD490953
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 14:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbiAQNSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 08:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiAQNSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 08:18:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF549C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 05:18:23 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1n9Rtu-0004nS-9h; Mon, 17 Jan 2022 14:18:22 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1n9Rtt-00APAa-61; Mon, 17 Jan 2022 14:18:21 +0100
Date:   Mon, 17 Jan 2022 14:18:21 +0100
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH v2 3/5] mtd: rawnand: gpmi: use a table to get EDO
 mode setup
Message-ID: <YeVsnQpOkyXaBk0+@pengutronix.de>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
 <20220117111829.1811997-4-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117111829.1811997-4-dario.binacchi@amarulasolutions.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 13:56:46 up 110 days,  1:53, 80 users,  load average: 20.96, 15.71,
 15.82
From:   Sascha Hauer <sha@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario,

On Mon, Jan 17, 2022 at 12:18:27PM +0100, Dario Binacchi wrote:
> +struct edo_mode {
> +	u32 tRC_min;
> +	long clk_rate;
> +	u8 wrn_dly_sel;
> +};
> +
> +static const struct edo_mode edo_modes[] = {
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 30000, .clk_rate = 22000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> +	{.tRC_min = 25000, .clk_rate = 80000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> +	{.tRC_min = 20000, .clk_rate = 100000000,
> +	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> +};
> +
>  /*
>   * <1> Firstly, we should know what's the GPMI-clock means.
>   *     The GPMI-clock is the internal clock in the gpmi nand controller.
> @@ -657,22 +678,18 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
>  	int sample_delay_ps, sample_delay_factor;
>  	u16 busy_timeout_cycles;
>  	u8 wrn_dly_sel;
> +	int i, emode = ARRAY_SIZE(edo_modes) - 1;
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
> +	/* Search the required EDO mode */
> +	for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
> +		if (sdr->tRC_min >= edo_modes[i].tRC_min) {
> +			emode = i;
> +			break;
> +		}

The first four entries of edo_modes[] all have the same value, so this loop
will never end on the second, third or fourth element. These elements are just
there to match 'emode' with the existing ONFI mode numbers, but then 'emode' is
never used as an ONFI mode number, instead it's only used as an index to the
array. You could equally well remove the second till fourth array entries.

Then with only three entries left in the array I wonder if you're not better
off with the original code and change it to something like:

	if (sdr->tRC_min >= 30000) {
		/* ONFI non-EDO modes [0-3] */
		hw->clk_rate = 22000000;
		min_rate = 0;
		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
	} else if (sdr->tRC_min >= 25000) {
		/* ONFI EDO mode 4 */
		hw->clk_rate = 80000000;
		min_rate = 22000000;
		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
	} else {
		/* ONFI EDO mode 5 */
		hw->clk_rate = 100000000;
		min_rate = 80000000;
		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
	}

	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
	if (hw->clk_rate < min_rate)
		return -EINVAL;

I think this would be easier to follow.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
