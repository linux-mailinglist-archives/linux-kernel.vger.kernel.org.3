Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE244AD9A7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348284AbiBHNWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358871AbiBHMlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:50 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FAC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:50 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id y15-20020a17090a474f00b001b88562650aso1537746pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f58A/1DtWFAR6i5/+w1ZQ8Tebq6XEefT77x9yip685A=;
        b=dAxJ1uY0JeJ42b2+NiCsfx/Pt5X/LtfjX+5tx3nMzwMh3jdmABwDd/vi41hBsxB99d
         HZ3l5hiMF1lnHHafiU/FYqwX5Iv3F41ismnHxX+CoaEKPqW374BHRSMYFQFIMU5Wxl5R
         uhzZUjCuhr7XtovsJHy2VG1Bp7YRnzc9RnE94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f58A/1DtWFAR6i5/+w1ZQ8Tebq6XEefT77x9yip685A=;
        b=Pob3u6bSn+OqK00v5o/hr58U6N3fWqmwqtZhEJ8PNewNitqvB8S+MzLLjezHfh9Ca1
         r7JYhdZf12bs4kSnmq6SnnERIy9FIZAwiuqsqwiVxgKnjXMhugrPyvMFlzJ5QStVkSON
         ZQOvZq2jq30nHsKeqnaiWqF8WKk43/MnR+iDH+e+8srmOFg+8+9wjeFhmdArYj13GZq3
         2A9yUartvWEuVp0T0d9U9D8ih+1y1oV+it8Wgj13Hz30l4h51U3elZSvLvOT4rKgso0r
         f1Lb9U2lbrUzut5YWZFyaaSMRQj4UJYkEZ7MHfkllUGLHBET+jkNFZzwWtUObQeueWoi
         WTWQ==
X-Gm-Message-State: AOAM533CCFCbPNa2uyWylNa4Wqfhnn7fKXwLqlZLFRUb8w9Tk5ZGonOD
        GBNgNfJkSB6omX9A5NkTgYeqPQ==
X-Google-Smtp-Source: ABdhPJxh3EZ7l73kasR4nbML+pFZXLWwRtlMNJHU9EoD3F/hf7VKmbXwT4gY8hNmeA9an1RBHQUbCw==
X-Received: by 2002:a17:902:c111:: with SMTP id 17mr3142063pli.96.1644324109514;
        Tue, 08 Feb 2022 04:41:49 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:49 -0800 (PST)
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
Subject: [PATCH v3 28/31] clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
Date:   Tue,  8 Feb 2022 20:40:31 +0800
Message-Id: <20220208124034.414635-29-wenst@chromium.org>
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

Various small clock controllers only have clock gates, and utilize
mtk_clk_simple_probe() as their driver probe function.

Now that we have a matching remove function, hook it up for the relevant
drivers. This was done with the following command:

sed -i -e '/mtk_clk_simple_probe/a \
        .remove = mtk_clk_simple_remove,' drivers/clk/mediatek/clk-mt8195-*.c

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-mt8195-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-ccu.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 1 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c     | 1 +
 drivers/clk/mediatek/clk-mt8195-ipe.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c      | 1 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c     | 1 +
 drivers/clk/mediatek/clk-mt8195-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-wpe.c          | 1 +
 14 files changed, 14 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index 3d261fc3848e..e4d00fe6e757 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -134,6 +134,7 @@ static const struct of_device_id of_match_clk_mt8195_cam[] = {
 
 static struct platform_driver clk_mt8195_cam_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-cam",
 		.of_match_table = of_match_clk_mt8195_cam,
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index f846f1d73605..4e326b6301ba 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -42,6 +42,7 @@ static const struct of_device_id of_match_clk_mt8195_ccu[] = {
 
 static struct platform_driver clk_mt8195_ccu_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ccu",
 		.of_match_table = of_match_clk_mt8195_ccu,
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index 22b52a8f15fe..12f5c436d075 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -88,6 +88,7 @@ static const struct of_device_id of_match_clk_mt8195_img[] = {
 
 static struct platform_driver clk_mt8195_img_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-img",
 		.of_match_table = of_match_clk_mt8195_img,
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 4ab312eb26a5..fbc809d05072 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -58,6 +58,7 @@ static const struct of_device_id of_match_clk_mt8195_imp_iic_wrap[] = {
 
 static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-imp_iic_wrap",
 		.of_match_table = of_match_clk_mt8195_imp_iic_wrap,
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index 5f9b69967459..8ebe3b9415c4 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -198,6 +198,7 @@ static const struct of_device_id of_match_clk_mt8195_infra_ao[] = {
 
 static struct platform_driver clk_mt8195_infra_ao_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-infra_ao",
 		.of_match_table = of_match_clk_mt8195_infra_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index fc1d42b6ac84..b0d745cf7752 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -43,6 +43,7 @@ static const struct of_device_id of_match_clk_mt8195_ipe[] = {
 
 static struct platform_driver clk_mt8195_ipe_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-ipe",
 		.of_match_table = of_match_clk_mt8195_ipe,
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index aca6d9c0837c..9411c556a5a9 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -39,6 +39,7 @@ static const struct of_device_id of_match_clk_mt8195_mfg[] = {
 
 static struct platform_driver clk_mt8195_mfg_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-mfg",
 		.of_match_table = of_match_clk_mt8195_mfg,
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index 907a92b22de8..2f6b3bb657db 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -54,6 +54,7 @@ static const struct of_device_id of_match_clk_mt8195_peri_ao[] = {
 
 static struct platform_driver clk_mt8195_peri_ao_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-peri_ao",
 		.of_match_table = of_match_clk_mt8195_peri_ao,
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index 26b4846c5894..e16c383f631b 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -39,6 +39,7 @@ static const struct of_device_id of_match_clk_mt8195_scp_adsp[] = {
 
 static struct platform_driver clk_mt8195_scp_adsp_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-scp_adsp",
 		.of_match_table = of_match_clk_mt8195_scp_adsp,
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index a1df04f42a90..a1446b666385 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -96,6 +96,7 @@ static const struct of_device_id of_match_clk_mt8195_vdec[] = {
 
 static struct platform_driver clk_mt8195_vdec_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-vdec",
 		.of_match_table = of_match_clk_mt8195_vdec,
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 7339851a0856..622f57804f96 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -61,6 +61,7 @@ static const struct of_device_id of_match_clk_mt8195_venc[] = {
 
 static struct platform_driver clk_mt8195_venc_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-venc",
 		.of_match_table = of_match_clk_mt8195_venc,
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index c3241466a8d0..bf2939c3a023 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -102,6 +102,7 @@ static const struct of_device_id of_match_clk_mt8195_vpp0[] = {
 
 static struct platform_driver clk_mt8195_vpp0_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp0",
 		.of_match_table = of_match_clk_mt8195_vpp0,
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index ce0b9a40a179..ffd52c762890 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -100,6 +100,7 @@ static const struct of_device_id of_match_clk_mt8195_vpp1[] = {
 
 static struct platform_driver clk_mt8195_vpp1_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-vpp1",
 		.of_match_table = of_match_clk_mt8195_vpp1,
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index 274d60838d8e..b483fab10e18 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -135,6 +135,7 @@ static const struct of_device_id of_match_clk_mt8195_wpe[] = {
 
 static struct platform_driver clk_mt8195_wpe_drv = {
 	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8195-wpe",
 		.of_match_table = of_match_clk_mt8195_wpe,
-- 
2.35.0.263.gb82422642f-goog

