Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635A581E19
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 05:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbiG0DQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 23:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiG0DQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 23:16:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D443DBD7;
        Tue, 26 Jul 2022 20:15:53 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id b11so7527462qvo.11;
        Tue, 26 Jul 2022 20:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+bzNz23O5POP059NXGAFxBTvgq0VJPxoUFyJ+Zf+sF4=;
        b=UDumRfitfDXkwxTCYroM9auAdxgh7zfPXcOozNvr7CHwzo3fFlRvTPLAzo9ts0lpE4
         H5EvN8f8I2uANMvl+ZLCPB5wHb3i+7dJ1s2yoM0XURiqD/nvxP5WTnXnjBIb9nU1RYJw
         3Cp2TNZkR5UmS5k6G7FOaaWeVcG6GxWYclTMiL6dyAMuuEpLyV5ReLUMgb3y8Ep4PxXS
         vNGhe0gbIhnrqiU0ObxkSTn7g5aPTZVes3nEvcvOk1uV3Tf6p2UY80S1XyIEfrhQQX20
         d4lEl7ge3IDUloHLOeS6oNk4Mf8txKZPGNcKWvE3jP97LK+rkC6dHN04uUaK/uEfEkTQ
         rQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+bzNz23O5POP059NXGAFxBTvgq0VJPxoUFyJ+Zf+sF4=;
        b=GrDQiZlHMbkq3ptJOCavw/5J1/EITPfi2EN6yzIePXDYov33rTPbAGQF/lKW2Q5ARY
         zKRszQbZ6Lc0FnzJlxtTlqf8rs/wUnOYCTvXt4W2bdOqx8/wRudKgaI86GYV421jO7pb
         KHzeNIeapc11zusy2W34okPCP8jvPKEcIfG4gFWzU4aCR1R+6PSU3e9ArkatxVQAVUJp
         oDnBfkerASlUfrv+7c66KplHp4g5YeAHm4IB5sjkOc6i1KuLPoOU+VUWPK/mArhH69lB
         pcXabtWYc5xinVqGhk5SgYMlV47Ho9am2A1kvwbiGVoNrFcnq1T/yAooJayscNRG6HOz
         d09Q==
X-Gm-Message-State: AJIora8bI0I7gLQRIOKVcNWa5uf0AfOFmv/MZTJ5tAu6SF5Z37/gmoXq
        5zyUxwI0YB6GQj4akx1wlag=
X-Google-Smtp-Source: AGRyM1t+vUxgJN+mx4u+5T5G83vTtc2ZbeXbJ64OlRvHoSc//1wcJ8a+5wCTXGgNBsHDFR5t20Gc0g==
X-Received: by 2002:ad4:5ecd:0:b0:474:71ae:da8d with SMTP id jm13-20020ad45ecd000000b0047471aeda8dmr2197372qvb.114.1658891752116;
        Tue, 26 Jul 2022 20:15:52 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id o21-20020a05620a2a1500b006b249cc505fsm13139981qkp.82.2022.07.26.20.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 20:15:46 -0700 (PDT)
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
Subject: [PATCH v5 07/12] clk: imx: Update pllv3 to support i.MXRT1170
Date:   Tue, 26 Jul 2022 23:15:41 -0400
Message-Id: <20220727031541.227335-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <202207270909.VypZ4wfI-lkp@intel.com>
References: <202207270909.VypZ4wfI-lkp@intel.com>
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
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Add __imx_clk_hw_pllv3 to change power bit
 - Add BM_PLL_POWER and imx_clk_hw_pllv3 to header
 - Remove imx_clk_hw_pll3_powerbit
---
 drivers/clk/imx/clk-pllv3.c | 57 +++++++++++++++++++++++++++++++++----
 drivers/clk/imx/clk.h       | 11 +++++--
 2 files changed, 60 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index eea32f87c60a..68b1498cafe1 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -21,8 +21,8 @@
 #define PLL_VF610_NUM_OFFSET	0x20
 #define PLL_VF610_DENOM_OFFSET	0x30
 
-#define BM_PLL_POWER		(0x1 << 12)
 #define BM_PLL_LOCK		(0x1 << 31)
+#define BM_PLL_LOCK_V2		(0x1 << 29)
 #define IMX7_ENET_PLL_POWER	(0x1 << 5)
 #define IMX7_DDR_PLL_POWER	(0x1 << 20)
 
@@ -34,6 +34,7 @@
  * @base:	 base address of PLL registers
  * @power_bit:	 pll power bit mask
  * @powerup_set: set power_bit to power up the PLL
+ * @lock_bit:	 pll lock bit mask
  * @div_mask:	 mask of divider bits
  * @div_shift:	 shift of divider bits
  * @ref_clock:	reference clock rate
@@ -48,6 +49,7 @@ struct clk_pllv3 {
 	void __iomem	*base;
 	u32		power_bit;
 	bool		powerup_set;
+	u32		lock_bit;
 	u32		div_mask;
 	u32		div_shift;
 	unsigned long	ref_clock;
@@ -65,7 +67,7 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
 	if ((pll->powerup_set && !val) || (!pll->powerup_set && val))
 		return 0;
 
-	return readl_relaxed_poll_timeout(pll->base, val, val & BM_PLL_LOCK,
+	return readl_relaxed_poll_timeout(pll->base, val, val & pll->lock_bit,
 					  500, PLL_LOCK_TIMEOUT);
 }
 
@@ -101,7 +103,7 @@ static int clk_pllv3_is_prepared(struct clk_hw *hw)
 {
 	struct clk_pllv3 *pll = to_clk_pllv3(hw);
 
-	if (readl_relaxed(pll->base) & BM_PLL_LOCK)
+	if (readl_relaxed(pll->base) & pll->lock_bit)
 		return 1;
 
 	return 0;
@@ -155,6 +157,39 @@ static const struct clk_ops clk_pllv3_ops = {
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
@@ -407,9 +442,9 @@ static const struct clk_ops clk_pllv3_enet_ops = {
 	.recalc_rate	= clk_pllv3_enet_recalc_rate,
 };
 
-struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
+struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 			  const char *parent_name, void __iomem *base,
-			  u32 div_mask)
+			  u32 div_mask, u8 pwr_bit)
 {
 	struct clk_pllv3 *pll;
 	const struct clk_ops *ops;
@@ -421,11 +456,21 @@ struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
 	if (!pll)
 		return ERR_PTR(-ENOMEM);
 
-	pll->power_bit = BM_PLL_POWER;
+	pll->power_bit = pwr_bit;
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
index 5061a06468df..2bf50c92fdfa 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -6,6 +6,8 @@
 #include <linux/spinlock.h>
 #include <linux/clk-provider.h>
 
+#define BM_PLL_POWER		BIT(12)
+
 extern spinlock_t imx_ccm_lock;
 extern bool mcore_booted;
 
@@ -102,6 +104,9 @@ extern struct imx_fracn_gppll_clk imx_fracn_gppll;
 	to_clk(clk_hw_register_gate2(dev, name, parent_name, flags, reg, bit_idx, \
 				cgr_val, cgr_mask, clk_gate_flags, lock, share_count))
 
+#define imx_clk_hw_pllv3(type, name, parent_name, base, div_mask) \
+	__imx_clk_hw_pllv3(type, name, parent_name, base, div_mask, 1)
+
 #define imx_clk_pllv3(type, name, parent_name, base, div_mask) \
 	to_clk(imx_clk_hw_pllv3(type, name, parent_name, base, div_mask))
 
@@ -242,6 +247,8 @@ struct clk_hw *imx_clk_hw_sscg_pll(const char *name,
 
 enum imx_pllv3_type {
 	IMX_PLLV3_GENERIC,
+	IMX_PLLV3_GENERICV2,
+	IMX_PLLV3_SYSV2,
 	IMX_PLLV3_SYS,
 	IMX_PLLV3_USB,
 	IMX_PLLV3_USB_VF610,
@@ -253,8 +260,8 @@ enum imx_pllv3_type {
 	IMX_PLLV3_AV_IMX7,
 };
 
-struct clk_hw *imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
-		const char *parent_name, void __iomem *base, u32 div_mask);
+struct clk_hw *__imx_clk_hw_pllv3(enum imx_pllv3_type type, const char *name,
+		const char *parent_name, void __iomem *base, u32 div_mask, u8 pwr_bit);
 
 #define PLL_1416X_RATE(_rate, _m, _p, _s)		\
 	{						\
-- 
2.36.1

