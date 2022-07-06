Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578A7568111
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiGFIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiGFIWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:06 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03100237FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:05 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y18so5043556plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tF4dHXue6VAthDO8rjRCUAqbIs0qxhJRHcU9wI4358E=;
        b=ZrQU0PrLMmbvxDBU2iEokT3gZ1VJwzUYnGZoo1MKx6gO6KZtoRwqLz13RzQGoaCh89
         W11Q1Q9Pp2QciYnlTxHqQj2PlHWSJpQ8fmCDVwQ2FuH6/lcS8tkrwOUVK4yRim08o/tG
         FKuXDrZ0u3emEEGWUDGE32QQB1ALVrI2O7nWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tF4dHXue6VAthDO8rjRCUAqbIs0qxhJRHcU9wI4358E=;
        b=CIqBPoqQFD9ZIofVdcctrZo0NJ/xeXIYJx/pG9Bf8+aUr5Z+bQMcaaMO/Yxs7SvDBY
         owrZc6rCSRYECvS75BpwOR21aePwsj2dHx7fyMn2hQATNsAuPTPVLmm/jSut4v98Bd7g
         +BGBBP/f9FsJGK+FiWWj9BoYSJpo6FmMH54ZAoOPP5xiLvh+N/AKu/rvcFbEJTyBnHNK
         c4oeMCim4bnWziyHKiMTP4IYoftUo44tCvttYuEYCzrZxmXaICr6n/Xi/VteeAArVBcS
         Ygs+wJwGxcPdSgFLDsUQZ9+mM0c7iNbe96EHKyRI5TmAUkzeQmeegoPLwMhb4CDk36wG
         kPSQ==
X-Gm-Message-State: AJIora8fzCQrk33lFU/1MBXPo+faUJ3V+9ikqVDuByfKpLoRRK7E1lKi
        HhIR4f5sub2R0JS8C3n/MRBi/g==
X-Google-Smtp-Source: AGRyM1vXb+lAKa3a12GtkthhfA4R8Yn7YU0ba2/ue2KUfpCm0R7dPGik1fSM9nymwNvDSjjdrtoP8A==
X-Received: by 2002:a17:902:cccf:b0:168:c4c3:e8ca with SMTP id z15-20020a170902cccf00b00168c4c3e8camr48217740ple.40.1657095724545;
        Wed, 06 Jul 2022 01:22:04 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:22:04 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>
Subject: [PATCH v2 3/6] media: mediatek: vcodec: decoder: Skip alignment for default resolution
Date:   Wed,  6 Jul 2022 16:21:35 +0800
Message-Id: <20220706082138.2668163-4-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
References: <20220706082138.2668163-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default resolution of 64x64 is already aligned, according to the
call to v4l_bound_align_image() in mtk_vcodec_dec_set_default_params().

Drop the redundant v4l_bound_align_image() call. This also removes one
usage of ctx->max_{width,height}.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
index fcb4b8131c49..4a64877bcd8f 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
@@ -180,13 +180,6 @@ void mtk_vcodec_dec_set_default_params(struct mtk_vcodec_ctx *ctx)
 	ctx->max_width = MTK_VDEC_MAX_W;
 	ctx->max_height = MTK_VDEC_MAX_H;
 
-	v4l_bound_align_image(&q_data->coded_width,
-				MTK_VDEC_MIN_W,
-				ctx->max_width, 4,
-				&q_data->coded_height,
-				MTK_VDEC_MIN_H,
-				ctx->max_height, 5, 6);
-
 	q_data->sizeimage[0] = q_data->coded_width * q_data->coded_height;
 	q_data->bytesperline[0] = q_data->coded_width;
 	q_data->sizeimage[1] = q_data->sizeimage[0] / 2;
-- 
2.37.0.rc0.161.g10f37bed90-goog

