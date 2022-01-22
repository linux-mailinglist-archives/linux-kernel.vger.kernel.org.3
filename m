Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1C496B67
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiAVJU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiAVJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:19:54 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC97C0613EF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id d5so8916765pjk.5
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mf1Ke59g0whTcDmTE2X4XTGQ5PLXVqIsYn1wvgyc6go=;
        b=NZC5E3vuCUE4gTyZrXKANY75px2GeM9sHB0ThxEMsyWf7bFNFj82onVSvkTPDjymQj
         86d7d6HVOIsBwpS2RuYr7chQtybx8swkLfzgf8DLqwzRRBqVcmLUVkVfG9tG/12cne3A
         ekjZIh/ERAsxNl5nTeQhJgaAoX2BOt2dysIv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mf1Ke59g0whTcDmTE2X4XTGQ5PLXVqIsYn1wvgyc6go=;
        b=DQnPpbWIXZcpdeol8isk4SItee9C3H/KAcbARF31lVuK/bbEu1zaAuVmXg4/3Fa+Va
         fJKjGSg+ROvKAXEujZ1geZcc6FudzrKqdVIw5IGxqiFE2Ls5P9ERFdxRkBU9oNtApioH
         jmdDCDCzAsIxuMDRfrEEGR/7R+LSO9NvPguOkvto0trO+UCGn2nF47xebhut2hL2FPoM
         CES612QUczBxiRaH10xBwJVGaA/pRwHYRaVO5+ON67BW6hnNtz2qwnNUSGcNBsTXLGIH
         4D0EKxCneMJww7xAklH0lxUV98bH2szwc9VclGUNbG1ny+71l5JhNTkCf5OCOcJXm1a+
         oBnA==
X-Gm-Message-State: AOAM5338i3YOimuzSA3Tn1ZINSiXjmuNnpmxfoTtPcZJ665QViQk1iM0
        n8LW0mUbm+KxzZkN2G6J/HgaboDUHCqziQ==
X-Google-Smtp-Source: ABdhPJzED5tMtAsnPQbU9tA6BO4HhRQHaqZgZr4UpkvtZ+6QDKLmSbQeQU9mpJ0NnG8E+2a28C41cg==
X-Received: by 2002:a17:90b:3503:: with SMTP id ls3mr2950048pjb.127.1642843126766;
        Sat, 22 Jan 2022 01:18:46 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:46 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 28/31] clk: mediatek: mt8195: Hook up mtk_clk_simple_remove()
Date:   Sat, 22 Jan 2022 17:17:28 +0800
Message-Id: <20220122091731.283592-29-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.35.0.rc0.227.g00780c9af4-goog

