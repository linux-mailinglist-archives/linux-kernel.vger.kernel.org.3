Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790E55A8DF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 12:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiFYKhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 06:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiFYKh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 06:37:27 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011902A269;
        Sat, 25 Jun 2022 03:37:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z21so8502110lfb.12;
        Sat, 25 Jun 2022 03:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0dm9KJtzaR5ke5V2d8sXQIXCLMAgrorSfKoR4+KGAsY=;
        b=kQoaDdeFQrxAQACWktYKJF3CXh7lJZIds2a8QPiNHMEtgVbiLkhWJd6XSri4bx/w1P
         TixXGmZGu9+Sx/CY6FwUNj3T9e+tuOBOWggkHLyL861KPZ/1C7cqVr3AlA4TU0+mxJ00
         gKvsezxEuEEAWJVipkOLWm0Gs1qdZr1wrPX4fwVmSV36Teje0pynFWKMBews9Pa4NvRm
         LMU6QIK48obfRSRmbQt/n8XF5S4XHIJr/9Sj756XAhls+UQc3ptq/k9vORZ1Y+tVsXLg
         QwD30EvIgUDOAyOE61LvwoCGEAmT6lfeCWE/IRQNS16zLwiDH5eOCjQfambb/1aWpm4M
         syBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0dm9KJtzaR5ke5V2d8sXQIXCLMAgrorSfKoR4+KGAsY=;
        b=1w8GFJqJ+qQWuOCOV64a3+uQJmx8RSnTZp9IIg58hNssPmjmF9xVvP5PFZyJE0zEtd
         GB7gTJteDuF73WRpLkbR5L6cF3eSzwElwX22A9BcveW2tvfWmalkAUF7k5sWJeC0wfjh
         0Z+pbZVYrQ0wXTitG/yYQD1YM5nVISJw0QTCzIEdqSP9pSaptxsvZi4phR9m5RYDIFgA
         zijMK8TEFA4ovNnqwimz72ytLaSPTpbBrk934BGaChr33mo7j9Tz5amlLs/18KU30Krp
         /sXeiXpq3NfTL3ZZchdSDS4J4H5XBRC1XtwPw6PXtJA/rQGdiBZg/WZO+q0kAz+Y4F4C
         RSwA==
X-Gm-Message-State: AJIora9GtD5KZ72hAbewsiwo6a4qMJAqnJENbtUQwzXgCBglZRDZiIQt
        Zmj+Qlk6eYTP2yqNBf0WKso=
X-Google-Smtp-Source: AGRyM1uelFPjZXnt8LC1ISb8/24MEX9UYHofUjaqpmhRvZ7bmg1TjcNp4E6Tv8uKTilDNE7BeGt2Yw==
X-Received: by 2002:a05:6512:39c6:b0:47f:6ad5:7184 with SMTP id k6-20020a05651239c600b0047f6ad57184mr2100458lfu.114.1656153446559;
        Sat, 25 Jun 2022 03:37:26 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id z8-20020ac25de8000000b0047ac01fc644sm809115lfq.44.2022.06.25.03.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 03:37:25 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Sat, 25 Jun 2022 12:38:50 +0200
Message-Id: <20220625103853.2470346-7-marcus.folkesson@gmail.com>
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

The ADC conversion is actually not rail-to-rail but with a factor 1.5.
Make use of this factor when calculating actual voltage.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v2:
        - No changes

 drivers/iio/adc/mcp3911.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 1469c12ebbb2..ede1ad97ed4d 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -48,8 +48,8 @@
 #define MCP3911_CHANNEL(x)		(MCP3911_REG_CHANNEL0 + x * 3)
 #define MCP3911_OFFCAL(x)		(MCP3911_REG_OFFCAL_CH0 + x * 6)
 
-/* Internal voltage reference in uV */
-#define MCP3911_INT_VREF_UV		1200000
+/* Internal voltage reference in mV */
+#define MCP3911_INT_VREF_MV		1200
 
 #define MCP3911_REG_READ(reg, id)	((((reg) << 1) | ((id) << 5) | (1 << 0)) & 0xff)
 #define MCP3911_REG_WRITE(reg, id)	((((reg) << 1) | ((id) << 5) | (0 << 0)) & 0xff)
@@ -178,11 +178,18 @@ static int mcp3911_read_raw(struct iio_dev *indio_dev,
 
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

