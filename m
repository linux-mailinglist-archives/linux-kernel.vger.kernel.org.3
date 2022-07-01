Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12D45631FA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236556AbiGAKx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbiGAKxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:53:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE31FCF4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:53:14 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id w1-20020a17090a6b8100b001ef26ab992bso2366155pjj.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ljX4VHxLEnJH6CxFcKPCMc5PmhMdDAHdoJtj9hiur4A=;
        b=ZJnV0EvEevnHaF+V45Jfd/vZCRzSzdRu+irbWKzuk44igljTEEObfiqNT4/id84ew8
         7LivaevSw+4G+bwl8ZyCUeOaZp07/xdf0+jrkbHA5CHHEgH33hoqd8rMrihn5oMudQuY
         aBsMIJICDEJxnECnNaZF0mmMNd3PMDVHVtKOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ljX4VHxLEnJH6CxFcKPCMc5PmhMdDAHdoJtj9hiur4A=;
        b=wufoHrq+QoktKwMo7QPSezG4yaag3oONxke54+pkJuZHZrTOUjLcdP3aGy7YDzzjy/
         A9HxorOM0HA6lDa7Ja43K7eodgtvhi6eKUuaPh8sHht/nmoACMHentug+elERwocNRQA
         nSh3UVvZoAEfIzvMMFKAg8xoiJq3ujJQUQsQl0maKDNw23uolzjiIx1uYovyTmI14jsw
         qmnQ9+TCau1q1pR7JXS9hlklgdsdzLzH4+Gyu1d8QlFl5pUiMwKZm2SzJlL18iQ164O9
         LHw6htMRnAgstMl+QWbEQ36lAZ5puXUjrU86A6q7uHcvlERQ0S4C3ZCQJFUp7LuhkN+A
         4qXg==
X-Gm-Message-State: AJIora/vVUEi/RrOpE4yv3pR9Sf9rhkskZ4gEZw8j5TqgI7vtuy/e4Fd
        f0hJjc4NLngBLa/o97XRNbG7vYMNpf2Cew==
X-Google-Smtp-Source: AGRyM1tgfY+HHtcbLfi96MHFfZj/RaDV0HbBWEhSC7TBeizj9KXzshRAWOyabhIS2FBHMwG4J9iaYg==
X-Received: by 2002:a17:902:bb8f:b0:16a:80e7:e5d9 with SMTP id m15-20020a170902bb8f00b0016a80e7e5d9mr20663846pls.25.1656672794162;
        Fri, 01 Jul 2022 03:53:14 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:13 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/6] media: mediatek: vcodec: Revert driver name change in encoder capabilities
Date:   Fri,  1 Jul 2022 18:52:35 +0800
Message-Id: <20220701105237.932332-5-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220701105237.932332-1-wenst@chromium.org>
References: <20220701105237.932332-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit fd9f8050e355d7fd1e126cd207b06c96cde7f783.

The driver name field should contain the actual driver name, not some
otherwise unused string macro from the driver. To make this clear,
copy the name from the driver's name field.

Fixes: fd9f8050e355 ("media: mediatek: vcodec: Change encoder v4l2 capability value")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h | 1 +
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
index 4140b4dd85bf..dc6aada882d9 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
@@ -22,6 +22,7 @@
 #define MTK_VCODEC_DRV_NAME	"mtk_vcodec_drv"
 #define MTK_VCODEC_DEC_NAME	"mtk-vcodec-dec"
 #define MTK_VCODEC_ENC_NAME	"mtk-vcodec-enc"
+#define MTK_PLATFORM_STR	"platform:mt8173"
 
 #define MTK_VCODEC_MAX_PLANES	3
 #define MTK_V4L2_BENCHMARK	0
diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
index ccc753074816..30aac54d97fa 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -232,11 +232,13 @@ static int mtk_vcodec_enc_get_chip_name(void *priv)
 static int vidioc_venc_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_enc_get_chip_name(priv);
 
-	strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
-	strscpy(cap->card, MTK_VCODEC_ENC_NAME, sizeof(cap->card));
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-enc", platform_name);
+	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
 
 	return 0;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

