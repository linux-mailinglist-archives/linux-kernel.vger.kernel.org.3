Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE15D58127F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiGZL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiGZL67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:58:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A5733348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:58 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id m12so21209639lfj.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fXheGcE2vh8eVRPsDfJBjefjPqTEXxVEm5Y9mMq+Fz0=;
        b=qI7oAyUz1S2BQMRtMxsKknQtd4etscgeBx8jKYNXWxwqJZReDaTny2mLlT5jTGtnLG
         bXzp+ZvO/QwuO0q1PtV6fpVr79k921sG+JCUT10m6hvpmj5luuJGb1Xf4r1Te62ymaZf
         KtUkv+XhxqizmEwlWP9htvQfkRemV5P2spDF6J+pPFDul+lZo+Gc9wEzyVvh3Js0BGnX
         ylXGkJwFM6QpQ5V6gsDlX/JobcqLy+ERx2f56FDlGCjRjnzvmLG4C6vj+sqHiSDEZe7f
         9nGTsFMI2q7L7T+OYWBVn8O/PBEupIJIh9FzUDw7BIpIHvZZxIXZXEgefuR3AGbGmV7I
         P5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fXheGcE2vh8eVRPsDfJBjefjPqTEXxVEm5Y9mMq+Fz0=;
        b=EGPWP+egnv7yfOnm+XhjJBKKvtrMg3BW++rR0vSSpYQWmw74gynNwYcSczbcXTwhGM
         /wc+a80g1FkTwOpkp+ya4DxKCW+FEZibrUCP0E/AYwMgzLSBVwrDxI082psvtxcMPvTP
         NZSzKx1BMUoa7H2OJxWUDuJoRdirEyHh2Cf/vBUtfYpXDDk1i0Md7J7WmAvGzrz93Mqn
         oINdIR0C2DyW6XcufRJC9ANuKmversVx9JM+PqWyhLlE/3SO4gZ1mVsmwRNFNiQAnj9g
         cNqzMjjXZirCKg7mrzMu8TmHtRIOikKsQj8GVeZZzh9B1GO38RTC4MDB/vaiHZZkP5xC
         hcYA==
X-Gm-Message-State: AJIora9EAcHHR7tYqsNjbRu/2BcoTyqLS5ZYKcPA1OXv5K+cqFzDANzw
        j798tNLV546O9vVuzM6ww2qMYQ==
X-Google-Smtp-Source: AGRyM1vq9fy7SbNAytMwkf+4EahvThfrvOV88XCAv01wwt3e3pSZrmVNz43dETwbDjXGuIfJffgBxA==
X-Received: by 2002:a05:6512:3084:b0:489:e658:25ac with SMTP id z4-20020a056512308400b00489e65825acmr6742052lfd.431.1658836736645;
        Tue, 26 Jul 2022 04:58:56 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id u5-20020a05651220c500b0048a9526c7d9sm773000lfr.257.2022.07.26.04.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 04:58:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Saenz Julienne <nsaenz@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/4] dt-bindings: soc: microchip: drop quotes when not needed
Date:   Tue, 26 Jul 2022 13:58:40 +0200
Message-Id: <20220726115841.101249-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Id and schema fields do not need quotes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/soc/microchip/atmel,at91rm9200-tcb.yaml          | 4 ++--
 .../bindings/soc/microchip/microchip,mpfs-sys-controller.yaml | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
index 597d67fba92f..2f8cf6191812 100644
--- a/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/microchip/atmel,at91rm9200-tcb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Atmel Timer Counter Block
 
diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
index b0dae51e1d42..04ffee3a7c59 100644
--- a/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
+++ b/Documentation/devicetree/bindings/soc/microchip/microchip,mpfs-sys-controller.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/soc/microchip/microchip,mpfs-sys-controller.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/soc/microchip/microchip,mpfs-sys-controller.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip PolarFire SoC (MPFS) MSS (microprocessor subsystem) system controller
 
-- 
2.34.1

