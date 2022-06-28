Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8D155D410
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243064AbiF1Dag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241808AbiF1DaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:30:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E56F10B3;
        Mon, 27 Jun 2022 20:30:07 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id s206so1926715pgs.3;
        Mon, 27 Jun 2022 20:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W3bZk2RgbGLiBzgiA1wbLysvDZIqXxx7I9gmSpoK2zk=;
        b=MDWvp+TxcAxrHdw2YpeOw9EiPGyZbOwhZHSo24Z/oE92Uua2OgT00dC0uX3PnYg+RE
         +Z3Yot4IElLd4yoFharoL1N0JQiDZmRPGvEWKuFUG9jPOfpjJcdtOKh/OyE2mLXM6dtg
         VVw3t+D6IGI3PVIYP6B62ODKads1b25l1jcg4OMJXIW0JgK41BSid2ivuFUl4nGKbvTZ
         qHkMPel/r6exw2ZVbM6VpjaY6BSHNgodO3LxvyxHpSxRksyuF8caQihyz0PkvIlZujaq
         tCOYfedlPkGcuMQTqNahyU9RV2ESBDHswNAoPhWaFW6hRQgxyNUyJ8CtIMULsx98c0bo
         lyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W3bZk2RgbGLiBzgiA1wbLysvDZIqXxx7I9gmSpoK2zk=;
        b=ZEhkbRj3vCjBKO5rm4nxHOmiyUTobRAOFYBP41F1SFdQNDuf8KTAicded60dmOcR4J
         OxaPCIkGpqp0IxilKx6Y9GMkOzvYH3ocdTmQVINANJdNyF7E0S8LTtLse9iC+D6c7baG
         TJp83wUg4noLnruJXocIwEX20ycXNciqUelPsb2/x6BC8dBgyEBFOnttxGE7ISNM1lD9
         iikPLauYwVHw3BP9r0wRQ6/KELK0U1coMbR90b+LSiqzzF6hSlJ4CK/Gs95pxwN7oYyw
         VM963c6TBj1Ty+DxfsTTfrmgndunIuuiSpvLStMJKnQf0aAhdc1EqmfzPLZ69TcKYKdH
         iefQ==
X-Gm-Message-State: AJIora9/MUx5Inv+ksMMZoars+hxLEOe64rqONpesrFDvUK9zA41R5Oj
        0dIbLCgpVxQrV1dXmx3msAM=
X-Google-Smtp-Source: AGRyM1tpSIi4cBAh4zH9J3H3Eoas6lqsynjOBMQw65BS1WTC88a4vjTTST4l/Nok1705u7T88gThJg==
X-Received: by 2002:a63:33ce:0:b0:40c:5487:6e6d with SMTP id z197-20020a6333ce000000b0040c54876e6dmr15984393pgz.135.1656387006937;
        Mon, 27 Jun 2022 20:30:06 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id c26-20020a62e81a000000b0050dc762816dsm8091160pfi.71.2022.06.27.20.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 20:30:06 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [RESEND PATCH v4 4/5] media: Add HEXTILE compressed format
Date:   Tue, 28 Jun 2022 11:29:44 +0800
Message-Id: <20220628032945.15410-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628032945.15410-1-milkfafa@gmail.com>
References: <20220628032945.15410-1-milkfafa@gmail.com>
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
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
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

