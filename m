Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEE256646A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGEH5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbiGEH5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:57:00 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896D13D74
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 00:56:58 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u12-20020a05600c210c00b003a02b16d2b8so6796588wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 00:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6b5YvPP6Cm40ZHiN9lWJqY1BKAIBQa8OhFlxO39IAZI=;
        b=gP5wyRaik5C0Bjp8IpFbJIrMLOKs8yPVyFoIC42ZhaAjw9hbxpQaNPA6lwZH/hBMMR
         Az65dtQPZvxgKhuFZAewgXi4f3rJH6dyxYi6BBEgm7qh2Cz9WwuwBdLMDl1wrG9CP16B
         De60OBUbiyPKd9GnYvzAMQ+gAFmXVFzUbLKGx+kL5oy931YQsYHcsgf1uL+qse8VdlyC
         9vb30Wz3+t94By/y3yfcb3Wd/LWhq71v4N8NJBhKlHEkFExBz0anPACZMLfl/7139uTl
         rrZc+Huh/mbAFyhHO8OB5ogxAzNEoIX3RDYTnHQDd/uoCIP7Yev8tgOL8uu1dqz3cooA
         wQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6b5YvPP6Cm40ZHiN9lWJqY1BKAIBQa8OhFlxO39IAZI=;
        b=QzQrkPYC5JkWsLwwpMWe99eAzJNzGFgha2jKahu+CFeLcV+4qrG9Adhk92G7mmpcC/
         fvMviv4EMm7OcpsSdE4F4PQEyv+pQ+d5xCo5oSs7Nr7Clj0nq3MUlkEA08YqP6RnGINC
         q+H5ZlVvgHHN3/bAb44CMszIz6fc2UW0VSzvjwOlX+9rfZYPoxvslH7eopWuHGLsTf5o
         /zN8TIuJOdEyi4Otq3CLnb6F4uGCwTEjDwb+vi+O4Y6lubBmvqUeZz5hYOOMcPNTJcYN
         tfqmGMzJEYx2wGtByuG25EdCbkcTN9cXG5tVPPhnmCrRDY5QD5vw5SQQze8uCBfmi+Zy
         mQ4A==
X-Gm-Message-State: AJIora++MxQrws9DdUOjvqmmMidHm+nSjb2tN9ZqMUK3R3pAc1/L4zU3
        21K+BfVWXa2MeSfsjGc5oKpyxQ==
X-Google-Smtp-Source: AGRyM1uMxsAd5+tDhIMxilNng66yioFL7S4YFsUh8CVh5sqh2ZnJ1n8jfi26E8hTZse1QgEQddWSEQ==
X-Received: by 2002:a05:600c:3ac3:b0:3a0:45b6:7efb with SMTP id d3-20020a05600c3ac300b003a045b67efbmr36527404wms.183.1657007817253;
        Tue, 05 Jul 2022 00:56:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3c4f:78be:dc90:14f9])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d5911000000b0021bbdc3375fsm8323473wrd.68.2022.07.05.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 00:56:56 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v5 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
Date:   Tue,  5 Jul 2022 09:56:49 +0200
Message-Id: <20220705075650.3165348-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220705075650.3165348-1-narmstrong@baylibre.com>
References: <20220705075650.3165348-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1543; h=from:subject; bh=iOBx9fr8HbPBX94EGJGOKU8CqvBCi3FrRoD0vFQxImA=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBiw+6hxEXENvi29/8PBCp5BxvMDA7bv97mLUSzbfas Q+zBXg+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYsPuoQAKCRB33NvayMhJ0ZxbD/ 9ABJc/gmqqibXPvDP7CwOXJs8Lwvf9rKLthCjcc6dMMYJ5jtc56LQggDPLxJwdGFXud+5OHshvoz9c uIm3aXTBe4BA+/C0FO+yKgtqV9BXUecjOQIbWCpfsJc8sC/qvo/oiKDnbzQKYTnOR2gKZO1dntpg8k PXjYR0wnPyCW9baVjL/8BJw0LLOpteulqtPK4ji36GoTIGKqhoLHLbDi+wDfxDFRnB294cdlv5KDxn z3EG5QKI7cWJBCfKVSmb3H0A39yzcWr+04v8+vxhraEtePgfWteL5AINR+CW0kzYZzTxJ1348TekIT 7YlmyuaRwpq69CArNMwHv65oIWV1cyV8ttNO7SKWJL0cL79Ck9NHnEdDJ98DvmQkNhVEJhRfYXE7ak O64wonKAv86sM77DSkXmT8m6Req/mvqQREyKbrg5tmbJ2Ju8Z/YWb4UvA4N+5mcTB8+HTWKFQvZZwW Ahm+3m55tagtDZRslRtOVG6Z/kGIT5l43OdYL4mX1qHkiUMixOwJLZxyMX263tPpEfSwguMJYDoZuk U1BJa/Dz9jwHSSZhQTr8YCfqj+kTkIlfsoEaateRbo7gj7mluDJftuWlOb1zp79ZOspLLX+vZrb5BC V0P+LpUwBeb3iHbui/gfMcw7y9JDbkDoTygn+LcYXLgUfHux4BoJMu1OYTIw==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This Analog D-PHY works with a separate Digital MIPI D-PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
new file mode 100644
index 000000000000..7aa0c05d6ce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic G12A MIPI analog PHY
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    const: amlogic,g12a-mipi-dphy-analog
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@0 {
+          compatible = "amlogic,g12a-mipi-dphy-analog";
+          reg = <0x0 0xc>;
+          #phy-cells = <0>;
+    };
-- 
2.25.1

