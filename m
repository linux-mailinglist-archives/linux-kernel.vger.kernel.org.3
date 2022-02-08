Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523234ACEAC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 03:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiBHCJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 21:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345414AbiBHCEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 21:04:50 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32D9C061A73;
        Mon,  7 Feb 2022 18:04:49 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l14so1357579qtp.7;
        Mon, 07 Feb 2022 18:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMTOaLQ7dmVrFU4YApnbu06iYLDeLwergecv++KC6K8=;
        b=mkDTU733eZDe3IQJBWlpy6D5azVFgSki1MdO1iVCNFFMhN8SGvlP5ph63WRire/zic
         xU2WRYGO8jQaBRGMniWFW1b0gQIM7Pzqws9PWBiiyO3BSjy27WHBA3USSLxteKiwjUi1
         DwcIDArU+phX9TjUmrPEvtEuoldrBlO/Xxy+YasqXqJMrmiJjd7KFRVLnwkN4YuLLaEx
         28AsKPMv2QECBGXCoYV9cpwumTdFNiBEMliUCiTcNhv2ws2FHG+lIuVGmkvXDsLkDDcQ
         /dnRZ5ieirGi317Rdd0hw75UsTdEtO96k+ZjEAxSRbihxYqXGNO07rv2A4nQrwV0ioPk
         eSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMTOaLQ7dmVrFU4YApnbu06iYLDeLwergecv++KC6K8=;
        b=hkjcyMaA6mXaQjjVouq2WFutdrr4xngW2NNyyYpwN9KJgM5WCzVjyu3IskvuK2AwG6
         y4nxUiOVI8PQ22dsVaKlXYqcpIhqpd5tqN6xbbTLjFK0RVnib47jdA4rg/XpTWgxAEji
         Gk1pNqrwXqLiXo1AsOVqOJVOob6qoiFFyECB2SnWqKZ/pwk+7pYBfEaZuZ2iLTLQMl9f
         83yJklFWrszzVfbspLLJYR4vurrSuNCJkwRBT2gJFoUS8EuYtg7YIafU7+AICTi8xKwC
         3yL0WydrAj96aW/HUIYCl2V7j4j8hws0XCxTrq7kXf7WWCMLkHuObmgVnjOin+JKQXv/
         U2mg==
X-Gm-Message-State: AOAM533waDDVF8kG4G86r2Q4e/h73+zdB89ANjByC4DLZu/8hVv8CYEN
        575ob1mpWkK8+v8rtIvEdZ0=
X-Google-Smtp-Source: ABdhPJxnnIed2IhUMFZZ8n+WceRSE84hbhrwKQtJWRv+FezkpmCuNWX7Uzr+mjHX974OE5wBh0IaZQ==
X-Received: by 2002:a05:622a:4d:: with SMTP id y13mr1682304qtw.629.1644285889048;
        Mon, 07 Feb 2022 18:04:49 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id u9sm1416055qko.130.2022.02.07.18.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 18:04:48 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v14 01/11] iio: afe: rescale: expose scale processing function
Date:   Mon,  7 Feb 2022 21:04:31 -0500
Message-Id: <20220208020441.3081162-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220208020441.3081162-1-liambeguin@gmail.com>
References: <20220208020441.3081162-1-liambeguin@gmail.com>
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

In preparation for the addition of kunit tests, expose the logic
responsible for combining channel scales.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c   | 65 ++++++++++++++-------------------
 include/linux/iio/afe/rescale.h | 32 ++++++++++++++++
 2 files changed, 60 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/iio/afe/rescale.h

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 69710c481376..65832dd09249 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -15,32 +15,43 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
+#include <linux/iio/afe/rescale.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
 
-struct rescale;
-
-struct rescale_cfg {
-	enum iio_chan_type type;
-	int (*props)(struct device *dev, struct rescale *rescale);
-};
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2)
+{
+	s64 tmp;
 
-struct rescale {
-	const struct rescale_cfg *cfg;
-	struct iio_channel *source;
-	struct iio_chan_spec chan;
-	struct iio_chan_spec_ext_info *ext_info;
-	bool chan_processed;
-	s32 numerator;
-	s32 denominator;
-};
+	switch (scale_type) {
+	case IIO_VAL_FRACTIONAL:
+		*val *= rescale->numerator;
+		*val2 *= rescale->denominator;
+		return scale_type;
+	case IIO_VAL_INT:
+		*val *= rescale->numerator;
+		if (rescale->denominator == 1)
+			return scale_type;
+		*val2 = rescale->denominator;
+		return IIO_VAL_FRACTIONAL;
+	case IIO_VAL_FRACTIONAL_LOG2:
+		tmp = (s64)*val * 1000000000LL;
+		tmp = div_s64(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		tmp = div_s64(tmp, 1000000000LL);
+		*val = tmp;
+		return scale_type;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
 
 static int rescale_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	s64 tmp;
 	int ret;
 
 	switch (mask) {
@@ -66,27 +77,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		} else {
 			ret = iio_read_channel_scale(rescale->source, val, val2);
 		}
-		switch (ret) {
-		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
-			return ret;
-		case IIO_VAL_INT:
-			*val *= rescale->numerator;
-			if (rescale->denominator == 1)
-				return ret;
-			*val2 = rescale->denominator;
-			return IIO_VAL_FRACTIONAL;
-		case IIO_VAL_FRACTIONAL_LOG2:
-			tmp = (s64)*val * 1000000000LL;
-			tmp = div_s64(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			tmp = div_s64(tmp, 1000000000LL);
-			*val = tmp;
-			return ret;
-		default:
-			return -EOPNOTSUPP;
-		}
+		return rescale_process_scale(rescale, ret, val, val2);
 	default:
 		return -EINVAL;
 	}
diff --git a/include/linux/iio/afe/rescale.h b/include/linux/iio/afe/rescale.h
new file mode 100644
index 000000000000..8a2eb34af327
--- /dev/null
+++ b/include/linux/iio/afe/rescale.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2018 Axentia Technologies AB
+ */
+
+#ifndef __IIO_RESCALE_H__
+#define __IIO_RESCALE_H__
+
+#include <linux/types.h>
+#include <linux/iio/iio.h>
+
+struct device;
+struct rescale;
+
+struct rescale_cfg {
+	enum iio_chan_type type;
+	int (*props)(struct device *dev, struct rescale *rescale);
+};
+
+struct rescale {
+	const struct rescale_cfg *cfg;
+	struct iio_channel *source;
+	struct iio_chan_spec chan;
+	struct iio_chan_spec_ext_info *ext_info;
+	bool chan_processed;
+	s32 numerator;
+	s32 denominator;
+};
+
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2);
+#endif /* __IIO_RESCALE_H__ */
-- 
2.35.1.4.g5d01301f2b86

