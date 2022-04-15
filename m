Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F6D502DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355943AbiDOQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355917AbiDOQqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:37 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDDED5EA4;
        Fri, 15 Apr 2022 09:44:08 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so10069965lji.1;
        Fri, 15 Apr 2022 09:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=Am27YhT/YQqKjARXR7UdZ55vxftUnAqRTESqB3PFnTudWku9ohh7f5BSNnI2F+mX14
         BICwtF9+gFnQBTq2i15BwmwZ2iyYKXgMo2vup92dIUfiz7kG3M/kER+nSY2/GUzLxtek
         zmxxFrhPwrzB3TktO8i4bt+cFPcsmVIBGpeORHWwRIS/6LbCW/nAqWWGYUDiwJFrlO0C
         oC6tnjp2bOJGu7z1sjyC5h37WAUa6CpwbaHPSNoQmUElwovvJFMiXcLnzhVoAjcEWgUk
         5MJw8vPZp4+Ptk5ZfardaLKMURaMSl9WdBSBULni46EIP9SZhlX4UP0fZgAcI7KuLPd6
         9UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=bjGGj+RGjloDD2xJb0mboUp85MH2yLS9jTkx1Ruh8pEIiTEfBLN8YITRM+B2hvuTQu
         oXrA+nTp8OES5afSEzt3w/mxnTN7ZoLtcPIPCbVZCMZf3vTQc8RLCPMbjDnL/u0pxnuA
         sCqRy3i+2U9pFToh+eyHMTrQ6wKBXdGpPeVHq3zRiZad+Bhg0JZ/8n9DjTcqXBXsaBzu
         QduKcwTtBnSTGhCpWd8SGucc6mh6N4DHuY5A4cwjjqBSKjCAYXzZgMnzFXLvSmZ0HIuk
         BOLW9xViQq0+0N02ekf11P/VHSFx3dHOmD8qijHjQpZqfUgr+ua8QnxEv0krbJTjjxat
         5AoA==
X-Gm-Message-State: AOAM533pJka9EZtPUyXef8zV0NROFuNYu8joWJ+hmEzWvB826TA3Rd7y
        viq4PBY3x4U6TvgA1XNjHy5U88yazZ0=
X-Google-Smtp-Source: ABdhPJz+663bzdYOZPIjEOwBExZPKIh/PxIf2H/+8Nit73dxPsOh5gXd8myuiDf02oeXqjGVMqpZYw==
X-Received: by 2002:a2e:9e81:0:b0:24b:4d4:aba0 with SMTP id f1-20020a2e9e81000000b0024b04d4aba0mr2211ljk.283.1650041046777;
        Fri, 15 Apr 2022 09:44:06 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id h22-20020a056512339600b0046bc4ceaeb6sm383787lfg.27.2022.04.15.09.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 09:44:06 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 1/4] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Fri, 15 Apr 2022 19:43:52 +0300
Message-Id: <20220415164356.25165-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415164356.25165-1-markuss.broks@gmail.com>
References: <20220415164356.25165-1-markuss.broks@gmail.com>
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

This patch adds device-tree bindings for regulators on Silicon Mitus
SM5703 MFD.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../siliconmitus,sm5703-regulator.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
new file mode 100644
index 000000000000..560df4c020ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/siliconmitus,sm5703-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Mitus SM5703 multi function device regulators
+
+maintainers:
+  - Markuss Broks <markuss.broks@gmail.com>
+
+description: |
+  SM5703 regulators node should be a sub node of the SM5703 MFD node. See SM5703 MFD
+  bindings at Documentation/devicetree/bindings/mfd/siliconmitus,sm5703.yaml
+  Regulator nodes should be named as USBLDO_<number>, BUCK, VBUS, LDO_<number>.
+  The definition for each of these nodes is defined using the standard
+  binding for regulators at Documentation/devicetree/bindings/regulator/regulator.txt.
+
+properties:
+  compatible:
+    const: siliconmitus,sm5703-regulator
+
+  buck:
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for the BUCK regulator.
+
+  vbus:
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for the VBUS regulator.
+
+patternProperties:
+  "^ldo[1-3]$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for single LDO regulator.
+
+  "^usbldo[1-2]$":
+    type: object
+    $ref: regulator.yaml#
+    description:
+      Properties for a single USBLDO regulator.
+
+additionalProperties: false
-- 
2.35.1

