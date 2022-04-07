Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B887D4F81D9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344041AbiDGOgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbiDGOgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:36:43 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB11E5A42
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:34:14 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id i27so11246228ejd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMc3AfG5H7Eoze1riLsoKQySy0boPTnHcGifTlbw67U=;
        b=ACt2wLpnHluTK801WClxUNjv0T9X0tOd4oKiCIIrZ9eNjavRSu/0d5x723ScrD6OQJ
         4ycrRvTpZwenEIWc5szrw7Xy7HZlT+y1tGmDJX1OMZr31b6onPuNIXxnElG8KwNEHG8v
         7cO8koLd+3k74YrxsfvbF4gSaFYQmeSEhO1sAvwcmL/frMNgxZdh5zphOLrEI0Sir9er
         DC9hAsYxXq9WhYZGMdDJ0rR2BpvJwQH5Utv5DyHXDBxGVwcgUk5UG0UAy1cblo+jn8md
         HomLK/kqgRoT+SxkiPmU1UQqoCsxtMxO6f0uP0EAexdHFKupYpNvhem6YnmogCUO6aYv
         /jyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZMc3AfG5H7Eoze1riLsoKQySy0boPTnHcGifTlbw67U=;
        b=GGn+tQxBbo30gEuzWyqJkrQ11rVy60wqO4G6UqxXmjTvRkLb9TveykCo0mEe7jI+/S
         7K4j3Bv9iR2kNyHX9UYgb+29GUYgMDY6go+DWj59HAUCOHdWnW+KEpjOvL3/VphJrgQH
         xAOKIuxYtlxXMKh1FAseqYVleji4DBV+KtyZucUzbJqwH3smsQMld4EEbbNyb/r4a/9m
         6jqAwX5/wiD65a97pP6VztWqGtV+hYI+zC9V7wW3CzYJbv4SeAO6vFZaFZuGpecm1JEe
         52dmEivf3kwZcJ9FxIXcZK6ZFBfSqh6G/qOU5rdAVOuNfKr6O1BeN0VLvC3XT4KcQTEA
         jFSw==
X-Gm-Message-State: AOAM530xNtP6+4c56mamPCmzlDq/zJa/eXo9507qDuvlDCQbXmq/ZHpc
        wxd/oO5qJg4XWATClobw8ybSnw==
X-Google-Smtp-Source: ABdhPJwXyL4FeMCVoeo0dwl9+9FIwF5PtSlfyv2y65g/77g1GH8eFdummy9lPfT8/0+oXckSp7xQIw==
X-Received: by 2002:a17:906:9c8e:b0:6df:f6bf:7902 with SMTP id fj14-20020a1709069c8e00b006dff6bf7902mr13552991ejc.191.1649342050635;
        Thu, 07 Apr 2022 07:34:10 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id r18-20020a05640251d200b0041d1600ab09sm107835edd.54.2022.04.07.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:34:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: align SPI NOR node name with dtschema
Date:   Thu,  7 Apr 2022 16:34:05 +0200
Message-Id: <20220407143405.295907-1-krzysztof.kozlowski@linaro.org>
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

The node names should be generic and SPI NOR dtschema expects "flash".

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt | 2 +-
 Documentation/devicetree/bindings/spi/spi-davinci.txt           | 2 +-
 Documentation/devicetree/bindings/spi/spi-pl022.yaml            | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt b/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
index 74981520d6dd..a99de13c7ccd 100644
--- a/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
+++ b/Documentation/devicetree/bindings/mtd/hisilicon,fmc-spi-nor.txt
@@ -17,7 +17,7 @@ spi-nor-controller@10000000 {
 	reg = <0x10000000 0x1000>, <0x14000000 0x1000000>;
 	reg-names = "control", "memory";
 	clocks = <&clock HI3519_FMC_CLK>;
-	spi-nor@0 {
+	flash@0 {
 		compatible = "jedec,spi-nor";
 		reg = <0>;
 	};
diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
index 200c7fc7b089..f012888656ec 100644
--- a/Documentation/devicetree/bindings/spi/spi-davinci.txt
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -78,7 +78,7 @@ spi0:spi@20bf0000 {
 	interrupts			= <338>;
 	clocks				= <&clkspi>;
 
-	flash: n25q032@0 {
+	flash: flash@0 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		compatible = "st,m25p32";
diff --git a/Documentation/devicetree/bindings/spi/spi-pl022.yaml b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
index bda45ff3d294..0e382119c64f 100644
--- a/Documentation/devicetree/bindings/spi/spi-pl022.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-pl022.yaml
@@ -143,7 +143,7 @@ examples:
         <&dma_controller 24 0>;
       dma-names = "rx", "tx";
 
-      m25p80@1 {
+      flash@1 {
         compatible = "st,m25p80";
         reg = <1>;
         spi-max-frequency = <12000000>;
-- 
2.32.0

