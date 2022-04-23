Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1EA50C85E
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 10:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiDWI5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 04:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbiDWI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 04:57:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4163203F7E;
        Sat, 23 Apr 2022 01:54:04 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id v4so65936ljd.10;
        Sat, 23 Apr 2022 01:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U+PN+GS0JECobt4d/ZN0bjvHqce0oNxs21CYm6No/tg=;
        b=j6BV+kWRL50dp4o5PLZRatbctyGekm6+QIrvMrBeksJYLLBx7OLhNmZYGDQsXsZ7mI
         B0UmHvIt2QSs7TyNZs4QkMGr6K2Pame2tQZtJBje2ZLYA8jUCph7OTP+nJc6g3zt0Dfg
         RmD3I3rs83kO9KIQn2ywUpTJpFeLdKtzjrQHc7og3aelNmgRmzxTMwrXO2aPr+vXc45K
         rDv/kGI316B+Qb2M4kI9CSpSNsrus73rDbr8KyWLj1w6kKM8RKNFRwbeowE7XWowSQVL
         p0doE1/b45THAJ1cs+l/k+NvP64cJISv6jdG4f4u/12gObntYtHPbIGRSLEb0BpbHchb
         m2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+PN+GS0JECobt4d/ZN0bjvHqce0oNxs21CYm6No/tg=;
        b=1Gotm+NCnh0dfhFYyVhMDJGhGxtc7NzTrfNJCpS8MXspeTUD7z10NsZ1OHFj4xLdov
         t9SwXWeNE+SHowLbDKLZgLj9ImyZChJVt9u5oyvhqC/vrakSrNJh4SS0lsAkBxSwajTa
         QgNS6gnI8AIckbEylbeupZAvvuVzr1iOxV4rKVWhIQ1Q/X0hYHVClZqHoijMvspVGSM8
         x7BcelBzBEQ2Lb7tLUF3g5x6/+FDs0fgrJsjXcisx4QJiJm4AzUYGlw/BeO+YbTP4jc4
         hVXVMFvQnPYfNfpVPXT2vwNIsWILhD3ZwalCOUiNF+IAWQl5rjL2t+l+UvILPHF8TEds
         tYDA==
X-Gm-Message-State: AOAM533njiL6YUa8jSS/1QZSP4pf6PXcW3SjSmOqvimlqqCdskRcR4eF
        sQdz0Kh1Jn/yJvd+TWrBOLWARcFo4Dg=
X-Google-Smtp-Source: ABdhPJzeA3FiRVvgK9aiKYPHx0tcuKZk8FzerCkkas+mLlgkeL/JUhxTfXkGPOskNODXkVeX9HVexQ==
X-Received: by 2002:a2e:bc05:0:b0:24b:212d:7521 with SMTP id b5-20020a2ebc05000000b0024b212d7521mr5083134ljf.243.1650704042927;
        Sat, 23 Apr 2022 01:54:02 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id p25-20020a2e9a99000000b0024dc3ccff47sm493677lji.32.2022.04.23.01.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 01:54:02 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v5 2/5] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Sat, 23 Apr 2022 11:53:15 +0300
Message-Id: <20220423085319.483524-3-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220423085319.483524-1-markuss.broks@gmail.com>
References: <20220423085319.483524-1-markuss.broks@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
index 000000000000..75ff16b58000
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
+    $ref: regulators.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for the BUCK regulator.
+
+  vbus:
+    type: object
+    $ref: regulators.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for the VBUS regulator.
+
+patternProperties:
+  "^ldo[1-3]$":
+    type: object
+    $ref: regulators.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator.
+
+  "^usbldo[1-2]$":
+    type: object
+    $ref: regulators.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for a single USBLDO regulator.
+
+additionalProperties: false
-- 
2.35.1

