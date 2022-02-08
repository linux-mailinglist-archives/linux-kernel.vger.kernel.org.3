Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 925B84AD8B8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245633AbiBHNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358121AbiBHMk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:40:58 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CFB1C03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:40:58 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i186so18700664pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pBFx2NNySizl9K48zr+VPwNldMAmerPdyAm7Jk3BRWk=;
        b=dKOOzV/fLazBCNFOIEnm1JNdL32Rklrc3AbJNCzgIvQQSjUM4aXSr94j4xzxA420JJ
         D8hO08EooGKH7idQcvWrNue3Isw+YvpvtEimDh2FSFcw7oRHBX0zj8OIb+SVz4BL/Hde
         g44pgl8RqHpLGee8woAw3B4+pA2cYunOCzqlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pBFx2NNySizl9K48zr+VPwNldMAmerPdyAm7Jk3BRWk=;
        b=RZHdKQY0UxdKmXMoBfRezSmjt77mTmCuPIJSyRvg+CvLljQahEBUNFeG9ua6ltjcH/
         rljAfrGw5+FqgiummuLjprYzo07BzCjHRa/UNYnEqTWNeZPMniE302eDudeGWSwti1xL
         C8euMOh3DMMFQ0cpjlSMNhpxMmW5ptA3UEcwA4DG5Y1/KYotLRJaNLbYg5fbzFoaIWXN
         x+DJ7ZxpTS3D8Q/z+FhOZ/tIjCQIp8biJPYS/ox85wt27WlYkKTUzEJNGOgFgLEe2UF2
         zT8OVOVJQYHNAqRNq6kNkERSHTtz60yIczBmJGBPkSt32UrsouG1Rem6zbmKyFtHeA9f
         Pdzg==
X-Gm-Message-State: AOAM530gyQxGQcJcfhd/IBOMeQgdhj3NzvnOBA/IU1yO5h/SwluD22HG
        y1UGBNmLx/4t1DMHa5TYzbMCcA==
X-Google-Smtp-Source: ABdhPJybGo2oMnaPzu5i0PbVYfVuPU0yopXfczB8i1F8jCKZPXGGmiUODMzI2ZCp579316g2u8sY3g==
X-Received: by 2002:a63:5460:: with SMTP id e32mr3327867pgm.330.1644324057786;
        Tue, 08 Feb 2022 04:40:57 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:40:57 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/31] clk: mediatek: gate: Implement unregister API
Date:   Tue,  8 Feb 2022 20:40:07 +0800
Message-Id: <20220208124034.414635-5-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The gate clk type within the MediaTek clk driver library only has a
register function, and no corresponding unregister function. This
means there is no way for its users to properly implement cleanup
and removal.

Add a matching unregister function for the gate type clk.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-gate.c | 35 +++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-gate.h |  3 +++
 2 files changed, 38 insertions(+)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index e51cfd8c653c..ed1ad5535d41 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -193,6 +193,21 @@ static struct clk *mtk_clk_register_gate(const char *name,
 	return clk;
 }
 
+static void mtk_clk_unregister_gate(struct clk *clk)
+{
+	struct mtk_clk_gate *cg;
+	struct clk_hw *hw;
+
+	hw = __clk_get_hw(clk);
+	if (!hw)
+		return;
+
+	cg = to_mtk_clk_gate(hw);
+
+	clk_unregister(clk);
+	kfree(cg);
+}
+
 int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    const struct mtk_gate *clks, int num,
 				    struct clk_onecell_data *clk_data,
@@ -244,4 +259,24 @@ int mtk_clk_register_gates(struct device_node *node,
 }
 EXPORT_SYMBOL_GPL(mtk_clk_register_gates);
 
+void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
+			      struct clk_onecell_data *clk_data)
+{
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num; i > 0; i--) {
+		const struct mtk_gate *gate = &clks[i - 1];
+
+		if (IS_ERR_OR_NULL(clk_data->clks[gate->id]))
+			continue;
+
+		mtk_clk_unregister_gate(clk_data->clks[gate->id]);
+		clk_data->clks[gate->id] = ERR_PTR(-ENOENT);
+	}
+}
+EXPORT_SYMBOL_GPL(mtk_clk_unregister_gates);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 3d75521ba20c..344adffb6578 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -55,4 +55,7 @@ int mtk_clk_register_gates_with_dev(struct device_node *node,
 				    struct clk_onecell_data *clk_data,
 				    struct device *dev);
 
+void mtk_clk_unregister_gates(const struct mtk_gate *clks, int num,
+			      struct clk_onecell_data *clk_data);
+
 #endif /* __DRV_CLK_GATE_H */
-- 
2.35.0.263.gb82422642f-goog

