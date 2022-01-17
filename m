Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED968490706
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiAQLSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiAQLSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:40 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F293C061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 30so64165104edv.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rYAxWnkHpq4eLp+nj5R4UJZTq/38ciAyZxzk+5L5YEQ=;
        b=eWWQ7Eq1ASjSoU3wXNkl4+S5loKAQAt6PHa0+A+R68n6ZX5g1AtMr+BiZZZpZ6Z5AE
         iEGu53zcXhZOap7+ZljQcAbLB0ltF7on2EyRPjGk+LstprLVfHsXl2msjJAmSNkx9ypG
         DhmZeYUTj77qcJfSepUEXPuy5/JX+JrviPo3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rYAxWnkHpq4eLp+nj5R4UJZTq/38ciAyZxzk+5L5YEQ=;
        b=Hk/hFKjRvrVOXJHRyO+aZdM6dCyaxw/8gJIXF4AoL4B1Ascls/JMCpbM71dM4b4vXy
         0a3gB0pQyOoL5RAvhpjZj+7u5WpUQ/1j4Sbw72autIZDHI1UYSnnlV0Ta1Lwjgxh7fZU
         O5+Df0xSmlrxoPKQEasXrVxxU91e6oCy41CVgdlyqe/DfIgd+7/r7SUvcNE29EIrf7B9
         IYi2tecAWkiPHclNvZTK7lePTYkJEV3Hkd16+71oKZNLsMhnrj9LJFG7Ik/cfy10zP/J
         uZWE88U3xknv9znguyroUo0HoUDVd5HTRrzSrKi9koy2H/f5EEVIQLDaoE+wWp1Yoa1Q
         ZUSA==
X-Gm-Message-State: AOAM531nST7yK+mQvy1ov33gGgKZ9yXHmVp2qKpLjkfjw65ipae94CLJ
        H2pMF2mVXqpLffEMbq1MRA1K9mXr4dAnzw==
X-Google-Smtp-Source: ABdhPJyKn6QCfHVFoBCjZsxSClHN31Hb+zRcpoNFpkT5JrofnLdT2dc7CAPh354e/9IyUsaWWHYUIw==
X-Received: by 2002:aa7:c945:: with SMTP id h5mr20209214edt.187.1642418318723;
        Mon, 17 Jan 2022 03:18:38 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:38 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v2 4/5] mtd: rawnand: gpmi: validate controller clock rate
Date:   Mon, 17 Jan 2022 12:18:28 +0100
Message-Id: <20220117111829.1811997-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
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

---

Changes in v2:
- Fix commit description.
- Add an example to the commit description to better understand the
  problem solved by the patch.
- Split the patch.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 24 ++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 4ac695aa5131..7ae7a37775a3 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -665,8 +665,8 @@ static const struct edo_mode edo_modes[] = {
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
@@ -679,6 +679,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	u16 busy_timeout_cycles;
 	u8 wrn_dly_sel;
 	int i, emode = ARRAY_SIZE(edo_modes) - 1;
+	long clk_rate;
 
 	/* Search the required EDO mode */
 	for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
@@ -688,7 +689,18 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 		}
 	}
 
-	hw->clk_rate = clk_round_rate(r->clock[0], edo_modes[emode].clk_rate);
+	clk_rate = clk_round_rate(r->clock[0], edo_modes[emode].clk_rate);
+	if (emode > 0 && !(clk_rate <= edo_modes[emode].clk_rate &&
+			   clk_rate > edo_modes[emode - 1].clk_rate)) {
+		dev_err(this->dev,
+			"edo mode %d clock setting: expected %ld, got %ld\n",
+			emode, edo_modes[emode].clk_rate, clk_rate);
+		return -ENOTSUPP;
+	}
+
+	dev_dbg(this->dev, "edo mode %d @ %ld Hz\n", emode, clk_rate);
+
+	hw->clk_rate = clk_rate;
 	wrn_dly_sel = edo_modes[emode].wrn_dly_sel;
 
 	/* SDR core timings are given in picoseconds */
@@ -731,6 +743,7 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 		hw->ctrl1n |= BF_GPMI_CTRL1_RDN_DELAY(sample_delay_factor) |
 			      BM_GPMI_CTRL1_DLL_ENABLE |
 			      (use_half_period ? BM_GPMI_CTRL1_HALF_PERIOD : 0);
+	return 0;
 }
 
 static int gpmi_nfc_apply_timings(struct gpmi_nand_data *this)
@@ -786,6 +799,7 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 {
 	struct gpmi_nand_data *this = nand_get_controller_data(chip);
 	const struct nand_sdr_timings *sdr;
+	int ret;
 
 	/* Retrieve required NAND timings */
 	sdr = nand_get_sdr_timings(conf);
@@ -801,7 +815,9 @@ static int gpmi_setup_interface(struct nand_chip *chip, int chipnr,
 		return 0;
 
 	/* Do the actual derivation of the controller timings */
-	gpmi_nfc_compute_timings(this, sdr);
+	ret = gpmi_nfc_compute_timings(this, sdr);
+	if (ret)
+		return ret;
 
 	this->hw.must_apply_timings = true;
 
-- 
2.32.0

