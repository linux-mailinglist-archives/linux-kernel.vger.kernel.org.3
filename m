Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 064404BCF54
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 16:28:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiBTPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 10:16:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244133AbiBTPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 10:16:22 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E33834BBE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:58 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d3so7198198wrf.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 07:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y9birgiS9Q1LdTibjI1qpS+INxYgCkhdm/5O40p8Ub8=;
        b=FGBW9qbGDlq6nxvPRK/HUbQ5I8vPFFMIt5zeUvx+pbnwmJrseZRG6W8Gs/hOfk86Xj
         mBlFn5pusTk67QxaaetMyGemCImqfFJBThhEHToSwuoGQIGvv+H/9hwp92AbctKRUgNx
         ZPCIIGtGZcKMUZ6hOotftwXRLJb9nkkZRNrpn/5o7zcl9AXD8WVAir0avqdV6Hju64hi
         cABuODa7KLHyCNjyGfeP6ybVKUAwCu2jzGZvXXk4seuRevdO4nMABA/C6ZsHJgkpnY9d
         4B477obfb+Qy4SLCvljH+p1d5XvyfMZLDQ8xKnQD79GAzvzNeTaRzD0RG6Ua9GvJDd+x
         rtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y9birgiS9Q1LdTibjI1qpS+INxYgCkhdm/5O40p8Ub8=;
        b=NdIuXg/PI9uErERyJY2pLt4aLmLZ9Y9SNVLO+2yT6MivbKGj0uJ5BObKsubOCgkIys
         uXt2IUVaetIQ09GpYMXpaQzExOfU6Gmjgw2ioUnznXA0lbJv+xnHu4CS9R5rzYGKz7Ls
         LXe7f90eZFzCagd0TL56Glew08T8MWPlKrDEX6ZjBP7pUo3RAE3rsrgmiUTHKfdZjUKb
         /OnF+CokJsLUxIsHegW9QKpgkncBkJu9aJjQThKEiUyb8Y/Z2dqCL3gP01XibK5TC1ZU
         qQEfcEM3GcmMZEhEr2cYd+kBMLV8cZ59OWihtQbZoFju7qggr/8gliwc/e+GigkR5vBY
         xmSQ==
X-Gm-Message-State: AOAM530GoDUaglNKCTubxHPOZEnxENvqmxgkveGt1NvbZsUW6lPUiggI
        Johm1l7bQgD8F/EstzXNsj975A==
X-Google-Smtp-Source: ABdhPJz4wOMRsj8Zdwrw44uV2D14PB78jcXKSQf1Girb0abQRhKGiEDFC6UTMpJHOMLCM3MrVkc51Q==
X-Received: by 2002:a5d:6b4c:0:b0:1e6:8ece:62e8 with SMTP id x12-20020a5d6b4c000000b001e68ece62e8mr12856136wrw.201.1645370156776;
        Sun, 20 Feb 2022 07:15:56 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id h7sm28687749wru.41.2022.02.20.07.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 07:15:56 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/13] dt-bindings: nvmem: add fsl,layerscape-sfp binding
Date:   Sun, 20 Feb 2022 15:15:22 +0000
Message-Id: <20220220151527.17216-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
References: <20220220151527.17216-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Walle <michael@walle.cc>

The Security Fuse Processor provides efuses and is responsible for
reading it at SoC startup and configuring it accordingly.

Signed-off-by: Michael Walle <michael@walle.cc>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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
2.21.0

