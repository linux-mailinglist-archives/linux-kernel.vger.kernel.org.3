Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1295A1EF3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 04:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244894AbiHZCmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 22:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiHZCmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 22:42:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB2CCE17;
        Thu, 25 Aug 2022 19:42:08 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 72so302202pfx.9;
        Thu, 25 Aug 2022 19:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc;
        bh=W3bZk2RgbGLiBzgiA1wbLysvDZIqXxx7I9gmSpoK2zk=;
        b=dUPy+OEMcRa1nyZzucaRpkc94cHtmV26a9/+L1NGCBxVtIyzeEwD81Hg8WRhzqxzpH
         0Q6ZBkJg8B4dhEDWle2klsWKpiRoIheiYyBH+B6Bs1nml2AP1B/uILgOUHwnhV/eu3dh
         0aY6NUwh+pm/sXcObbXtQwHBpZrTdKL27p7b3Kj9LwYCobGxQGvv5sbI5Pp1PIPCoe1V
         ZCXVPam/MH76wNTQ04rQXXoDiNZo8zhLXnCQSQdZLj92YhmoIzZqkf/RrMYDZGMUnbcZ
         KhIq+/JTYJQUVjyum9X4RvGsZRpJACdMqx9V5MZVMNuuUJvKJ+165r/nblypZ+CsJ8at
         FMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc;
        bh=W3bZk2RgbGLiBzgiA1wbLysvDZIqXxx7I9gmSpoK2zk=;
        b=el/U/OJ7FfrJttDuG8X0fTbr6EakB6ifqEr6UDgpC0B9Q3q5R7ZmXHf2HBP+ELwcp4
         XBZs2lNMdV/gzfjK3sna4AFq0SmQ4z8cipok1CO/oLrP+eRtuqlPEngmDMBD+PigV7v2
         y6Jm383PxSixFDfrv/VkUCk16bVG9rDsu17txuVbYr1YwtAvkrDFE19c0NivD6Eqp5HM
         AdrLu1MN4UEDdlH940kZhqGrc+tmiGA+57Ib8W/pNtwG3X275eIRU4VrZ5DmP4fQOx1w
         xlHQdhKdiRAvzXwnJsmbZTrqddWYV7ZvnkBVWCNlbhFDoEKfZF2FPep42Bqh7QJut12c
         p3xg==
X-Gm-Message-State: ACgBeo0WgaewvM0VMKZPQp30VWtbTq4dMuOeBMzIlxLG/lYtpvTcxc1x
        gUu6+ZS+TCR8fdlNrX+rM2I=
X-Google-Smtp-Source: AA6agR5raHMZzhyhkrBfIGelgu0xZt/PqvlibfpUTNKH28h7qTR2t0oGOs8kXxJ7eTR7legie5WJ/g==
X-Received: by 2002:a63:e409:0:b0:429:a62a:3b3 with SMTP id a9-20020a63e409000000b00429a62a03b3mr1552728pgi.459.1661481727533;
        Thu, 25 Aug 2022 19:42:07 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s34-20020a17090a69a500b001f021cdd73dsm444473pjj.10.2022.08.25.19.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 19:42:07 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com, Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v5 4/5] media: Add HEXTILE compressed format
Date:   Fri, 26 Aug 2022 10:41:23 +0800
Message-Id: <20220826024124.22747-5-milkfafa@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220826024124.22747-1-milkfafa@gmail.com>
References: <20220826024124.22747-1-milkfafa@gmail.com>
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

