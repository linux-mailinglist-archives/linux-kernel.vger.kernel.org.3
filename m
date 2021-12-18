Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9D479C1E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbhLRSqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:46:24 -0500
Received: from ixit.cz ([94.230.151.217]:42022 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232070AbhLRSqX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:46:23 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 0F9962243C;
        Sat, 18 Dec 2021 19:46:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639853181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yba2jSXF7AIHzB99hdJZuJUeURVQ+t6t49LZe+mzb3c=;
        b=19Yl1KPYCL2Jbe4zJe8iuF00DNADDffGrf4s/L8ZRIWzl6aCaY7q5RjKrtitFZhPj492Fs
        QsKpcePBNbJa1UW1TpeRFhe2kg4RL77NQxzN/g+a7hGCTaMShHyp4Zww4/GQqdKOOvxvMG
        81iNiySrAGtQ/DznNkDd7jjpaNw/P5U=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-binding: soc: qcom: convert Qualcomm Command DB documentation to yaml
Date:   Sat, 18 Dec 2021 19:46:16 +0100
Message-Id: <20211218184617.19923-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm Command DB documentation into yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 .../bindings/reserved-memory/qcom,cmd-db.txt  | 37 ---------------
 .../bindings/reserved-memory/qcom,cmd-db.yaml | 46 +++++++++++++++++++
 2 files changed, 46 insertions(+), 37 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
deleted file mode 100644
index 68395530c0a5..000000000000
--- a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Command DB
----------
-
-Command DB is a database that provides a mapping between resource key and the
-resource address for a system resource managed by a remote processor. The data
-is stored in a shared memory region and is loaded by the remote processor.
-
-Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
-controlling shared resources. Depending on the board configuration the shared
-resource properties may change. These properties are dynamically probed by the
-remote processor and made available in the shared memory.
-
-The bindings for Command DB is specified in the reserved-memory section in
-devicetree. The devicetree representation of the command DB driver should be:
-
-Properties:
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: Should be "qcom,cmd-db"
-
-- reg:
-	Usage: required
-	Value type: <prop encoded array>
-	Definition: The register address that points to the actual location of
-		    the Command DB in memory.
-
-Example:
-
-	reserved-memory {
-		[...]
-		reserved-memory@85fe0000 {
-			reg = <0x0 0x85fe0000 0x0 0x20000>;
-			compatible = "qcom,cmd-db";
-			no-map;
-		};
-	};
diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
new file mode 100644
index 000000000000..fa5cd6a77634
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/qcom,cmd-db.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/reserved-memory/qcom,cmd-db.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Command DB
+
+description: |
+  Command DB is a database that provides a mapping between resource key and the
+  resource address for a system resource managed by a remote processor. The data
+  is stored in a shared memory region and is loaded by the remote processor.
+
+  Some of the Qualcomm Technologies Inc SoC's have hardware accelerators for
+  controlling shared resources. Depending on the board configuration the shared
+  resource properties may change. These properties are dynamically probed by the
+  remote processor and made available in the shared memory.
+
+maintainers:
+  - Mahesh Sivasubramanian <msivasub@codeaurora.org>
+
+allOf:
+  - $ref: "reserved-memory.yaml"
+
+properties:
+  compatible:
+    const: qcom,cmd-db
+
+required:
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        reserved-memory@85fe0000 {
+            reg = <0x85fe0000 0x20000>;
+            compatible = "qcom,cmd-db";
+            no-map;
+        };
+    };
-- 
2.34.1

