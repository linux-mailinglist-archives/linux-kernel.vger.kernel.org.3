Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41733488619
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 21:54:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbiAHUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 15:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbiAHUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 15:53:39 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B079EC061401;
        Sat,  8 Jan 2022 12:53:38 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id b85so10075523qkc.1;
        Sat, 08 Jan 2022 12:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e/ker9BlooBL9CPJxenjCRhQehzmhQtAZVQ9PuNp+0Q=;
        b=UQtKps1+Z2lJvU2UWoQvngzI/nQOKOwiKCvrhLdKh5hKoLIA4Y19walKXjUs4mDiU2
         9c81bFO7RaGHLWIztX/I0uWjXh7ec4ge8hb7KKZZ6tUjh0wTkMpnoK2WSla2MxMZrkLm
         wLT5mRxxpc92CcerDbgvQzZbohD35zq82NbdHhmdezOLlsWFkbsmP1HFd1QFxLxey8uU
         489oGk+12wlKC4+enKugG/feBx8Vcv586BHOvBN1r+UNEfNHqd5bFboWNzGL+NZNpGLj
         +/H4qnArXb5jbpdLPAKXLDgY2QS/GxzWoPaLeK6gHGOIRCEE6q9DOAB/O1CzQe1HEilc
         xJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e/ker9BlooBL9CPJxenjCRhQehzmhQtAZVQ9PuNp+0Q=;
        b=Hk50AWOLrz2wLLcThXJLazaoA+t2uu8S3UUe7JL1QDW1jKSYdjjBFUOFUmVmIY2zD0
         I/3rI4CoP3lIbt0H/2F3WbhX67uJfE6pzA3wSqqR2/mJKkaCRtFWEtim50NxLqZxhu2l
         wBwmgpYpfDQc2lmxNdxXcSVxzLpjNQ/s9QDczJw+kbU2dCas/t4DNZLqCmLFLROLHlgi
         jwQ2/CVccwXChI7wwuoPyijoxEIgAWTAIMmGWnZo4D95bWhl4wVpo4PAY8nEf8C7ABaQ
         nipY70hW6ksX7mylONLMs6OIGtPHMTAzx2nGx6ikyb5BJ2rpKYcrOM/WbOOFjgPjsRVm
         CdXw==
X-Gm-Message-State: AOAM530PJ4H1sTxQpuLlN/B5FVsI4tyDVlGXLkA18IWPpeWpz3EzIQuP
        RLYUS3EorP1PVgu4gk5gDAg=
X-Google-Smtp-Source: ABdhPJyVXFmDL3ciTJKREasamp6t5falDecl7daJFhOUtgS7P8m3QftNMAaurZWhvl6z2hdUciSxcg==
X-Received: by 2002:a05:620a:4708:: with SMTP id bs8mr21101333qkb.246.1641675217884;
        Sat, 08 Jan 2022 12:53:37 -0800 (PST)
Received: from shaak.. (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id p16sm1650377qtx.19.2022.01.08.12.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 12:53:37 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v12 06/16] iio: afe: rescale: expose scale processing function
Date:   Sat,  8 Jan 2022 15:53:09 -0500
Message-Id: <20220108205319.2046348-7-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20220108205319.2046348-1-liambeguin@gmail.com>
References: <20220108205319.2046348-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 000000000000..698092b6cbb1
--- /dev/null
+++ b/include/linux/iio/afe/rescale.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Liam Beguin <liambeguin@gmail.com>
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
2.34.0

