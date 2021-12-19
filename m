Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 499F147A2C4
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236909AbhLSWkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhLSWkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:04 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2081C061574;
        Sun, 19 Dec 2021 14:40:04 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id d21so7796495qkl.3;
        Sun, 19 Dec 2021 14:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r/J/yS3v9lRITtz+ahTNaRdQPYHDQc6+wiw6txSGUmE=;
        b=bWAzs/SKJabcDIXij35O9Lg2G/aS95sDffBgMMhZ5vCefkyW7SOkkb/qVCekOu/SfA
         m/rXblPkk9An4CeGi1B7+sSvube4/sfjEPINQPaKhGKmgJeAbHu4Pmg0wyfXIa+oLmgP
         MBfbmnQxggFkYFScTzDMnsA5TXRkb6LyfVxPQYYO9O4E1pm5x2U8XoBMTwApuewERXof
         ifUfIXchz+65qgt3Qx1VIz8ZNk4ppSIagFRpPOmwKJSWGLhH6OmjTmN5gznFrISF/MiM
         txGfXjKBgrSXYgjf34bT+jxRC19TPg/2yvGBmV85HBEb2OJwsxJ1fx4bMwMi8imszgBJ
         HOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r/J/yS3v9lRITtz+ahTNaRdQPYHDQc6+wiw6txSGUmE=;
        b=B7cdodDyStz+hNFVFjm9UFYs0+A49yASVwbbe9eGHmI43qwgnnNGBye1D/38/jnv+f
         a/kG/NNJRgRUn8Zgs2Qxu1h0gDa2emMz0K8sjdoTISzWUGhuhCC9ULRHf035jUI4M6EC
         GT0BvO4WTyuvjG+ec4uyEWyMINYF4y/kWjfvZLPBfAZoAwemgVFgapp8YSkZ+gVZWUDF
         l4twZ6uLaT5vKmmoSA7zhLf+x96Xh98rqUP5juO38ni+udie3VPPCfiTq7k3KnWiwPFL
         UMVV5cjpkIDGk9pt+uRJAaqPc7ZswHbDQDed9VwB64yyKcgGCIKIrI6OEVCeLwDJm6/v
         XBLQ==
X-Gm-Message-State: AOAM5303qIhpMAcAqf9Z3KcWxlqtdsy6ebDzWJb+zjSyntpZvV+qAUEL
        c2Ykikuel9DjZjEjIRl7AQY=
X-Google-Smtp-Source: ABdhPJz98I6ArtQMYLDn872AHmsZ/iL4WQnaFugt8FOgSMHgpxg4cwMgO406eaFafJ/4NtF0hbzZ+w==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr7959882qka.768.1639953603850;
        Sun, 19 Dec 2021 14:40:03 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:03 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 03/14] iio: inkern: make a best effort on offset calculation
Date:   Sun, 19 Dec 2021 17:39:42 -0500
Message-Id: <20211219223953.16074-4-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

iio_convert_raw_to_processed_unlocked() assumes the offset is an
integer. Make a best effort to get a valid offset value for fractional
cases without breaking implicit truncations.

Fixes: 48e44ce0f881 ("iio:inkern: Add function to read the processed value")
Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/inkern.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index dbe13fad3cbb..aff6d2d3447c 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -595,13 +595,35 @@ EXPORT_SYMBOL_GPL(iio_read_channel_average_raw);
 static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	int raw, int *processed, unsigned int scale)
 {
-	int scale_type, scale_val, scale_val2, offset;
+	int scale_type, scale_val, scale_val2;
+	int offset_type, offset_val, offset_val2;
 	s64 raw64 = raw;
-	int ret;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
-	if (ret >= 0)
-		raw64 += offset;
+	offset_type = iio_channel_read(chan, &offset_val, &offset_val2,
+				       IIO_CHAN_INFO_OFFSET);
+	if (offset_type >= 0) {
+		switch (offset_type) {
+		case IIO_VAL_INT:
+			break;
+		case IIO_VAL_INT_PLUS_MICRO:
+		case IIO_VAL_INT_PLUS_NANO:
+			/*
+			 * Both IIO_VAL_INT_PLUS_MICRO and IIO_VAL_INT_PLUS_NANO
+			 * implicitely truncate the offset to it's integer form.
+			 */
+			break;
+		case IIO_VAL_FRACTIONAL:
+			offset_val /= offset_val2;
+			break;
+		case IIO_VAL_FRACTIONAL_LOG2:
+			offset_val /= (1 << offset_val2);
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		raw64 += offset_val;
+	}
 
 	scale_type = iio_channel_read(chan, &scale_val, &scale_val2,
 					IIO_CHAN_INFO_SCALE);
-- 
2.34.0

