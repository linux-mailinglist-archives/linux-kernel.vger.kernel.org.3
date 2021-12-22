Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762E247CBD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 04:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242221AbhLVDrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 22:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242197AbhLVDrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 22:47:00 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD9C061748;
        Tue, 21 Dec 2021 19:47:00 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z9so790013qtj.9;
        Tue, 21 Dec 2021 19:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hscPqaqXpcu6DXMBiBTFfYMJ6fCqMu/wY7BdxG1ViLQ=;
        b=hzfnCEqv7errqekAIlP7SAYOWW2zwRjaQcwXhXM6+yIAITajMYfpqDbnqrmHDG1Dy5
         7+JGi+ugOqYOxya8w7WxIwqOtt3xmTmMEWlkY0fyZbRehFLBdVN9WBkGdnna6+mGUVly
         zbDeZjISXN16/KlWeqSVuG5r322PEwZCAtxg8m0rkN7sGFXNQ9Pw1rK2nJTnixlMFAO/
         KtpApQu/hYPrB/ydCat9dx5JpxlZOUThnb02e3WOFCM4z4xZhN1Zv5Zy+1shvkhPmJM3
         Y5faXUMLuwBrV9Scv7fnJpJPQropPh14nHRfvTzzuTpNsHHpJrLniQ9Y8eDqIlZA4pd2
         d0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hscPqaqXpcu6DXMBiBTFfYMJ6fCqMu/wY7BdxG1ViLQ=;
        b=Fc6JPgrTmvXCYsfdsK/y3zATpPBu5ZXTFrKZFiqNS023ZS4fvNwnZEV6RnXx99gQkc
         LfgdmVddyYGJ+Pe3FiQMbZzx0scrUe4aU1ClqDSEzcq2f7LhXmcgAIvCXHCYS/m/vBhb
         YJQHbr8f/upXP11hDczclA73jQfoPggFywzzafrD7i9i+WwlwLTAGp2nKycFOuVU+ouS
         zYiP7y/h4ZsURhE2hckF6QiJDwX7e2Spki5wveF+tatnLcCeVh8/ug7/mI+yarIKqEtB
         TGd5JW3IFqrLTtN3FVf/4ux6SIQRB6ruohZowGIvXqzKsHCbLvtNbu6kLSUikWvSC7oH
         EyPQ==
X-Gm-Message-State: AOAM533zExAw30wuU5cFwDce4+kMoJWbaQcQAbxsHDnEt+4tED2aVGnt
        fT3sMO/n13w8eQri3dM+oQs=
X-Google-Smtp-Source: ABdhPJwmn1KG+mWlZqSEw4btikmEOatPeQw/JyhnjbYr2V3A+9BxM5EURkJU+F/WyPJhublWa+eaUg==
X-Received: by 2002:ac8:7f88:: with SMTP id z8mr902242qtj.365.1640144819208;
        Tue, 21 Dec 2021 19:46:59 -0800 (PST)
Received: from shaak.xiphos.ca (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id f18sm918944qko.34.2021.12.21.19.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 19:46:58 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v11 04/15] iio: afe: rescale: expose scale processing function
Date:   Tue, 21 Dec 2021 22:46:35 -0500
Message-Id: <20211222034646.222189-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211222034646.222189-1-liambeguin@gmail.com>
References: <20211222034646.222189-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

In preparation for the addition of kunit tests, expose the logic
responsible for combining channel scales.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/iio-rescale.c   | 65 ++++++++++++++-------------------
 include/linux/iio/afe/rescale.h | 30 +++++++++++++++
 2 files changed, 58 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/iio/afe/rescale.h

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..d0669fd8eac5 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -11,35 +11,46 @@
 #include <linux/gcd.h>
 #include <linux/iio/consumer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/afe/rescale.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-struct rescale;
-
-struct rescale_cfg {
-	enum iio_chan_type type;
-	int (*props)(struct device *dev, struct rescale *rescale);
-};
+int rescale_process_scale(struct rescale *rescale, int scale_type,
+			  int *val, int *val2)
+{
+	unsigned long long tmp;
 
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
+		tmp = *val * 1000000000LL;
+		do_div(tmp, rescale->denominator);
+		tmp *= rescale->numerator;
+		do_div(tmp, 1000000000LL);
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
-	unsigned long long tmp;
 	int ret;
 
 	switch (mask) {
@@ -65,27 +76,7 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
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
-			tmp = *val * 1000000000LL;
-			do_div(tmp, rescale->denominator);
-			tmp *= rescale->numerator;
-			do_div(tmp, 1000000000LL);
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
index 000000000000..14d4ee1227c6
--- /dev/null
+++ b/include/linux/iio/afe/rescale.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
+ */
+
+#ifndef __IIO_RESCALE_H__
+#define __IIO_RESCALE_H__
+
+#include <linux/iio/iio.h>
+
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
2.34.0

