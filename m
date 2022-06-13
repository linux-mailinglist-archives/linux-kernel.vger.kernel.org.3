Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EF0548B33
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354398AbiFMMzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356440AbiFMMyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:54:02 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053A434BA7;
        Mon, 13 Jun 2022 04:12:54 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h192so5246936pgc.4;
        Mon, 13 Jun 2022 04:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oqTkyZ/R9/aOjKZlhpbfjvDgfGSkULBZvX8wxg4YxyU=;
        b=EkfouFuwigzPeP3CaHjbjOBiWlhMunkQOLCaHKE2YU6uwGayAsPnUiKSAXGdXu18cJ
         v4gsLlJJlItr1BUXfBsqy4n/SJ3JfrJozMKwoYPdCNYzW3nIjUOr8xTpW2pnpdzMS6N3
         fU1tUtmrLaNU1SbFzyXbBnxLXiGR5p8MfWcLVM8ZECExJE9azVAatV/AqH5t25q8zpX3
         hhfuJLTyojZTZyemTeos0TFjLPWsXyMrWe7iM56nTK6jVjsQpTeVehX8WVnWFMOzDINC
         A/K/lWvB8Z/L9aRwVHBilttnT0nQc9JF1fuhIfPB9oUg8Paw8u8WsrP8Dvt6YEOmRlZP
         C7pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oqTkyZ/R9/aOjKZlhpbfjvDgfGSkULBZvX8wxg4YxyU=;
        b=MdlEYUkZ+RMXJ0Okv2zwUi40zMOdFmXoNZYw1cmlt6hJAmPEPOLLCnc/L4gwz15AK0
         aOrCbgr/QDLBMGzumOaTnv3tmyQpDaGHVwrvY5tkrLosgz1OXFQyUMtwKlTgk71vhqmI
         oPv6iFSLQmLXxdbimd3MY7SEJ2wEku5h3xvNGXhyKfOufv3ZJjQs4AAalZSiQ6+uEkLZ
         0v15SC6nUIXcM2bdsIi8/tOGCNHvkQisG/w9zo7e2PC7kRh2Uk+H4CNxdJmYNCanqIAj
         Bo59VvKi+TorNvf9/aZGOP3jAk4+sRHyJNUS2o5GffWtzJSCLnd9hWiMgMqW9mJysViZ
         q6aQ==
X-Gm-Message-State: AOAM532vZjB3lBs6pz09r6mTZhd3+A+rlJQRu+3kDjrnEjeL2Z5G+k9o
        QOkqouDFwoIXEqmcZB+WNng=
X-Google-Smtp-Source: ABdhPJykU5u3d/PSqbUfSBIHCI7wMOPjK0kTGhhrXnoTs+pr7YZi4FLWyDRwJrY+TNdVd5Qu1JUYlg==
X-Received: by 2002:a65:67c1:0:b0:3fd:ebd6:5dab with SMTP id b1-20020a6567c1000000b003fdebd65dabmr30448557pgs.75.1655118769299;
        Mon, 13 Jun 2022 04:12:49 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-72-115-109.emome-ip.hinet.net. [42.72.115.109])
        by smtp.gmail.com with ESMTPSA id g17-20020a056a000b9100b0051b4e53c487sm5199989pfj.45.2022.06.13.04.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 04:12:49 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, matthias.bgg@gmail.com,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com, ChiYuan Huang <cy_huang@richtek.com>
Subject: [PATCH v2 01/15] dt-bindings: usb: Add Mediatek MT6370 TCPC
Date:   Mon, 13 Jun 2022 19:11:32 +0800
Message-Id: <20220613111146.25221-2-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613111146.25221-1-peterwu.pub@gmail.com>
References: <20220613111146.25221-1-peterwu.pub@gmail.com>
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

From: ChiYuan Huang <cy_huang@richtek.com>

Add Mediatek MT6370 TCPC binding documentation.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml    | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 000000000000..aa083e92bbba
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/mediatek,mt6370-tcpc.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Mediatek MT6370 Type-C Port Switch and Power Delivery controller
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  Mediatek MT6370 is a multi-functional device.
+  It integrates charger, ADC, flash, RGB indicators,
+  regulators (DSV/VIBLDO), and TypeC Port Switch with Power Delivery controller.
+  This document only describes MT6370 Type-C Port Switch and
+  Power Delivery controller.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt6370-tcpc
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+additionalProperties: false
+
+required:
+  - compatible
+  - interrupts
-- 
2.25.1

