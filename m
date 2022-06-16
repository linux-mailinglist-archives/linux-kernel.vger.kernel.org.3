Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7454EB0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378616AbiFPUZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378566AbiFPUZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:25:29 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEB25B8BC;
        Thu, 16 Jun 2022 13:25:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n10so4853270ejk.5;
        Thu, 16 Jun 2022 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S51F3Je5QDB420YRCT+3HINCDkvBOXZdT2bwWLedeKE=;
        b=BBO69XMOO3d5o5uHjrczeLA5BMwcMouFDIOARWkmT7GrhDj6Rh6l5caepWk2XyUIgc
         8Gn6BFxCb/irQ78FHD46MDFyUe++lQlzDybuxYEKQruT4YzuMgS1/e1DVP7usIvj7Q9X
         Ewj9G4WoKZNd0dvus4bQrhzYuebUrtVeyoGgpil8lVAyK7q1B+lzU0yXZOfLwflgtFFN
         sW/TsuU5WcdYSz2jwALtvwoXQHEYjZufP3cwKXuQx5I5lUdTG07sSwrnEKNsClJM5x2E
         XiY/uI/N0i8RQL7O/XkrKQa4DQicNwX95RPUS0nizP/gJn0YtQsFdS/AhuTcb3pg+zoy
         luug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S51F3Je5QDB420YRCT+3HINCDkvBOXZdT2bwWLedeKE=;
        b=jXeE9Kr2eLvd3at1rjym2+MEpAmcDSB/irZDph983U/ad2FsozVEwsF0jo6zaCL/0q
         RNKvLSizjGeb3t8/Yj7JSp7Dr4LeN/1RXoUAdfbJSMkSRdinb3Vbge2W4rYVpwS6uqWn
         tRUDtoVZzHxQmka1Zm3X5d3GFIz4NaIum+2PMNRAzTp5SMVsisemi/vpyJwyN5oPH3q8
         xOHSLvupXy7FhUKAJs0rtRglqwhL27A465egv7BOGqmeyBGfJu7TmQIVeOhFVEXqZ2HG
         Z9RVeJsQQWWD9YRm6HxfyTy94nFyNNoAK2npiQDY3ltJdJkhCDYK+RLaLXlDNWAQLXKG
         ydzg==
X-Gm-Message-State: AJIora+3fGIxp1fYInzx85ldlue7mt9EJLVPLkLfwe56NC4XOBR57KbR
        yeK51wjcI35ZfXXIxsFkD7w=
X-Google-Smtp-Source: AGRyM1sDaGC+6BR752Es4zGOOLY2CRsRtcQIh1wgtcW8aG69QcftAAgu5n+sP0gTrl7CxcEdIodS2Q==
X-Received: by 2002:a17:907:8b87:b0:715:e127:b64d with SMTP id tb7-20020a1709078b8700b00715e127b64dmr5996239ejc.481.1655411126677;
        Thu, 16 Jun 2022 13:25:26 -0700 (PDT)
Received: from kista.localdomain (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id 21-20020a170906329500b006fe8a4ec62fsm1186760ejw.4.2022.06.16.13.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:25:26 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, nicolas.dufresne@collabora.com,
        gregkh@linuxfoundation.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH v2 7/7] media: hantro: sunxi: Enable 10-bit decoding
Date:   Thu, 16 Jun 2022 22:25:13 +0200
Message-Id: <20220616202513.351039-8-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220616202513.351039-1-jernej.skrabec@gmail.com>
References: <20220616202513.351039-1-jernej.skrabec@gmail.com>
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
2.36.1

