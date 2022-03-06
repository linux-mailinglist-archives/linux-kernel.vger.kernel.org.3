Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728654CEAD2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 12:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbiCFLNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 06:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiCFLMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 06:12:41 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AD8606FC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 03:11:48 -0800 (PST)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6792E3F618
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 11:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646565104;
        bh=ooKaXowXEnZxahywb1wfZAg4AWHbsKObfN/Ew6XXXRw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=CYAL3c9OR83dR1iSTmPPvbJoSDq00AGhziySAgS+TTuVXcaKvQZfwWHhb7i+dBcX8
         XbPDikj5PEcsB9HcfvPT5EiFwIKn1OUXomh9oZKtdRB+PtEuRD2zQY2CUXq/cp2xY6
         mEiM1OdzOlSN5ECR/VI9ZqA/djFjJwLFaf8a5Zlg6qm37HGnmHHBQ5FN2iTXVMdTo2
         0mj1pcCwXShuj1A7cZKy8uwfudDGmSMkUECgmo2pgVQF4YINiVHLUx9y70J5A94TMO
         sXjtEhJaz8Hs28j2FF5KTWg8orHTK/iMVj1JQlsBWTHs25G3YotRzJc9H1cX9Im3DS
         4LgWxggIGdT3Q==
Received: by mail-ed1-f69.google.com with SMTP id bq19-20020a056402215300b0040f276105a4so6768341edb.2
        for <linux-kernel@vger.kernel.org>; Sun, 06 Mar 2022 03:11:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ooKaXowXEnZxahywb1wfZAg4AWHbsKObfN/Ew6XXXRw=;
        b=mpmPp5zdBNjRPzY70M4QrSNKinHkBnRwhaa6x1ChAF7MKUtE2xbp9O5DR9RD88GsC4
         mUOJSvV4CG2GdCi4EVUS4tiHM5uo2t8ll5ctwjtxOGKJuL2CUifsp6E6/xGolbeo88iI
         2zTChO+GrioMXMt8dgaKV+CEB5G/xNBMqybJ4qzjaLBVnCNsC+iG2SLRCJkoRHi8YTOk
         yq1JSTlsjt7IjMC8URlalKrWf8gL6XSrVfvVU4GvNvlN1PXM56NQBR7N0NDtz2CtVMbW
         9IxaRdVYvk8q8CLdbkcm4Ez98ZsIO9KQuJODRi5NeEB1Qi8TtmkrHyZ9J2k5Oq50Mezm
         uzcw==
X-Gm-Message-State: AOAM5323E5R8BEW4Iqji1PCpNKHPuqbJSfoGtUnqesrE0BmicpJ4bHSq
        /faBDFfQLiv3BOKMc+tOCnWLmAI5uYmswXkIcXttu9JvTpPVqPnUFSxhjNfk6F4twfFS/jpItx2
        Yqk6F3/prZVdYznCVAVlTtxKa7NDWgCH7hUbL2SbrHA==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr5452650ejj.767.1646565103213;
        Sun, 06 Mar 2022 03:11:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ1ed4qzxBbYzHrlnD8XX/sT7klp5jhLS9V8sQLJhk1P830VQKhrTEknvYCZVGqRqW8eDEQg==
X-Received: by 2002:a17:906:1ec3:b0:6cf:d118:59e2 with SMTP id m3-20020a1709061ec300b006cfd11859e2mr5452623ejj.767.1646565102968;
        Sun, 06 Mar 2022 03:11:42 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id a9-20020a1709066d4900b006da888c3ef0sm3720444ejt.108.2022.03.06.03.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Mar 2022 03:11:42 -0800 (PST)
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
Cc:     Rob Herring <robh@kernel.org>
Subject: [PATCH v3 08/12] dt-bindings: ufs: snps,tc-dwc-g210: convert to dtschema
Date:   Sun,  6 Mar 2022 12:11:21 +0100
Message-Id: <20220306111125.116455-9-krzysztof.kozlowski@canonical.com>
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

Convert the Synopsys Universal Flash Storage (UFS) Controller to DT
schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/ufs/snps,tc-dwc-g210.yaml        | 51 +++++++++++++++++++
 .../bindings/ufs/tc-dwc-g210-pltfrm.txt       | 26 ----------
 2 files changed, 51 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
 delete mode 100644 Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt

diff --git a/Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml b/Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
new file mode 100644
index 000000000000..671a70d95138
--- /dev/null
+++ b/Documentation/devicetree/bindings/ufs/snps,tc-dwc-g210.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/ufs/snps,tc-dwc-g210.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys DesignWare Universal Flash Storage (UFS) Controller
+
+maintainers:
+  - Li Wei <liwei213@huawei.com>
+
+# Select only our matches, not all jedec,ufs
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - snps,dwc-ufshcd-1.40a
+  required:
+    - compatible
+
+allOf:
+  - $ref: ufs-common.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - snps,g210-tc-6.00-20bit
+          - snps,g210-tc-6.00-40bit
+      - const: snps,dwc-ufshcd-1.40a
+      - const: jedec,ufs-2.0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ufs@d0000000 {
+        compatible = "snps,g210-tc-6.00-40bit",
+                     "snps,dwc-ufshcd-1.40a",
+                     "jedec,ufs-2.0";
+        reg = <0xd0000000 0x10000>;
+        interrupts = <24>;
+    };
diff --git a/Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt b/Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
deleted file mode 100644
index 71c0777960e9..000000000000
--- a/Documentation/devicetree/bindings/ufs/tc-dwc-g210-pltfrm.txt
+++ /dev/null
@@ -1,26 +0,0 @@
-* Universal Flash Storage (UFS) DesignWare Host Controller
-
-DWC_UFS nodes are defined to describe on-chip UFS host controllers and MPHY.
-Each UFS controller instance should have its own node.
-
-Required properties:
-- compatible	: compatible list must contain the PHY type & version:
-			"snps,g210-tc-6.00-20bit"
-			"snps,g210-tc-6.00-40bit"
-		  complemented with the Controller IP version:
-			"snps,dwc-ufshcd-1.40a"
-		  complemented with the JEDEC version:
-			"jedec,ufs-1.1"
-			"jedec,ufs-2.0"
-
-- reg		: <registers mapping>
-- interrupts	: <interrupt mapping for UFS host controller IRQ>
-
-Example for a setup using a 1.40a DWC Controller with a 6.00 G210 40-bit TC:
-	dwc-ufs@d0000000 {
-		compatible = "snps,g210-tc-6.00-40bit",
-			     "snps,dwc-ufshcd-1.40a",
-			     "jedec,ufs-2.0";
-		reg = < 0xd0000000 0x10000 >;
-		interrupts = < 24 >;
-	};
-- 
2.32.0

