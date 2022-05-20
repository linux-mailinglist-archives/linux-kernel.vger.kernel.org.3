Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A684152E2AF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 04:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344871AbiETCsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 22:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344843AbiETCsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 22:48:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90348149153;
        Thu, 19 May 2022 19:48:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 137so6629025pgb.5;
        Thu, 19 May 2022 19:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Aut+o9rfvWHqOONG13fN766+RLiN2j4Zswig8lgnh6A=;
        b=mt0Bm0NWZ0PpZvy9PgPLDCWxkjLZm2wOIINCQ4B9h8CUWDJOQ9YHY9Gaqwkbvq1cX9
         Bo5zEjnm5PDzWqJnC5hyRCBkLlmdgIx63wzMCajrcNHyynpk/R5xblBQDA4RQRlQ6EPG
         0bi9uhu1NJt18engeMoepVNDUhPQLtuBKsQskN28wsoWcJ/HGW0DkVO1E6uIYrmPYotI
         5plUpuP3az6oDYE/c33NDpUafbTuwbt2/35I5jqIQOWQ2gYCQmdmkO5vfyPwOaO4MhtP
         EKD33M4M/3Vsgw3VH0fbOgSrMVmAe9fds9+vNcpL9JYrCeyAYYn3Y7RwRCYce29YQDUq
         bJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Aut+o9rfvWHqOONG13fN766+RLiN2j4Zswig8lgnh6A=;
        b=FlShGaTkeEHGF1wf0FG6Uu9v5lJzKmASDvQFIt1ICLMsQp9ZGscN1vN15u7kIr6t1Z
         THNmpPwSeWRYLDR6E0UBJy51lqn7wuJym2cQyQ8nqp+p5QQxhT7iEVjcf8X9dScCXlas
         vkE3drXI5Cu2IpUjt2ke3m3Jt7OSDel+iUbFt2puSxuF+7+AMQX5wxd7YtB3TS7+wupr
         b7XTKt7qvfeR73NFqCcFgHQBSO6ER/pCdaZw7jxEGVXREWhxVDKZ8Ul12do/yGjHB6zK
         jtGrEEZm3bsPPBGVX1mT39lDCbHl7YUYV/ark/DKmf77ogi4xZ/ZVzEiNS24YUmF4gBT
         nUtQ==
X-Gm-Message-State: AOAM530pPUXWlQyygA5P0wwLFW6B8StD9k4A9kztRy1lLlnyUz/WG4DX
        +z8EzgrQrnNK1DlZK46kLj8=
X-Google-Smtp-Source: ABdhPJx8c2HrsRQqil6H1HOfljjgTuyEBakwTDuLtQ2jkRB/emqOZN3P6TiGmK4xyMLPBlnru9siLw==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr7716956pfv.36.1653014886022;
        Thu, 19 May 2022 19:48:06 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a629709000000b0050df474e4d2sm379406pfe.218.2022.05.19.19.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 19:48:05 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v3 4/5] media: Add HEXTILE compressed format
Date:   Fri, 20 May 2022 10:47:43 +0800
Message-Id: <20220520024744.25655-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220520024744.25655-1-milkfafa@gmail.com>
References: <20220520024744.25655-1-milkfafa@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HEXTILE compressed format. This format is defined in Remote Framebuffer
Protocol (RFC 6143) and is used by Encoding Compression Engine present on
Nuvoton NPCM SoCs.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 7 +++++++
 drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
 include/uapi/linux/videodev2.h                            | 1 +
 3 files changed, 9 insertions(+)

diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
index cabfa34b7db5..bad2b9a2f16e 100644
--- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
+++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
@@ -239,6 +239,13 @@ please make a proposal on the linux-media mailing list.
 	It remains an opaque intermediate format and the MDP hardware must be
 	used to convert ``V4L2_PIX_FMT_MT21C`` to ``V4L2_PIX_FMT_NV12M``,
 	``V4L2_PIX_FMT_YUV420M`` or ``V4L2_PIX_FMT_YVU420``.
+    * .. _V4L2-PIX-FMT-HEXTILE:
+
+      - ``V4L2_PIX_FMT_HEXTILE``
+      - 'HXTL'
+      - Compressed format used by Nuvoton NPCM video driver. This format is
+        defined in Remote Framebuffer Protocol (RFC 6143, chapter 7.7.4 Hextile
+        Encoding).
 .. raw:: latex
 
     \normalsize
diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
index 96e307fe3aab..9365519d65bb 100644
--- a/drivers/media/v4l2-core/v4l2-ioctl.c
+++ b/drivers/media/v4l2-core/v4l2-ioctl.c
@@ -1441,6 +1441,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
 		case V4L2_PIX_FMT_SE401:	descr = "GSPCA SE401"; break;
 		case V4L2_PIX_FMT_S5C_UYVY_JPG:	descr = "S5C73MX interleaved UYVY/JPEG"; break;
 		case V4L2_PIX_FMT_MT21C:	descr = "Mediatek Compressed Format"; break;
+		case V4L2_PIX_FMT_HEXTILE:	descr = "Hextile Compressed Format"; break;
 		default:
 			if (fmt->description[0])
 				return;
diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 3768a0a80830..1c7af015b43b 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -746,6 +746,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel Planar Greyscale 10-bit and Depth 16-bit */
 #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4-bit packed depth confidence information */
 #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-bit dithered RGB */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile compression */
 
 /* 10bit raw bayer packed, 32 bytes for every 25 pixels, last LSB 6 bits unused */
 #define V4L2_PIX_FMT_IPU3_SBGGR10	v4l2_fourcc('i', 'p', '3', 'b') /* IPU3 packed 10-bit BGGR bayer */
-- 
2.17.1

