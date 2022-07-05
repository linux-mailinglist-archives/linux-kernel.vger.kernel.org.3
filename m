Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E946E56647F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbiGEHwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbiGEHwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:52:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC5213D6A;
        Tue,  5 Jul 2022 00:52:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z41so14228829ede.1;
        Tue, 05 Jul 2022 00:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVHg27tFoCVvZZIXk/W94pwI0Pu4JuMAc/g2EqD7c8I=;
        b=CYr0HGCmIpU9tGWD2SZn/cCWxwGIhI4vSE7yNrw3jvX35pfLMdSuYkZn+aRhaqQrFV
         wUiljZdTSAT1Qphe09CajjMcNNRnZoLQSqWUKN1dMnHSybQYHCj3DH3pcjcsCdGXP3h4
         vRrOrUL/ZBeuYpPmACPFsXqQQ4JoJPDo39HZESMHB4X9FK5g8U1lc8GpTJodXm6wYMBm
         WXKMtYKcvuL5bvqEQIkvfYmthZXs6zyeHrhVlUJgdud1+zK863uHkFMZ31enqw6dzC6E
         Z7ct5el9AqIuEb3hN5YuEEBBqV/EDTCCDFAeCDmBJcQm1R3ghLtwg+wQ1sY+z6zxdQLl
         bpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sVHg27tFoCVvZZIXk/W94pwI0Pu4JuMAc/g2EqD7c8I=;
        b=Vyk7NE8slJcTpY4jK/pxLVs0Shl1cc6FlRnJiXpNWMAfP8HC6UIBrCQ5LTT+cCPVk2
         lV4Y41vu8RrdZaCLbRGcf3kU2CnBxQpCtQG36Kf9yBDfTu7CWEhxIireoQEFRI+n10mM
         rN6WJZQywiPlwcg4B4guoFeSoJL9hnHtnEon1m7meoHs2zpCD6czZNYQ7+8cpliENpgJ
         KvzpiIQSw9qfAktY3d5iX0AvEZrYH23hnr0Jzac4QSV79RUR5lRL9zCz1L1dkFyAsa3F
         OmFrc0I0kqIt/QDI6PA6/MCbcJlon6RjrmjRQ9aqDpLv8tDn9j8o3eP6lEr5FlLt+EsL
         35cQ==
X-Gm-Message-State: AJIora+jvzPy15ppgm5AJa0FYEm48P3BJryri7nT3z8eIHpP2iZ/Od8L
        EDmYtk61a9s9835TunHWEjc=
X-Google-Smtp-Source: AGRyM1vYJUa7eNnjIo+BOJ3SwH3f9c/JjmwfxHh5ctJZ51DjW1EJTxHpL1HA2YYhSpMihoKRCuag0g==
X-Received: by 2002:a05:6402:4414:b0:434:f58c:ee2e with SMTP id y20-20020a056402441400b00434f58cee2emr43708933eda.362.1657007560160;
        Tue, 05 Jul 2022 00:52:40 -0700 (PDT)
Received: from roman-Latitude-3400.globallogic.com ([195.234.74.2])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090676d100b0072aac7446edsm4171579ejn.41.2022.07.05.00.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:52:39 -0700 (PDT)
From:   Roman Stratiienko <r.stratiienko@gmail.com>
To:     samuel@sholland.org
Cc:     peron.clem@gmail.com, mturquette@baylibre.com, sboyd@kernel.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@gmail.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: [PATCH v3] clk: sunxi-ng: sun50i: h6: Modify GPU clock configuration to support DFS
Date:   Tue,  5 Jul 2022 10:52:26 +0300
Message-Id: <20220705075226.359475-1-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using simple bash script it was discovered that not all CCU registers
can be safely used for DFS, e.g.:

    while true
    do
        devmem 0x3001030 4 0xb0003e02
        devmem 0x3001030 4 0xb0001e02
    done

Script above changes the GPU_PLL multiplier register value. While the
script is running, the user should interact with the user interface.

Using this method the following results were obtained:

| Register  | Name           | Bits  | Values | Result |
| --        | --             | --    | --     | --     |
| 0x3001030 | GPU_PLL.MULT   | 15..8 | 20-62  | OK     |
| 0x3001030 | GPU_PLL.INDIV  |     1 | 0-1    | OK     |
| 0x3001030 | GPU_PLL.OUTDIV |     0 | 0-1    | FAIL   |
| 0x3001670 | GPU_CLK.DIV    |  3..0 | ANY    | FAIL   |

DVFS started to work seamlessly once dividers which caused the
glitches were set to fixed values.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>

---

Changelog:

V2:
- Drop changes related to mux
- Drop frequency limiting
- Add unused dividers initialization

V3:
- Adjust comments
---
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 2ddf0a0da526f..068d1a6b2ebf3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -95,13 +95,13 @@ static struct ccu_nkmp pll_periph1_clk = {
 	},
 };
 
+/* For GPU PLL, using an output divider for DFS causes system to fail */
 #define SUN50I_H6_PLL_GPU_REG		0x030
 static struct ccu_nkmp pll_gpu_clk = {
 	.enable		= BIT(31),
 	.lock		= BIT(28),
 	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
 	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
-	.p		= _SUNXI_CCU_DIV(0, 1), /* output divider */
 	.common		= {
 		.reg		= 0x030,
 		.hw.init	= CLK_HW_INIT("pll-gpu", "osc24M",
@@ -294,9 +294,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(deinterlace_clk, "deinterlace",
 static SUNXI_CCU_GATE(bus_deinterlace_clk, "bus-deinterlace", "psi-ahb1-ahb2",
 		      0x62c, BIT(0), 0);
 
+/* Keep GPU_CLK divider const to avoid DFS instability. */
 static const char * const gpu_parents[] = { "pll-gpu" };
-static SUNXI_CCU_M_WITH_MUX_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
-				       0, 3,	/* M */
+static SUNXI_CCU_MUX_WITH_GATE(gpu_clk, "gpu", gpu_parents, 0x670,
 				       24, 1,	/* mux */
 				       BIT(31),	/* gate */
 				       CLK_SET_RATE_PARENT);
@@ -1193,6 +1193,16 @@ static int sun50i_h6_ccu_probe(struct platform_device *pdev)
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
 
+	/* Force PLL_GPU output divider bits to 0 */
+	val = readl(reg + SUN50I_H6_PLL_GPU_REG);
+	val &= ~BIT(0);
+	writel(val, reg + SUN50I_H6_PLL_GPU_REG);
+
+	/* Force GPU_CLK divider bits to 0 */
+	val = readl(reg + gpu_clk.common.reg);
+	val &= ~GENMASK(3, 0);
+	writel(val, reg + gpu_clk.common.reg);
+
 	/* Enable the lock bits on all PLLs */
 	for (i = 0; i < ARRAY_SIZE(pll_regs); i++) {
 		val = readl(reg + pll_regs[i]);
-- 
2.34.1

