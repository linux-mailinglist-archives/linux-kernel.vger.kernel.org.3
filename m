Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 867D4490705
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiAQLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 06:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236728AbiAQLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 06:18:39 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAE6C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:39 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m4so63982342edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 03:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gk6v+zkr/8Bz9MIGt4fGPVyLyGj2QkozkhBTdVX/PUo=;
        b=VIXTBpMjhqZKt4rQ3FtVXzMnmqezrKxs8k1eSDAutK1Jfyt7mC1LZ7DYG5m4sXOeYE
         K94/xRWf2H3fKlAcYXE4wuT6fRf8oiALFqZaYyy3N5mNLpqL9tX+SAmcHQHkhIFd2EZm
         3CkbiYwRHinLAv3PxmapAgT73USBoOxYY/nb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gk6v+zkr/8Bz9MIGt4fGPVyLyGj2QkozkhBTdVX/PUo=;
        b=lRtnUWD2MWruZh07HBD26OhNhOK5zOTo5VqLcvrxPFpJO9QLqIXhute6KVFogW+LDK
         FGKgAtV1MOMAq95vv7c/vrVFKlBAHCVG7LXAlPJ+tgRIov5KnllNZmNXJxclNHiTDz8k
         4GBbsAhaqZE14TIsWFn5Ix5PFUx8QVqLH+WgKgo+PoMgGZ0LIseQJ8qR8cAczFMBApHF
         7NS9IoT7QH11LoS8eMlEg0lNlbWZxzq4k3gkrn+QX+UMi4qwANGnRXDBvBMQtIdHXLyY
         lPObYKkxh9vs21cI9FugXyv3x2+9C6biQiKH7LYhPFEw0bkLcQF/CJN6zw0FRuegtePU
         xvbQ==
X-Gm-Message-State: AOAM533DT64j1v+UJu7IwOxxG3cum7cODTrM07Grbx1tp8MQ8MX+YzSD
        3GXaRb03IyC6b1tKXXTj842D5XBU79KC5g==
X-Google-Smtp-Source: ABdhPJzfcTUuKvzsSykyLHp6DawCurAnU7xOZb2fKrRxwC5e0xT0BSoq7Nb96brhwacD7RdAXwP73A==
X-Received: by 2002:a17:906:49c4:: with SMTP id w4mr16071378ejv.745.1642418317529;
        Mon, 17 Jan 2022 03:18:37 -0800 (PST)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-52-8-210.retail.telecomitalia.it. [82.52.8.210])
        by smtp.gmail.com with ESMTPSA id f11sm5142713edv.67.2022.01.17.03.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 03:18:37 -0800 (PST)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Michael Trimarchi <michael@amarulasolutions.com>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [RFC PATCH v2 3/5] mtd: rawnand: gpmi: use a table to get EDO mode setup
Date:   Mon, 17 Jan 2022 12:18:27 +0100
Message-Id: <20220117111829.1811997-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
References: <20220117111829.1811997-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation patch for the upcoming validation of the
GPMI controller clock rate.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Add the patch to the series.

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 43 +++++++++++++++-------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 73c3bf59b55e..4ac695aa5131 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -570,6 +570,27 @@ static int bch_set_geometry(struct gpmi_nand_data *this)
 	return ret;
 }
 
+struct edo_mode {
+	u32 tRC_min;
+	long clk_rate;
+	u8 wrn_dly_sel;
+};
+
+static const struct edo_mode edo_modes[] = {
+	{.tRC_min = 30000, .clk_rate = 22000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
+	{.tRC_min = 30000, .clk_rate = 22000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
+	{.tRC_min = 30000, .clk_rate = 22000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
+	{.tRC_min = 30000, .clk_rate = 22000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS},
+	{.tRC_min = 25000, .clk_rate = 80000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
+	{.tRC_min = 20000, .clk_rate = 100000000,
+	 .wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY},
+};
+
 /*
  * <1> Firstly, we should know what's the GPMI-clock means.
  *     The GPMI-clock is the internal clock in the gpmi nand controller.
@@ -657,22 +678,18 @@ static void gpmi_nfc_compute_timings(struct gpmi_nand_data *this,
 	int sample_delay_ps, sample_delay_factor;
 	u16 busy_timeout_cycles;
 	u8 wrn_dly_sel;
+	int i, emode = ARRAY_SIZE(edo_modes) - 1;
 
-	if (sdr->tRC_min >= 30000) {
-		/* ONFI non-EDO modes [0-3] */
-		hw->clk_rate = 22000000;
-		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_4_TO_8NS;
-	} else if (sdr->tRC_min >= 25000) {
-		/* ONFI EDO mode 4 */
-		hw->clk_rate = 80000000;
-		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
-	} else {
-		/* ONFI EDO mode 5 */
-		hw->clk_rate = 100000000;
-		wrn_dly_sel = BV_GPMI_CTRL1_WRN_DLY_SEL_NO_DELAY;
+	/* Search the required EDO mode */
+	for (i = 0; i < ARRAY_SIZE(edo_modes); i++) {
+		if (sdr->tRC_min >= edo_modes[i].tRC_min) {
+			emode = i;
+			break;
+		}
 	}
 
-	hw->clk_rate = clk_round_rate(r->clock[0], hw->clk_rate);
+	hw->clk_rate = clk_round_rate(r->clock[0], edo_modes[emode].clk_rate);
+	wrn_dly_sel = edo_modes[emode].wrn_dly_sel;
 
 	/* SDR core timings are given in picoseconds */
 	period_ps = div_u64((u64)NSEC_PER_SEC * 1000, hw->clk_rate);
-- 
2.32.0

