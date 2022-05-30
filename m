Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5485384C5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 17:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238936AbiE3PXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 11:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239582AbiE3PXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 11:23:33 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3941913392B
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:24:19 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s24so7546705wrb.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUAWdJ1Rf6hO8ecNBUpnATX0ltMJMJR8PSAH4KO8bJM=;
        b=LXAGdGTLAayi/VD6RlJh8cDSac2FGSYcJt/uGESSMobfyQL1XbIq81Ywa+yllK/x2E
         sJAS1Rtf5zCjVFmHW4pfy9Tm5dcA5ZVlkEAgvw2NGpz9WZyyL1fOivsSvW9ytr3I57tI
         +6fjo5tQhXgr2qaexjNggNiuq6T69aTHW9odw2YHwZzw+W6m95HcY+q9sBmorz9c0xYk
         bA0W/CuhgZRg2uQS5Mkr9/Y/bZpmCfybLP6mrXZw7koQ3b+VufvplHhXB5NVUCdaMUoW
         TCkVYinu9AA7khJHktcQJTHSDsPEUzbWColgtl13bs4lm9K4PQIRKfICpI7XOPwBSQPj
         1kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rUAWdJ1Rf6hO8ecNBUpnATX0ltMJMJR8PSAH4KO8bJM=;
        b=wguXXSstmbFqMlC4UYsrOBnM7Ct/0i1T4ExsHwq4UCzo2CMyYeQifTeXAiN23Zc9j7
         x3Zb+2YITWhxm+az/ZVVNmCy+0kdnPvaqcGpEO0jKyKoRBHEdnV2xCuBiyFhe1kM5Srb
         A12KykUZUVucP2qqwYdJMH2KeinTqFtdMlfsyD2GrLEh8mnoXQa4x+Yhi8+4YhEc6d28
         LKcyAaAmfyEe3dfFVGNP1v1O8e2JBrvPVb3UDPNfA0Y1yVgkeelKpAf6Bd2I+Xn9k29O
         JC2B1GCICPqV7FPup+lVAOi4IXcvc1d4wVFq5yCswVuZeZ7WjbeOvZhrRxVpmHGxU4/V
         7JGg==
X-Gm-Message-State: AOAM53226kiCf7XeZlriR/g1XWlIC8N5M1PQDMYT0WNYHces6cD74CKl
        q2s45J22AfLlzyd1XcrzugiNPw==
X-Google-Smtp-Source: ABdhPJwUdn2UEohzLhlkvTp89uivSBFAQcrCfQrdg/myp0CdGWHmaAJLOG8f0NAC612sXpmZ9kB+sw==
X-Received: by 2002:a05:6000:1288:b0:210:154:ea50 with SMTP id f8-20020a056000128800b002100154ea50mr21132673wrx.213.1653920656629;
        Mon, 30 May 2022 07:24:16 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id y4-20020a056000168400b0020d10a249eesm9134310wrd.13.2022.05.30.07.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 07:24:15 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/mediatek: fix crtc index computation
Date:   Mon, 30 May 2022 16:24:07 +0200
Message-Id: <20220530142407.781187-1-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code always assume that the main path is enabled, which is not
always the case. When the main path is not enabled, the CRTC index
of the ext path is incorrect which makes the secondary path
not usable. Fix the CRTC index calculation.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 46 +++++++++++++++------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 5d7504a72b11..6f2abfc608fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -430,25 +430,47 @@ int mtk_ddp_comp_get_id(struct device_node *node,
 	return -EINVAL;
 }
 
+static bool mtk_drm_comp_is_enabled(struct drm_device *drm,
+				    const enum mtk_ddp_comp_id *path,
+				    unsigned int path_len)
+{
+	struct mtk_drm_private *priv = drm->dev_private;
+
+	return path && path_len && !!priv->comp_node[path[path_len - 1]];
+}
+
 unsigned int mtk_drm_find_possible_crtc_by_comp(struct drm_device *drm,
 						struct device *dev)
 {
 	struct mtk_drm_private *private = drm->dev_private;
-	unsigned int ret = 0;
+	unsigned int index = 0;
 
-	if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path, private->data->main_len,
+	if (mtk_drm_find_comp_in_ddp(dev, private->data->main_path,
+				     private->data->main_len,
 				     private->ddp_comp))
-		ret = BIT(0);
-	else if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
-					  private->data->ext_len, private->ddp_comp))
-		ret = BIT(1);
-	else if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
-					  private->data->third_len, private->ddp_comp))
-		ret = BIT(2);
-	else
-		DRM_INFO("Failed to find comp in ddp table\n");
+		return BIT(index);
+
+	if (mtk_drm_comp_is_enabled(drm, private->data->main_path,
+				    private->data->main_len))
+		index++;
 
-	return ret;
+	if (mtk_drm_find_comp_in_ddp(dev, private->data->ext_path,
+				     private->data->ext_len,
+				     private->ddp_comp))
+		return BIT(index);
+
+	if (mtk_drm_comp_is_enabled(drm, private->data->ext_path,
+				    private->data->ext_len))
+		index++;
+
+	if (mtk_drm_find_comp_in_ddp(dev, private->data->third_path,
+					  private->data->third_len,
+					  private->ddp_comp))
+		return BIT(index);
+
+	DRM_INFO("Failed to find comp in ddp table\n");
+
+	return 0;
 }
 
 int mtk_ddp_comp_init(struct device_node *node, struct mtk_ddp_comp *comp,
-- 
2.36.1

