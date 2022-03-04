Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D00BC4CD8F0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240763AbiCDQQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240705AbiCDQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:16:21 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17DB1B8CB9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:15:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id bk29so13441243wrb.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n+My/nqfiMsUFME5jSzdOaKmEvDAySulF7VBL4+IJf4=;
        b=PnqV9wYmLqfFTc4OFJc5UAuaMvtmWEJJN1yL6Rm7H2Q2mStp4J3ChxMgn06ydCvXyK
         UVRtV/otmLgWI2azaSmPvS4xLdRkV3dkpCcAM6LMGr8w+AwDloylveLMcJBdDQosT0q5
         KPsoJe0mc+UridMf98U3NAi8nlEXwLZWoGI3R2UzOvVn1t8KlwaJZlZvWSBH4JdmARrb
         akkAOnaXLWabkA7OwsKaB8vjC2N/RQOQJb3V3D7vfckSt1zL+lkoaFiaTEfO/g8DDgbe
         zgYKdl4HKH63UGK6xrr+AByFwFqoA8+ajW49r1XlNolMOOXw3kyLLtWl1STMzHFKGZZ+
         zIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n+My/nqfiMsUFME5jSzdOaKmEvDAySulF7VBL4+IJf4=;
        b=LWOUfxuChcroXRw10wT7qFTuWJHuc1yV9EuRWu01PbfOMug2WecfPo4VTw5yc8JKnq
         2QiQVmNcb89cfVNJbrRf3fcBhaooDTHLd/fWh6+CY+LwUTf7CcuZhfUxrDp0/W4cs/Cg
         oPoB2mJ6yHpVdMpodNfhF8H5dvkAsB1O9cjOVbGeChidOxuqTj4RPJk/IntGpCiN+fqF
         tAsyhL0o8VuGNyRSc/okw4FuBb8nZvTlFuJgG+w7qkvffNniD9+2xg+4+y/ehR3+i8/5
         GqiQlaONzYw82QND/80/QZfgWqEQkMXJ4BbxnVJRvbqlzVSk2QwxWstkcwOYnllf8whB
         ar/A==
X-Gm-Message-State: AOAM530UAejj+/Ig4NXAMcJ0gXmKGOPuhHk/EV8PUF2dnADQD0HcbNnO
        IUCGSxLi1VSRv0jXLHiautdmcw==
X-Google-Smtp-Source: ABdhPJyfHIvzkrsMlpfQsnDvygOuOwOVs1EDwFq3zpjNDBuNMMUBYWWaEnz39fCgj1Cxh74/FkXKDg==
X-Received: by 2002:adf:ef81:0:b0:1f0:95f:30a7 with SMTP id d1-20020adfef81000000b001f0095f30a7mr13676692wro.636.1646410531281;
        Fri, 04 Mar 2022 08:15:31 -0800 (PST)
Received: from xps-9300.baylibre (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g6-20020a5d5406000000b001f049726044sm4937307wrv.79.2022.03.04.08.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 08:15:30 -0800 (PST)
From:   Alexandre Bailon <abailon@baylibre.com>
To:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or
Cc:     matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com,
        Julien STEPHAN <jstephan@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>
Subject: [PATCH v4 5/7] remoteproc: mtk_apu: Use match_data
Date:   Fri,  4 Mar 2022 17:15:12 +0100
Message-Id: <20220304161514.994128-6-abailon@baylibre.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220304161514.994128-1-abailon@baylibre.com>
References: <20220304161514.994128-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien STEPHAN <jstephan@baylibre.com>

This commits prepare the driver to be more generic in order to support
multiple platform using the compatible property.
To do that, put some register values and the clocks names inside
private data.

Signed-off-by: Julien STEPHAN <jstephan@baylibre.com>
Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 drivers/remoteproc/mtk_apu.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/remoteproc/mtk_apu.c b/drivers/remoteproc/mtk_apu.c
index 3905eb5b7174..deec51b86ba5 100644
--- a/drivers/remoteproc/mtk_apu.c
+++ b/drivers/remoteproc/mtk_apu.c
@@ -58,12 +58,20 @@
 
 #define APU_RESET_DELAY				(27)
 
+struct mtk_apu_conf {
+	u32 core_default0;
+	u32 core_default1;
+	u32 num_clks;
+	const char * const *clk_names;
+};
+
 struct mtk_apu_rproc {
 	struct device *dev;
 	void __iomem *base;
 	int irq;
 	unsigned int num_clks;
 	struct clk_bulk_data *clks;
+	struct mtk_apu_conf *conf;
 	struct iommu_domain *domain;
 	struct list_head mappings;
 
@@ -81,6 +89,13 @@ static const char * const mt8183_clk_names[] = {
 	"jtag"
 };
 
+static const struct mtk_apu_conf mt8183_conf = {
+	.core_default0 = (0x10 << 23) | (0x10 << 18),
+	.core_default1 = (0x10 << 0) | (0x10 << 5),
+	.num_clks = ARRAY_SIZE(mt8183_clk_names),
+	.clk_names = mt8183_clk_names
+};
+
 static int mtk_apu_iommu_map(struct rproc *rproc, struct rproc_mem_entry *entry)
 {
 	struct mtk_apu_rproc *apu_rproc = rproc->priv;
@@ -289,10 +304,9 @@ static int mtk_apu_rproc_start(struct rproc *rproc)
 	writel(core_ctrl, apu_rproc->base + CORE_CTRL);
 
 	/* Configure memory accesses to go through the IOMMU */
-	writel(CORE_DEFAULT0_AWUSER_USE_IOMMU | CORE_DEFAULT0_ARUSER_USE_IOMMU |
-	      CORE_DEFAULT0_QOS_SWAP_1, apu_rproc->base + CORE_DEFAULT0);
-	writel(CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
-		CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU,
+	writel(apu_rproc->conf->core_default0 | CORE_DEFAULT0_QOS_SWAP_1,
+		apu_rproc->base + CORE_DEFAULT0);
+	writel(apu_rproc->conf->core_default1,
 		apu_rproc->base + CORE_DEFAULT1);
 
 	/* Release the APU */
@@ -565,11 +579,18 @@ static int mtk_apu_rproc_probe(struct platform_device *pdev)
 		goto free_rproc;
 	}
 
-	apu_rproc->num_clks = ARRAY_SIZE(mt8183_clk_names);
+
+	apu_rproc->conf = (struct mtk_apu_conf *)device_get_match_data(dev);
+	if (!apu_rproc->conf) {
+		ret = -ENODEV;
+		goto free_rproc;
+	}
+
+	apu_rproc->num_clks = apu_rproc->conf->num_clks;
 	apu_rproc->clks = devm_kcalloc(dev, apu_rproc->num_clks,
 				     sizeof(*apu_rproc->clks), GFP_KERNEL);
 	for (i = 0; i < apu_rproc->num_clks; ++i)
-		apu_rproc->clks[i].id = mt8183_clk_names[i];
+		apu_rproc->clks[i].id = apu_rproc->conf->clk_names[i];
 
 	ret = devm_clk_bulk_get(dev, apu_rproc->num_clks, apu_rproc->clks);
 	if (ret) {
@@ -611,7 +632,7 @@ static int mtk_apu_rproc_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id mtk_apu_rproc_of_match[] = {
-	{ .compatible = "mediatek,mt8183-apu", },
+	{ .compatible = "mediatek,mt8183-apu", .data = &mt8183_conf },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, mtk_apu_rproc_of_match);
-- 
2.34.1

