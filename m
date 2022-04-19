Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5E1507277
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354230AbiDSQEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354214AbiDSQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:03:57 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14A62E9F5;
        Tue, 19 Apr 2022 09:01:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so21143454lji.1;
        Tue, 19 Apr 2022 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFBsyQuHqlU/CZm7xcPsaJCJaO+7JVo6gg5hMfRKx4g=;
        b=hMxCBENOG8jL5pwFSK9fq0Z5vVD+/HwafWo+uqg9BoG1Ivt/Qf7Upub2jcngs+ufYw
         ys9QYpEWsrDc29GuuschUSNt5GquNx0ONSd0yO5HD66qYMzVW6K38nHYt5FPX5h29lMC
         MDB+fwkMVgUygK4CSkbC9siu8E0mDLg3gzItTxC2dH/q6CgA4Tfpi07K1v9N5hinn6gH
         s9mz2DEkpCON/DaRxySeG6D0Bp3ivbaqVOSvly3Xl0w1Y6iwkyX281Hm7FPDgft0Fha8
         k8ZhrClk4jwrQlLgM7SKRu0BCT7nWn0Ckcqhj0+m25UnfoJY+SyEyWI/1ornxzkASANa
         oDmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFBsyQuHqlU/CZm7xcPsaJCJaO+7JVo6gg5hMfRKx4g=;
        b=hG7Df0luViBZWhHdM3D1N+BuzzCECdm7FKf32I0bnBkO5dGQVz9PzVlogmnkn0umur
         /I0nWf4rBJha+KU1XnWJ0EECU9LaEF6WF3Q4lVjyNUOcwUhB6iFaOAvOYbCLtnJPBZb+
         V6rp6ucQK46eS7rYaQVra3AoSVbctHh0DgXcYj5PkaQIinK9lHHPrSxmkQqns0bBcGl5
         wRuy08NU7ov5aEhZKEkYtNzLBDGp0yJxf0mFp4x/QxM6LjDC73PrGPn+VlvGyLNQwraK
         P/jpq/SW70ZEC2+lafEvsYCMgd2HKqq+CPdOgPpAOuGh4YaKdUH5DQs4+tBAS7oMTLED
         tijQ==
X-Gm-Message-State: AOAM530OcwGhJp3XNk55M8wP5hDCmr8qL0XKwMxF6WvrD98ofEvfEwv1
        ztzA8Peq8QRc+GEoWpMfoQFI3vmJWvw=
X-Google-Smtp-Source: ABdhPJzbiC75qP9ddf47DsjMflKY7gME8Bhgq6eUO+O5Guo3Ytvn61Kx0k3nGTbtuz+yIin4XqC6GQ==
X-Received: by 2002:a2e:7f05:0:b0:24b:b6a:4e41 with SMTP id a5-20020a2e7f05000000b0024b0b6a4e41mr10377469ljd.210.1650384072887;
        Tue, 19 Apr 2022 09:01:12 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id m5-20020a194345000000b0046e951e34b3sm1506663lfj.24.2022.04.19.09.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 09:01:12 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 1/4] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Tue, 19 Apr 2022 19:00:54 +0300
Message-Id: <20220419160058.9998-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419160058.9998-1-markuss.broks@gmail.com>
References: <20220419160058.9998-1-markuss.broks@gmail.com>
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
 .../siliconmitus,sm5703-regulator.yaml        | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml

diff --git a/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
new file mode 100644
index 000000000000..a8ffd3ecf3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/siliconmitus,sm5703-regulator.yaml
@@ -0,0 +1,52 @@
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

