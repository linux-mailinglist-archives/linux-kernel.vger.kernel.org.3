Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55AE447A2C7
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 23:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236882AbhLSWkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 17:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236858AbhLSWkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 17:40:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0E3C061574;
        Sun, 19 Dec 2021 14:40:05 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id l25so7775675qkl.5;
        Sun, 19 Dec 2021 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G47PgUXxClqnLBALjPrDawXxxJ3JotIIVYOm6gyc1rw=;
        b=KyvzdgLLGkfq7k+L6ro/24JCb3lgAX5BInSxo8GYpZcv8WkPWHNpcG2AQlcJCAchQ9
         rGUHubGP+EqroO3o5oGGE+UJ5lML/k1fA9qWWjZv73KuPs2hGTLZp/QKDljvnWEdTDl3
         Xbb6v+zOmzf0pHFUUWAXNWh9BnA/p8w/k+G6OCtmGAI0IHm9GKXA6iRf12rAXM1ttVPt
         aq0LtJwt32vn+VBDkqjis+xgYxmsAyfEPB4auzoTzx/usZmRPTprldVttMSu3t9af3qX
         T9hteDteNowxOF65DjfeeuyteQ541eK3Brk/1+2kE3obQCijZTI+3QFZNtQldzS6nntw
         Xl/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G47PgUXxClqnLBALjPrDawXxxJ3JotIIVYOm6gyc1rw=;
        b=59ai1UCccZvU3260jtf5dP4PsTd/WFrf6qT+ClJ+4PEqV0Efs4QhDNsliPzKtjKeVv
         YUU9yGBGX0Khlf7x+C4RlQTLtIQxsEVy9k23f/rpEkv2cbe0tl+Q088c2kz2CQ27zs9L
         AfkhqaA/qqzXBXdHLVd9Yl+7lsrEFZx963Oxdqs2PFFrzafL1HTAIwZFP3TgHzQ/CsCy
         D9w6dOPWKINd/NGplb7S7rfT+fgOlqJdyW7YeKgs6N+Ytp42jEDDNj48gn6OozERbAbb
         6xwfGKeZg7wy+9HSvophb89F6u3jyL97GMbZokpkLvbzDp0ss7XxAmROseJXZp8YUlMo
         VQJA==
X-Gm-Message-State: AOAM530/Vby11mod9YC8vFX6yD2S39Uw2zPmBcTqjjCxITOIPPcbaful
        Gs2KFdL7bNdBMay2ZxMqPgg=
X-Google-Smtp-Source: ABdhPJyrIjZ7CoqtM2oRbwBLvyf9twPC+0fQvRe+sHWjk3thbkNnN7FjNGR0wfMr5u983bHYgvalPQ==
X-Received: by 2002:a05:620a:4710:: with SMTP id bs16mr8192178qkb.551.1639953605116;
        Sun, 19 Dec 2021 14:40:05 -0800 (PST)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id q7sm4591880qkl.72.2021.12.19.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 14:40:04 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v10 04/14] iio: afe: rescale: expose scale processing function
Date:   Sun, 19 Dec 2021 17:39:43 -0500
Message-Id: <20211219223953.16074-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211219223953.16074-1-liambeguin@gmail.com>
References: <20211219223953.16074-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

In preparation for the addition of kunit tests, expose the logic
responsible for combining channel scales.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
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

