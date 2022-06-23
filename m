Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1548955844B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 19:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiFWRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiFWRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 13:37:54 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92692B4F;
        Thu, 23 Jun 2022 10:07:15 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id j21so91785lfe.1;
        Thu, 23 Jun 2022 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0E4art4WHyIDsKy+IOK+bSE3VnO/zAwRAVWiCR6wQsM=;
        b=XK1yu15Q26rYs9zDD16HkxWE+plO8GeZ+dNujYTCKpe0TBb9yxE8UjsSaLbdNB5qgy
         wdewUnj3qqqzHpiTGOtPOCQfXBhSf8Aa7T0CijynNDEP+9Sb+fuQu6kBrqECzbe7hJDW
         aBFumHP43UwBjt5ZxPjA2w60ETmwUhIzpJCpCt54fTlFh40UC3ez72g0dMICG0is8RDD
         PjLS/EGzGYJnRl41uj1poo5Iq7znQ2n+xYLNlVbYePC2Z/qqucryweylIgCBzuCVy0Oc
         4wZqFJmB22a2V+tIDMI9B9+h4B63K2rBEqcgg6JO4RkT9H8KhnartdiDsbFlE2yCgd/m
         RCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0E4art4WHyIDsKy+IOK+bSE3VnO/zAwRAVWiCR6wQsM=;
        b=AfTF06MC0ga6m29Gv6x3CeoHzW8gYCb1o2pPll/MMp10KSXdaAz8HMH5kNiS2MQieq
         9WAi7ApMBEvIwMMqCuKbzThZonqkv7xFsbCiXa7IuFAeIoyr4DzP6JdbajSCHh1LzBZl
         5MKZZ1/YbGZVe9IZj0PATq5G6MUaXSCgweGasmYLsRylg0mIa7Y9xiU7wYiUjiuceyOx
         VhQ3BmqzQFxWj1YsyYKqeYt42VsmRiCWJFw/EAVWi3c8gGPPFkb2i946Q8pf34BuIhiS
         J6Bf62KBOvSxr8fwbxUt//i0j9rN/VrQ8lAC4ceguJKGY48+RzuHbsn1zmj2v7vI60TL
         dZQQ==
X-Gm-Message-State: AJIora8wOzGvVg4Ea6PGmQ5TFjCI8/VRV+6yDmiVeb0Du15ppuWzV2vi
        7avgRM3gYfnQOQVQ5yE6QFo=
X-Google-Smtp-Source: AGRyM1vX8jlCl+4BPopA0BVNn2QNiJNNOFUmG++cyTTTiZGKTZyDG8lzDMD3GuWJRGn17RqeB6OEkA==
X-Received: by 2002:a05:6512:22c1:b0:479:54b6:8281 with SMTP id g1-20020a05651222c100b0047954b68281mr6210521lfu.291.1656004033642;
        Thu, 23 Jun 2022 10:07:13 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id w27-20020a19491b000000b0047a0bf9540asm3060405lfa.213.2022.06.23.10.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 10:07:12 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/10] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Thu, 23 Jun 2022 19:08:41 +0200
Message-Id: <20220623170844.2189814-7-marcus.folkesson@gmail.com>
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

The ADC conversion is actually not rail-to-rail but with a factor 1.5.
Make use of this factor when calculating actual voltage.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/adc/mcp3911.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index 65831bef12f6..9e365947d285 100644
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

