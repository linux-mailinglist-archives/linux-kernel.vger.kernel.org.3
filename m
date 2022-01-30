Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B664A3765
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 17:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355490AbiA3QLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 11:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355473AbiA3QLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 11:11:18 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55474C061714;
        Sun, 30 Jan 2022 08:11:18 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id g145so9948088qke.3;
        Sun, 30 Jan 2022 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMTOaLQ7dmVrFU4YApnbu06iYLDeLwergecv++KC6K8=;
        b=Dopl9rfJiV65Q6TXLcgKC3FViQVgw/FUeRM6nf8lIuvnrlKhBD5NiIAuMH+/UaGDdn
         N7YwKWvCkwDrc9HYiTY5iHfy9Gz4VSpDHaJy+DTb/RILM1YQ/ePJ4EEpi5qnqs319jkH
         TFGbplTFjqNSQv7si1AQMrcie6/3W2sFDxl0WbeWcxR4cMlqKjajzLtJXDLGmzrWV+lf
         p3zcXzNBKfuCqQrBfvjIryaVupPMdehkszNjFqg6TgXZb1+0pr2G+OYlAZKX84ackqQ/
         ixLLRCIcKfPfnA+55e4JBvsr7xkps7Y52RsUEXw+6G9bqU7N5Jt65uTxfOX1h5pWuXDk
         3diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMTOaLQ7dmVrFU4YApnbu06iYLDeLwergecv++KC6K8=;
        b=lNMusE0xdPAV7/t6iTRRECK7tqWeUaZjoIk1EYC9uH5dDA68wIPbJXoMX7ls+IYaMA
         M+T9ZGjeRsRPQxcGQBX8HpC48M+IG743MBPBp358yLZsgIUHdddPMfqxbkbO8TmbmNZy
         MdPZNohwWnRrBwFvSsybRNZUtj2Ua88FOZ03jlmIiU3HFWk50vF4I81MQYJIfWvdlc8j
         5hlHS/aDDXqIbRUeQ5/vjXiV2j0so4IEuRDRQjs6QR6rMScvvTq/Fc9223KHSiv8c+q0
         64lw8aAFttKTuDGKuJvBFco1HWeInhu4IsWjNfhXjDgATYFuSSMRiH+aO4aSjHrmX83o
         iq2A==
X-Gm-Message-State: AOAM530D6y9Gy90X+IHdMcbfZmWoSZZB8MDZgZuOW32K3Cn3KcVbwkl3
        BnYPKbX0lDWNG0buTfNuCXc=
X-Google-Smtp-Source: ABdhPJwFGVOC5gOSb37QQoxK9f1YuVknm1dwZD18q9Glh3wSDeJ39kh6NiW25jCluLXmGHiPqz6x8Q==
X-Received: by 2002:a37:c4c:: with SMTP id 73mr10968454qkm.537.1643559077431;
        Sun, 30 Jan 2022 08:11:17 -0800 (PST)
Received: from shaak.. (modemcable055.92-163-184.mc.videotron.ca. [184.163.92.55])
        by smtp.gmail.com with ESMTPSA id v73sm6906148qkb.51.2022.01.30.08.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 08:11:16 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        andy.shevchenko@gmail.com, lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v13 01/11] iio: afe: rescale: expose scale processing function
Date:   Sun, 30 Jan 2022 11:10:51 -0500
Message-Id: <20220130161101.1067691-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.35.1.4.g5d01301f2b86
In-Reply-To: <20220130161101.1067691-1-liambeguin@gmail.com>
References: <20220130161101.1067691-1-liambeguin@gmail.com>
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

