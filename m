Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7BE5246F3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351022AbiELH2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350977AbiELH1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:27:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB613C095;
        Thu, 12 May 2022 00:27:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id cq17-20020a17090af99100b001dc0386cd8fso4106916pjb.5;
        Thu, 12 May 2022 00:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RK7P/G14GNSW6jrJ4jgbop4KxUD85r0Sbd2J3CZlqLU=;
        b=n0urGepyXkIlytzvgQbpxoeR7OTPesI6aTPJlkc1SRT4V7EFD6bmI4VNHvB7G/f6WP
         mIUN4YyHTUSfbj1LfNM0RgrUE/XJEYOa9qjlx4+8KdW607ChbjI2WzVjHcDlwM4B7o8l
         dZH1XORjjKLskrHsS2IOZHSYm+2e+xjYdmpcK3xdcYV+o5q9+8rX110IdCV8WESLLPXZ
         8NBKB+HpAcG8AVxDDVqQ6rRIKLdPXrmF+rk79MNFj1UH6ZRswArcECxche89z0uEh+y5
         2G4QTATbfoq9pkNKk7B4Rcuzq7IldGezhMoXawS4Fm29701B87CHlDXrCMWnmaXDryfd
         29Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RK7P/G14GNSW6jrJ4jgbop4KxUD85r0Sbd2J3CZlqLU=;
        b=OfevmjVuSayYkVycqzmZuGbDK07QBkgNX/gluOJYDmpMKKqbSgf8iRZLPN5wDq4e59
         wbkXSsAVRbo+eQctiWzsgm3/VH33UGspGZwzJNdHrcnKu7G6lA6WzH77gKzRkojn01yS
         o2odeBysKkaudbnmms+rZqweUCrPhF3SHqVMhbvOzDnAII1N7X8IVGegwMqB9XPQFBh0
         t+4b3MyfMvuumdFcbMqPrsFn0d12b91G7Oydn7bum5rC7j6seniZ4WPRDxyoD74OThAc
         PeFbfGrJwR3oKYZlszwHEImNDclCNIppQo3TvsbvGz0kr4NUZfElGYdsFEWF0vNfAiGY
         PqeA==
X-Gm-Message-State: AOAM531gHepe4wk3x1e3N05+mxe2MgqafINnbuVmDaPdwlZK7GBgeA6G
        te4CjC0vq1Vvve/K2rBSwKs=
X-Google-Smtp-Source: ABdhPJzQIUQvr2MhSwIcDBA4+9eHkXPEPxoE+OjmFiWCMlb/eVF6SwH0qEJCYXTllPC6Pw1hlH6zvQ==
X-Received: by 2002:a17:902:c3cb:b0:15c:e5d2:227e with SMTP id j11-20020a170902c3cb00b0015ce5d2227emr28378826plj.13.1652340465672;
        Thu, 12 May 2022 00:27:45 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id z9-20020aa79e49000000b0050dc762813csm3082779pfq.22.2022.05.12.00.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 00:27:45 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
X-Google-Original-From: Marvin Lin <kflin@nuvoton.com>
To:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
Subject: [PATCH v1 4/5] media: Add HEXTILE compressed format
Date:   Thu, 12 May 2022 15:27:21 +0800
Message-Id: <20220512072722.25005-5-kflin@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220512072722.25005-1-kflin@nuvoton.com>
References: <20220512072722.25005-1-kflin@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HEXTILE compressed format. This format is defined in Remote
Framebuffer Protocol (RFC 6143) and is used by VNC features.

Signed-off-by: Marvin Lin <kflin@nuvoton.com>
---
 drivers/media/v4l2-core/v4l2-ioctl.c | 1 +
 include/uapi/linux/videodev2.h       | 1 +
 2 files changed, 2 insertions(+)

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
index 3768a0a80830..e0e69f71d700 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -710,6 +710,7 @@ struct v4l2_pix_format {
 #define V4L2_PIX_FMT_FWHT     v4l2_fourcc('F', 'W', 'H', 'T') /* Fast Walsh Hadamard Transform (vicodec) */
 #define V4L2_PIX_FMT_FWHT_STATELESS     v4l2_fourcc('S', 'F', 'W', 'H') /* Stateless FWHT (vicodec) */
 #define V4L2_PIX_FMT_H264_SLICE v4l2_fourcc('S', '2', '6', '4') /* H264 parsed slices */
+#define V4L2_PIX_FMT_HEXTILE  v4l2_fourcc('H', 'X', 'T', 'L') /* Hextile */
 
 /*  Vendor-specific formats   */
 #define V4L2_PIX_FMT_CPIA1    v4l2_fourcc('C', 'P', 'I', 'A') /* cpia1 YUV */
-- 
2.17.1

