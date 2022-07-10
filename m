Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094F256CE58
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 11:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiGJJPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 05:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGJJPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 05:15:10 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02BDE0C8;
        Sun, 10 Jul 2022 02:15:08 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 9-20020a1c0209000000b003a2dfdebe47so620750wmc.3;
        Sun, 10 Jul 2022 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vc7tw6mjJ5Kc17Ui5i1QizKqiPx9CvjzA49Ha2NV+Nw=;
        b=Ty/2rr5vN64Q6JitKGJrkeJIksYnyifTseF1jGfltq3HtT9zSawk0G4qteU1pYLrvP
         P2/CDwrl2XPxJpb6eVR/LMYRlE96h+Gc1mHB77nHF2XGBIb0BE6XiELjEgjN/faIIFqL
         wekBIg+aVusJZ7vBY4lsdYKvFDc6BK1BuvIUGR/EHK+u9u0PXb8oJsXBuRsuMJlnwilA
         VFrptUc7raP/8PCbJ+/p084yMBAf+V4xTbzbSVTakFRTMXgxG7KjxKSMCCDzBqv+e04S
         PGVs0v6kNVhNDsY2WWkGqMyhgFSjwt6MZZYa9z8JaySrUX5CtBqOp6CaS78iU897U+Cx
         s1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Vc7tw6mjJ5Kc17Ui5i1QizKqiPx9CvjzA49Ha2NV+Nw=;
        b=C3pnwSfHRJFzxdYYNu6nhPYxm3V3QmbvGetWeTfti+s2yUljuasXynz07Y07ejBFb0
         eNdKf9tND/GaiCqp9EKaSMxQ/N+ScMJo9lOt4DHV1UGHWTmbzzMFfJToGHB+KUdRGL9f
         DxlUTl1yaUMw7aoTN4r6ItwQ6r5Mx4G+PLuC8AJMjkF/iEoEwQ3pq/XDs0Iz34xMZO0s
         +DFt0TUMHML0CC/Z+8ziKQTTq9blx6wuAkUFntPmRv1UFhhsmssuDhRkL40cJ6MnEF54
         L0/WRNuZ4P5eSlhZfJ1w5dSLxp0V+sSWE5KaB24PU/+0v8ISS+PFOM7eRv4T2tgdgm5m
         J09g==
X-Gm-Message-State: AJIora85TxG5AKLKvkQwx2uw6lWmTuO4cifXsTqId44tsF+O2rK57UPl
        algAiCXedf1Qc5AWm9NQRxRVdplPVb8=
X-Google-Smtp-Source: AGRyM1u9/6oh+NaijHI/FNEYiao0fJn8a5ZlJyOi2B/MDBvs+WLaMw3F529PrCZz/fCp9vjWg42TyA==
X-Received: by 2002:a05:600c:5108:b0:3a1:a0c2:ba47 with SMTP id o8-20020a05600c510800b003a1a0c2ba47mr10214381wms.68.1657444507135;
        Sun, 10 Jul 2022 02:15:07 -0700 (PDT)
Received: from xps-work.lan (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id n8-20020a7bc5c8000000b0039c457cea21sm3475469wmk.34.2022.07.10.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 02:15:06 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/5] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Sun, 10 Jul 2022 11:14:55 +0200
Message-Id: <20220710091456.15789-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add bosch,bmp380 compatible string for the new family of sensors.
This family includes the BMP380, BMP384 and BMP388. The register map
in this family changes substantially and introduces new features
but core concepts and operations carryover from the previous iterations

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
index 49257f9251e8..72cd2c2d3f17 100644
--- a/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/bmp085.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/pressure/bmp085.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: BMP085/BMP180/BMP280/BME280 pressure iio sensors
+title: BMP085/BMP180/BMP280/BME280/BMP380 pressure iio sensors
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -16,6 +16,7 @@ description: |
     https://www.bosch-sensortec.com/bst/products/all_products/bmp180
     https://www.bosch-sensortec.com/bst/products/all_products/bmp280
     https://www.bosch-sensortec.com/bst/products/all_products/bme280
+    https://www.bosch-sensortec.com/bst/products/all_products/bmp380
 
 properties:
   compatible:
@@ -24,6 +25,7 @@ properties:
       - bosch,bmp180
       - bosch,bmp280
       - bosch,bme280
+      - bosch,bmp380
 
   reg:
     maxItems: 1
-- 
2.36.1

