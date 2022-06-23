Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077C7558454
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiFWRlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiFWRhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:55 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2463B92173;
        Thu, 23 Jun 2022 10:07:17 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a13so12442lfr.10;
        Thu, 23 Jun 2022 10:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ept+S9MCFJKpRtcRZmZou1ZYAVo4ChcwRbtVyRYJMdc=;
        b=JWqBhXxwp1hbh1XQ70jQ65D9d304cBsZX/9wj8GGvKcBrs6ki9VAPE7Nm+O9iF5oUO
         iu+wpFi5JPnrwJLXEhGS5PsbWfZwBb2kv1pkcVw3c66s/bKry1R4elqnKN+0GXDolGlz
         +F3SB3K1sjwY8a0W3ddUq/TnT6pfYqbSUP3ichMGIviqxp2e/kUeFOMz7iOPTIeudii8
         du2plq5Sb+UrvMtNCsWB4zvuf14r0tyWP0o5j3vVT4oUupRL5T1F+FbjbfLSB5NgcqDL
         4pi4XLpK2zg1f0DFK1yJWLN9hGrIvzsRbSE/d+PgnSUX+jV+FDaIJpeMkNqMSKSHja9R
         zgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ept+S9MCFJKpRtcRZmZou1ZYAVo4ChcwRbtVyRYJMdc=;
        b=BAI0FuwhlxFcyVMBAIwB+6BMbRlOqLDZxKrsyyo255Iq5ocZADEIYXt5EeKOrGNWkj
         wDCkoBPZ6X4feeBvv7aUDpnaGoxV2gSlvzbujRWH/S6K07PZMpo76OJ5VuHitJ9iGqzu
         39ec/ypoVNMoTiV6SV3WtHFMSoZeQmjicVLTVvndo5LZXOtc9i9HU/e5EF4xVfPot/DO
         0nAICfLmQZZvNYDHBcc5/r5wU1gTenwKC1hcF6weNLOLgT+u4oYCCcN8StaGPQBgx3El
         KOTJWT29XAVwY1x5LclEdYrCiVpIAHicqIDMucNC2zOnat5TP24ccnHrzCPAX8N+Dwt2
         XWkQ==
X-Gm-Message-State: AJIora9kClyAzBkpPSm8VS/exAUAPPz11xco31h4itSlpKh5D6Q2zocd
        PRyXigMOjS7t6jxJR02N3Eg=
X-Google-Smtp-Source: AGRyM1tpzsmJMfxjHHIP30Az2JIeDqD5QQ4o8hSl1yuZbdZwLwg48AaQlyAKLjBfl3h19xzJx4k1gw==
X-Received: by 2002:a05:6512:36ce:b0:479:4e8:c208 with SMTP id e14-20020a05651236ce00b0047904e8c208mr6219729lfs.496.1656004035383;
        Thu, 23 Jun 2022 10:07:15 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:14 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iio: adc: mcp3911: add support for phase
Date:   Thu, 23 Jun 2022 19:08:42 +0200
Message-Id: <20220623170844.2189814-8-marcus.folkesson@gmail.com>
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

The MCP3911 incorporates a phase delay generator,
which ensures that the two ADCs are converting the
inputs with a fixed delay between them.
Expose it to userspace.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 9e365947d285..aefc5eac874c 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -155,6 +155,17 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 		ret = IIO_VAL_INT;
 		break;
+
+	case IIO_CHAN_INFO_PHASE:
+		ret = mcp3911_read(adc,
+				   MCP3911_REG_PHASE, val, 2);
+		if (ret)
+			goto out;
+
+		*val = sign_extend32(*val, 12);
+		ret = IIO_VAL_INT;
+		break;
+
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		ret = mcp3911_read(adc,
 				MCP3911_REG_CONFIG, val, 2);
@@ -225,6 +236,16 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 				MCP3911_STATUSCOM_EN_OFFCAL, 2);
 		break;
 
+	case IIO_CHAN_INFO_PHASE:
+		if (val2 != 0 || val > 0xfff) {
+			ret = -EINVAL;
+			goto out;
+		}
+
+		/* Write phase */
+		ret = mcp3911_write(adc, MCP3911_REG_PHASE, val,
+				    2);
+		break;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (val) {
 		case 4096:
@@ -273,7 +294,9 @@ static int mcp3911_write_raw(struct iio_dev *indio_dev,
 		.channel = idx,					\
 		.scan_index = idx,				\
 		.scan_index = idx,				\
-		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
+		.info_mask_shared_by_type =			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO)|	\
+			BIT(IIO_CHAN_INFO_PHASE),		\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_OFFSET) |		\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-- 
2.36.1

