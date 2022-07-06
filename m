Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490B6568101
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 10:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiGFIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiGFIWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 04:22:00 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D48723BD0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 01:22:00 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id i190so842353pge.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 01:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JwjM4aG2gB9+TdDB98m3vhzsdflSXb4D+/c8i8pKJx0=;
        b=N7dOOvucEDYkMqhp2ctayX7Z/y+eURq7LldgGQRj+MugzxvffpIXvCfvAIn6/ybvl6
         DJKXqzhMUySX352b33U36W/ZPbS30UgaBToh+RKEoeiqlEKezAxBJp/2fLE4yHXp51E9
         miuVayU/xVrUZhKUdARWa6siIeedl8mdvDZlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JwjM4aG2gB9+TdDB98m3vhzsdflSXb4D+/c8i8pKJx0=;
        b=s4xMzlrjCOGAobsIdXDwtg7XpHVEtshV2e09s3cekEvwbIMYP3B8YdbEdPyiZWzxIC
         dwWmoln22BmqFiRYy4msPg/kEb7NPE8/QhEZW9UZQaEbjYQjD3lZAAwMnrCQbvLohAm1
         5+Q2lTYIraoloQzBO5o6RQZ4g721mWldJzjk09TNxDvSmdkasH/JSKQaf2aQvLrayerS
         UDyKiK3D61ePoCVRnm6iADl5xZJAL5Zix80aJOh2Iw4JspnY842Ns/m8LVNQosv+HnFv
         CJdoHEdp80uMSGf6CVApsraQpB8SnQnxH8kPC+46eYj/6n//xTcneb51NwoAwBhPzyJG
         /IMQ==
X-Gm-Message-State: AJIora9cUGLmv7AvNcPOqwFtp4HNKp+Bmofbwkn2RwYRUV6kr2ngukGP
        E1gxx8WIvIM31d/qAfT47ZP1uA==
X-Google-Smtp-Source: AGRyM1vdyg/m1tsExpeqCPFt1V28vkyPJIpq4iabapLc2qReT+Wur6sP+aTdbO3uuzEOUpoqJb9qYw==
X-Received: by 2002:a05:6a00:174f:b0:525:518e:71d6 with SMTP id j15-20020a056a00174f00b00525518e71d6mr45951288pfc.68.1657095719919;
        Wed, 06 Jul 2022 01:21:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:74a3:a7a4:af57:d7f])
        by smtp.gmail.com with ESMTPSA id rm1-20020a17090b3ec100b001ed27d132c1sm20767040pjb.2.2022.07.06.01.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 01:21:59 -0700 (PDT)
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
Subject: [PATCH v2 1/6] media: mediatek: vcodec: decoder: Const-ify stepwise_fhd
Date:   Wed,  6 Jul 2022 16:21:33 +0800
Message-Id: <20220706082138.2668163-2-wenst@chromium.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220706082138.2668163-1-wenst@chromium.org>
References: <20220706082138.2668163-1-wenst@chromium.org>
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

stepwise_fhd is the reference framesize variable, and should not be
altered. Make it constant.

Fixes: ("76250b48de79 media: mediatek: vcodec: Getting supported decoder format types")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 .../media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
index 16d55785d84b..f1c0276c9026 100644
--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_stateless.c
@@ -119,7 +119,7 @@ static struct mtk_video_fmt default_cap_format;
 static unsigned int num_formats;
 static unsigned int num_framesizes;
 
-static struct v4l2_frmsize_stepwise stepwise_fhd = {
+static const struct v4l2_frmsize_stepwise stepwise_fhd = {
 	.min_width = MTK_VDEC_MIN_W,
 	.max_width = MTK_VDEC_MAX_W,
 	.step_width = 16,
-- 
2.37.0.rc0.161.g10f37bed90-goog

