Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839C259296B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 08:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbiHOGM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 02:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239909AbiHOGL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 02:11:59 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1192418E0C;
        Sun, 14 Aug 2022 23:11:53 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id r17so9372257lfm.11;
        Sun, 14 Aug 2022 23:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=ZnlLRiHQsCpOZ8GUpmYe1fQICBNpJYF4yJ5P9XeXI20=;
        b=pLe3EbU08HPX/hE5ab2YnG5HutPXIisYwVbhzo82pYYFC69kO3t8IRHDiapXgHCU5H
         lfduR7eAOX3NAOQiWU26Q6x+ZTCU1w3FmgbVvXnjKlRBT+GrgIiACHeOsQ7ApjwuFvzT
         yaME+Xw4kuw1k6J8iJp3qKeAe8PwEoQQfmCF2AN5Po4o/hRinsikJcRpdkQ+MzV6HWWz
         FPL3mj047Vg8agEphXPSmWwa8LbhtzfN92VhkQpjsTfTHoYiLlFYqGCHWEFriwg/vy8o
         cIcQGJ7kiwE182jbMC3Z5cSZEMX8d/JxWkojjrhzTcbvozoW/R18xQQ9ePMMelor3y0m
         SZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=ZnlLRiHQsCpOZ8GUpmYe1fQICBNpJYF4yJ5P9XeXI20=;
        b=JiUpXlkpIOODDgZH3QhErzfK0g3R+Jak1xDk13FuBROXHDHGoH9FQBAhQzpo5VgjY6
         5BfXY1AtfOZwusZZJH/ewc3w+gHBxsLoCK1xOjNCa2dsxeMK535IPG7se71VzGSkRqN6
         ZQ6GGQpOSiREofu8dJamRHt+SwrCR0xK9PuAL5Zov/zbAOfTwiUjHKkV/Y3VjbQtnwhz
         qZ9EemPxb1L/X0wCGmXuBUPFGveJ9arfMQMKDD+hpxENT0p7ZFu2Bt21CxMKr1QTGVpD
         MsqHwBR+8BFNIHsBvwmgH7z+oqUHW50hA6L3NHns7MsSRywzvrBd/gldC63UBXdDppS7
         15+g==
X-Gm-Message-State: ACgBeo25cVlF5q44dGeqTWla1L0gKX6ibMcB8wwnE8If+5nfAZ7Vkh6U
        Ms5Rm9i9KfCGi70MQHwtEAY=
X-Google-Smtp-Source: AA6agR7uwZ1BQT7z7B1+ytAxs9fjrKlgcefo/Z44vdyPmR5Q2nChoF8ZJoTpVoFRcMoBQKfzhDuQVQ==
X-Received: by 2002:a05:6512:3ba9:b0:48a:e66b:77c3 with SMTP id g41-20020a0565123ba900b0048ae66b77c3mr4686602lfv.204.1660543911410;
        Sun, 14 Aug 2022 23:11:51 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id g17-20020a2eb5d1000000b0025d70efeaaasm1296464ljn.75.2022.08.14.23.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 23:11:50 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/9] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Mon, 15 Aug 2022 08:16:19 +0200
Message-Id: <20220815061625.35568-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815061625.35568-1-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
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

The ADC conversion is actually not rail-to-rail but with a factor 1.5.
Make use of this factor when calculating actual voltage.

Fixes: 3a89b289df5d ("iio: adc: add support for mcp3911")
Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index f8875076ae80..890af7dca62d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -40,8 +40,8 @@
 #define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
 #define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
 
-/* Internal voltage reference in uV */
-#define MCP3911_INT_VREF_UV		1200000
+/* Internal voltage reference in mV */
+#define MCP3911_INT_VREF_MV		1200
 
 #define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
@@ -139,11 +139,18 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
 			*val = ret / 1000;
 		} else {
-			*val = MCP3911_INT_VREF_UV;
+			*val = MCP3911_INT_VREF_MV;
 		}
 
-		*val2 = 24;
-		ret = IIO_VAL_FRACTIONAL_LOG2;
+		/*
+		 * For 24bit Conversion
+		 * Raw = ((Voltage)/(Vref) * 2^23 * Gain * 1.5
+		 * Voltage = Raw * (Vref)/(2^23 * Gain * 1.5)
+		 */
+
+		/* val2 = (2^23 * 1.5) */
+		*val2 = 12582912;
+		ret = IIO_VAL_FRACTIONAL;
 		break;
 	}
 
-- 
2.37.1

