Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDB57F0AD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 19:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238315AbiGWRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238295AbiGWRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 13:38:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24E31EEC0;
        Sat, 23 Jul 2022 10:38:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso4081713wms.2;
        Sat, 23 Jul 2022 10:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GiLNVtCZ/comMeKOF/hrTe2K4Wy7cDxvkOFs3YEqxbU=;
        b=d8EBltywcAFXfcKPqTIIw5q7voC6OlWbdstf/6tphykMBxGlxQw1Obr3lCq79IySIe
         hYrCzD2vKtyGIZQY1IBT72tvACWbmdS0uRzjzeqWCT/RFJTJpjZ9yewdLIPEp9FtKRFZ
         f7cK+5Q+wH6V3Gid1Cm16dRpq4XI0srGbzLVEDBNiuhCrWsRK7zb7ozXwu5RM9vAx05d
         zZ5b7XIAToQf4A9ZHE1zQ5Oid9C9tqXYuzzAI8OEfOJ/dpByeCdce5laGaatHjYNRVji
         Oiaxhzdf6e7gu5UWno1mQEpCmRfecy2bGsTtNCGsr9UPKINJ9WHHVh4CHmnoiDt1kOX1
         fTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GiLNVtCZ/comMeKOF/hrTe2K4Wy7cDxvkOFs3YEqxbU=;
        b=gyVgSx2rP0rroCDvu87qIPaDR4sn+AkhkxnBRBk4goUChidAe6WDa7aViLpp1iaOzX
         NYpLpsjK+wjcG7Fzjm3mgVPSL9EvudduCrTjC3eYXYYx1cM8Xb47C3HvlQORDm8CxCw+
         xGP/ueGJlV++1ou6pqAZgbOB1OQ70qf5YS96pqFaAvsXp6E7wNCJOc6APk3ktCr8Wi+O
         x+1DE30UW/R/Evl5cUlAC6MVqY19sKi5SWIk62O0Cf7tzDOBVxIVmPf6osXkqQVQQzFm
         NQtqk8ApebX5Yhsk2Pn+qOqEPU2F64+bDjoQd7MfbN+oEJqrniON+KCKZNrf5hvq5Mca
         i28w==
X-Gm-Message-State: AJIora/2QCH62bWdfJ4f6wGYMaCxQW+CrVaFiwWa2bqeT+tfAylZzNBN
        6el0pErY7vA42Ktt+oHJbu9Jtidi/qd2zQ==
X-Google-Smtp-Source: AGRyM1uKaEEFgVIppa9pGzoJy4EkWZNqMChYduxosRK2pNPmgymG8/GYlaHM57Mf4W3QurntwRXpLw==
X-Received: by 2002:a05:600c:501e:b0:3a3:4a04:fdb5 with SMTP id n30-20020a05600c501e00b003a34a04fdb5mr2662067wmr.168.1658597893914;
        Sat, 23 Jul 2022 10:38:13 -0700 (PDT)
Received: from xps-work.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id az14-20020adfe18e000000b0021e529efa60sm1533279wrb.1.2022.07.23.10.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 10:38:13 -0700 (PDT)
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
Subject: [PATCH v4 1/5] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Sat, 23 Jul 2022 19:38:04 +0200
Message-Id: <8c9e40d02418d3418795596c908589f47e13a36b.1658597501.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1658597501.git.ang.iglesiasg@gmail.com>
References: <cover.1658597501.git.ang.iglesiasg@gmail.com>
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
2.37.1

