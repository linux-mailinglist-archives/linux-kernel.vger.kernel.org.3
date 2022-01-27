Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0914E49E7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbiA0Qhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:37:52 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49797 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiA0Qhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:37:36 -0500
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 2F2D2223EA;
        Thu, 27 Jan 2022 17:37:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1643301454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S51ZapZnYq1k6n2qxYfSXh5MaRdNceh6NgrFguI6b6s=;
        b=am4VRjOnPRhCEqV8KcvKa3taiD2k+m8rnygSVEatXNpj/m7QbYsB1/h8l7FA9nguJ1tyKf
        p+kyoJjCAIXlTkuTdDD3l0Q2coCVKNgyszQjzjEaLSc/EW8iZQ9ABepUiqRHbdM2zIFlGD
        M1gjAl+9YccVsgwDCV6le91WvZNKxBk=
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v1 1/3] dt-bindings: nvmem: add fsl,layerscape-sfp binding
Date:   Thu, 27 Jan 2022 17:37:26 +0100
Message-Id: <20220127163728.3650648-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127163728.3650648-1-michael@walle.cc>
References: <20220127163728.3650648-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Security Fuse Processor provides efuses and is responsible for
reading it at SoC startup and configuring it accordingly.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
new file mode 100644
index 000000000000..80914b93638e
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/fsl,layerscape-sfp.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/fsl,layerscape-sfp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Layerscape Security Fuse Processor
+
+maintainers:
+  - Michael Walle <michael@walle.cc>
+
+description: |
+  SFP is the security fuse processor which among other things provide a
+  unique identifier per part.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    enum:
+      - fsl,ls1028a-sfp
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
+    efuse@1e80000 {
+        compatible = "fsl,ls1028a-sfp";
+        reg = <0x1e80000 0x8000>;
+    };
-- 
2.30.2

