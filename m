Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922B15019CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbiDNRPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245335AbiDNRO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:14:28 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478E2AC;
        Thu, 14 Apr 2022 10:06:49 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k5so10195882lfg.9;
        Thu, 14 Apr 2022 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=bZgldF2lv9T9o0cFvCbfuIL7I+DP73WYYM4S6EjQIg6LjVtSHP7P0byYkiRAd2cp+a
         GvtiAbapLphNXb/3+ft2LkBakDeK/9N+gQbnnkSQ80PNkUwsxYOd5VSCAdDGBQN06f7S
         YMB1P2vlPtuwUTtk2Z1x3Y/7xf25kImU2bATt5Kv6wYQpb5Nbq3uoHIWAuD+uErFZx+t
         Ls8vVZhrGml2AAh1K/p2l+Y+jIc7H6umnvF39HxLRtmOGMUhhfPNymEET8RZQz7JTgUa
         tQwWw5O1cNT2gMY4yJOkYqgEZsEauS68Y1kTAWSjFMOnPiiWDDlK0SNRNjBEKvRQmRwS
         7NKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/92dgGLUolkAH3AU+1is8vSs4x9gInGUtOx7kaljC1s=;
        b=E49Hc2Wsm2Bfp6wF77Lf1UtzNDVzqPuwCZP44+IRi2mQz47QeSLuYn3X9GRl/L8EHi
         c2V78HG1g4m66zmVqpeeG55+9DTRslVwph3rbOVYWqs4GRcc/QBs296Y8XA0r44sVmMz
         nQiqHLw+tDCFnHkIjd33VvtiRf/tRxjhzQ9lncXsroSGPZmw1Bl/2f50pc5V9BZuydLY
         Dlo47B01rQjjJ3afo5ov8ymifNRB5BO+wSKgf9Q4LD29I1pi3a7u8Gpy/FR60vYKqFGR
         9r7HuqW5BhZdjHTtr+aKQDXz/NkZH1M4r/EF6RD5A7AMKuiAOLiKzc+AS+vVRkBpMCMI
         MliA==
X-Gm-Message-State: AOAM532o1QUHojakKaLQn3lwaWaLXU5gnchL+YtqTNYYrloSl69K/vCT
        gyFoBqWAz2B1+UJnyBtcB+36ypx/hWc=
X-Google-Smtp-Source: ABdhPJyqd6QiuzQgazxcAFLbvPElBxpHe4xypq/hljs6ZpZC+Vsc2yn8LOfXtmzSp8/HSn3ehEb90g==
X-Received: by 2002:a05:6512:ea3:b0:46d:103c:8a46 with SMTP id bi35-20020a0565120ea300b0046d103c8a46mr2414914lfb.221.1649956007830;
        Thu, 14 Apr 2022 10:06:47 -0700 (PDT)
Received: from nergzd-desktop.localdomain ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id x11-20020a056512046b00b0046bbe5d2eabsm52216lfd.75.2022.04.14.10.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:06:47 -0700 (PDT)
From:   Markuss Broks <markuss.broks@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Markuss Broks <markuss.broks@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: regulator: Add bindings for Silicon Mitus SM5703 regulators
Date:   Thu, 14 Apr 2022 20:06:12 +0300
Message-Id: <20220414170616.23319-2-markuss.broks@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414170616.23319-1-markuss.broks@gmail.com>
References: <20220414170616.23319-1-markuss.broks@gmail.com>
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

