Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9364AAD0F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 00:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381364AbiBEXdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 18:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBEXdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 18:33:52 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C471C061348;
        Sat,  5 Feb 2022 15:33:51 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id k13so19757946lfg.9;
        Sat, 05 Feb 2022 15:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTGxMUD+Y/e2SIuHcf/n5N/bPbvSPfdhfosfyFHnjSM=;
        b=AQgPUOEAAjsob5q1TYDcbdFYKdASPIsg0LD2bQ9Ww+lq1e8NGppyzWXIZc6oGuO5si
         5OlTFy1CH3JL0RFpk8mg1tC/FwmkL3AbT4MKU8dMfWOIS5hEcoNwPtobYKy7hdYHYnXf
         K/R/Oj1bTYZf9WXAfwUt46sbtEjtDCBdlX69AFQzDz31jya8LcyMcvvJ3B4iS1t92cYG
         lzbRVQltOoBMM8QlAOi+ZgEQE3/B7UhM250O5Px6vc1PkXuuxWXEt9DG8qKAVJvU3end
         wCrtoOFSKS7gzJAhibl1wtLa7tkgmvjZ79bQtA9xabREftpEZTD+K3L1cvGfjsGSDonq
         YzAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hTGxMUD+Y/e2SIuHcf/n5N/bPbvSPfdhfosfyFHnjSM=;
        b=XB3paKotgFhIZ/36d9C/Vx5/kJtiIwmHt9DdkhNRKzKuhYvFBIJpk14ht4V6HzmbEQ
         0S4WiovGtwC9ZXgqoJRJ8PQ8rw7/U8arSTKaEW91R8Fo7NAkb/qD4iS+CB0PnJQEthfe
         l1Qk4vqcfAMhrjbi357BK7EX4UUwZv/g+jtp6tvQG1xjRzXuBZX1VZfDsM2vi6QiYIts
         vFuw3l3GQqhlR5oANoLv6ECRNEVrOHfQ0DxQTsNVo1omOZLJ8wX1lc6kwl3+uN2cviXb
         fnIv6/HEsXyl/0k/7zXwX9w5AMIp4Zsyl+xaXduDZCUV/gszJkUqUkus3DagY2J0PewT
         bVeg==
X-Gm-Message-State: AOAM530dklD3B8HDhFbF5GyiluC6w34MEk4lT6IMfrFNuVToYZnwrDHe
        UrA+LpcuCT89Audw6BSHv10=
X-Google-Smtp-Source: ABdhPJwUsYwrar5ZAoigpEbg5JFCfrjJ8wLITtvOjwBLyZsNPKwjEXajuiSrFa/SoMQ6m7N/SK3Q4Q==
X-Received: by 2002:ac2:4c09:: with SMTP id t9mr3715612lfq.406.1644104029408;
        Sat, 05 Feb 2022 15:33:49 -0800 (PST)
Received: from localhost (93-80-64-103.broadband.corbina.ru. [93.80.64.103])
        by smtp.gmail.com with ESMTPSA id m12sm888400lfj.90.2022.02.05.15.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 15:33:48 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Mikhail Rudenko <mike.rudenko@gmail.com>,
        linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] media: sun6i-csi: fix colorspace in sun6i_video_try_fmt()
Date:   Sun,  6 Feb 2022 02:33:31 +0300
Message-Id: <20220205233332.67316-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.35.1
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

With gstreamer 1.19.3 all attempts to capture video in YUV formats on
our Allwinner H3-based custom board with an ov5640 sensor result in
pipeline crashes with the following messages:

	Device '/dev/video0' does not support 2:0:0:0 colorimetry
	Additional debug info:
	Device wants 2:0:0:0 colorimetry

Fix this by setting the correct colorspace in sun6i_video_try_fmt().

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---

Actually there is a second issue with sun6i_video_try_fmt(): reported
bytesperline is wrong for planar YUV formats, but I believe it will be
fixed by [1].

[1] https://lore.kernel.org/linux-media/20220205185429.2278860-40-paul.kocialkowski@bootlin.com/

 drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
index 607a8d39fbe2..682c26536034 100644
--- a/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
+++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_video.c
@@ -368,7 +368,11 @@ static int sun6i_video_try_fmt(struct sun6i_video *video,
 	if (pixfmt->field == V4L2_FIELD_ANY)
 		pixfmt->field = V4L2_FIELD_NONE;

-	pixfmt->colorspace = V4L2_COLORSPACE_RAW;
+	if (pixfmt->pixelformat == V4L2_PIX_FMT_JPEG)
+		pixfmt->colorspace = V4L2_COLORSPACE_JPEG;
+	else
+		pixfmt->colorspace = V4L2_COLORSPACE_SRGB;
+
 	pixfmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
 	pixfmt->quantization = V4L2_QUANTIZATION_DEFAULT;
 	pixfmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
--
2.35.1
