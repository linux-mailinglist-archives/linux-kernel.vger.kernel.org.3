Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B66522406
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 20:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbiEJSas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 14:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348875AbiEJSap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 14:30:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5E2DDC;
        Tue, 10 May 2022 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652207444; x=1683743444;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SByInZuezabV9ptXq3P9/wReRUwF7TvR/B7eWfqBJNI=;
  b=FFcHRannz73f2PGL9On+udmF4wU0dphoajICexSFzbCmWgV9ML9iOeUE
   nJJjgKjaorygBAkuJgFzEm729ua+YZnEgCpIoPrMxj9Fd939pCcQ5BaXJ
   xRY448uA2LnfEOVvpW6l4/ChezAswO2dE9zg1fvOSZHkSHjU+RRjc0KHk
   pwPli+WNLP+hBb4/AEUtIwzD6qgzt0TWO6W84QXmbb/KP2iSOPZrzvx/E
   +YDRteHoSqVCY5kfeTHJLEXpotqUf7UYPYR2Dj7LC5AiTdzHWiVsj89dB
   SNswjlBVrc64GHiJomJNPcghiV5K982S7FUOvhJCpXplzntLtm9AyFPNc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249998288"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="249998288"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="738839902"
Received: from rhweight-wrk1.ra.intel.com ([137.102.106.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:30:42 -0700
From:   matthew.gerlach@linux.intel.com
To:     dinguyen@kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v5 1/3] dt-bindings: soc: add bindings for Intel HPS Copy Engine
Date:   Tue, 10 May 2022 11:30:39 -0700
Message-Id: <20220510183041.876583-2-matthew.gerlach@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220510183041.876583-1-matthew.gerlach@linux.intel.com>
References: <20220510183041.876583-1-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Gerlach <matthew.gerlach@linux.intel.com>

Add device tree bindings documentation for the Intel Hard
Processor System (HPS) Copy Engine.

Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
v5:
  - add Reviewed-by: Krzysztof Kozlowski

v4:
  - move from soc to soc/intel/

v3:
  - remove unused label
  - move from misc to soc
  - remove 0x from #address-cells/#size-cells values
  - change hps_cp_eng@0 to dma-controller@0
  - remote inaccurate 'items:' tag
---
 .../soc/intel/intel,hps-copy-engine.yaml      | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml

diff --git a/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
new file mode 100644
index 000000000000..8634865015cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2022, Intel Corporation
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/intel/intel,hps-copy-engine.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Intel HPS Copy Engine
+
+maintainers:
+  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
+
+description: |
+  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
+  a bootable image from host memory to HPS DDR.  Additionally, there is a
+  register the HPS can use to indicate the state of booting the copied image as
+  well as a keep-a-live indication to the host.
+
+properties:
+  compatible:
+    const: intel,hps-copy-engine
+
+  '#dma-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    bus@80000000 {
+        compatible = "simple-bus";
+        reg = <0x80000000 0x60000000>,
+              <0xf9000000 0x00100000>;
+        reg-names = "axi_h2f", "axi_h2f_lw";
+        #address-cells = <2>;
+        #size-cells = <1>;
+        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
+
+        dma-controller@0 {
+            compatible = "intel,hps-copy-engine";
+            reg = <0x00000000 0x00000000 0x00001000>;
+            #dma-cells = <1>;
+        };
+    };
-- 
2.25.1

