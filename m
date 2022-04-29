Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13A51485A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358585AbiD2LnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbiD2LnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:43:12 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27221C6671;
        Fri, 29 Apr 2022 04:39:54 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id y19so10180697ljd.4;
        Fri, 29 Apr 2022 04:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qf3Gnh0r/kH14MrLVG6iizA1sf1487qOGLkcc43P0Os=;
        b=eR7O1MdIebnFj/Ml1zaxjL6DtmxxNFs71Suhqc/MESprUhT4GvoW/kWqjAoSoQJ45F
         y8i++NF841lIoNyIROqh/4dmZS7WJT8UL8Xs30lUixnsXqvcmeWjaRsgmetNVXSrji/X
         gSZnWf9mbdrTBFt0y5hBR5DyZT6TL5aD0vZXUt4geDCGTf9qfYbh8DCybGMW0vRCiVoh
         zDjxEsMK8rocGKJxs1Mud1dFZc784/f8QPPiABKHTXZr8K5Jzukir2q4p1FHuOQIRPpi
         RUFNI+ccskbIehnBa5lbqUmx1GICY3elF6ltEXMKS5E6kU8Vax2P3VIsItLf3xugp7/U
         gx7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qf3Gnh0r/kH14MrLVG6iizA1sf1487qOGLkcc43P0Os=;
        b=eZBDutbVUq718a8rPaStGzjPQ1pf4K3oroVNe5+UF3VtGsnbTGcIIZs7eAzdJTrbOs
         mDvxp1SP0M+V8RdzbAmMDAwqGGBOflH7pVK+wJEpY5MpzyACxpOtQ3lnu1cCYdJrCgm5
         5tNl//sr0YLXgAD3Bnj3KJP5wXxjeQxSGFytNGK8XL1uKvwUAXnc1GLyt8/okz12dJx/
         XQ4wJXldkDoiU1M54bZhksioe9LoxN879Aqxl8dB6eChf6cgdTLXVAd7+f9rA17HwxeU
         5yc8HW8V0E07emBhTMOiCcNwfWMLelLfISOYXVURb/aYrxoi5aFDoFEp4tBbqmONLpkw
         hQ4A==
X-Gm-Message-State: AOAM533aALrR/NLqj2PqdA0+YjmhVjeAXbGwowgeLHUnrKgpFiCWBo7B
        Nc/tEmVna/HNXxiVXpMUwDNsIlhkyrI=
X-Google-Smtp-Source: ABdhPJyThILU8UMBSTIwKqMzBbYfwpw3i6vwhnHKLBh8cvkaHw2tWxAsInu8dLWhofJz1A8TvMkjBA==
X-Received: by 2002:a2e:a604:0:b0:24f:d33:6d7a with SMTP id v4-20020a2ea604000000b0024f0d336d7amr19272898ljp.117.1651232392220;
        Fri, 29 Apr 2022 04:39:52 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id v3-20020a196103000000b00472030b7f61sm217972lfb.270.2022.04.29.04.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:39:51 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v6 2/5] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Fri, 29 Apr 2022 14:39:25 +0300
Message-Id: <20220429113927.5145-1-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree bindings for regulators on Silicon Mitus
SM5703 MFD.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 .../siliconmitus,sm5703-regulator.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
new file mode 100644
index 000000000000..9d84117530ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
@@ -0,0 +1,49 @@
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
+  buck:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for the BUCK regulator.
+
+  vbus:
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for the VBUS regulator.
+
+patternProperties:
+  "^ldo[1-3]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator.
+
+  "^usbldo[1-2]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for a single USBLDO regulator.
+
+additionalProperties: false
-- 
2.35.1

