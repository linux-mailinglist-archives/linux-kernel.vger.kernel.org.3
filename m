Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD3E5691D1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 20:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbiGFS3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 14:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiGFS3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 14:29:25 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC3DDAE;
        Wed,  6 Jul 2022 11:29:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so16901937wrv.10;
        Wed, 06 Jul 2022 11:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ipO2NkMUMMvxvzZn2ltri7y+IHfLy0+fza0bQjlk34=;
        b=lkGkOKrNCzdbqRpsx09FoK7d/OanN8Jr9CgkeEcU8CM5aoHdA6Pvhu74nWGVd50Und
         hIfGjNZqe3qCQ25Qgt27NJgQXnGTSa47OFddWoEBSdwb7s5pbP9so+VzOBfHwLBUvSOj
         K/WRLDMeQgAacHo3Xfy0WPdCPHUQRS04LN/j912/BOdpLVJCrfcvu+8YP5coRQzOLy/b
         VWZz78ujP3oOQFeHy0E9BJ3czWex1efyuk4h7eh/+O6QBaR5iuB2s1uvdml7ikROky0s
         ue8NB3jiiaMQCMMi043vRnOB0zZAHPQIw1cAAnhzvMecpLGjaoVrG+LsKk7TWSH3LQ8B
         SKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ipO2NkMUMMvxvzZn2ltri7y+IHfLy0+fza0bQjlk34=;
        b=M1eWF6N5wYcAkLWk82a+li7M9N17laiaEHR7zdB0fraeRdCtLGob5s6tWdYjxWdw6P
         MyX0ZylVe2yxEb/ipLyot57pfH3t136I4spqeaZNr/icmavoEFtsFEyChwivCcg8lSce
         2siaFoDVgDOFWPTah1s2DF8jxFLiNr9MPmW68bqddQL3/A7HLDxGqVNl80vfFCZrkW7Q
         TNP8vNUtNl8lrvsnY/Vtcop3r5h4zGE20j3OyQ2A/mb4K7fNwk039wNKdfLz12LJCEA8
         qvLYk0fw1taCA3zbjth2YBqegNaU2/uQrQd0ZJcFeKskfCzxyY5CjzPsmgbtRYuETwKS
         2NAA==
X-Gm-Message-State: AJIora9lAh/ZxFvaFzFzzPVXJqzABoT8GpUr9HjGI2v/p3Q3cfTFfQTJ
        XnQbga9KuX/oHRXX3Ii6iLEUXoeJgjirZA==
X-Google-Smtp-Source: AGRyM1ux1QIOhjvHQjtoROyzGjFt6VIyFfhw6EWam9o2tDucO6Mufz2phavnv2wM30ROS89HUqHXWg==
X-Received: by 2002:a5d:64ad:0:b0:21b:b412:a34b with SMTP id m13-20020a5d64ad000000b0021bb412a34bmr39603551wrp.161.1657132160349;
        Wed, 06 Jul 2022 11:29:20 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r15-20020a0560001b8f00b0021d74906683sm5142406wru.28.2022.07.06.11.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 11:29:20 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v3 7/7] media: hantro: sunxi: Enable 10-bit decoding
Date:   Wed,  6 Jul 2022 20:29:01 +0200
Message-Id: <20220706182901.78949-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220706182901.78949-1-jernej.skrabec@gmail.com>
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that infrastructure for 10-bit decoding exists, enable it for
Allwinner H6.

Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/staging/media/hantro/sunxi_vpu_hw.c | 27 +++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/staging/media/hantro/sunxi_vpu_hw.c b/drivers/staging/media/hantro/sunxi_vpu_hw.c
index fbeac81e59e1..02ce8b064a8f 100644
--- a/drivers/staging/media/hantro/sunxi_vpu_hw.c
+++ b/drivers/staging/media/hantro/sunxi_vpu_hw.c
@@ -23,12 +23,39 @@ static const struct hantro_fmt sunxi_vpu_postproc_fmts[] = {
 			.step_height = 32,
 		},
 	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010,
+		.codec_mode = HANTRO_MODE_NONE,
+		.postprocessed = true,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = 32,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = 32,
+		},
+	},
 };
 
 static const struct hantro_fmt sunxi_vpu_dec_fmts[] = {
 	{
 		.fourcc = V4L2_PIX_FMT_NV12_4L4,
 		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
+		.frmsize = {
+			.min_width = FMT_MIN_WIDTH,
+			.max_width = FMT_UHD_WIDTH,
+			.step_width = 32,
+			.min_height = FMT_MIN_HEIGHT,
+			.max_height = FMT_UHD_HEIGHT,
+			.step_height = 32,
+		},
+	},
+	{
+		.fourcc = V4L2_PIX_FMT_P010_4L4,
+		.codec_mode = HANTRO_MODE_NONE,
+		.match_depth = true,
 		.frmsize = {
 			.min_width = FMT_MIN_WIDTH,
 			.max_width = FMT_UHD_WIDTH,
-- 
2.37.0

