Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485E64B4F72
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352092AbiBNL4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:56:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352161AbiBNLzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:55:54 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157D9C4E;
        Mon, 14 Feb 2022 03:55:46 -0800 (PST)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0A7CF22236;
        Mon, 14 Feb 2022 12:55:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644839744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/NjyFjKbCBQABoYhh6yk7oefa153RWchuWsomjveFjg=;
        b=cLlopmktfsW2Su2/BF5oD3dmXrJdVBp7e+nx9xDE9tR70srUoNWajIlm9mOnGAKjYPzBwF
        Zs3RvvTw1bW739lx+6MGdoHRR7IyIBTDaD5VDRBz3CCDZ1kMG/yn5Rh65PQHtAkfKY/R1f
        9XgsetiXgdjiJUMgk3zN7e7vSXkwV8o=
From:   Michael Walle <michael@walle.cc>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/3] dt-bindings: nvmem: add fsl,layerscape-sfp binding
Date:   Mon, 14 Feb 2022 12:55:27 +0100
Message-Id: <20220214115529.662948-2-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220214115529.662948-1-michael@walle.cc>
References: <20220214115529.662948-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Security Fuse Processor provides efuses and is responsible for
reading it at SoC startup and configuring it accordingly.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
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

