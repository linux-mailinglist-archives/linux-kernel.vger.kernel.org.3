Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61E6570C3D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiGKU5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiGKU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:57:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449DB71BD4;
        Mon, 11 Jul 2022 13:57:46 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B19C6601A08;
        Mon, 11 Jul 2022 21:57:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657573064;
        bh=lT2RbPUhF1d7L6O72t6D2MDk7XFGvlh+JP1mpe3bNmE=;
        h=From:To:Cc:Subject:Date:From;
        b=ONr3aZj2yAqacjB/6ndNsvSF1urKkAwSJUU60eNh08Zg3DzD7Pl5z9PmISv7undHo
         bsnM1YkzSqlc1FMZ4Moax+DugL1UCI30LWGd3GZIlB08u8QZXwi972F7fYBuD/Xl9t
         dHyB7qmkYIxg7YSmNycsZ0PUHRU27bB7I8xTZyySCobiE3N5WaCJrzVUOFPzx/D+ga
         ORNCF3qA4flzcbGBenKwj1/ZBiQUBsaX3y/5WDA8hnHtCktgveSgpv4jsRjztIOXeS
         4ea8KL7nkC2sDVQUcP+b2EUHSBDPXQouG5LevJ49ZJfGh9ReqJhCu3ivqt1Oz8/Xlm
         zVfmSmZAFOvYQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's imp_iic_wrap clocks
Date:   Mon, 11 Jul 2022 16:57:33 -0400
Message-Id: <20220711205733.203963-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel parent
clock be enabled before their hardware status can be checked. Since this
wasn't taken into account, reading from the clk_summary debugfs file
would cause the system to completely freeze.

Assuming that this clock is managed only by the kernel, and not by any
firmware, simply drop the is_enabled() optional callback and instead
rely on the enable count for the imp_iic_wrap clocks.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/clk/mediatek/clk-gate.c                | 6 ++++++
 drivers/clk/mediatek/clk-gate.h                | 1 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index 421806236228..8e7c719a69b3 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -124,6 +124,12 @@ static void mtk_cg_disable_inv_no_setclr(struct clk_hw *hw)
 	mtk_cg_clr_bit_no_setclr(hw);
 }
 
+const struct clk_ops mtk_clk_gate_ops_setclr_counted = {
+	.enable		= mtk_cg_enable,
+	.disable	= mtk_cg_disable,
+};
+EXPORT_SYMBOL_GPL(mtk_clk_gate_ops_setclr_counted);
+
 const struct clk_ops mtk_clk_gate_ops_setclr = {
 	.is_enabled	= mtk_cg_bit_is_cleared,
 	.enable		= mtk_cg_enable,
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index d9897ef53528..b5502b2911f5 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -19,6 +19,7 @@ extern const struct clk_ops mtk_clk_gate_ops_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_no_setclr_inv;
+extern const struct clk_ops mtk_clk_gate_ops_setclr_counted;
 
 struct mtk_gate_regs {
 	u32 sta_ofs;
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index 700356ac6a58..900ee601169c 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -20,7 +20,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 
 #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)			\
 	GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,	\
-		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+		&mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
 
 static const struct mtk_gate imp_iic_wrap_c_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_C_I2C10, "imp_iic_wrap_c_i2c10", "infra_i2c0", 0),
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index fbc809d05072..e50a77b844f4 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -18,7 +18,7 @@ static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
 
 #define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)				\
 	GATE_MTK_FLAGS(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift,	\
-		&mtk_clk_gate_ops_setclr, CLK_OPS_PARENT_ENABLE)
+		&mtk_clk_gate_ops_setclr_counted, CLK_OPS_PARENT_ENABLE)
 
 static const struct mtk_gate imp_iic_wrap_s_clks[] = {
 	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_S_I2C5, "imp_iic_wrap_s_i2c5", "top_i2c", 0),
-- 
2.37.0

