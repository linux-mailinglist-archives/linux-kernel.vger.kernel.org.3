Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C44565CCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiGDRTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiGDRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:19:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83305C40;
        Mon,  4 Jul 2022 10:19:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id t25so16767021lfg.7;
        Mon, 04 Jul 2022 10:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3iLMWXKaK4OETrzqj817kmzJiQmAFyABnf3Lx/BATM=;
        b=o36lKSXE5dV6YeHDcu6+aT70KGbnlzBB/WyHUS2O4iHqc1a0gGIpnUXB02QlB8LGlo
         bRplTe02AZCH7c1+QGGxqtHkDsAt9NCeAFavbxIr/an504ksNxkSZGz9Bej9iTwdxzdE
         LawqEpapxbb096jnn342x8GXP8aTr3tG2EX06AfgZaaRiMnSjIhPFQR+afuRQTFmEwhQ
         1sO2LjikVhXJSxSuDFElWXl2YWXLp71uwZBCn7fFwL/fc9hB2s4djxQepMxOUbSkIpzv
         g6bLiyvgZNVy1B5BNdWdzFQt8yldgAV5NfyNoF9Waag7p+MQ0JMgSnb8yNj+cX2+H57L
         7C3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3iLMWXKaK4OETrzqj817kmzJiQmAFyABnf3Lx/BATM=;
        b=YhCOv+G7GZ1psFpwluLYscEHHYgwOpsLGv0nUo30SFOFPgGqIuxPe99eOIa52aq6Hg
         oQ7YSPtYKmuaq7ODEv8gjjGCvnq8vdfSNY2PKzV2O1x5mNezQsen2wpsaghzdKsbGB/9
         8dIeRpjDEMtcncsvSdWIZnemyd+p9fRfQbAusKjBXY5sWZDLP1Blp9M7jl749gy3rXl2
         ZNKSOUcjPAwUIBPgMvz1YiTm7wG3pyUQ0MVsd5xNLEszkUWWFEmQKbjVeHxXAWZ4c71o
         tHf6HJQOav8sfxp9ys4/213Fzogs2wsiTcJLYzCyts91OC+FweF4cH5v7yoIXIdo4Rz+
         0r6g==
X-Gm-Message-State: AJIora8AuWLsBlcNps2MHZpi6sc7k7gajskJ1xbXF5JvEV0hB48dxSF2
        K9esmXYfvOGmow1krOuxFdk=
X-Google-Smtp-Source: AGRyM1vTlowbru3uEqOCa5DQTi/XPqqbzfMUgzGK/exiKz/jVMmvW0C8wOA/Od145tYXRgYZNIzM+Q==
X-Received: by 2002:ac2:4d82:0:b0:47f:aff4:3684 with SMTP id g2-20020ac24d82000000b0047faff43684mr20092398lfe.557.1656955151922;
        Mon, 04 Jul 2022 10:19:11 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a2ea609000000b0025bf6099cdbsm2772720ljp.78.2022.07.04.10.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:19:11 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] iio: adc: mcp3911: use correct formula for AD conversion
Date:   Mon,  4 Jul 2022 19:21:10 +0200
Message-Id: <20220704172116.195841-4-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704172116.195841-1-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
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
Acked-by: Jonathan Cameron <jic23@kernel.org>
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

