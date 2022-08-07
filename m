Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC158BABA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiHGL41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiHGL40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:56:26 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2D632F;
        Sun,  7 Aug 2022 04:56:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so8018045wru.8;
        Sun, 07 Aug 2022 04:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GiLNVtCZ/comMeKOF/hrTe2K4Wy7cDxvkOFs3YEqxbU=;
        b=EK4hhOdLGrSuSVmZeu6uVQOHvg65LOK+IUqnc2cF5SLGB59YlwaN299i6A1StvCqV4
         sUw+HOMbWDg6lHqCWIgZZuiJ0qp/PTain9MnFV19dzTgj4536xvGfhzHm62V3ZywVkJW
         4ffgCd8rCdsdQoOkPhMWOpV/jfoZ/ZXbSlfXtY2P9OQvNeztchKhGZQcP2aXZqwT4f6L
         w9hR/TlijVpdWBZOAvw443qxgCyvIFJyiwxmv6hZtQtEJB8TdOaPomGmetq3HZGdn599
         3oSF4lf6MnzK/4kZ8YDhf2upZW3SupoX/w3vpxb6sNpxTFC9OvXTzEoctNiuY7rvpMSF
         qITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GiLNVtCZ/comMeKOF/hrTe2K4Wy7cDxvkOFs3YEqxbU=;
        b=cCjP/vawTWICLWRNXaQZ+plkKM77paXlL7zpXvqoDId/uuthG7PRI5gWDVFsBRIbEi
         IK49RFfVMS2yvF7RHCqmDaRoLRNv/D3MnGjy6N8R8QaQnR4m5OAfw+jbZx/1mpHqeV+M
         8aPq9z9z71lN1MxiRYmoDqXk03Y+gKUXGZ/mbbLCrtlFncVpvSdiO12r+DtndmjDZX2L
         n37SmP2vO3Ow6IFWfZcMIktY1hxkcRGf1uUr+6Cph8UEQRezrUjny5AWHKZcbmt311tt
         Tv/Yv4og9b5Plh+xs/86ewey0Ymx/2b39+hORH/0VJHB4bV0fX4eMsaU130SZ8b6qkwb
         aFsQ==
X-Gm-Message-State: ACgBeo1rQ99tT8sO3BdOW23NWKiwXlo1feP2mRdXavG4zkG2JEpHOzEK
        ksBmq4rt1RQZfRYW7RB3wiXB8mpmQEo=
X-Google-Smtp-Source: AA6agR4eyw8QvS+cb6eOmsYp0LvPKcnTjZIkkRDGdJ3vct/edVg8MQfzD3Or6zY/JUR7hBMuWs0KPA==
X-Received: by 2002:a5d:4804:0:b0:21f:bf7:83be with SMTP id l4-20020a5d4804000000b0021f0bf783bemr9180075wrq.94.1659873383365;
        Sun, 07 Aug 2022 04:56:23 -0700 (PDT)
Received: from DreamMachine2.lan (188.red-83-35-57.dynamicip.rima-tde.net. [83.35.57.188])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a4eea0aa48sm11164014wmq.0.2022.08.07.04.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Aug 2022 04:56:22 -0700 (PDT)
From:   Angel Iglesias <ang.iglesiasg@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andreas Klinger <ak@it-klinger.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/5] dt-bindings: iio: pressure: bmp085: Add BMP380 compatible string
Date:   Sun,  7 Aug 2022 13:56:20 +0200
Message-Id: <4bc2c39b0ec0453ecffd090fdef5b6c8d771d69a.1659872590.git.ang.iglesiasg@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <cover.1659872590.git.ang.iglesiasg@gmail.com>
References: <cover.1659872590.git.ang.iglesiasg@gmail.com>
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
2.37.1

