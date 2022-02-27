Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B374C5C68
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 15:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiB0OvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 09:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiB0OvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 09:51:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE75D5E9;
        Sun, 27 Feb 2022 06:50:32 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f8so1925265edf.10;
        Sun, 27 Feb 2022 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGi7V8f/8PCG3FpLnmowzHOV4cFkD8Gq/ByZ6la1IPg=;
        b=hzPWe+jX/7+e9H8NqkS/+4rfUfunau4bHR/8ykqfml8K0ruAFohKPfLS+fwopvLj85
         89MBU3SIKprZGEMAv6O8Hr1cnUSMn4DK3/iSXFRwU50ZaQDnvxHk/TaEZ69uYk326rLN
         6tP6sTj2B80ssDDltzpJyVYnM/gtzCSLIiRDNlLrRTVAD4HtJYANiP4ZqAs9IxrffFUK
         Byhh8YX9H9CbUXoNTbGwM5bX0JyfX4pSNFSmItJonpRM8Fpb79O8KkkJv0VAqkeUtiL4
         zGldlts3dFqOCSuDpeA6H8t9TC5YJdg40yiSQ8ogR4Imkf3B1u554POVWa9Fmm7EzC4B
         dmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGi7V8f/8PCG3FpLnmowzHOV4cFkD8Gq/ByZ6la1IPg=;
        b=jRW7LpOnpyZ0ZxmpLIyWqpNP+urLS/vO0lynQ+rtztp1nrlVZA38KrME56wj7D/8ew
         bjwyxMunWWtr8WUf+fqNQHoW60BdXu8/e6WEAgB8IA8kd4FH0/XoQ/c/j/WcWLB+Hstb
         uhLLMrW4EQv3Krf5mGools4lYLxETyhHwNNrnfOxFr0rZsrtbQKTWd1QdeFlRuj35ced
         HIxgq8GtVTQ5uT5ZjxnO3B7avmxJANNG2uqKbJwlQl2ABbQw4vyyg8RLSr8ZHaCXNiZK
         heTAovb+rbFO419V2TEgiLi6ZXwxblHyT77Q3Ru1R3sX/RCDpOW/cs2WYmkopo5WPsid
         0DHg==
X-Gm-Message-State: AOAM531thZAY2V98lsWFGF2yRE3SqigBbySQ48biuTt3wZbifP8oFeYb
        lfrKvnqR4YTI1MJWu4JgmIE=
X-Google-Smtp-Source: ABdhPJyr6HTKorqbTa0EK/G4pBDfhQMVAgAD+XKw3QGDBOcDvTWfJd57g+f/QPZy6xOyUFjJd48viw==
X-Received: by 2002:a05:6402:4415:b0:410:d28b:1e14 with SMTP id y21-20020a056402441500b00410d28b1e14mr15428586eda.211.1645973431450;
        Sun, 27 Feb 2022 06:50:31 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id a1-20020a1709063e8100b006ce06ed8aa7sm3501887ejj.142.2022.02.27.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 06:50:31 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, nicolas@ndufresne.ca, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, wens@csie.org, samuel@sholland.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [RFC PATCH 2/8] media: Add P010 format
Date:   Sun, 27 Feb 2022 15:49:20 +0100
Message-Id: <20220227144926.3006585-3-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
References: <20220227144926.3006585-1-jernej.skrabec@gmail.com>
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

Add P010 format, which is commonly used for 10-bit videos.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/media/v4l2-core/v4l2-common.c | 2 ++
 drivers/media/v4l2-core/v4l2-ioctl.c  | 1 +
 include/uapi/linux/videodev2.h        | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-core/v4l2-common.c
index 1db0020e08c0..4ede36546e9c 100644
--- a/drivers/media/v4l2-core/v4l2-common.c
+++ b/drivers/media/v4l2-core/v4l2-common.c
@@ -275,6 +275,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 format)
 		{ .format = V4L2_PIX_FMT_YUV422P, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 3, .bpp = { 1, 1, 1, 0 }, .hdiv = 2, .vdiv = 1 },
 		{ .format = V4L2_PIX_FMT_GREY,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 1, .bpp = { 1, 0, 0, 0 }, .hdiv = 1, .vdiv = 1 },
 
+		{ .format = V4L2_PIX_FMT_P010,    .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
+
 		/* Tiled YUV formats */
 		{ .format = V4L2_PIX_FMT_NV12_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 1, 2, 0, 0 }, .hdiv = 2, .vdiv = 2 },
 		{ .format = V4L2_PIX_FMT_P010_4L4, .pixel_enc = V4L2_PIXEL_ENC_YUV, .mem_planes = 1, .comp_planes = 2, .bpp = { 2, 4, 0, 0 }, .hdiv = 2, .vdiv = 2 },
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 048f326c57b9..a8d999e23e5b 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1295,6 +1295,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 	case V4L2_PIX_FMT_M420:		descr = "YUV 4:2:0 (M420)"; break;
 	case V4L2_PIX_FMT_NV12:		descr = "Y/CbCr 4:2:0"; break;
 	case V4L2_PIX_FMT_NV21:		descr = "Y/CrCb 4:2:0"; break;
+	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
 	case V4L2_PIX_FMT_NV16:		descr = "Y/CbCr 4:2:2"; break;
 	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
 	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 772dbadd1a24..211bc11a48cb 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -597,6 +597,7 @@ struct v4l2_pix_format {
 /* two planes -- one Y, one Cr + Cb interleaved  */
 #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/CbCr 4:2:0  */
 #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/CrCb 4:2:0  */
+#define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/CbCr 4:2:0 10-bit */
 #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/CbCr 4:2:2  */
 #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/CrCb 4:2:2  */
 #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/CbCr 4:4:4  */
-- 
2.35.1

