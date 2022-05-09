Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD39520401
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbiEISBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239935AbiEISBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:01:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDCE1B33E2;
        Mon,  9 May 2022 10:57:20 -0700 (PDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by gandalf.ozlabs.org (Postfix) with ESMTP id 4Kxplz1829z4ySZ;
        Tue, 10 May 2022 03:57:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kxpls5wzLz4xVP;
        Tue, 10 May 2022 03:57:13 +1000 (AEST)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Tao Ren <rentao.bupt@gmail.com>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Subject: [PATCH v7 08/11] spi: aspeed: Calibrate read timings
Date:   Mon,  9 May 2022 19:56:13 +0200
Message-Id: <20220509175616.1089346-9-clg@kaod.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220509175616.1089346-1-clg@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To accommodate the different response time of SPI transfers on different
boards and different SPI NOR devices, the Aspeed controllers provide a
set of Read Timing Compensation registers to tune the timing delays
depending on the frequency being used. The AST2600 SoC has one of these
registers per device. On the AST2500 and AST2400 SoCs, the timing
register is shared by all devices which is problematic to get good
results other than for one device.

The algorithm first reads a golden buffer at low speed and then performs
reads with different clocks and delay cycle settings to find a breaking
point. This selects a default good frequency for the CEx control register.
The current settings are a bit optimistic as we pick the first delay giving
good results. A safer approach would be to determine an interval and
choose the middle value.

Calibration is performed when the direct mapping for reads is created.
Since the underlying spi-nor object needs to be initialized to create
the spi_mem operation for direct mapping, we should be fine. Having a
specific API would clarify the requirements though.

Cc: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>
Tested-by: Tao Ren <rentao.bupt@gmail.com>
Tested-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 drivers/spi/spi-aspeed-smc.c | 281 +++++++++++++++++++++++++++++++++++
 1 file changed, 281 insertions(+)

diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index d2b63c8bb88f..35f6934847b7 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -33,6 +33,8 @@
 #define   CTRL_IO_ADDRESS_4B		BIT(13)	/* AST2400 SPI only */
 #define   CTRL_IO_DUMMY_SET(dummy)					\
 	(((((dummy) >> 2) & 0x1) << 14) | (((dummy) & 0x3) << 6))
+#define   CTRL_FREQ_SEL_SHIFT		8
+#define   CTRL_FREQ_SEL_MASK		GENMASK(11, CTRL_FREQ_SEL_SHIFT)
 #define   CTRL_CE_STOP_ACTIVE		BIT(2)
 #define   CTRL_IO_MODE_CMD_MASK		GENMASK(1, 0)
 #define   CTRL_IO_MODE_NORMAL		0x0
@@ -45,6 +47,9 @@
 /* CEx Address Decoding Range Register */
 #define CE0_SEGMENT_ADDR_REG		0x30
 
+/* CEx Read timing compensation register */
+#define CE0_TIMING_COMPENSATION_REG	0x94
+
 enum aspeed_spi_ctl_reg_value {
 	ASPEED_SPI_BASE,
 	ASPEED_SPI_READ,
@@ -70,10 +75,15 @@ struct aspeed_spi_data {
 	bool	hastype;
 	u32	mode_bits;
 	u32	we0;
+	u32	timing;
+	u32	hclk_mask;
+	u32	hdiv_max;
 
 	u32 (*segment_start)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_end)(struct aspeed_spi *aspi, u32 reg);
 	u32 (*segment_reg)(struct aspeed_spi *aspi, u32 start, u32 end);
+	int (*calibrate)(struct aspeed_spi_chip *chip, u32 hdiv,
+			 const u8 *golden_buf, u8 *test_buf);
 };
 
 #define ASPEED_SPI_MAX_NUM_CS	5
@@ -525,6 +535,8 @@ static int aspeed_spi_chip_adjust_window(struct aspeed_spi_chip *chip,
 	return 0;
 }
 
+static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip);
+
 static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	struct aspeed_spi *aspi = spi_controller_get_devdata(desc->mem->spi->master);
@@ -573,6 +585,8 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	chip->ctl_val[ASPEED_SPI_READ] = ctl_val;
 	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
 
+	ret = aspeed_spi_do_calibration(chip);
+
 	dev_info(aspi->dev, "CE%d read buswidth:%d [0x%08x]\n",
 		 chip->cs, op->data.buswidth, chip->ctl_val[ASPEED_SPI_READ]);
 
@@ -825,6 +839,249 @@ static u32 aspeed_spi_segment_ast2600_reg(struct aspeed_spi *aspi,
 		((end - 1) & AST2600_SEG_ADDR_MASK);
 }
 
+/*
+ * Read timing compensation sequences
+ */
+
+#define CALIBRATE_BUF_SIZE SZ_16K
+
+static bool aspeed_spi_check_reads(struct aspeed_spi_chip *chip,
+				   const u8 *golden_buf, u8 *test_buf)
+{
+	int i;
+
+	for (i = 0; i < 10; i++) {
+		memcpy_fromio(test_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
+		if (memcmp(test_buf, golden_buf, CALIBRATE_BUF_SIZE) != 0) {
+#if defined(VERBOSE_DEBUG)
+			print_hex_dump_bytes(DEVICE_NAME "  fail: ", DUMP_PREFIX_NONE,
+					     test_buf, 0x100);
+#endif
+			return false;
+		}
+	}
+	return true;
+}
+
+#define FREAD_TPASS(i)	(((i) / 2) | (((i) & 1) ? 0 : 8))
+
+/*
+ * The timing register is shared by all devices. Only update for CE0.
+ */
+static int aspeed_spi_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
+				const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	const struct aspeed_spi_data *data = aspi->data;
+	int i;
+	int good_pass = -1, pass_count = 0;
+	u32 shift = (hdiv - 1) << 2;
+	u32 mask = ~(0xfu << shift);
+	u32 fread_timing_val = 0;
+
+	/* Try HCLK delay 0..5, each one with/without delay and look for a
+	 * good pair.
+	 */
+	for (i = 0; i < 12; i++) {
+		bool pass;
+
+		if (chip->cs == 0) {
+			fread_timing_val &= mask;
+			fread_timing_val |= FREAD_TPASS(i) << shift;
+			writel(fread_timing_val, aspi->regs + data->timing);
+		}
+		pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(aspi->dev,
+			"  * [%08x] %d HCLK delay, %dns DI delay : %s",
+			fread_timing_val, i / 2, (i & 1) ? 0 : 4,
+			pass ? "PASS" : "FAIL");
+		if (pass) {
+			pass_count++;
+			if (pass_count == 3) {
+				good_pass = i - 1;
+				break;
+			}
+		} else {
+			pass_count = 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	if (good_pass < 0)
+		return -1;
+
+	/* We have at least one pass of margin, let's use first pass */
+	if (chip->cs == 0) {
+		fread_timing_val &= mask;
+		fread_timing_val |= FREAD_TPASS(good_pass) << shift;
+		writel(fread_timing_val, aspi->regs + data->timing);
+	}
+	dev_dbg(aspi->dev, " * -> good is pass %d [0x%08x]",
+		good_pass, fread_timing_val);
+	return 0;
+}
+
+static bool aspeed_spi_check_calib_data(const u8 *test_buf, u32 size)
+{
+	const u32 *tb32 = (const u32 *)test_buf;
+	u32 i, cnt = 0;
+
+	/* We check if we have enough words that are neither all 0
+	 * nor all 1's so the calibration can be considered valid.
+	 *
+	 * I use an arbitrary threshold for now of 64
+	 */
+	size >>= 2;
+	for (i = 0; i < size; i++) {
+		if (tb32[i] != 0 && tb32[i] != 0xffffffff)
+			cnt++;
+	}
+	return cnt >= 64;
+}
+
+static const u32 aspeed_spi_hclk_divs[] = {
+	0xf, /* HCLK */
+	0x7, /* HCLK/2 */
+	0xe, /* HCLK/3 */
+	0x6, /* HCLK/4 */
+	0xd, /* HCLK/5 */
+};
+
+#define ASPEED_SPI_HCLK_DIV(i) \
+	(aspeed_spi_hclk_divs[(i) - 1] << CTRL_FREQ_SEL_SHIFT)
+
+static int aspeed_spi_do_calibration(struct aspeed_spi_chip *chip)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	const struct aspeed_spi_data *data = aspi->data;
+	u32 ahb_freq = aspi->clk_freq;
+	u32 max_freq = chip->clk_freq;
+	u32 ctl_val;
+	u8 *golden_buf = NULL;
+	u8 *test_buf = NULL;
+	int i, rc, best_div = -1;
+
+	dev_dbg(aspi->dev, "calculate timing compensation - AHB freq: %d MHz",
+		ahb_freq / 1000000);
+
+	/*
+	 * use the related low frequency to get check calibration data
+	 * and get golden data.
+	 */
+	ctl_val = chip->ctl_val[ASPEED_SPI_READ] & data->hclk_mask;
+	writel(ctl_val, chip->ctl);
+
+	test_buf = kzalloc(CALIBRATE_BUF_SIZE * 2, GFP_KERNEL);
+	if (!test_buf)
+		return -ENOMEM;
+
+	golden_buf = test_buf + CALIBRATE_BUF_SIZE;
+
+	memcpy_fromio(golden_buf, chip->ahb_base, CALIBRATE_BUF_SIZE);
+	if (!aspeed_spi_check_calib_data(golden_buf, CALIBRATE_BUF_SIZE)) {
+		dev_info(aspi->dev, "Calibration area too uniform, using low speed");
+		goto no_calib;
+	}
+
+#if defined(VERBOSE_DEBUG)
+	print_hex_dump_bytes(DEVICE_NAME "  good: ", DUMP_PREFIX_NONE,
+			     golden_buf, 0x100);
+#endif
+
+	/* Now we iterate the HCLK dividers until we find our breaking point */
+	for (i = ARRAY_SIZE(aspeed_spi_hclk_divs); i > data->hdiv_max - 1; i--) {
+		u32 tv, freq;
+
+		freq = ahb_freq / i;
+		if (freq > max_freq)
+			continue;
+
+		/* Set the timing */
+		tv = chip->ctl_val[ASPEED_SPI_READ] | ASPEED_SPI_HCLK_DIV(i);
+		writel(tv, chip->ctl);
+		dev_dbg(aspi->dev, "Trying HCLK/%d [%08x] ...", i, tv);
+		rc = data->calibrate(chip, i, golden_buf, test_buf);
+		if (rc == 0)
+			best_div = i;
+	}
+
+	/* Nothing found ? */
+	if (best_div < 0) {
+		dev_warn(aspi->dev, "No good frequency, using dumb slow");
+	} else {
+		dev_dbg(aspi->dev, "Found good read timings at HCLK/%d", best_div);
+
+		/* Record the freq */
+		for (i = 0; i < ASPEED_SPI_MAX; i++)
+			chip->ctl_val[i] = (chip->ctl_val[i] & data->hclk_mask) |
+				ASPEED_SPI_HCLK_DIV(best_div);
+	}
+
+no_calib:
+	writel(chip->ctl_val[ASPEED_SPI_READ], chip->ctl);
+	kfree(test_buf);
+	return 0;
+}
+
+#define TIMING_DELAY_DI		BIT(3)
+#define TIMING_DELAY_HCYCLE_MAX	5
+#define TIMING_REG_AST2600(chip)				\
+	((chip)->aspi->regs + (chip)->aspi->data->timing +	\
+	 (chip)->cs * 4)
+
+static int aspeed_spi_ast2600_calibrate(struct aspeed_spi_chip *chip, u32 hdiv,
+					const u8 *golden_buf, u8 *test_buf)
+{
+	struct aspeed_spi *aspi = chip->aspi;
+	int hcycle;
+	u32 shift = (hdiv - 2) << 3;
+	u32 mask = ~(0xfu << shift);
+	u32 fread_timing_val = 0;
+
+	for (hcycle = 0; hcycle <= TIMING_DELAY_HCYCLE_MAX; hcycle++) {
+		int delay_ns;
+		bool pass = false;
+
+		fread_timing_val &= mask;
+		fread_timing_val |= hcycle << shift;
+
+		/* no DI input delay first  */
+		writel(fread_timing_val, TIMING_REG_AST2600(chip));
+		pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+		dev_dbg(aspi->dev,
+			"  * [%08x] %d HCLK delay, DI delay none : %s",
+			fread_timing_val, hcycle, pass ? "PASS" : "FAIL");
+		if (pass)
+			return 0;
+
+		/* Add DI input delays  */
+		fread_timing_val &= mask;
+		fread_timing_val |= (TIMING_DELAY_DI | hcycle) << shift;
+
+		for (delay_ns = 0; delay_ns < 0x10; delay_ns++) {
+			fread_timing_val &= ~(0xf << (4 + shift));
+			fread_timing_val |= delay_ns << (4 + shift);
+
+			writel(fread_timing_val, TIMING_REG_AST2600(chip));
+			pass = aspeed_spi_check_reads(chip, golden_buf, test_buf);
+			dev_dbg(aspi->dev,
+				"  * [%08x] %d HCLK delay, DI delay %d.%dns : %s",
+				fread_timing_val, hcycle, (delay_ns + 1) / 2,
+				(delay_ns + 1) & 1 ? 5 : 5, pass ? "PASS" : "FAIL");
+			/*
+			 * TODO: This is optimistic. We should look
+			 * for a working interval and save the middle
+			 * value in the read timing register.
+			 */
+			if (pass)
+				return 0;
+		}
+	}
+
+	/* No good setting for this frequency */
+	return -1;
+}
+
 /*
  * Platform definitions
  */
@@ -833,6 +1090,10 @@ static const struct aspeed_spi_data ast2400_fmc_data = {
 	.hastype       = true,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -843,6 +1104,10 @@ static const struct aspeed_spi_data ast2400_spi_data = {
 	.hastype       = false,
 	.we0	       = 0,
 	.ctl0	       = 0x04,
+	.timing	       = 0x14,
+	.hclk_mask     = 0xfffff0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	/* No segment registers */
 };
 
@@ -851,6 +1116,10 @@ static const struct aspeed_spi_data ast2500_fmc_data = {
 	.hastype       = true,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xffffd0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -861,6 +1130,10 @@ static const struct aspeed_spi_data ast2500_spi_data = {
 	.hastype       = false,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xffffd0ff,
+	.hdiv_max      = 1,
+	.calibrate     = aspeed_spi_calibrate,
 	.segment_start = aspeed_spi_segment_start,
 	.segment_end   = aspeed_spi_segment_end,
 	.segment_reg   = aspeed_spi_segment_reg,
@@ -872,6 +1145,10 @@ static const struct aspeed_spi_data ast2600_fmc_data = {
 	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
 	.segment_reg   = aspeed_spi_segment_ast2600_reg,
@@ -883,6 +1160,10 @@ static const struct aspeed_spi_data ast2600_spi_data = {
 	.mode_bits     = SPI_RX_QUAD | SPI_RX_QUAD,
 	.we0	       = 16,
 	.ctl0	       = CE0_CTRL_REG,
+	.timing	       = CE0_TIMING_COMPENSATION_REG,
+	.hclk_mask     = 0xf0fff0ff,
+	.hdiv_max      = 2,
+	.calibrate     = aspeed_spi_ast2600_calibrate,
 	.segment_start = aspeed_spi_segment_ast2600_start,
 	.segment_end   = aspeed_spi_segment_ast2600_end,
 	.segment_reg   = aspeed_spi_segment_ast2600_reg,
-- 
2.35.1

