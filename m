Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB4D58282A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 16:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiG0OB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbiG0OBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 10:01:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A715706
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:01:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id m12so26164283lfj.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 07:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTRv04jRGjZbH4AAF7E6i5dcKRpckaIkqqWvwX8C2Dc=;
        b=M00BLd+qHlqHsi7yxk28/QtIWrZNTL1x1UfNgDIELA7ybYbjuRUlZblE5A9Z3mjKWV
         T0qzUOb4aluSX16LSr2FcytO+Pv9YbTEEXN2mUx0HHsUpxl49QG41JB/1/iKL8p//w7B
         L7mNjyfCpq9dNIzwwKM0tMeytq+Qcs0/XJ2a7hL6jp7qeFrDY4TKEHxDXRWuXwRyKmdl
         4aU1getVQ1us3+2gh9dAmCmT213To4z1YSSgZ2WZ0GUmn0shLKW3af0vmOfUGDv5OKJC
         oI4lyqv0QMn6kW0B8oIQQdKmM9OR6kQ4o4HbCX+lMfGV6BsK40hm+DTbJCaTmvBRY/xF
         FKZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QTRv04jRGjZbH4AAF7E6i5dcKRpckaIkqqWvwX8C2Dc=;
        b=CgmNcjEooY1RJamZhR0y8Pb0dN4hvNN6zXFNEBb4KDWLeTvewvkcDYHKZqtUvWo6Km
         Tyc8d+HJTFZXFRQ8Lff61cawRmkLVPCRqqavxidkHbIrOEHpZO8yV1B1pphrGSWQTzPq
         SMJocIOXRO7+5yGOCRU8fmKlA8NuA98aC6nyKQPQ9w9j8cmTDjJ7+AlaY/iEBdOlPIoF
         kqNbg02uNLdzgrhnjfOteo44nh7RZ3X3oLUDsB5ouZ7xoInLAj5uMz8A0LP2AcJs4YzA
         6l91trKjC5236gm8LJduZajyDT8DwElycg6VLP26WvTJ4KV2u+Ww2FKVXSKnUUbe0ZdN
         X9FA==
X-Gm-Message-State: AJIora9/yzz7sYk0wErQSB2GkEQB9nomBl4r+a3PalRsHL6Fa0xz5nOE
        4j3NXO0nnhYZcKafiTYrEss3Xg==
X-Google-Smtp-Source: AGRyM1s7Oh2i8t4FMTF1klFD9obE209h7ljaba3F2fI3DYREDp2Kf1mczCOKJAhm9xtJnxAW/LoG4w==
X-Received: by 2002:a19:2d15:0:b0:48a:85f7:7e37 with SMTP id k21-20020a192d15000000b0048a85f77e37mr7009108lfj.392.1658930512516;
        Wed, 27 Jul 2022 07:01:52 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id bi18-20020a05651c231200b0025e119e9276sm1203287ljb.99.2022.07.27.07.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 07:01:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: iio: gyroscope: bosch,bmg160: correct number of pins
Date:   Wed, 27 Jul 2022 16:01:48 +0200
Message-Id: <20220727140148.223508-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BMG160 has two interrupt pins to which interrupts can be freely mapped.
Correct the schema to express such case and fix warnings like:

  qcom/msm8916-alcatel-idol347.dtb: gyroscope@68: interrupts: [[97, 1], [98, 1]] is too long

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml        | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
index b6bbc312a7cf..ebf98bc2eb7f 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
@@ -24,6 +24,9 @@ properties:
 
   interrupts:
     minItems: 1
+    items:
+      - description: INT1 pin
+      - description: INT2 pin
     description:
       Should be configured with type IRQ_TYPE_EDGE_RISING.
 
-- 
2.34.1

