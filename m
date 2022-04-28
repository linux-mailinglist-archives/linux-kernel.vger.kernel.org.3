Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7ED513E02
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352613AbiD1Vwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352464AbiD1VwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:14 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11DC3E25;
        Thu, 28 Apr 2022 14:48:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id f14so4501553qtq.1;
        Thu, 28 Apr 2022 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xxRlAMG5Hgv7VO31n+Y4OOs69sgs7kvDAutG1MZ11mM=;
        b=PuyVmmFi5ydIfFWVrkLflr+gdDwaGb8767NELliwu5x6PJrbYX/AXliehLu2werqjN
         C/fa3E2au16YjQUUTxdI2ZD1tDwMd0o+bFtNNjWCwG53/4dyv2uERIhAGKic3ysaX5yr
         zg1PDsa6CUJbfxfwDIPD58cDnfXlImmovSSYvEVky+HJJAhb5wOMKH7rzICPuwVzfkei
         EgHKRj1UlksHRf0VC7AYzYbxPmyz/Jlsy+tCeDfpwTvKboPDO34GTrE6hexj+wzkc4VJ
         4iZM01WK5P7f5UiVohcpo0E5oi20OUMhxbSATg+5ZldFmeqGTUE5isgvy/pWrktNz+Si
         Kwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xxRlAMG5Hgv7VO31n+Y4OOs69sgs7kvDAutG1MZ11mM=;
        b=2yT/GnI77Et2no1Hab0k6E1atv9q3yxrLcvemymQ5cwGrhEi1q1pD3H232t1hFUwEQ
         xREvBsF92DVsW7rhxLfPprS9CkQQWG5BHUxOM+7UkQeXS0qoXI0HrFA542ztpL6j6vK0
         8Fnur4j81a+zu15TYMxnPW1RjUDf1Pfv9fE68wRRc7voNxfd9wOT7GjW80Kh38rV/VZx
         5YyLpvG3F22CatXPZtsrsRXgWKv6DhHSmtBoR7xTC880cRRtNTij8LykP0f0psd10Qxc
         uTpNT8L7QEZr9+SaxVUMbPs4Bw1CQ+uxJ8eneZYLuXLJYzuqeJadJYOJEmC7Bmz0aXBg
         /Utw==
X-Gm-Message-State: AOAM532rbKCgITRR4MHQY69J+q1BJWCBEaEtqrET/3LfKMPwQ3oTaPOV
        8DgMpCkqaVvI+Y2lSM3ZbR0=
X-Google-Smtp-Source: ABdhPJzFJsUDCkJKDs6FX385VYStj2Wtl/ZtzzShv4B3L/NtgSI0k4CwEtfJj5FUobUCjaNpzCswsQ==
X-Received: by 2002:ac8:4e4d:0:b0:2f1:f986:6b62 with SMTP id e13-20020ac84e4d000000b002f1f9866b62mr24780278qtw.585.1651182535713;
        Thu, 28 Apr 2022 14:48:55 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:55 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v2 09/15] ARM: clk: imx: Update pllv3 to support i.MXRT1170
Date:   Thu, 28 Apr 2022 17:48:32 -0400
Message-Id: <20220428214838.1040278-10-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i.MXRT1170 has a pll that has the multiplier bits inverted and
cannot be changed add IMX_PLLV3_GENERICV2.

The i.MXRT1170 also has the lock bit moved as well as the
power bit inverted the power bit also is in different locations on each
pll control register.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Nothing done
---
 drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++++--
 drivers/clk/imx/clk.h       |  4 +++
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index 20ee9611ba6e..a1dbc3a2e280 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -23,6 +23,7 @@
 
 #define BM_PLL_POWER		(0x1 << 12)
 #define BM_PLL_LOCK		(0x1 << 31)
+#define BM_PLL_LOCK_V2		(0x1 << 29)
 #define IMX7_ENET_PLL_POWER	(0x1 << 5)
 #define IMX7_DDR_PLL_POWER	(0x1 << 20)
 
@@ -34,6 +35,7 @@
  * @base:	 base address of PLL registers
  * @power_bit:	 pll power bit mask
  * @powerup_set: set power_bit to power up the PLL
+ * @lock_bit:	 pll lock bit mask
  * @div_mask:	 mask of divider bits
  * @div_shift:	 shift of divider bits
  * @ref_clock:	reference clock rate
@@ -48,6 +50,7 @@ struct clk_pllv3 {
 	void __iomem	*base;
 	u32		power_bit;
 	bool		powerup_set;
+	u32		lock_bit;
 	u32		div_mask;
 	u32		div_shift;
 	unsigned long	ref_clock;
@@ -65,7 +68,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
 		return 0;
 
-	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
+	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
 					  500, PLL_LOCK_TIMEOUT);
 }
 
@@ -101,7 +104,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 
-	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
+	if (readl_relaxed(pll->base) & pll->lock_bit)
 		return 1;
 
 	return 0;
@@ -155,6 +158,39 @@ static const struct clk_ops clk_pllv3_ops = {
 	.set_rate	= clk_pllv3_set_rate,
 };
 
+static int clk_pllv3_genericv2_set_rate(struct clk_hw *hw, unsigned long rate,
+		unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 val, div;
+
+	div = (readl_relaxed(pll->base) >> pll->div_shift) & pll->div_mask;
+	val = (div == 0) ? parent_rate * 22 : parent_rate * 20;
+
+	if (rate == val)
+		return 0;
+
+	return -EINVAL;
+}
+
+static unsigned long clk_pllv3_genericv2_recalc_rate(struct clk_hw *hw,
+					   unsigned long parent_rate)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+	u32 div = (readl_relaxed(pll->base) >> pll->div_shift)  & pll->div_mask;
+
+	return (div == 0) ? parent_rate * 22 : parent_rate * 20;
+}
+
+static const struct clk_ops clk_pllv3_genericv2_ops = {
+	.prepare	= clk_pllv3_prepare,
+	.unprepare	= clk_pllv3_unprepare,
+	.is_prepared	= clk_pllv3_is_prepared,
+	.recalc_rate	= clk_pllv3_genericv2_recalc_rate,
+	.round_rate	= clk_pllv3_round_rate,
+	.set_rate	= clk_pllv3_genericv2_set_rate,
+};
+
 static unsigned long clk_pllv3_sys_recalc_rate(struct clk_hw *hw,
 					       unsigned long parent_rate)
 {
@@ -407,6 +443,13 @@ static const struct clk_ops clk_pllv3_enet_ops = {
 	.recalc_rate	= clk_pllv3_enet_recalc_rate,
 };
 
+void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift)
+{
+	struct clk_pllv3 *pll = to_clk_pllv3(hw);
+
+	pll->power_bit = shift;
+}
+
 struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 			  const char *parent_name, void __iomem *base,
 			  u32 div_mask)
@@ -422,10 +465,20 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 		return ERR_PTR(-ENOMEM);
 
 	pll->power_bit = BM_PLL_POWER;
+	pll->lock_bit = BM_PLL_LOCK;
 	pll->num_offset = PLL_NUM_OFFSET;
 	pll->denom_offset = PLL_DENOM_OFFSET;
 
 	switch (type) {
+	case IMX_PLLV3_GENERICV2:
+		pll->lock_bit = BM_PLL_LOCK_V2;
+		pll->powerup_set = true;
+		ops = &clk_pllv3_genericv2_ops;
+		break;
+	case IMX_PLLV3_SYSV2:
+		pll->lock_bit = BM_PLL_LOCK_V2;
+		pll->powerup_set = true;
+		fallthrough;
 	case IMX_PLLV3_SYS:
 		ops = &clk_pllv3_sys_ops;
 		break;
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 7d220a01de1f..e70e985840a4 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -220,6 +220,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
+	IMX_PLLV3_GENERICV2,
+	IMX_PLLV3_SYSV2,
 	IMX_PLLV3_SYS,
 	IMX_PLLV3_USB,
 	IMX_PLLV3_USB_VF610,
@@ -231,6 +233,8 @@ enum imx_pllv3_type {
 	IMX_PLLV3_AV_IMX7,
 };
 
+void imx_clk_hw_pll3_powerbit(struct clk_hw *hw, u8 shift);
+
 struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 		const char *parent_name, void __iomem *base, u32 div_mask);
 
-- 
2.35.1

