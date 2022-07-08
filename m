Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 195ED56B77F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238006AbiGHKpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238008AbiGHKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:45:23 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052984EF0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 03:45:21 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z1so10249491plb.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLbLav8l8KNdtyThB58u5SXfgbP0TLoaQoo90nnZjIw=;
        b=H6/aHv6DkkKB7cF5JsVlhpayBbZOXG0Cvl2/XYn64znFK/MtS4mC8I+s8YOK2HZeNh
         vMd9G+Wj5czYkhTnCdL+qqshd9r7aQ8bymOl+Fnj+kQlPGsJf44BDjJ6c7KKXX0NhIVe
         TevhgQUDyNHbPllQFobkTv9YW3fA2KaAxYBsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLbLav8l8KNdtyThB58u5SXfgbP0TLoaQoo90nnZjIw=;
        b=x0bYH50zEBJrzGABbD7ZXtJd60NfruuKY+hIPWRq4xGuVEse7Xq0HseKZ6a5io1GDg
         DwVz3UX7eiyEAHFpilpS2oq/KwAKhYnSZv0ZJKyKDPnhwd06BDba9o4PoADmbi/wAhrG
         wFE41KFpht/sZaVMHKvLX4BBuCCSaLFnSArEVtrOs0E5PzFEzWWFbfmnaKyyv2E7hJVw
         h1YgRRjKnH2P/HgA/lX06uF+1rVqyZFElhs4eySC8N8zg1ZFkf5BdwED/AplunV+dX4I
         sf2ERafuQ6ttyyHXtFOnlI+tZrQizwPRj8LkocqFnDHD7EjMdUy6CRRrOpwhRAx9iaRe
         egGg==
X-Gm-Message-State: AJIora+pTPf3AWGhnI4oPXjBhL/Xjw7WOFA6RdEt3x9hs1WrjFZ5a45u
        LUNamT9yQPYUwWJNAM2GM/PlAA==
X-Google-Smtp-Source: AGRyM1t7zh3BjpjgCpMwcYmLHbsBzl4/5XcKIXOUoFXqM0owdePl7ODco0/D1d+2ouSx2TTV0ocSHw==
X-Received: by 2002:a17:902:a589:b0:16b:c227:d7f9 with SMTP id az9-20020a170902a58900b0016bc227d7f9mr2892816plb.29.1657277120859;
        Fri, 08 Jul 2022 03:45:20 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:db98:ad5d:ca9:da58])
        by smtp.gmail.com with ESMTPSA id m6-20020a635806000000b0040c9213a414sm27216187pgb.46.2022.07.08.03.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:45:20 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 1/2] media: mediatek: vcodec: Make decoder capability fields fit requirements
Date:   Fri,  8 Jul 2022 18:44:50 +0800
Message-Id: <20220708104451.3901064-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220708104451.3901064-1-wenst@chromium.org>
References: <20220708104451.3901064-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This partially reverts commit a8a7a278c56ad3b4ddd4db9a960e0537d032b0b3,
and changes things so that the capability string fields of the decoder
conform to their requirements.

This recent change caused ChromeOS's decoder to no longer function. This
is due to ChromeOS using the driver name field to match the video device
with its accompanying media device. After the change, they no longer
matched.

The driver name field should contain the actual driver name, not some
otherwise unused string macro from the driver. To make this clear,
copy the name from the driver's name field.

The card name for the video decoder previously held a static platform
name that was fixed to match MT8173. This obviously doesn't make sense
for newer chips. Since commit a8a7a278c56a ("media: mediatek: vcodec:
Change decoder v4l2 capability value"), this field was changed to hold
the driver's name, or "mtk-vcodec-dec". This doesn't make much sense
either, since this still doesn't reflect what chip this is.

Instead, fill in the card name with "MTxxxx video decoder" with the
proper chip number.

Since commit f2d8b6917f3b ("media: v4l: ioctl: Set bus_info in
v4l_querycap()"), the V4L2 core provides a default value for the
bus_info field for platform and PCI devices. This value will match
the default value for media devices added by commit cef699749f37
("media: mc: Set bus_info in media_device_init()"). These defaults
are stable and device-specific.

Drop the custom capability bus_info from the mtk-vcodec decoder
driver, and use the defaults. This also fixes the long standing
issue where the media device used for the stateless decoder didn't
have its bus_info set, and would never match its accompanying video
device.

Fixes: a8a7a278c56a ("media: mediatek: vcodec: Change decoder v4l2 capability value")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index 5d6fdf18c3a6..209de1ec02e4 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -243,11 +243,12 @@ static int mtk_vcodec_dec_get_chip_name(void *priv)
 static int vidioc_vdec_querycap(struct file *file, void *priv,
 				struct v4l2_capability *cap)
 {
+	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
+	struct device *dev = &ctx->dev->plat_dev->dev;
 	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
 
-	strscpy(cap->driver, MTK_VCODEC_DRV_NAME, sizeof(cap->driver));
-	strscpy(cap->card, MTK_VCODEC_DEC_NAME, sizeof(cap->card));
-	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-dec", platform_name);
+	strscpy(cap->driver, dev->driver->name, sizeof(cap->driver));
+	snprintf(cap->card, sizeof(cap->card), "MT%d video decoder", platform_name);
 
 	return 0;
 }
-- 
2.37.0.rc0.161.g10f37bed90-goog

