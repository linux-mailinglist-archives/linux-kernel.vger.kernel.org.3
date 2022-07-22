Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC79E57E1ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiGVNEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235242AbiGVNEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:04:05 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD1BAF964;
        Fri, 22 Jul 2022 06:04:04 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id a23so5143641lfm.10;
        Fri, 22 Jul 2022 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LOBKkyxGhqnbdYbdfpuPA+uTBiXYlsIeG7X+Dc9rmpo=;
        b=OQHk61dP9obbTlyXmSO2X+FMtCLoE6dPTyRRLEcPhk40HEWUbjNeifF65Zcku+so7K
         jsg+z4/+KKCEpHEZpKJEWC+vQd4FKHHYeD78F2hS8zHPExtr37WFWGjlTZWaypLzBMWS
         GsIWsyepXS3KN3JWI/3BQglzvjWqUMq0JVPK1ms7zAz9qAmRdVfxdlgU3zddWIythcDa
         Si5f5dKXjebmrEVnCezJQAq9B+wwtRq/Fs8szalCrVnhhAdGc2ZrtRl3FgTwE3B9Ucxa
         zRG1iEzOyXxuUcDK0hORy7D0cK36PNl4NhRTIOB+3x+1UoEjy3GAYe/4GOs5NUWtdq/K
         jW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LOBKkyxGhqnbdYbdfpuPA+uTBiXYlsIeG7X+Dc9rmpo=;
        b=H58xRhXxyjaS4+7BI4ftjD/svzceJZNxt3cbk5KfuRNBUfKop6qa24spRgQgH3jtyt
         KFvFXeKFol/6t/su0CPEOmKgbnlJFU1LwpgB8VvtTQhgE4l89/mIXVPk4Dt2SQzHH31U
         zl/P34i0eDeJ3dO6y/9r2mHaxV50e36rGdOiR5MFG9aR1hN+rvNBSooeirfyKR1ciAmL
         DIcHSG/9xgkCeccHTEq8Zn7Bgw+58b5WLuBMoaFN6F34vLsCU+CNkrEEo36lVfgp/LVL
         b7wQeDA7QwEowr/xdxI4OOhrbrA8yqWFOnDDVddjRVoHIffe351qdskcW/pNjnS4tcM1
         UWNw==
X-Gm-Message-State: AJIora8RgxzPoLAHIjZ0kBxGJme7/HBzHVNDqUiPCM9oWNqVeohfc7z6
        RN8oF4e7TzYD4qgykseQqgo=
X-Google-Smtp-Source: AGRyM1tjTFWg3W3r/SkCWGS4CibsSM9q5ByXOxNFED0J3QMvDAZuY4YLnzVyCuvO5PKITYkGzS001A==
X-Received: by 2002:a05:6512:1109:b0:489:e7b4:7cc with SMTP id l9-20020a056512110900b00489e7b407ccmr157051lfg.617.1658495043622;
        Fri, 22 Jul 2022 06:04:03 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512203200b004786d37229csm1039673lfs.155.2022.07.22.06.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 06:04:03 -0700 (PDT)
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
Subject: [PATCH v4 3/9] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Fri, 22 Jul 2022 15:07:20 +0200
Message-Id: <20220722130726.7627-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220722130726.7627-1-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
2.36.1

