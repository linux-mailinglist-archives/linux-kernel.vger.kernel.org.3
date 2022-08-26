Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80925A2E39
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbiHZSVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiHZSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:20:29 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1A672EED
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:20:26 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id c16-20020a17090aa61000b001fb3286d9f7so7999041pjq.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=FNx8fpay38lh/JkGq4/J4K8jVk0AX2jeOsObYgqKLZ0=;
        b=QohTMZ0LE1ziu/k2s3a83WWpaD1AsW6bQDDirT9QqzuFN+aVdXl+OqlPy146baQ8MK
         cCpKY9LEJsr1Vu42eCAJgrXYePE8FBHc9NsCLNO3ZJVv+vWfKEJPGQ5VQf6HRXg7l2Rd
         4jEkz56c7DDqjxYzaXYN4YUBOCMHkSiw7PIg/KyGVIY07BxCsoNAFdv+COkqcplCxLG/
         9omws5dxmxwdltA9Lax6iyG+Mi/3RfXSg/dhV1WUje9OXnQNHA8zvL6VPSiWuYKpd9sZ
         rxKMV7Ve/q5nJN8g99aap6yi26FAnkZ81IU/5G1bxxhqwc3baPiNBij72G/7cGVAYbjk
         OMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=FNx8fpay38lh/JkGq4/J4K8jVk0AX2jeOsObYgqKLZ0=;
        b=xzW62FlJkv51jAtQNRNGYaGXof8TzzGqDoSO+zEjm3k/6c+MYwXAcmMgZ8KiunCev0
         EiB9sI3OvRyzwJkU/UrD6zuKilsbz/EJ+8TpQFTGfdO2bdklVELr/fnE20UTEWWUy8LC
         qNchB8yOd5ENR+kzCjz124b91nfgrXrlQnPBngZTAD0IzNYn0hdrhX3x9Mi50cuz3a2q
         gw3ZW/vaTH1GMj0CXPVeJhe/TeFu94JQqqc80r5s02/jiIaiWMSe7EryJuEXliopgZwA
         VB2T1I+IePLR+8JLr+/bBaOJ4tuAFUEK7CGbHXD56xNkacKAgKJMsLTduqNpG4sgifBJ
         7iBQ==
X-Gm-Message-State: ACgBeo2haRDnpu+SFXWMrfo9dXjGm60ZMy6TosE8Lej92lSOgBpqLW3a
        ofnjpUzgE5ViNVBXCOOWpJlf
X-Google-Smtp-Source: AA6agR4uKSirml3xe3PlLeKQC8S8OvTYtQDF+QAhG9Vj1L7uVKi8CLTwu1SvQ1FZnafeswMWgUrzIQ==
X-Received: by 2002:a17:90b:3807:b0:1f4:ecf7:5987 with SMTP id mq7-20020a17090b380700b001f4ecf75987mr5426181pjb.13.1661538025655;
        Fri, 26 Aug 2022 11:20:25 -0700 (PDT)
Received: from localhost.localdomain ([117.193.214.147])
        by smtp.gmail.com with ESMTPSA id s5-20020a170902b18500b00173368e9dedsm1881868plr.252.2022.08.26.11.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 11:20:25 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org, robh@kernel.org, andersson@kernel.org
Cc:     kw@linux.com, bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        dmitry.baryshkov@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/11] dt-bindings: PCI: qcom-ep: Add support for SM8450 SoC
Date:   Fri, 26 Aug 2022 23:49:22 +0530
Message-Id: <20220826181923.251564-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
References: <20220826181923.251564-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings support for SM8450 SoC. Only the clocks are
different on this platform, rest is same as SDX55.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
index 83a2cfc63bc1..9914d575ec41 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     const: qcom,sdx55-pcie-ep
+    const: qcom,sm8450-pcie-ep
 
   reg:
     items:
@@ -33,11 +34,11 @@ properties:
 
   clocks:
     minItems: 7
-    maxItems: 7
+    maxItems: 8
 
   clock-names:
     minItems: 7
-    maxItems: 7
+    maxItems: 8
 
   qcom,perst-regs:
     description: Reference to a syscon representing TCSR followed by the two
@@ -120,6 +121,28 @@ allOf:
             - const: sleep # PCIe Sleep clock
             - const: ref # PCIe Reference clock
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sm8450-pcie-ep
+    then:
+      properties:
+        clocks:
+          minItems: 8
+          maxItems: 8
+        clock-names:
+          items:
+            - const: aux # PCIe Auxiliary clock
+            - const: cfg # PCIe CFG AHB clock
+            - const: bus_master # PCIe Master AXI clock
+            - const: bus_slave # PCIe Slave AXI clock
+            - const: slave_q2a # PCIe Slave Q2A AXI clock
+            - const: ref # PCIe Reference clock
+            - const: ddrss_sf_tbu # PCIe DDRSS SF TBU clock
+            - const: aggre_noc_axi # PCIe AGGRE NOC AXI clock
+
 unevaluatedProperties: false
 
 examples:
-- 
2.25.1

