Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8B34F8179
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343867AbiDGOWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243420AbiDGOWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:22:41 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87C7185023
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:20:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id x24so1620734edl.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yiAtg3rQQsYQrz3HB5ABJGFof1KEIaqkT/i4ea96+g=;
        b=i+7pZ9/Nair/2xYhlI9bGgpJiP5BqE3ziFD/WqnsIpu2jvt84iP1oK+U2wYZqW1n70
         HjumBvZnYJ/Wm4eDrzj4CqPltjkoCmt5D2d44nl+l0Nrpj7tbIJbWXWi5DRbOqSyuBtd
         5B9ycEYP05uCBB2bHC/MRChDklzSw+81GkmmnKj9vkS6tnL5DeftHBkyDc8ZCynVgii2
         emGWXqGiNnT/5K8HSpLui38zySkSZ/SqAQUjZVGg+O6jZW6weetXZ/wi/FTtQfULiSbx
         bPk9oFmxDOuw8cbt6h/kKflta3iwlniNkPOV9ib8J7uaVlDq8S648DouwLwtl+F4lhsG
         5RZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8yiAtg3rQQsYQrz3HB5ABJGFof1KEIaqkT/i4ea96+g=;
        b=aIRHyh6JqwdBy5fV4tE61ilAVR7hO2yLaV+H1qyx3JJreULWR9b/SxSARJt3devpez
         vNTCL2SJJ6/SG9gb4/g2+Jj9LSx0AhgKDky9caefMOFC7Mq81peJ9O3KgMJOa2OVRRi8
         AG1/3shsxgW3KJkdZgqGOsuuXhytKaE8XVnKvB3J2fBd2wVRWQBtuGurtlO6Vb7Og+O0
         veKsJHM44Y/e+eSsa+HLACpJa3rjfyL8DjHHqVWJ6lHv5K5DVesXO2oBaF/O1nq++yrv
         W4y9FsHcysoVvQZ4x0uKKY8+nakD5Tw0ZAc+A9OWerQ+BmebMxAprbEyrKvFOrimwJHn
         JwWQ==
X-Gm-Message-State: AOAM531x+mPJJ0x31hJxngqEO8jA6T9A88vNgo8kqisBWCnUomsqcxQg
        80vn+rk21SqVRTdw7YwZ+nPFIAagI5U63ujd
X-Google-Smtp-Source: ABdhPJzyaOBLTEXENkXIMPbhz9LkdnGmd3J+mXWjFUZRe447oVTT7rG0hn9KUNzp9DqfPtB4nY3OSw==
X-Received: by 2002:a05:6402:368d:b0:419:31c4:4db8 with SMTP id ej13-20020a056402368d00b0041931c44db8mr14563757edb.93.1649341207567;
        Thu, 07 Apr 2022 07:20:07 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id c1-20020a50cf01000000b0041cb7e02a5csm7416182edk.87.2022.04.07.07.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:20:07 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: mtd: jedec,spi-nor: remove unneeded properties
Date:   Thu,  7 Apr 2022 16:20:04 +0200
Message-Id: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After conversion the jedec,spi-nor DT schema to reference other schemas
(SPI and MTD) and use unevaluatedProperties, several properties are
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mtd/jedec,spi-nor.yaml        | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
index 4abfb4cfc157..708e7f88fd92 100644
--- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
+++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
@@ -50,10 +50,6 @@ properties:
     minItems: 1
     maxItems: 2
 
-  spi-max-frequency: true
-  spi-rx-bus-width: true
-  spi-tx-bus-width: true
-
   m25p,fast-read:
     type: boolean
     description:
@@ -74,14 +70,9 @@ properties:
       be used on such systems, to denote the absence of a reliable reset
       mechanism.
 
-  label: true
-
   partitions:
     type: object
 
-  '#address-cells': true
-  '#size-cells': true
-
 patternProperties:
   # Note: use 'partitions' node for new users
   '^partition@':
@@ -99,8 +90,6 @@ examples:
         #size-cells = <0>;
 
         flash@0 {
-            #address-cells = <1>;
-            #size-cells = <1>;
             compatible = "spansion,m25p80", "jedec,spi-nor";
             reg = <0>;
             spi-max-frequency = <40000000>;
-- 
2.32.0

