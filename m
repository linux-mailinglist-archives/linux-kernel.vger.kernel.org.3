Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5376D47A2DB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236966AbhLSWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhLSWkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:11 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D15EC06173F;
        Sun, 19 Dec 2021 14:40:11 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id kk22so7850382qvb.0;
        Sun, 19 Dec 2021 14:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ORHem+cjpQo4DN5Jr/pC6A3WhQVJUKYdKPjLXZMj8I=;
        b=qF3wg8tziqev4/NjipGLGSXln0YyYqLQ/uDjYRIFQnKy0VDpfeJczaA+Z3Sa/3rjBh
         sqrRwe3vbqZBuHYoP7S6hMH5FSud1HRo4/zTrImTX61XAxwTUGU/0fuNlS6dun6aZGRi
         8YEFlwpu8R+CYdH+ypeIPE+9vRRsRykwDEcBGi7b95yyhLzcXI7OKMqZtkECmO7S7jPP
         6fGAsTTFsPRUNMTP2gmaYzgktSBTPIPGYJq4apM1GMB0RJxnw8nXSa7PRkLrDzUEhIEu
         q/bD5hDa9p9coXeO2TqT2cY//JShElAA3jORdEUoX0pQFxj51lLXClLqzeAIj2Qait12
         WLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ORHem+cjpQo4DN5Jr/pC6A3WhQVJUKYdKPjLXZMj8I=;
        b=KcQkgvB3hLqDeuX1bzAQRhFfZPCq99UOQeqyvFlud++7uc3nKdh1zhHcAd4dnP5mOx
         yHxKPUQ9ICIfsqE0pAlOuWqqLSA8AXm8ZnGSH/PL7k0lvE+ZyZlQUbwIOtqxl/9Zlh45
         3Die3i+TyxyxsUmq0W+99KnyACpFUrEko3Itqf32mkAVib3Uyt9W/BUnru/YOBxgJJTz
         7leyvMj1fJNatTsKpxjEZXlFwe9swreb175cHFfTx81BaeNkY4nn8YfaNPfMuqyL0p6r
         u6PC254zLgpGZ4MiWeCFte7KYE0oC7vOZW6EnSqOMLtNu1j8iEJOoM6jWfgX3kJamM2f
         29OQ==
X-Gm-Message-State: AOAM531S3uxjkDE7M/BcUK8F/YXUeDGOaLvs+a6n7Ec5HvZffmOCTDTD
        1i8dZABabwtNHcchBmd+ksU=
X-Google-Smtp-Source: ABdhPJywyWBMyutWRO7OA9+3fRkvOZByUHJNFpsbrBmRrQJAxq7Sq6AChlKHq3713v9rWujHGMjLQw==
X-Received: by 2002:a05:6214:4019:: with SMTP id kd25mr10656766qvb.59.1639953610651;
        Sun, 19 Dec 2021 14:40:10 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:10 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 09/14] iio: afe: rescale: reduce risk of integer overflow
Date:   Sun, 19 Dec 2021 17:39:48 -0500
Message-Id: <20211219223953.16074-10-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation on
a 64-bit integer. Since the rescaling is only performed on *val, reuse
the IIO_VAL_FRACTIONAL_LOG2 case.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 66306477aeab..4ab19a730a57 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -23,21 +23,31 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 			  int *val, int *val2)
 {
 	s64 tmp;
+	int _val, _val2;
 	s32 rem, rem2;
 	u32 mult;
 	u32 neg;
 
 	switch (scale_type) {
-	case IIO_VAL_FRACTIONAL:
-		*val *= rescale->numerator;
-		*val2 *= rescale->denominator;
-		return scale_type;
 	case IIO_VAL_INT:
 		*val *= rescale->numerator;
 		if (rescale->denominator == 1)
 			return scale_type;
 		*val2 = rescale->denominator;
 		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL:
+		/*
+		 * When the product of both scales doesn't overflow, avoid
+		 * potential accuracy loss (for in kernel consumers) by
+		 * keeping a fractional representation.
+		 */
+		if (!check_mul_overflow(*val, rescale->numerator, &_val) &&
+		    !check_mul_overflow(*val2, rescale->denominator, &_val2)) {
+			*val = _val;
+			*val2 = _val2;
+			return IIO_VAL_FRACTIONAL;
+		}
+		fallthrough;
 	case IIO_VAL_FRACTIONAL_LOG2:
 		tmp = (s64)*val * 1000000000LL;
 		tmp = div_s64(tmp, rescale->denominator);
@@ -49,7 +59,10 @@ int rescale_process_scale(struct rescale *rescale, int scale_type,
 		if (!rem)
 			return scale_type;
 
-		tmp = 1 << *val2;
+		if (scale_type == IIO_VAL_FRACTIONAL)
+			tmp = *val2;
+		else
+			tmp = 1 << *val2;
 
 		rem2 = *val % (int)tmp;
 		*val = *val / (int)tmp;
-- 
2.34.0

