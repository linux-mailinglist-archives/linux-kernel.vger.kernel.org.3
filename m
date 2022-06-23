Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D7A557931
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiFWL5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiFWL5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:14 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948184D275;
        Thu, 23 Jun 2022 04:57:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so2327896pjl.5;
        Thu, 23 Jun 2022 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KWYF04Kqw/g4GpFzDDseOqLX9HJqf5t7pZ43NwlDoRA=;
        b=N5Hi5lrJAUTF0QYRvC+Vqjsc/CENQ8/vU32++suooWGaiWmvY8gbq+ONwaRZCfg7ON
         TdMsw6zCQH9SzXm+hWu52Mx64xIN4XHBtJiyimH3SgCUj0lXRprJ/hTjX/2H2XyI+/He
         5OnCLnAaHoLzhxuQtr4VQC6JTIhU//UpdZFT3MQtHvq7JBIe9ik7y2gOYgy0m37/4dIJ
         9P5lhTR+Y9ZHJ0qzpzRIZHMDFCFop2d3OrRjJEbcjoXNku14JU3eyaxNgeJ/bNOiFvq4
         b/mw5lrHnUUGX7OHn6QT8rzo/sGT7I6x7GXvIX9Nd0Zv0K73yxLH9uWI3y6vfZ8OhaJ6
         7CWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KWYF04Kqw/g4GpFzDDseOqLX9HJqf5t7pZ43NwlDoRA=;
        b=lhGPF56mTLkzGhYvSP96K9/x3fUKhd3Dp29zsohFLYsL7nbV+8WsXFSFBcRYi5832h
         QxRmydeZ9kB49ysCC8lrrlpNDQeshDpsB8IqxHQBAwDVQv785QZD3cyG6zOOwUOFvW1X
         H7rQKyOVcxK23dJ0eCcYPSpxQUfK2QVSAwUsi021owYXCNzS/PKmmK5ak39hnQjV+kF5
         cudEc/uzUr/BpBJub5o9p/F3rjppyUB3yvgwCOPq5Q+NYMKBRRflhGpeVwNJl0gJ93Ef
         ALPCT/tIf+ZCCgJU4VWgygcA2n5uEXdcrl7eD2llnglssFQA4efivzg4biSwrZlYMuS5
         zLPg==
X-Gm-Message-State: AJIora8ZSXET5h6qhaL7N7JqaSgkMgvGzWVCvQadj2DT/82eCHAKCEm9
        +X/7YXqt8TP9ATeRcvJ+TfE=
X-Google-Smtp-Source: AGRyM1sqZrTGobn9nD9LkUqiSOOr584dAD1/Q4aTGEiE04urNhRGv1JMtSnofC8JHWzGr0UvWgloQQ==
X-Received: by 2002:a17:902:8a91:b0:168:e74b:1056 with SMTP id p17-20020a1709028a9100b00168e74b1056mr38061696plo.16.1655985431136;
        Thu, 23 Jun 2022 04:57:11 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:57:10 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 01/14] dt-bindings: usb: Add Mediatek MT6370 TCPC
Date:   Thu, 23 Jun 2022 19:56:18 +0800
Message-Id: <20220623115631.22209-2-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/usb/mediatek,mt6370-tcpc.yaml         | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml

diff --git a/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml b/Documentation/devicetree/bindings/usb/mediatek,mt6370-tcpc.yaml
new file mode 100644
index 0000000..aa083e9
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
2.7.4

