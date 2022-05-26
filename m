Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D790534848
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345829AbiEZBlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345480AbiEZBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:41:48 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A919CCA0;
        Wed, 25 May 2022 18:41:47 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id r68so600471oie.12;
        Wed, 25 May 2022 18:41:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ow0AIyaq7EGrDHL0uxoOhpgYh92bWgjMZ0SAJ89jsgk=;
        b=NjbZhLHm8FBHeZ/+jJg6+t49282uuCXtDrcw6PFjDR14uAPWy2jdd5W8KqoyCnLRyF
         AroGeqQDFCpdUrY/zKG//FK19vS9hvPGpKjdY4O2iN0SjW9wTvlSMU5UNY2jbs7Yck6v
         T1iL2xAsIVJ+aLCAslzLcsltKAYbBenJh9nxDL3+4iKUpD9yowEBVl5EbZfKtwSMyWIF
         MltFP494akjsuh+fLwFtpdX8ZRX0GIhlv4imAgqWXTgBNjKGC3PA29YPBmyjOwAKZJBZ
         DQOBEDj2v0LVthiqhz45USp8dIYvkNY3DIjQtK4NyOuNAcr1vvz+5o5qJTFWWc2z9+Ue
         GyXw==
X-Gm-Message-State: AOAM530FiBzDdqEK7c3cBWj3g00xU8UJfQf59z+ui2LDloGnjs6Pcc0f
        KSCHWQK8naXI07P3Wam1sQ==
X-Google-Smtp-Source: ABdhPJwJKd/Mf58soX6Eu+14f9g0ga+xNoIALrnFl0zz+tE2ryYBeWFtR8NyOvcPnb1co44FQunEvw==
X-Received: by 2002:a05:6808:1407:b0:32a:f4d8:932a with SMTP id w7-20020a056808140700b0032af4d8932amr6903268oiv.109.1653529306552;
        Wed, 25 May 2022 18:41:46 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id bm22-20020a056820189600b0035eb4e5a6besm141759oob.20.2022.05.25.18.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:41:45 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in examples
Date:   Wed, 25 May 2022 20:41:41 -0500
Message-Id: <20220526014141.2872567-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'unevaluatedProperties' schema checks is not fully working and doesn't
catch some cases where there's a $ref to another schema. A fix is pending,
but results in new warnings in examples.

'spi-max-frequency' is supposed to be a per SPI peripheral device property,
not a SPI controller property, so drop it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml | 1 -
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 1 -
 2 files changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
index ece261b8e963..7326c0a28d16 100644
--- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
@@ -47,6 +47,5 @@ examples:
         clocks = <&clkcfg CLK_SPI0>;
         interrupt-parent = <&plic>;
         interrupts = <54>;
-        spi-max-frequency = <25000000>;
     };
 ...
diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index e2c7b934c50d..78ceb9d67754 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -110,7 +110,6 @@ examples:
         pinctrl-names = "default";
         pinctrl-0 = <&qup_spi1_default>;
         interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>;
-        spi-max-frequency = <50000000>;
         #address-cells = <1>;
         #size-cells = <0>;
     };
-- 
2.34.1

