Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C465357DD1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiGVJGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234819AbiGVJG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:06:28 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D837D820FC;
        Fri, 22 Jul 2022 02:06:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D394E6601AC4;
        Fri, 22 Jul 2022 10:06:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658480785;
        bh=mMJ3K3TbXn/UUL3S3d3jiPJuEaitXGiVGUupceF1OPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jrOBiCnS/BpRMjPT9WRXnEsL9rOV8m/wdtb2QAXOOhWO5TSofZfCO5+JCVNAgsAtX
         ehbKREA2qNsN0V2/HTgCDHM/ft4MLcp6QEysX8GF9ljG/kiFQo+k0W9U8lwFkd/5QN
         oT/95BdGOokcQmqEpGQO1yHJJk3RiArj52wreVnupD48bGw9Fu5OLK+V+jxl05tbDd
         JjYi4V5eBJm4fwPVI+mjZ0vEJ4fLfLjo4JFv6Z8QbS9nB7MFwPE8IlDFF+ovqJ91a2
         QZcMvHWpQxtTgwqZ6K1vjA29zLlKVDOsxrbx2z5rIpCtyAM8CPlq4oMitc+mWPxNwk
         i9Vd23RKtivXA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, y.oudjana@protonmail.com,
        angelogioacchino.delregno@collabora.com, jason-jh.lin@mediatek.com,
        ck.hu@mediatek.com, fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        kernel@collabora.com
Subject: [PATCH v6 7/8] clk: mediatek: clk-apmixed: Add helper function to unregister ref2usb_tx
Date:   Fri, 22 Jul 2022 11:06:08 +0200
Message-Id: <20220722090609.52364-8-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
References: <20220722090609.52364-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ref2usb_tx clock was introduced a long time ago and, at that time,
the MediaTek clock drivers were using CLK_OF_DECLARE, so they would
never unregister.

Nowadays, unregistering clock drivers is a thing, as we're registering
them as platform_driver and allowing them to be kernel modules: add a
helper function to cleanup the ref2usb_tx clock during error handling
and upon module removal.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 9 +++++++++
 drivers/clk/mediatek/clk-mtk.h     | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index f126da693a7f..60e34f124250 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -100,4 +100,13 @@ struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_ref2usb_tx);
 
+void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw)
+{
+	struct mtk_ref2usb_tx *tx = to_mtk_ref2usb_tx(hw);
+
+	clk_hw_unregister(hw);
+	kfree(tx);
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_ref2usb_tx);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 1b95c484d5aa..62d650045cba 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -188,6 +188,7 @@ void mtk_free_clk_data(struct clk_hw_onecell_data *clk_data);
 
 struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
+void mtk_clk_unregister_ref2usb_tx(struct clk_hw *hw);
 
 struct mtk_clk_desc {
 	const struct mtk_gate *clks;
-- 
2.35.1

