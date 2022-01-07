Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65D364874CA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346495AbiAGJfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346488AbiAGJfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:35:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60933C061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 01:35:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 59-20020a17090a09c100b001b34a13745eso4083613pjo.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 01:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMnNxOVPdXzMfPknulPEnJPfMLKNc3bQyvDsss2ILoA=;
        b=SQOfsqu/dTsrW4Rh30S050hhBuAno4qMY8keBxE7AeP2blOAkVtr8166QXlMCquZbL
         EXE7PCbtLHdRGuJlnaekl8QvBtSA+T2fhNfa3f7AIgIiaUnRst4YARLjvaLh3XXln5dz
         FXS+1C8FFj6VMVZlufqphj5b4ErQeSQ/QrmiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMnNxOVPdXzMfPknulPEnJPfMLKNc3bQyvDsss2ILoA=;
        b=rvPepjgV5WFiVBWmz80X/g11GuD6iAVr6W32b82fWtWq1mQuLSgYfLH7Tktf8a26Mc
         pkvXBcvEBWJcJacFje2CPT+Bnuy8nhgxvaDv0D9rgvhgVhtq+vxmM1kPj9Lc8j9mXtmT
         /jij0dXC26+N20+sMUWZXAD3eJ7XsWbTfRJMiLC+n5t0WrXg/gNDMbuBlN6czzr1DnGY
         5E+nyW9Duf23USbvBtKFxaUG7Str3lrR45YWn7lYaOcXXDeGS+zctiAJXqkhC/NB8Zxn
         JQkgLfzTg2qYGLFZDoDPo0pa7z6eyMm7Wd3KktKGs/1VVCpApa22IzjYykMLP8GrqNQ8
         3j6A==
X-Gm-Message-State: AOAM532wc896Cq/Djt90LNLWk0BXgUGieMV8ftS4mheXZr2kt+lHCfZt
        ixmPcgkBbwapsSuqUaleZDRSIA==
X-Google-Smtp-Source: ABdhPJz2DHgRtXL8o0aUKFZg+E1A4xv2/O6qvFArtKHRvQeL73J/2Bshk583jXCoFWRB9NYatEWTcw==
X-Received: by 2002:a17:902:9a8b:b0:149:be04:40ab with SMTP id w11-20020a1709029a8b00b00149be0440abmr21318112plp.159.1641548114894;
        Fri, 07 Jan 2022 01:35:14 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8f6b:ee:64d8:ae81])
        by smtp.gmail.com with ESMTPSA id j17sm5269192pfu.77.2022.01.07.01.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 01:35:14 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFT v2 4/8] media: hantro: jpeg: Add JFIF APP0 segment to JPEG encoder output
Date:   Fri,  7 Jan 2022 17:34:51 +0800
Message-Id: <20220107093455.73766-5-wenst@chromium.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107093455.73766-1-wenst@chromium.org>
References: <20220107093455.73766-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the V4L2_PIX_FMT_JPEG format doesn't specify any requirements for
the APP0 or APP1 segments, it would be nice if the output is JFIF
compliant. While some programs can read JPEG streams that aren't, some
guess work is involved.

Add the standard JFIF APP0 segment to the JPEG header, so that the JPEG
encoder output is JFIF compliant.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/staging/media/hantro/hantro_jpeg.c | 21 +++++++++++++--------
 drivers/staging/media/hantro/hantro_jpeg.h |  2 +-
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/media/hantro/hantro_jpeg.c b/drivers/staging/media/hantro/hantro_jpeg.c
index df62fbdff7c9..7d4018bd6876 100644
--- a/drivers/staging/media/hantro/hantro_jpeg.c
+++ b/drivers/staging/media/hantro/hantro_jpeg.c
@@ -12,15 +12,15 @@
 #include "hantro_jpeg.h"
 #include "hantro.h"
 
-#define LUMA_QUANT_OFF		7
-#define CHROMA_QUANT_OFF	72
-#define HEIGHT_OFF		141
-#define WIDTH_OFF		143
+#define LUMA_QUANT_OFF		25
+#define CHROMA_QUANT_OFF	90
+#define HEIGHT_OFF		159
+#define WIDTH_OFF		161
 
-#define HUFF_LUMA_DC_OFF	160
-#define HUFF_LUMA_AC_OFF	193
-#define HUFF_CHROMA_DC_OFF	376
-#define HUFF_CHROMA_AC_OFF	409
+#define HUFF_LUMA_DC_OFF	178
+#define HUFF_LUMA_AC_OFF	211
+#define HUFF_CHROMA_DC_OFF	394
+#define HUFF_CHROMA_AC_OFF	427
 
 /* Default tables from JPEG ITU-T.81
  * (ISO/IEC 10918-1) Annex K, tables K.1 and K.2
@@ -144,6 +144,11 @@ static const unsigned char hantro_jpeg_header[JPEG_HEADER_SIZE] = {
 	/* SOI */
 	0xff, 0xd8,
 
+	/* JFIF-APP0 */
+	0xff, 0xe0, 0x00, 0x10, 0x4a, 0x46, 0x49, 0x46,
+	0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x01,
+	0x00, 0x00,
+
 	/* DQT */
 	0xff, 0xdb, 0x00, 0x84,
 
diff --git a/drivers/staging/media/hantro/hantro_jpeg.h b/drivers/staging/media/hantro/hantro_jpeg.h
index 035ab25b803f..f33c492134e4 100644
--- a/drivers/staging/media/hantro/hantro_jpeg.h
+++ b/drivers/staging/media/hantro/hantro_jpeg.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
 
-#define JPEG_HEADER_SIZE	601
+#define JPEG_HEADER_SIZE	619
 #define JPEG_QUANT_SIZE		64
 
 struct hantro_jpeg_ctx {
-- 
2.34.1.575.g55b058a8bb-goog

