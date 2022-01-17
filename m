Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68FA490C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 17:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbiAQQST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 11:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiAQQSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 11:18:16 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D364BC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:15 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g22so21266137edu.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gsZSLbMzMCUtYGaf0gWZ0uuBEAA6iy7oiMig3gzLyxY=;
        b=FpzqaeFutVXXlVAX0Ax8r9DmQxyuIHHNFxqePFvmcxbEx4Haz72Vhy6FU1st3+HVP3
         jMIiV5ELJK0BYq1ehNWYCo0MnY0OCqF0r1oWI8QRzSF8kdTlzlmV6UFaEPb/RldxT2yF
         fzNHwU8A8ZksP94/QG8AFrFC7VjeoEb+5cD2s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gsZSLbMzMCUtYGaf0gWZ0uuBEAA6iy7oiMig3gzLyxY=;
        b=Zd3VovF+Hn9iNYvcdbrxmTG56/aRpXmUUCpkXE8glgIY6AQlV37gTkbsk/Jy1Nihyd
         wAyw57N4FqiUhBGp4NsoNw4Y9Jm7ha2ecnzIeT4WjDxVLQcgGQz1J3+a7QMDqxU9DWIK
         yrrbtKym/xa6xVV3KA1QQnSXs9Oq8X6PxH2G3X4Lneu2eSyjcCt+jryeBmZpGQa6B+A+
         DF7Rh1YiZ0BqUXv9rZ20uXTXS/iWnjnSRNx9qVzN/gsgtJg4bXCq71xSGsuI7twfa2ol
         RxWf9qljBbxBNUWO0jpdMS8nlHDsVdsSIn+rHnFTg495N8wbnZJKfcH9aaGp5LWJAa7b
         9XEg==
X-Gm-Message-State: AOAM530RVYg+niEIfsdyTIyio3n2+7452u3D3dZlrbetCRZHNE5ALprj
        vdkJGljmMRSuh5cwMjE+gz4pXG2tsbEowQ==
X-Google-Smtp-Source: ABdhPJyK72rzpHJ978ZqYIpz5Z3wLmpWDsmIwzBaJFJ7pygK2XoCLJisgeYMDOuN+6G2IawZhsxHiw==
X-Received: by 2002:a17:907:8a1a:: with SMTP id sc26mr17417046ejc.498.1642436294120;
        Mon, 17 Jan 2022 08:18:14 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id s4sm4147652ejm.146.2022.01.17.08.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 08:18:13 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v3 3/4] mtd: rawnand: gpmi: validate controller clock rate
Date:   Mon, 17 Jan 2022 17:17:54 +0100
Message-Id: <20220117161755.1863579-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
References: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

For example, suppose that gpmi_nfc_compute_timings() is called to set
edo mode 5 (100MHz) but the rate returned by clk_round_rate() is 80MHz
(edo mode 4). In this case gpmi_nfc_compute_timings() will return error,
and will be called again to set edo mode 4, which this time will be
successful.

[1] https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org
[2] http://www.onfi.org/-/media/client/onfi/specs/onfi_3_0_gold.pdf?la=en

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Remove the "mtd: rawnand: gpmi: use a table to get EDO mode setup" patch.
- Simplify the validation logic (suggested by Sascha Hauer <sha@pengutronix.de>).

Changes in v2:
- Fix commit description.
- Add an example to the commit description to better understand the
  problem solved by the patch.
- Split the patch.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 73c3bf59b55e..cf35f4206030 100644
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
@@ -657,23 +657,33 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	int sample_delay_ps, sample_delay_factor;
 	u16 busy_timeout_cycles;
 	u8 wrn_dly_sel;
+	unsigned long clk_rate, min_rate;
 
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
 
-	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
+	clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
+	if (clk_rate <= min_rate) {
+		dev_err(this->dev, "clock setting: expected %ld, got %ld\n",
+			hw->clk_rate, clk_rate);
+		return -ENOTSUPP;
+	}
 
+	hw->clk_rate = clk_rate;
 	/* SDR core timings are given in picoseconds */
 	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
 
@@ -714,6 +724,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 		hw->ctrl1n |= BF_GPMI_CTRL1_RDN_DELAY(sample_delay_factor) |
 			      BM_GPMI_CTRL1_DLL_ENABLE |
 			      (use_half_period ? BM_GPMI_CTRL1_HALF_PERIOD : 0);
+	return 0;
 }
 
 static int gpmi_nfc_apply_timings(struct gpmi_nand_data *this)
@@ -769,6 +780,7 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 {
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	const struct nand_sdr_timings *sdr;
+	int ret;
 
 	/* Retrieve required NAND timings */
 	sdr = nand_get_sdr_timings(conf);
@@ -784,7 +796,9 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 		return 0;
 
 	/* Do the actual derivation of the controller timings */
-	gpmi_nfc_compute_timings(this, sdr);
+	ret = gpmi_nfc_compute_timings(this, sdr);
+	if (ret)
+		return ret;
 
 	this->hw.must_apply_timings = true;
 
-- 
2.32.0

