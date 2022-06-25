Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA2355A8F5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbiFYKhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiFYKh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C272A40D;
        Sat, 25 Jun 2022 03:37:27 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id j21so8601634lfe.1;
        Sat, 25 Jun 2022 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jUsXE3yzxLd+uhE7uMJm8hyFKvelHgMO2H58Uby0WNA=;
        b=XYpFIAucCcRTIXXYfQ1iJkSLhg89fcAARUZAZ5Zhj4lqBBx91FPOScqks0zNCrnTKN
         rXO032Qii1VZGH3A6HnqGjTXIalG4JGZNJrGUWeE5rwAuQ9dCB9FGieX6evN/+8Q6HvM
         PM7ELnVDQTDh0tkaaZ0ZyGzdrBmCnNznBVHImge97IK+775sgeQd61dsMUTkKm80HhfL
         9t3BIXitPQZmN0GBuiu7kjzIwCEnFj96OCY3NZfHJJsP4PwwfIIZyRgkwK+b1gC5J7+X
         FqLI21OHnd5YscMfZvhadr/VJVrHzvtrvu5mSm5osIRSJAWgc6ofzabGygKGnXhLG8Ra
         /7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jUsXE3yzxLd+uhE7uMJm8hyFKvelHgMO2H58Uby0WNA=;
        b=Gq3zBcSiiEBTCJ0MuNn5iyWol2J89FE9yRzHxWeEbwKdRl8N4yqWZ8DGumePijLeto
         Th3Qvq/a3kddah1nwPNedv4Pja0/JF8uGKSYrKQfSozxhAc6EyRkVhBjLDpYOy749S5g
         anDiA5nYD4ubqlqefDB0LDYgqlo+sqmziV3hvUhUPL+VpXcxWHaXCTX523X1U5h+kDHs
         evxQRPTvmuGqf0oNyPMtBlB5vdKVl8DufTYT5EODp9I1iP6Wkg5aXuCnZCxUSjCT9bwl
         c3mNC0AU63iyKQ9itFXiaaNPIXFBkWrT2zLzHqJ7fhEbj8OP14jh3tZ7og2WceKc4pKv
         t/7g==
X-Gm-Message-State: AJIora+IZktliEWWLZS6TCKUSHLAqqeircfB5T3hyYJTdFxlJD5eCdHb
        7ECFnF5CZKiBW7xD41zMLOU0JlGvSaydDfEj
X-Google-Smtp-Source: AGRyM1vhJNdg6eDWkw+7SlhudVQwj5pj0hzkpbWCKCxHk5XVw7WBTDymvtLTw1QeUoHFsNYVrQhCYw==
X-Received: by 2002:a19:e05e:0:b0:47f:7821:444d with SMTP id g30-20020a19e05e000000b0047f7821444dmr2198898lfj.515.1656153445436;
        Sat, 25 Jun 2022 03:37:25 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:24 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] iio: adc: mcp3911: add support for oversampling ratio
Date:   Sat, 25 Jun 2022 12:38:49 +0200
Message-Id: <20220625103853.2470346-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
References: <20220625103853.2470346-1-marcus.folkesson@gmail.com>
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

The chip supports oversampling ratio, so expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - Make use of osr table
        - Change formatting and typos

 drivers/iio/adc/mcp3911.c | 47 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f4ee0c27c2ab..1469c12ebbb2 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2018 Marcus Folkesson <marcus.folkesson@gmail.com>
  * Copyright (C) 2018 Kent Gustavsson <kent@minoris.se>
  */
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -35,6 +37,7 @@
 #define MCP3911_REG_CONFIG		0x0c
 #define MCP3911_CONFIG_CLKEXT		BIT(1)
 #define MCP3911_CONFIG_VREFEXT		BIT(2)
+#define MCP3911_CONFIG_OSR		GENMASK(13, 11)
 
 #define MCP3911_REG_OFFCAL_CH0		0x0e
 #define MCP3911_REG_GAINCAL_CH0		0x11
@@ -53,6 +56,8 @@
 
 #define MCP3911_NUM_CHANNELS		2
 
+static const int mcp3911_osr_table[] = {32, 64, 128, 256, 512, 1024, 2048, 4096};
+
 struct mcp3911 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -108,6 +113,22 @@ static int mcp3911_update(struct mcp3911 *adc, u8 reg, u32 mask,
 	return mcp3911_write(adc, reg, val, len);
 }
 
+static int mcp3911_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*type = IIO_VAL_INT;
+		*vals = mcp3911_osr_table;
+		*length = ARRAY_SIZE(mcp3911_osr_table);
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int mcp3911_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *channel, int *val,
 			    int *val2, long mask)
@@ -134,6 +155,16 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = mcp3911_read(adc,
+				MCP3911_REG_CONFIG, val, 2);
+		if (ret)
+			goto out;
+
+		*val = FIELD_GET(MCP3911_CONFIG_OSR, *val);
+		*val = 32 << *val;
+		ret = IIO_VAL_INT;
+		break;
 
 	case IIO_CHAN_INFO_SCALE:
 		if (adc->vref) {
@@ -186,6 +217,17 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		for (int i = 0; i < sizeof(mcp3911_osr_table); i++) {
+			if (val == mcp3911_osr_table[i]) {
+				val = FIELD_PREP(MCP3911_CONFIG_OSR, i);
+				ret = mcp3911_update(adc, MCP3911_REG_CONFIG, MCP3911_CONFIG_OSR,
+						val, 2);
+				break;
+			}
+		}
+		break;
 	}
 
 out:
@@ -198,9 +240,13 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.indexed = 1,					\
 		.channel = idx,					\
 		.scan_index = idx,				\
+		.scan_index = idx,				\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
+		.info_mask_shared_by_type_available =		\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 		.scan_type = {					\
 			.sign = 's',				\
 			.realbits = 24,				\
@@ -252,6 +298,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
+	.read_avail = mcp3911_read_avail,
 };
 
 static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
-- 
2.36.1

