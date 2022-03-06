Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A36E4CEACB
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiCFLNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:13:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbiCFLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:45 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317B2606E5
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:53 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 505473F60D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565100;
        bh=lf3L+0o9CMSrEd/gKJSlHCZX7vz5FnWuL1aM1XjlPVQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=J1THvrZYUvPmdS1vOqxHdr8hyySTKa679+xacMDyJdfDVhvXIlS+ezxsv51VFbw0j
         NskXMbKer5FrFR4gjJanP6z2C1OkKCD5+l6GTsNLEBav3yDh61AFLzaT3DmFnN6hpg
         l4iZs/AYwzulCKiT4Qqw5A6vcjrae9JDqBCxZ0SuA2RFO/dmlRlyc+R1bGTo9t2Dxf
         BBavFPu+1d73Xgc/H/r5h8+WUkB6pacY5j+GSeU7d7o6LErtNj3QamKqQMYcAmhwbD
         ZyYQAe2Hfrvi73kf5nJEiQjLH2F5jKzUEyVIKLUPBJ2B0aY2U76NVTznMAxouLYSa9
         DUOo0OUlzoQDQ==
Received: by mail-ed1-f70.google.com with SMTP id n11-20020a50cc4b000000b00415e939bf9eso4588421edi.22
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lf3L+0o9CMSrEd/gKJSlHCZX7vz5FnWuL1aM1XjlPVQ=;
        b=JiIXUZ8JbdsTz8HCsOHiKxbdLDnCzbXPhtq/rqPJd/p+CY4wwK6jBM44hWKhscZWbn
         UekjIee468VJ15U86VBLdJXjDdBXhTb890v/vStMcKY9wm2fw5l8VAQFsU75WWZBBo/D
         SXX/NSypXE5rBnZG/TGoRbJCQ1Erb6tdXfUV6pgduifI8yRsNtMbcgYL01XyZvwF7/Rn
         O5en6y2oV57VAod3jkShYiXP1dbgrEdrJHh379WVegT7FD3E07gIMdjpKAnS9bfLD/wL
         Ay56h0Gjm8Cwm8IG6OAGEb0OfxCfqlhVxyTdf0oWVjUUZV5aeMXFyU5b2CcDZWWuuLkL
         k0gQ==
X-Gm-Message-State: AOAM531WIAT4VoyKgvX1c7wohpsV8WD9vEJR1Fn1mQDyaHsYAwB65OSM
        QZq43D9JuF9WhhwPH3SbGlaM6bdD9YOOWkSGxCDsKUcyvfnxgzJk7votgCWxWsRaGybnPERLMFe
        31xA7z9IcmZmiW61PJvh9C9TGMJVrNfgVnVaNt/HL7w==
X-Received: by 2002:a05:6402:d0d:b0:416:1d69:f23b with SMTP id eb13-20020a0564020d0d00b004161d69f23bmr6273185edb.141.1646565091334;
        Sun, 06 Mar 2022 03:11:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwZtXPDKuzvvxfR2qyr8z+IQLrONJ/y+63x3Fbz/V1C7LxKea28+CanHlFXHMdCVOY2o4Xmiw==
X-Received: by 2002:a05:6402:d0d:b0:416:1d69:f23b with SMTP id eb13-20020a0564020d0d00b004161d69f23bmr6273165edb.141.1646565091125;
        Sun, 06 Mar 2022 03:11:31 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wei Xu <xuwei5@hisilicon.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jan Kotas <jank@cadence.com>, Li Wei <liwei213@huawei.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-scsi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 01/12] dt-bindings: ufs: add common platform bindings
Date:   Sun,  6 Mar 2022 12:11:14 +0100
Message-Id: <20220306111125.116455-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
References: <20220306111125.116455-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for common parts (platform) of Universal Flash Storage
(UFS) Host Controllers in dtschema format.

Include also the bindings directory in the UFS maintainers entry.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../devicetree/bindings/ufs/ufs-common.yaml   | 82 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/ufs/ufs-common.yaml

diff --git a/Documentation/devicetree/bindings/ufs/ufs-common.yaml b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
new file mode 100644
index 000000000000..47a4e9e1a775
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/ufs-common.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/ufs-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common properties for Universal Flash Storage (UFS) Host Controllers
+
+maintainers:
+  - Alim Akhtar <alim.akhtar@samsung.com>
+  - Avri Altman <avri.altman@wdc.com>
+
+properties:
+  clocks: true
+
+  clock-names: true
+
+  freq-table-hz:
+    items:
+      items:
+        - description: Minimum frequency for given clock in Hz
+        - description: Maximum frequency for given clock in Hz
+    description: |
+      Array of <min max> operating frequencies in Hz stored in the same order
+      as the clocks property. If this property is not defined or a value in the
+      array is "0" then it is assumed that the frequency is set by the parent
+      clock or a fixed rate clock source.
+
+  interrupts:
+    maxItems: 1
+
+  lanes-per-direction:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+    default: 2
+    description:
+      Number of lanes available per direction.  Note that it is assume same
+      number of lanes is used both directions at once.
+
+  vdd-hba-supply:
+    description:
+      Phandle to UFS host controller supply regulator node.
+
+  vcc-supply:
+    description:
+      Phandle to VCC supply regulator node.
+
+  vccq-supply:
+    description:
+      Phandle to VCCQ supply regulator node.
+
+  vccq2-supply:
+    description:
+      Phandle to VCCQ2 supply regulator node.
+
+  vcc-supply-1p8:
+    type: boolean
+    description:
+      For embedded UFS devices, valid VCC range is 1.7-1.95V or 2.7-3.6V. This
+      boolean property when set, specifies to use low voltage range of
+      1.7-1.95V. Note for external UFS cards this property is invalid and valid
+      VCC range is always 2.7-3.6V.
+
+  vcc-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCC supply.
+
+  vccq-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCCQ supply.
+
+  vccq2-max-microamp:
+    description:
+      Specifies max. load that can be drawn from VCCQ2 supply.
+
+dependencies:
+  freq-table-hz: [ 'clocks' ]
+
+required:
+  - interrupts
+
+additionalProperties: true
diff --git a/MAINTAINERS b/MAINTAINERS
index d7ea92ce1b1d..ef16268b6ca6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20100,6 +20100,7 @@ R:	Alim Akhtar <alim.akhtar@samsung.com>
 R:	Avri Altman <avri.altman@wdc.com>
 L:	linux-scsi@vger.kernel.org
 S:	Supported
+F:	Documentation/devicetree/bindings/ufs/
 F:	Documentation/scsi/ufs.rst
 F:	drivers/scsi/ufs/
 
-- 
2.32.0

