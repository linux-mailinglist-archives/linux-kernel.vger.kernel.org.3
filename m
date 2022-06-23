Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A81F558453
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234619AbiFWRlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234582AbiFWRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:54 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85A49217E;
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a2so56351lfg.5;
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCOeJ/RL4OsQEpw+dtahUcCad0vIrYxWUL3JF0e8HLc=;
        b=mXw9FDQnxA5G0jf68xxK8Nvy+nDuvAqUO86Uk3FvI8bDhn8sPVP1p1K+yNfuO9zB7O
         9Xb0wBw6U/wqwWgrk4q8JhC/T+IayTaOpieieJMwCjSPilOtXA0Nectk3syWHhSODjBR
         CBxEBvRFobg+l7irICuTNHniQPwnwKR5eXZFZewFs/rahujwfCaUXHcCScQOHdSON6ZT
         3INnbxJAM4Ro/7rvGTnSyfUq6KKsQL1yIY5VRjQdvLiU73QsedibWVPDe8e5IAcjx8pq
         1q2T2WI1mmpJl8j/OaCVfNS3KfAGZ+g3jlz955RlCX/EtF/KBo7xhMAKChDiW4fvIsUH
         7bKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCOeJ/RL4OsQEpw+dtahUcCad0vIrYxWUL3JF0e8HLc=;
        b=iYNlP3P/hX3Hs725q1SYqnHicTKTSf+dCxkUEYegb3ukHOWIwl8okSWsqR/zJ5YV2W
         CjRvGNKQJZUXlVZ0ccdYZE+xmLVU4MypzgzppFXv1vfdkEUW+i1BQAxcYYmpJkKq7flW
         3ONB/D3iBwEoKEAcgc7seW01FKgih1DFlF7CXgnhnSUStZIVbioYYH6+FIVm2oBjORW1
         xIRWXdFs1CTTbcORII5OMcl59nGO9rXCoc4lqEF/ICkZ9rGfGJ2VdRUqwm0OKsKv5GZ2
         nh4mxrZ/+Yv2NH2lYsH+9kST+U897RGff+x8O4jMuMfFu+NmWW7fKxFVa9JqoaTWSJs/
         YMNA==
X-Gm-Message-State: AJIora9RQyTn9hPZlfGAhCxcd8efFHbuaEy4CcgdaG1bRKykB/JyROrN
        e7xyWXumY2HvGfzUqh+aCagkUdtva+X4tQ==
X-Google-Smtp-Source: AGRyM1vojOZilE7iWyjmaHwrX0NcTKcapCRrhLVtOYKRuxOtPiiFijPvlHEKwdLdysC+QWy6IeallQ==
X-Received: by 2002:ac2:4e08:0:b0:47f:7b73:c9b9 with SMTP id e8-20020ac24e08000000b0047f7b73c9b9mr6202076lfr.5.1656004032201;
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:11 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/10] iio: adc: mcp3911: add support for oversampling ratio
Date:   Thu, 23 Jun 2022 19:08:40 +0200
Message-Id: <20220623170844.2189814-6-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
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

The chip support oversampling ratio so expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 72 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index e761feed5303..65831bef12f6 100644
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
 
+
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
@@ -186,6 +217,42 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		switch (val) {
+		case 4096:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x07);
+			break;
+		case 2048:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x06);
+			break;
+		case 1024:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x05);
+			break;
+		case 512:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x04);
+			break;
+		case 256:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x03);
+			break;
+		case 128:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x02);
+			break;
+		case 64:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x01);
+			break;
+		case 32:
+			val = FIELD_PREP(MCP3911_CONFIG_OSR, 0x00);
+			break;
+		default:
+			ret = -EINVAL;
+			goto out;
+		}
+
+		ret = mcp3911_update(adc, MCP3911_REG_CONFIG,
+				MCP3911_CONFIG_OSR,
+				val, 2);
+		break;
 	}
 
 out:
@@ -198,9 +265,13 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
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
@@ -252,6 +323,7 @@ static irqreturn_t mcp3911_trigger_handler(int irq, void *p)
 static const struct iio_info mcp3911_info = {
 	.read_raw = mcp3911_read_raw,
 	.write_raw = mcp3911_write_raw,
+	.read_avail = mcp3911_read_avail,
 };
 
 static irqreturn_t mcp3911_interrupt(int irq, void *dev_id)
-- 
2.36.1

