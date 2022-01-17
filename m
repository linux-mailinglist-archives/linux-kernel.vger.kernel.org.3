Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BB2490B45
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 16:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbiAQPQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 10:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiAQPQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 10:16:40 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A91C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 07:16:40 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1n9TkM-0002fX-Kj; Mon, 17 Jan 2022 16:16:38 +0100
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1n9TkJ-0004sF-U3; Mon, 17 Jan 2022 16:16:35 +0100
Date:   Mon, 17 Jan 2022 16:16:35 +0100
From:   Sascha Hauer <sha@pengutronix.de>
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
Message-ID: <20220117151635.GB23490@pengutronix.de>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
 <20220117111829.1811997-4-dario.binacchi@amarulasolutions.com>
 <YeVsnQpOkyXaBk0+@pengutronix.de>
 <CABGWkvruAWcOxX99U0jcK1sz+AoGKKJwHWbtn_kSO=SJsCO5Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABGWkvruAWcOxX99U0jcK1sz+AoGKKJwHWbtn_kSO=SJsCO5Wg@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 15:16:11 up 37 days, 23:01, 81 users,  load average: 0.33, 0.20,
 0.20
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 03:08:30PM +0100, Dario Binacchi wrote:
> Hi Sascha,
> 
> On Mon, Jan 17, 2022 at 2:18 PM Sascha Hauer <sha@pengutronix.de> wrote:
> >
> > Hi Dario,
> >
> > On Mon, Jan 17, 2022 at 12:18:27PM +0100, Dario Binacchi wrote:
> > > +struct edo_mode {
> > > +     u32 tRC_min;
> > > +     long clk_rate;
> > > +     u8 wrn_dly_sel;
> > > +};
> > > +
> > > +static const struct edo_mode edo_modes[] = {
> > > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > > +     {.tRC_min = 30000, .clk_rate = 22000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
> > > +     {.tRC_min = 25000, .clk_rate = 80000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> > > +     {.tRC_min = 20000, .clk_rate = 100000000,
> > > +      .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
> > > +};
> > > +
> > >  /*
> > >   * <1> Firstly, we should know what's the GPMI-clock means.
> > >   *     The GPMI-clock is the internal clock in the gpmi nand controller.
> > > @@ -657,22 +678,18 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
> > >       int sample_delay_ps, sample_delay_factor;
> > >       u16 busy_timeout_cycles;
> > >       u8 wrn_dly_sel;
> > > +     int i, emode = ARRAY_SIZE(edo_modes) - 1;
> > >
> > > -     if (sdr->tRC_min >= 30000) {
> > > -             /* ONFI non-EDO modes [0-3] */
> > > -             hw->clk_rate = 22000000;
> > > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
> > > -     } else if (sdr->tRC_min >= 25000) {
> > > -             /* ONFI EDO mode 4 */
> > > -             hw->clk_rate = 80000000;
> > > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> > > -     } else {
> > > -             /* ONFI EDO mode 5 */
> > > -             hw->clk_rate = 100000000;
> > > -             wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> > > +     /* Search the required EDO mode */
> > > +     for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
> > > +             if (sdr->tRC_min >= edo_modes[i].tRC_min) {
> > > +                     emode = i;
> > > +                     break;
> > > +             }
> >
> > The first four entries of edo_modes[] all have the same value, so this loop
> > will never end on the second, third or fourth element. These eleqments are just
> > there to match 'emode' with the existing ONFI mode numbers, but then 'emode' is
> > never used as an ONFI mode number, instead it's only used as an index to the
> > array. You could equally well remove the second till fourth array entries.
> >
> > Then with only three entries left in the array I wonder if you're not better
> > off with the original code and change it to something like:
> 
> This implementation is justified by the next patch in the series ([RFC
> PATCH v2 4/5] mtd: rawnand: gpmi: validate controller clock rate).
> I thought that clock rate validation could be better implemented by
> indexing a table. The replication of the second, third and fourth
> elements
> makes the index also the edo mode (used in the debug printout). Using
> a less redundant table (three elements) requires the edo mode
> to be stored in it if you want to keep the debug printing or remove
> the debug message.
> 
> >
> >         if (sdr->tRC_min >= 30000) {
> >                 /* ONFI non-EDO modes [0-3] */
> >                 hw->clk_rate = 22000000;
> >                 min_rate = 0;
> >                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
> >         } else if (sdr->tRC_min >= 25000) {
> >                 /* ONFI EDO mode 4 */
> >                 hw->clk_rate = 80000000;
> >                 min_rate = 22000000;
> >                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> >         } else {
> >                 /* ONFI EDO mode 5 */
> >                 hw->clk_rate = 100000000;
> >                 min_rate = 80000000;
> >                 wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
> >         }
> >
> >         hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
> >         if (hw->clk_rate < min_rate)
> >                 return -EINVAL;
> >
> > I think this would be easier to follow.
> 
> I think the key point is to decide if the patch "[RFC PATCH v2 4/5]
> mtd: rawnand: gpmi: validate controller clock rate" makes sense.
> I thought of this patch to facilitate that implementation, since it
> compares the real GPMI clock rate to that of the previous edo mode.
> I thought it wasn't elegant to implement another switch case.

You don't have to implement another switch/case. It's already there.

To be more clear my suggestion was to replace 3/5 and 4/5 with the
following.

Sascha

---------------------------8<--------------------------------

From 879fb5daaf19524ae29eda84c75d08668ad06d42 Mon Sep 17 00:00:00 2001
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 17 Jan 2022 12:18:28 +0100
Subject: [PATCH] mtd: rawnand: gpmi: validate controller clock rate

What to do when the real rate of the gpmi clock is not equal to the
required one? The solutions proposed in [1] did not lead to a conclusion
on how to validate the clock rate, so, inspired by the document [2], I
consider the rate correct only if not lower or equal to the rate of the
previous edo mode. In fact, in chapter 4.16.2 (NV-DDR) of the document [2],
it is written that "If the host selects timing mode n, then its clock
period shall be faster than the clock period of timing mode n-1 and
slower than or equal to the clock period of timing mode n.". I thought
that it could therefore also be used in this case, without therefore
having to define the valid rate ranges empirically.

For example, suppose that gpmi_nfc_compute_timings() is called for edo
mode 5 configuration (100MHz, from the `edo_modes' table) but the rate
returned by clk_round_rate() is 80MHz (edo mode 4 from the `edo_modes'
table). In this case gpmi_nfc_compute_timings() will return error, and
will be called again for edo mode 4 configuration, which this time will
be successful.

[1] https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org
[2] http://www.onfi.org/-/media/client/onfi/specs/onfi_3_0_gold.pdf?la=en

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 73c3bf59b55e..dcad7410d817 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -644,8 +644,8 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
  *         RDN_DELAY = -----------------------     {3}
  *                           RP
  */
-static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
-				     const struct nand_sdr_timings *sdr)
+static int gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
+				    const struct nand_sdr_timings *sdr)
 {
 	struct gpmi_nfc_hardware_timing *hw = &this->hw;
 	struct resources *r = &this->resources;
@@ -653,6 +653,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	unsigned int period_ps, reference_period_ps;
 	unsigned int data_setup_cycles, data_hold_cycles, addr_setup_cycles;
 	unsigned int tRP_ps;
+	unsigned int min_rate;
 	bool use_half_period;
 	int sample_delay_ps, sample_delay_factor;
 	u16 busy_timeout_cycles;
@@ -661,18 +662,23 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	if (sdr->tRC_min >= 30000) {
 		/* ONFI non-EDO modes [0-3] */
 		hw->clk_rate = 22000000;
+		min_rate = 0;
 		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
 	} else if (sdr->tRC_min >= 25000) {
 		/* ONFI EDO mode 4 */
 		hw->clk_rate = 80000000;
+		min_rate = 22000000;
 		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
 	} else {
 		/* ONFI EDO mode 5 */
 		hw->clk_rate = 100000000;
+		min_rate = 80000000;
 		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
 	}
 
 	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
+	if (hw->clk_rate < min_rate)
+		return -ENOTSUPP;
 
 	/* SDR core timings are given in picoseconds */
 	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
@@ -714,6 +720,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 		hw->ctrl1n |= BF_GPMI_CTRL1_RDN_DELAY(sample_delay_factor) |
 			      BM_GPMI_CTRL1_DLL_ENABLE |
 			      (use_half_period ? BM_GPMI_CTRL1_HALF_PERIOD : 0);
+	return 0;
 }
 
 static int gpmi_nfc_apply_timings(struct gpmi_nand_data *this)
@@ -769,6 +776,7 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 {
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	const struct nand_sdr_timings *sdr;
+	int ret;
 
 	/* Retrieve required NAND timings */
 	sdr = nand_get_sdr_timings(conf);
@@ -784,7 +792,9 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 		return 0;
 
 	/* Do the actual derivation of the controller timings */
-	gpmi_nfc_compute_timings(this, sdr);
+	ret = gpmi_nfc_compute_timings(this, sdr);
+	if (ret)
+		return ret;
 
 	this->hw.must_apply_timings = true;
 
-- 
2.30.2

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
