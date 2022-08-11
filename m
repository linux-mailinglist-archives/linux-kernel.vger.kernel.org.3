Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD4058FDA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 15:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiHKNox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 09:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235024AbiHKNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 09:44:52 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA7C5C95B
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:44:50 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j1so21453348wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 06:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=cwQ/6CG5P9M/wD2vawRWGlkWTsdG08rZx3qwmHD2FDw=;
        b=ZxD1tsVwvcWQYM92JLGkvhfBR2maRvpmPudc5Mu9yaKyQp3KTZEZrB4gSFhebebO0g
         DhckHgA/opYF0/y5FUkS4BF3sAnUF/z4qygdth3f7Rym0qimNPVtP/2fPq7k50W0DVZQ
         GZC49VL7FCjk0LYUpEZtYMw3OpgHcOKS/UDHLvBdDJPs5dYMokacCswaDEhWL1jnWnqy
         o99FVyPYh/ICUSd7Ec9DKWXCncTz/oxwR7TuRcoXAqdPCVSsKuYpvAdTmLZsDeIdzvc5
         7f9KMPBxyrhsfESf1aWSVfeeQ9S1gWb8+QiOx0qMFz5HhrE4JBYO7DaanOReoMFh6Urj
         5zIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=cwQ/6CG5P9M/wD2vawRWGlkWTsdG08rZx3qwmHD2FDw=;
        b=PH8mhipYCPlnce2IBvjQZuQRlOcqdRYJO/UVS9xXqp1MIHBlZORgf1yTYZpRVwvkhf
         C9cVabmVYgnx8Tba1qonzf5PY1ve9NCpp98tFv4tQ1sJA2Co6U0vO6arzypTEXAyLUIV
         pYuwWia+WGgYQNr++UdkMkbBL3YgsNdZOkjszWnsXQZPX4Zy+idTWDQvK78ver4gNvZn
         2kGXHpKm9fjhDSIDO3YLiM53KmJjkRnY+bb/ay7NvclG1MtsR1YzM7E2jv/oYp/Vw7T5
         v8uFKf/7EzRGF0FCqmJPc3CoCQaDEKh2e2sLt3caFMavKr//gKwd8/0/Bl4WBi6hqJBF
         xWWA==
X-Gm-Message-State: ACgBeo3b6L/WsU086ooIqhxV6exJ2vz118z90dDtrQkay2x7tM0ouZZX
        XicLFORpmN6R2xOHR9tOJQvDZZVYWsdiLg==
X-Google-Smtp-Source: AA6agR4vPvmQKRUDVLW5aWmEva+cJ8234Nt4P7AXyhvwgvbKmdbxMvSNg3g/Ln8aoxhfx8KCKlj/mw==
X-Received: by 2002:adf:ecc7:0:b0:220:5fef:6d40 with SMTP id s7-20020adfecc7000000b002205fef6d40mr20173136wro.5.1660225488471;
        Thu, 11 Aug 2022 06:44:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:982:cbb0:5a29:f77c:5f49:bb7])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d698b000000b0021eff2ecb31sm20097607wru.95.2022.08.11.06.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 06:44:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     broonie@kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Da Xue <da@libre.computer>
Subject: [PATCH] spi: meson-spicc: add local pow2 clock ops to preserve rate between messages
Date:   Thu, 11 Aug 2022 15:44:45 +0200
Message-Id: <20220811134445.678446-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8651; h=from:subject; bh=QfUZP4t9cGMoLiK2JoVp8TV+NsVbJzy0NMXGO6lyE6s=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBi9QfCbGBIVwrCnnz7It4TcCO05t1vUBizMR/wls9o /ihOtsyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYvUHwgAKCRB33NvayMhJ0XB+EA CHzMxpaew+1goCMdCYYo5p1+RTBM7PVIpVtlPd9QytViFeuLuaAAqX+OsYFR4UqMJCsG6QFg4L0ZuB LkY9kwieqsyjUkfM3nR9q28HxdFZWA24EQ5O4uV3UoFhrSd5/9dROmAdznEmgvdo15kOIcH6d+xEDD dM4CfgwBtPPJRKCCKCe+L/bPkkvn7VGmPJIf4Ql7aqbjOpuhK3+wAfL8IFlTF7CsFMLO+E5Htdft0M kw21H4CP//2w99J73siLacoCoUJ1B9DinFR/tgE6FeWOSuDKll5PBm0evR5/7l+/qrJ0/Ii693MWFO rsuTMp3+gvWKoo9MrQERlMeXQasXU268WBGg+q6xVt/ZJfK25KBcI38S++bqDOI2DJSRuN5s0U2nrx SGutlVooN380FnzuHQM4OmuEElioxQKzTB7dTVWjCuRz7r2/aDLyWHPn8p6hdD3uFL10d0Gb6nDU3V se5M4VpgOLXf6DIcBGno3AfE+LXUTvMc8bBik+hvsKyh4CPU7eFEs7hMUtO2PKgAJtU3AO/QqQz20q fpR/WnbTiGMNRPPVZBijO0JMR87wdO5zKC06kAsxJ0IbIOuLv5F44qpDeIZOjASnd5ye/6y+0yCl0w UqCvwV67EI0FHvqspzGy06r1sn8KR2YGqnrcNixVaNWh+FoCpAPoAfmEGTZA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the end of a message, the HW gets a reset in meson_spicc_unprepare_transfer(),
this resets the SPICC_CONREG register and notably the value set by the
Common Clock Framework.

This is problematic because:
- the register value CCF can be different from the corresponding CCF cached rate
- CCF is allowed to change the clock rate whenever the HW state

This introduces:
- local pow2 clock ops checking the HW state before allowing a clock operation
- separation of legacy pow2 clock patch and new enhanced clock path
- SPICC_CONREG datarate value is now value kepts across messages

It has been checked that:
- SPICC_CONREG datarate value is kept across messages
- CCF is only allowed to change the SPICC_CONREG datarate value when busy
- SPICC_CONREG datarate value is correct for each transfer

This didn't appear before commit 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
because we recalculated and wrote the rate for each xfer.

Fixes: 3e0cf4d3fc29 ("spi: meson-spicc: add a linear clock divider support")
Reported-by: Da Xue <da@libre.computer>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
This is a second try after [1] which was not good enough in regards to CCF.

[1] http://lore.kernel.org/r/20220809152019.461741-1-narmstrong@baylibre.com

 drivers/spi/spi-meson-spicc.c | 129 ++++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-meson-spicc.c b/drivers/spi/spi-meson-spicc.c
index 0bc7daa7afc8..e4cb52e1fe26 100644
--- a/drivers/spi/spi-meson-spicc.c
+++ b/drivers/spi/spi-meson-spicc.c
@@ -156,6 +156,7 @@ struct meson_spicc_device {
 	void __iomem			*base;
 	struct clk			*core;
 	struct clk			*pclk;
+	struct clk_divider		pow2_div;
 	struct clk			*clk;
 	struct spi_message		*message;
 	struct spi_transfer		*xfer;
@@ -168,6 +169,8 @@ struct meson_spicc_device {
 	unsigned long			xfer_remain;
 };
 
+#define pow2_clk_to_spicc(_div) container_of(_div, struct meson_spicc_device, pow2_div)
+
 static void meson_spicc_oen_enable(struct meson_spicc_device *spicc)
 {
 	u32 conf;
@@ -421,7 +424,7 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
 	struct spi_device *spi = message->spi;
-	u32 conf = 0;
+	u32 conf = readl_relaxed(spicc->base + SPICC_CONREG) & SPICC_DATARATE_MASK;
 
 	/* Store current message */
 	spicc->message = message;
@@ -458,8 +461,6 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 	/* Select CS */
 	conf |= FIELD_PREP(SPICC_CS_MASK, spi->chip_select);
 
-	/* Default Clock rate core/4 */
-
 	/* Default 8bit word */
 	conf |= FIELD_PREP(SPICC_BITLENGTH_MASK, 8 - 1);
 
@@ -476,12 +477,16 @@ static int meson_spicc_prepare_message(struct spi_master *master,
 static int meson_spicc_unprepare_transfer(struct spi_master *master)
 {
 	struct meson_spicc_device *spicc = spi_master_get_devdata(master);
+	u32 conf = readl_relaxed(spicc->base + SPICC_CONREG) & SPICC_DATARATE_MASK;
 
 	/* Disable all IRQs */
 	writel(0, spicc->base + SPICC_INTREG);
 
 	device_reset_optional(&spicc->pdev->dev);
 
+	/* Set default configuration, keeping datarate field */
+	writel_relaxed(conf, spicc->base + SPICC_CONREG);
+
 	return 0;
 }
 
@@ -518,14 +523,60 @@ static void meson_spicc_cleanup(struct spi_device *spi)
  * Clk path for G12A series:
  *    pclk -> pow2 fixed div -> pow2 div -> mux -> out
  *    pclk -> enh fixed div -> enh div -> mux -> out
+ *
+ * The pow2 divider is tied to the controller HW state, and the
+ * divider is only valid when the controller is initialized.
+ *
+ * A set of clock ops is added to make sure we don't read/set this
+ * clock rate while the controller is in an unknown state.
  */
 
-static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
+static unsigned long meson_spicc_pow2_recalc_rate(struct clk_hw *hw,
+						  unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
+
+	if (!spicc->master->cur_msg || !spicc->master->busy)
+		return 0;
+
+	return clk_divider_ops.recalc_rate(hw, parent_rate);
+}
+
+static int meson_spicc_pow2_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
+
+	if (!spicc->master->cur_msg || !spicc->master->busy)
+		return -EINVAL;
+
+	return clk_divider_ops.determine_rate(hw, req);
+}
+
+static int meson_spicc_pow2_set_rate(struct clk_hw *hw, unsigned long rate,
+				     unsigned long parent_rate)
+{
+	struct clk_divider *divider = to_clk_divider(hw);
+	struct meson_spicc_device *spicc = pow2_clk_to_spicc(divider);
+
+	if (!spicc->master->cur_msg || !spicc->master->busy)
+		return -EINVAL;
+
+	return clk_divider_ops.set_rate(hw, rate, parent_rate);
+}
+
+const struct clk_ops meson_spicc_pow2_clk_ops = {
+	.recalc_rate = meson_spicc_pow2_recalc_rate,
+	.determine_rate = meson_spicc_pow2_determine_rate,
+	.set_rate = meson_spicc_pow2_set_rate,
+};
+
+static int meson_spicc_pow2_clk_init(struct meson_spicc_device *spicc)
 {
 	struct device *dev = &spicc->pdev->dev;
-	struct clk_fixed_factor *pow2_fixed_div, *enh_fixed_div;
-	struct clk_divider *pow2_div, *enh_div;
-	struct clk_mux *mux;
+	struct clk_fixed_factor *pow2_fixed_div;
 	struct clk_init_data init;
 	struct clk *clk;
 	struct clk_parent_data parent_data[2];
@@ -560,31 +611,45 @@ static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
 	if (WARN_ON(IS_ERR(clk)))
 		return PTR_ERR(clk);
 
-	pow2_div = devm_kzalloc(dev, sizeof(*pow2_div), GFP_KERNEL);
-	if (!pow2_div)
-		return -ENOMEM;
-
 	snprintf(name, sizeof(name), "%s#pow2_div", dev_name(dev));
 	init.name = name;
-	init.ops = &clk_divider_ops;
-	init.flags = CLK_SET_RATE_PARENT;
+	init.ops = &meson_spicc_pow2_clk_ops;
+	/*
+	 * Set NOCACHE here to make sure we read the actual HW value
+	 * since we reset the HW after each transfer.
+	 */
+	init.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE;
 	parent_data[0].hw = &pow2_fixed_div->hw;
 	init.num_parents = 1;
 
-	pow2_div->shift = 16,
-	pow2_div->width = 3,
-	pow2_div->flags = CLK_DIVIDER_POWER_OF_TWO,
-	pow2_div->reg = spicc->base + SPICC_CONREG;
-	pow2_div->hw.init = &init;
+	spicc->pow2_div.shift = 16,
+	spicc->pow2_div.width = 3,
+	spicc->pow2_div.flags = CLK_DIVIDER_POWER_OF_TWO,
+	spicc->pow2_div.reg = spicc->base + SPICC_CONREG;
+	spicc->pow2_div.hw.init = &init;
 
-	clk = devm_clk_register(dev, &pow2_div->hw);
-	if (WARN_ON(IS_ERR(clk)))
-		return PTR_ERR(clk);
+	spicc->clk = devm_clk_register(dev, &spicc->pow2_div.hw);
+	if (WARN_ON(IS_ERR(spicc->clk)))
+		return PTR_ERR(spicc->clk);
 
-	if (!spicc->data->has_enhance_clk_div) {
-		spicc->clk = clk;
-		return 0;
-	}
+	return 0;
+}
+
+static int meson_spicc_enh_clk_init(struct meson_spicc_device *spicc)
+{
+	struct device *dev = &spicc->pdev->dev;
+	struct clk_fixed_factor *enh_fixed_div;
+	struct clk_divider *enh_div;
+	struct clk_mux *mux;
+	struct clk_init_data init;
+	struct clk *clk;
+	struct clk_parent_data parent_data[2];
+	char name[64];
+
+	memset(&init, 0, sizeof(init));
+	memset(&parent_data, 0, sizeof(parent_data));
+
+	init.parent_data = parent_data;
 
 	/* algorithm for enh div: rate = freq / 2 / (N + 1) */
 
@@ -637,7 +702,7 @@ static int meson_spicc_clk_init(struct meson_spicc_device *spicc)
 	snprintf(name, sizeof(name), "%s#sel", dev_name(dev));
 	init.name = name;
 	init.ops = &clk_mux_ops;
-	parent_data[0].hw = &pow2_div->hw;
+	parent_data[0].hw = &spicc->pow2_div.hw;
 	parent_data[1].hw = &enh_div->hw;
 	init.num_parents = 2;
 	init.flags = CLK_SET_RATE_PARENT;
@@ -754,12 +819,20 @@ static int meson_spicc_probe(struct platform_device *pdev)
 
 	meson_spicc_oen_enable(spicc);
 
-	ret = meson_spicc_clk_init(spicc);
+	ret = meson_spicc_pow2_clk_init(spicc);
 	if (ret) {
-		dev_err(&pdev->dev, "clock registration failed\n");
+		dev_err(&pdev->dev, "pow2 clock registration failed\n");
 		goto out_clk;
 	}
 
+	if (spicc->data->has_enhance_clk_div) {
+		ret = meson_spicc_enh_clk_init(spicc);
+		if (ret) {
+			dev_err(&pdev->dev, "clock registration failed\n");
+			goto out_clk;
+		}
+	}
+
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret) {
 		dev_err(&pdev->dev, "spi master registration failed\n");
-- 
2.25.1

