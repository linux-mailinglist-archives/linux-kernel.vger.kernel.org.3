Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E60850289C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352570AbiDOLC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 07:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352543AbiDOLCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 07:02:55 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FC191341;
        Fri, 15 Apr 2022 04:00:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id bi26so13540822lfb.2;
        Fri, 15 Apr 2022 04:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=PJPPb5ZuC8V3lOmHXIx64Vu5AmRc/Jp/EignkCeVcb9Ei9gdeesylm8kWLTE2yVj9F
         9UIB0oUm2Lv7M+NB73NnSFEVRowcsCN+xyomxKD36poYdvv6a5FMknqJaBA6bO07i7P1
         ILTh1279oStf73WDp7uUxVTdIlvq0k32UwL6kX1KmmPVH3Ztxet06LDgaLQhfhHEHMp0
         vCZaG2vPII3erfc6nDnaa5JyM70eUkvvSYKjDaIk/NRMhJDJVa04z/p58jF+OBaQWLIp
         w9uMGPSmTRetT038ZWmgvCimc6aCh3dlxHG/a/tE1YqP3mjisR1RU/jbIiBFuv2yIGgC
         Y3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=MHwDjsBdnf6PM/nObueFtjUV8ikKm0zYjbWDjmV8I62hX8/NJEdMP4S5te8CMYooyk
         v3z5ik3VoV3d262cnqFpWve+LqT4bWlIgy7NxctAajL7gMNkTpl6YVR8ZsJVZqHFmLF2
         2TiKvDGlWj+VK7XMLN/oJHIJJPpV/gXaOfCJPrpL9EKdnge6aOFbOA+roT9eXmBc5CTg
         AT8aIpis/LaXEc+IfDagPzGX9Ug4on3J2pMJaSKGCLi68kKKxT7pN1kcHZzH6Uk071TL
         FfD75CWNwYINWxAX8SV8wLJC/dXrIS4/Yn+9sW++CLt8AGU9AcXR0s6ZtCmqcW/+eDPU
         tNPg==
X-Gm-Message-State: AOAM532rOQ2DmaKU00ndEQeSPKaxJktvCk2R+QVj6wWsO9589Tm7RGlX
        UEKP3viGfTGbfLJq3WgAtHsNf5zH2KY=
X-Google-Smtp-Source: ABdhPJxXbhv9aIrRqoXY27+EgsCEXZzkjxj3rSJZ8gmlX6W403cjBG96eoG/q518yYQ3QntC1knwvA==
X-Received: by 2002:ac2:4e70:0:b0:44a:866e:605f with SMTP id y16-20020ac24e70000000b0044a866e605fmr4774279lfs.678.1650020424732;
        Fri, 15 Apr 2022 04:00:24 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id q14-20020a0565123a8e00b0044a7b26ae1dsm292341lfu.109.2022.04.15.04.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 04:00:24 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Fri, 15 Apr 2022 14:00:10 +0300
Message-Id: <20220415110014.7384-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415110014.7384-1-markuss.broks@gmail.com>
References: <20220415110014.7384-1-markuss.broks@gmail.com>
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

