Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D25525A32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 05:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376840AbiEMDg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 23:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376847AbiEMDf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 23:35:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79929B7DE;
        Thu, 12 May 2022 20:35:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a191so6360592pge.2;
        Thu, 12 May 2022 20:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8zMHqi3yqKJENYLoeBcGjkD8v2fKK4XGuEyyjPVzsgk=;
        b=SqGraAyRoFb8lpXHJZOf7XAML98FWMltAyaZ/qIRk7slqYq1RghgCR4k9/6Yq5lc72
         MuWHDdamdAzuj2jr13aq8ir1TlcJLK5m7KOFafKPbKLR5JxFon6Bk/E/dNdozK1iSA8S
         /Rf9+1O/bqMUe+O+lkwBKYfm9rLtXll9CCiUSsUJn9qYhMbmqpJDLo7fkZX4hdIEFFWB
         SxjocHvE+egJ8vHi6n3NjYFZmZYuJ7jaNOI+y3jygdVTxNaGxWawcDJAk1C8762NGtkT
         7J0lL9unk9JZceBcUysjtSFrO54FSgeKO7nXuLHg9hmXGZF9UHU6aOExI8EnCfQs/uxK
         BWtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8zMHqi3yqKJENYLoeBcGjkD8v2fKK4XGuEyyjPVzsgk=;
        b=fH9W74oGW0snHqPcWzmQNeMsnAvpN68kn7pSbIx6CqXSmE1V33Bw9cAcOTv5QqlLc8
         i1RcEjiwOZ8R6w79AZs7Ut0lxwY81CGmGme+q2fEdSmBO5ipMdcgwkvVcP8A/wNTw4jX
         2mbOf4oOflUjD7gfv+OzOg8N2KxNtkZTEG0AcHoh5n2d7xhZjB6R9NZaaBAWOhGYwfNQ
         FpZ5XzZOBvDUSY77IOLUqIBlYmVhCbKkm5VBVaiLYdcEOPnYYNsgiTRLI4kwYW1B/RO8
         RulM1PHm02yLpc0AbZe1mgEWkMOsDtGY4lQXL+TR4kSqLKhdqsJ8ReKZYYGy/EUIqXY2
         4HHw==
X-Gm-Message-State: AOAM533aclm3S/crUgr9eVr6i4HrVff8V8QKdvhHApA75x+P0uhWIc67
        vkMTnSno+S/BkQwSEEghe2M=
X-Google-Smtp-Source: ABdhPJw6hfHnmaJiyVv9euLErcRUjbaSSV1uXQGHDMl6Yo6HT1YoHPBIVo1o8gYdh5mNtADNBzG6sw==
X-Received: by 2002:a05:6a00:2481:b0:50d:4839:5896 with SMTP id c1-20020a056a00248100b0050d48395896mr2685313pfv.37.1652412956923;
        Thu, 12 May 2022 20:35:56 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id b7-20020a1709027e0700b0015e8d4eb1c7sm685133plm.17.2022.05.12.20.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 20:35:50 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v2 4/5] media: Add HEXTILE compressed format
Date:   Fri, 13 May 2022 11:34:49 +0800
Message-Id: <20220513033450.7038-5-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513033450.7038-1-kflin@nuvoton.com>
References: <20220513033450.7038-1-kflin@nuvoton.com>
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

Signed-off-by: Marvin Lin <kflin@nuvoton.com>
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

