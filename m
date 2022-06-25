Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4955AB33
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 17:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbiFYPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiFYPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 11:08:54 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B51260E;
        Sat, 25 Jun 2022 08:08:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z9so2810629wmf.3;
        Sat, 25 Jun 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew49skD5ZdIyGwg0/jTXLSgKgIqRxhQSBsZllVavisc=;
        b=E6UBqmaLkgezVesa+rPuXLzn/YidAqtOlWFDKmZpDsoNLrnKskJJpUG1mt+c5/Bg1/
         Y6HJLP1Nidv2UBhpahzA/WpVUlo+e3EEO/XotHWlMOuGSaf3QTKjTg6T4PWT4Ygm5CpG
         G5NXTRGWvK9zvUkPCib+dno3BeYRzfZ8KJXya/pu5+LObPRcPSshAihVsX5mDZyEB3I2
         K/deKlIYZP+If3BrXdigCVhlnP935IcF060wVGEklxCPF3veWM/s/Z59LNQ2u7YYWzLV
         AJ+Ei+JjnnwRgiv2ZbC6JY82YFdfXVDE2Tm/hjzs3F9c5Rhcb1t9XVjtddo303YlFC0/
         cXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ew49skD5ZdIyGwg0/jTXLSgKgIqRxhQSBsZllVavisc=;
        b=zwZ+lyCHyF3AnYpoARMXrdcMuC4iTRTZrnIiDbTpwK16vdQaGZ1M/S/CYXXSipdX/R
         qvdxMkkm5Wtfj2QBq2A12FNtgYPVxxWZDRQedxNOT0fIkW1Y+GvkFoUB8aIWs7d/ehqq
         Mt2u2d/ITZGyvjJMCBP+/FUWgvbzzoKF+QPi6t6Zckiomc5/z5qioS9TqTQu/YLbzGj7
         cweWAk5d+fGyc4pVJw4wwx9QxFweowf/IRKPCvWMECvZC/HQB+YJlKuJB5LClTCeyBdJ
         LxAJm4Yg9XZBaiLaCAJTcIPQDSgS0JQhylDHgIRN3hIzBqGeYgDfAEgQ6F1uMW/z5jyM
         KNcA==
X-Gm-Message-State: AJIora8ResGbfF+pnmUuL44SUPIw1v4wNTfvHammw+q5lZ0ItNVCtf0f
        auCZpy1PwNmM+HPl0XgM+qIrZjsGf5g=
X-Google-Smtp-Source: AGRyM1vaJdUc8+hFBFdGPMKizMHQjT2bA+uBtAFGxLXullQcBteWP97tNYSiDJreaHAWojUnAWigiw==
X-Received: by 2002:a05:600c:4f95:b0:39c:9897:5290 with SMTP id n21-20020a05600c4f9500b0039c98975290mr9487508wmq.149.1656169730998;
        Sat, 25 Jun 2022 08:08:50 -0700 (PDT)
Received: from localhost.localdomain (214.red-83-37-4.dynamicip.rima-tde.net. [83.37.4.214])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c100100b003a03d34b85fsm5017942wmc.25.2022.06.25.08.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 08:08:50 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Sat, 25 Jun 2022 17:08:09 +0200
Message-Id: <20220625150811.47292-1-ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bosch,bmp380 compatible string for the new family of sensors.
This family includes the BMP380, BMP384 and BMP388. The register map
in this family changes substantially and introduces new features
but core concepts and operations carryover from the previous iterations

Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
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
2.25.1

