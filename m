Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D386E5631F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 12:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiGAKxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 06:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbiGAKxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 06:53:09 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C1B94
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 03:53:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id m14-20020a17090a668e00b001ee6ece8368so6040507pjj.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zRI9Gh7/YtjgP8mVgApQyA3GHi/707s2OxZOLEZ9+C4=;
        b=Hs8XspyQYDCsbTiyxekYNXorFxxz/uNUUV1G6tU7K0S9W/6puaw0ZMpKUGGZs4Tatk
         hA/iAbm6BPVSQRsQDD02OXTxKoQdFyHteMx9SVYTsFeBrHECss4HdVqLNMsSVkVIWyqy
         pEuFr4+J80MSXT0OqwAO8+fXVkbGwYjx4fhP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zRI9Gh7/YtjgP8mVgApQyA3GHi/707s2OxZOLEZ9+C4=;
        b=IgmMawEuMSPRKILcd1GVZtWQGgPOK4AfmkHCXm1KOvnSuOQN1aMBW5DVSKk+qgVmbs
         2/XOp7UfkAJfq9hfQj+BvRGAKr0fqjLu4QLnuEMzZiFLHFvhEQB/6udNSlJrVwhD9NUA
         tUTu5/3WAjNlQjfvFerquFJ3VhhwQkzxuO/KlpY4YOUdK3O9kQbXv2H8csA0WPql+JXV
         Md/1AF1atj5UaVDDoRn07LSYvyrzZpTGfZWB7cX8WF7erG8AfVms1BYoAE3GbXvJZihQ
         qh45iKFe88iuN9Yox7+5LqJ/8EgAQkmxPGbr36djPzNCzp/bTm+wAEe2ftI2SEZUbOcc
         UhWA==
X-Gm-Message-State: AJIora/p/f6ZbzRkSGDw/R8hFIriJQlympPLfmKiXmb9mhVnDPWh8Udw
        YnISGIG/v/9QYej8LqIhjwsNhg==
X-Google-Smtp-Source: AGRyM1thrJAL4fMosshrrxIa9gN4QIMY/Q1Zq8NQRWgztOQpLfQiSsViCjvDYvLI4NRK+Rca0AtsbA==
X-Received: by 2002:a17:90a:bc84:b0:1ec:81f4:f86f with SMTP id x4-20020a17090abc8400b001ec81f4f86fmr17714158pjr.29.1656672787210;
        Fri, 01 Jul 2022 03:53:07 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:59bf:8b47:50a0:b04f])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b0016a058b7547sm14906670pll.294.2022.07.01.03.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:53:06 -0700 (PDT)
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
Subject: [PATCH 1/6] media: mediatek: vcodec: Revert driver name change in decoder capabilities
Date:   Fri,  1 Jul 2022 18:52:32 +0800
Message-Id: <20220701105237.932332-2-wenst@chromium.org>
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

This partially reverts commit a8a7a278c56ad3b4ddd4db9a960e0537d032b0b3.

This recent change caused ChromeOS's decoder to no longer function. This
is due to ChromeOS using the driver name field to match the video device
with its accompanying media device. After the change, they no longer
matched.

The driver name field should contain the actual driver name, not some
otherwise unused string macro from the driver. To make this clear,
copy the name from the driver's name field.

Fixes: a8a7a278c56a ("media: mediatek: vcodec: Change decoder v4l2 capability value")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 5d6fdf18c3a6..e7ea632a3f94 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -243,9 +243,11 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
-	strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
 	strscpy(cap->card, MTK_VCODEC_DEC_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-dec", platform_name);
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

