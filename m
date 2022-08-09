Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B5A58D4AA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 09:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239718AbiHIHdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 03:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239184AbiHIHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 03:32:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CC421258;
        Tue,  9 Aug 2022 00:32:36 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id z25so15893783lfr.2;
        Tue, 09 Aug 2022 00:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DUg/UtKI3lhbBag3pyXoXDGizX7U/1Bs4mZYx2tp8Kc=;
        b=aR+bvgQhUTsfetzQeHWlaii1W2UeggcAx2yrHxMGTdEAWRGi4iTR7I4ouSyx/2RRhZ
         rtOMdVxg90ee2PUdGHJ0mOFMDXI5q2fdwjhfAH2EgU6yuvHzVvyPo4vXb4k3wtpyRgq1
         kI4bC7pkLeppLMJcqn6jCUCyatHnBdba2iQ1tHOPlq0Lk7zbE8ndyed989sDGAqlDR0l
         7W74b5y1bI4nbnqUfL/GT1kfbaT/3Uo7+O+Lv3dzow5Rf1zYFjdPnL+9IDxZfEpj9qYS
         kuAjUMmmFH8y+aM0lqp77vEGuXlKZqNqU717CXkhq3G2+qcbfB8TTyS5+CG7SGKtXLuW
         AygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DUg/UtKI3lhbBag3pyXoXDGizX7U/1Bs4mZYx2tp8Kc=;
        b=K0f+OT7fQ/tNsMyzfRISAOkVzzK7koR1N5BB5AoVcvqfHqrbxAlfH3mV1wd6Sox/gb
         uqZLcOzBZYJNcHDVrOHlKfANTud7BuP02FRH7MfszSeNfyDAH+QWMEbYT0OlJY6Uz0EI
         iHcL/aX8jz1kOQdfw1Z5dNul/9fA5qQ7k2yTMZZFAHDUNVSfhDQne9/zcJNmyuPSZrq0
         h9aO2UYDZFfj/XtLjwUoHS6dXdHbNtFv2JGeSqg20iFXdhxvWnGI7M7BdsyWp5DBKhIu
         jhlDw1LUlP8XGdvtHCvI4diwfTA5JtgK9FPFchofyGVeZHwStO44wa3BiutAKmrMwIcj
         +Dlw==
X-Gm-Message-State: ACgBeo1C+wNVOaqes6KMQHLpF020wzTw94iZ8jvoloTu2v/5bnbUbmgF
        K/Zx0OaECGqSdHGrd16wc4o=
X-Google-Smtp-Source: AA6agR7ypL5xCbfspKg3LaqVdwfp1e+V1Qn58xCO6kI3Xrvl7ga9kDMJLa5SswtuSuhqs8JOPkaHww==
X-Received: by 2002:ac2:46c4:0:b0:48a:ea0e:1bdc with SMTP id p4-20020ac246c4000000b0048aea0e1bdcmr8193730lfo.613.1660030354150;
        Tue, 09 Aug 2022 00:32:34 -0700 (PDT)
Received: from localhost.localdomain (82-209-154-112.cust.bredband2.com. [82.209.154.112])
        by smtp.gmail.com with ESMTPSA id k15-20020a05651c10af00b0025d620892cdsm1528911ljn.107.2022.08.09.00.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 00:32:33 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 7/9] dt-bindings: iio: adc: mcp3911: add microchip,data-ready-hiz entry
Date:   Tue,  9 Aug 2022 09:36:46 +0200
Message-Id: <20220809073648.167821-8-marcus.folkesson@gmail.com>
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

The Data Ready Output Pin is either hard wired to work as high
impedance or push-pull. Make it configurable.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/adc/microchip,mcp3911.yaml     | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
index 95ab285f4eba..57a16380f864 100644
--- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml
@@ -36,6 +36,13 @@ properties:
     description: IRQ line of the ADC
     maxItems: 1
 
+  microchip,data-ready-hiz:
+    description:
+      Data Ready Pin Inactive State Control
+      true = The DR pin state is high-impedance when data are NOT ready
+      false = The DR pin state is a logic high when data are NOT ready
+    type: boolean
+
   microchip,device-addr:
     description: Device address when multiple MCP3911 chips are present on the same SPI bus.
     $ref: /schemas/types.yaml#/definitions/uint32
-- 
2.37.1

