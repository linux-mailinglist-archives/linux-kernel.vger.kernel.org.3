Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FE14EFA71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351684AbiDATeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351166AbiDATef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:34:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE717666D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:32:43 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3425677pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=0jLO5UVmEjHPFZZwqrRxNUtvnmVwhAOf+6irA8tpjDc=;
        b=4rC5LT0lsSNYz/LJEW41ze2g2QWYpQiN7X2W+HC6N+DHPxcp4fWuKYFOVG3Mc2TLqw
         37f0UmiQqzGVZB36eXNSSxiPPiYtGgDcjT/Eo1GqH1H1q9Nvha/AFkJlnztXt15tpDQg
         yfc9FnyzErRq/ukBDftNubsPBmdHSTeepZHn2onM8BwBY8VKEc034dt+vPWKVM2Q6Y4i
         JIk/Vhgc5fa1wUx+tkxxNVDbOLpeUjcTINg7vHmUsVvgRQFIqjDl0gyoWXs6iGhzqz+j
         Kv9KbSeqGF0JCpYuyz9KFjL0qiBaNtg6q/PLWAwzbFg6+jlbUY+KWelX82hgicavAC6Y
         FfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=0jLO5UVmEjHPFZZwqrRxNUtvnmVwhAOf+6irA8tpjDc=;
        b=BXVK82hkp2+ZOxEPm7SM37+0UzHGHNt4dHtejZGOft9/h/aGzfmEuqlBm3LRWu+m4Q
         NzRsXTyJqTmTxo5gMZCZLel04g3LSn7DXYDlhxwHXyJ82dFB/u8Be97mvoH97QpGQjYN
         WJ+EtdUHPQ6znkgpX5P+xk2F1vTCePeZEZI7trT+8NHus6Rh8R3NGwNyQYpSqacajBgF
         3Q01xofJ988WoUH66LLjzXT+BzUAOxpe6/Oqbm5962uDNVspuVCF/uyr7RBUqSfv6qOT
         kG3FeAgKfmEjDR3WP7Q36KAeCx3uOuaicMVfPtETcJ/G0f+gDls/IpbM8OgPyRpUfd7z
         8Svg==
X-Gm-Message-State: AOAM530tiyisYKSQ9zfN9ldYHbYN2WlhHPKoeShQ4DysI1hz/cYHOmFq
        vhzy4poIbfnli90N4sUmxyS2v+S59AsifqPU
X-Google-Smtp-Source: ABdhPJyZ+1aOIcSRvjFD4osbW3W8c0zQ8nYtOLOV/Fq3SJdKFJg52OI1EaYHLRSu9niP7drMTcWCPQ==
X-Received: by 2002:a17:90b:3802:b0:1c6:905c:af2e with SMTP id mq2-20020a17090b380200b001c6905caf2emr13475714pjb.236.1648841563206;
        Fri, 01 Apr 2022 12:32:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id o22-20020a056a0015d600b004fb03c903c3sm4212080pfu.71.2022.04.01.12.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:32:42 -0700 (PDT)
Subject: [PATCH] dt-bindings: Fix phandle-array issues in the idle-states bindings
Date:   Fri,  1 Apr 2022 12:31:08 -0700
Message-Id: <20220401193108.12490-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     robh+dt@kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        anup@brainfault.org, guoren@kernel.org, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
phandle-array bindings have been disambiguated.  This fixes the new
generic idle-states bindings to comply with the schema.

Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 .../devicetree/bindings/cpu/idle-states.yaml  | 96 +++++++++----------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
index 95506ffb816c..6f5223659950 100644
--- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
@@ -385,8 +385,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x0>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@1 {
@@ -394,8 +394,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x1>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@100 {
@@ -403,8 +403,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x100>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@101 {
@@ -412,8 +412,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x101>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@10000 {
@@ -421,8 +421,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x10000>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@10001 {
@@ -430,8 +430,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x10001>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@10100 {
@@ -439,8 +439,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x10100>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@10101 {
@@ -448,8 +448,8 @@ examples:
             compatible = "arm,cortex-a57";
             reg = <0x0 0x10101>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_0_0 &CPU_SLEEP_0_0
-                   &CLUSTER_RETENTION_0 &CLUSTER_SLEEP_0>;
+            cpu-idle-states = <&CPU_RETENTION_0_0>, <&CPU_SLEEP_0_0>,
+                   <&CLUSTER_RETENTION_0>, <&CLUSTER_SLEEP_0>;
         };
 
         cpu@100000000 {
@@ -457,8 +457,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x0>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100000001 {
@@ -466,8 +466,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x1>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100000100 {
@@ -475,8 +475,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x100>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100000101 {
@@ -484,8 +484,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x101>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100010000 {
@@ -493,8 +493,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x10000>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100010001 {
@@ -502,8 +502,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x10001>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100010100 {
@@ -511,8 +511,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x10100>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         cpu@100010101 {
@@ -520,8 +520,8 @@ examples:
             compatible = "arm,cortex-a53";
             reg = <0x1 0x10101>;
             enable-method = "psci";
-            cpu-idle-states = <&CPU_RETENTION_1_0 &CPU_SLEEP_1_0
-                   &CLUSTER_RETENTION_1 &CLUSTER_SLEEP_1>;
+            cpu-idle-states = <&CPU_RETENTION_1_0>, <&CPU_SLEEP_1_0>,
+                   <&CLUSTER_RETENTION_1>, <&CLUSTER_SLEEP_1>;
         };
 
         idle-states {
@@ -615,56 +615,56 @@ examples:
             device_type = "cpu";
             compatible = "arm,cortex-a15";
             reg = <0x0>;
-            cpu-idle-states = <&cpu_sleep_0_0 &cluster_sleep_0>;
+            cpu-idle-states = <&cpu_sleep_0_0>, <&cluster_sleep_0>;
         };
 
         cpu@1 {
             device_type = "cpu";
             compatible = "arm,cortex-a15";
             reg = <0x1>;
-            cpu-idle-states = <&cpu_sleep_0_0 &cluster_sleep_0>;
+            cpu-idle-states = <&cpu_sleep_0_0>, <&cluster_sleep_0>;
         };
 
         cpu@2 {
             device_type = "cpu";
             compatible = "arm,cortex-a15";
             reg = <0x2>;
-            cpu-idle-states = <&cpu_sleep_0_0 &cluster_sleep_0>;
+            cpu-idle-states = <&cpu_sleep_0_0>, <&cluster_sleep_0>;
         };
 
         cpu@3 {
             device_type = "cpu";
             compatible = "arm,cortex-a15";
             reg = <0x3>;
-            cpu-idle-states = <&cpu_sleep_0_0 &cluster_sleep_0>;
+            cpu-idle-states = <&cpu_sleep_0_0>, <&cluster_sleep_0>;
         };
 
         cpu@100 {
             device_type = "cpu";
             compatible = "arm,cortex-a7";
             reg = <0x100>;
-            cpu-idle-states = <&cpu_sleep_1_0 &cluster_sleep_1>;
+            cpu-idle-states = <&cpu_sleep_1_0>, <&cluster_sleep_1>;
         };
 
         cpu@101 {
             device_type = "cpu";
             compatible = "arm,cortex-a7";
             reg = <0x101>;
-            cpu-idle-states = <&cpu_sleep_1_0 &cluster_sleep_1>;
+            cpu-idle-states = <&cpu_sleep_1_0>, <&cluster_sleep_1>;
         };
 
         cpu@102 {
             device_type = "cpu";
             compatible = "arm,cortex-a7";
             reg = <0x102>;
-            cpu-idle-states = <&cpu_sleep_1_0 &cluster_sleep_1>;
+            cpu-idle-states = <&cpu_sleep_1_0>, <&cluster_sleep_1>;
         };
 
         cpu@103 {
             device_type = "cpu";
             compatible = "arm,cortex-a7";
             reg = <0x103>;
-            cpu-idle-states = <&cpu_sleep_1_0 &cluster_sleep_1>;
+            cpu-idle-states = <&cpu_sleep_1_0>, <&cluster_sleep_1>;
         };
 
         idle-states {
@@ -719,8 +719,8 @@ examples:
             reg = <0x0>;
             riscv,isa = "rv64imafdc";
             mmu-type = "riscv,sv48";
-            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
-                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+            cpu-idle-states = <&CPU_RET_0_0>, <&CPU_NONRET_0_0>,
+                            <&CLUSTER_RET_0>, <&CLUSTER_NONRET_0>;
 
             cpu_intc0: interrupt-controller {
                 #interrupt-cells = <1>;
@@ -735,8 +735,8 @@ examples:
             reg = <0x1>;
             riscv,isa = "rv64imafdc";
             mmu-type = "riscv,sv48";
-            cpu-idle-states = <&CPU_RET_0_0 &CPU_NONRET_0_0
-                            &CLUSTER_RET_0 &CLUSTER_NONRET_0>;
+            cpu-idle-states = <&CPU_RET_0_0>, <&CPU_NONRET_0_0>,
+                            <&CLUSTER_RET_0>, <&CLUSTER_NONRET_0>;
 
             cpu_intc1: interrupt-controller {
                 #interrupt-cells = <1>;
@@ -751,8 +751,8 @@ examples:
             reg = <0x10>;
             riscv,isa = "rv64imafdc";
             mmu-type = "riscv,sv48";
-            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
-                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+            cpu-idle-states = <&CPU_RET_1_0>, <&CPU_NONRET_1_0>,
+                            <&CLUSTER_RET_1>, <&CLUSTER_NONRET_1>;
 
             cpu_intc10: interrupt-controller {
                 #interrupt-cells = <1>;
@@ -767,8 +767,8 @@ examples:
             reg = <0x11>;
             riscv,isa = "rv64imafdc";
             mmu-type = "riscv,sv48";
-            cpu-idle-states = <&CPU_RET_1_0 &CPU_NONRET_1_0
-                            &CLUSTER_RET_1 &CLUSTER_NONRET_1>;
+            cpu-idle-states = <&CPU_RET_1_0>, <&CPU_NONRET_1_0>,
+                            <&CLUSTER_RET_1>, <&CLUSTER_NONRET_1>;
 
             cpu_intc11: interrupt-controller {
                 #interrupt-cells = <1>;
-- 
2.34.1

