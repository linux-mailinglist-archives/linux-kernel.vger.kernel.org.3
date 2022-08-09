Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912F658D49E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiHIHco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiHIHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:32 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773BBE003;
        Tue,  9 Aug 2022 00:32:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id bx38so12116655ljb.10;
        Tue, 09 Aug 2022 00:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZnlLRiHQsCpOZ8GUpmYe1fQICBNpJYF4yJ5P9XeXI20=;
        b=MONaGphdMLbgiLFkSjeBJTZ2fYuavDc1hO5Ln/eQm5EpJgrYrOX4hJcOabbierBVk7
         Y9/IoeVEx8HwjAB7Qfp0IEOQur9m5P24A3FgBORb2SpwzsA/kZBZsUU7Fp8LVF+rn8ad
         tZBhzF9oNs9ymftwNjHuQFsThCeNOYETqYg5x9wdZ0cyWZIfIjBUTFDy5T760lA5ttfG
         YasrH3JhSpnUmTHNgh7U18I+y4mmjoOy6I6vUClmBqvjdtmrF7/QZG1kqdhAL/19B/G/
         2OcA9M5Flw2GFjigyBiAP0ikXIQmKoF70lXfmjXFB15gfmVmyFakxSInmaAjMWb/BVGs
         LEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZnlLRiHQsCpOZ8GUpmYe1fQICBNpJYF4yJ5P9XeXI20=;
        b=wrvCE3zKH3r7fnKYj8Dy8tM+isDpOIa6MCvfXSrggLBkv32dk5RZEvvP2jvE9BmIZ5
         zAI9cVFeRITyIOYVqZ+gouoQlBUJWWPeb1v5rJLFNvVFKGg8y4U2Vr1eHNf8rKFyslJ8
         RgUiORCuO7BFyWeN+E2t00UNEdenuX2r0xDtdQTNr5J0NoeQNltVqR1oEGFSKTI70i1l
         krtDx9uraL6EUnzNEqoAnVeacXv7rq6VX6ns1K1OhhjRhWvuib0djuQ8vva1ZUkb8Dtv
         55V0E116DepBUTqttATYjJiREtu/Q/OCP1Wr/6WCc3VC9DIjstcoId2btji4RjqrFSML
         6YQA==
X-Gm-Message-State: ACgBeo0BJBsrgfd4Nn/Ptx2V15m1wZHK3myeQo/0chaVSrw+Y677a/Pn
        5xGTLcy5lAEsVj+VkWGPZjM=
X-Google-Smtp-Source: AA6agR4nCzarSzkMC9IdG5foQgQhVyDMR1qMxsMaEbCzbXZ/i70TBWI/uD/bWyM2Jga2/l++5zu8Iw==
X-Received: by 2002:a05:651c:543:b0:25f:dbbb:9cd4 with SMTP id q3-20020a05651c054300b0025fdbbb9cd4mr2825936ljp.495.1660030349846;
        Tue, 09 Aug 2022 00:32:29 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:29 -0700 (PDT)
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
Subject: [PATCH v5 3/9] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Tue,  9 Aug 2022 09:36:42 +0200
Message-Id: <20220809073648.167821-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809073648.167821-1-marcus.folkesson@gmail.com>
References: <20220809073648.167821-1-marcus.folkesson@gmail.com>
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

