Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67AE54EFC35
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 23:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352810AbiDAViO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 17:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351536AbiDAViM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 17:38:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC557483
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 14:36:22 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso3667470pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 14:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=aYp862D2P9rwZ8w0k1RYiGcPZn0LcpIwaRufe0fXT+Y=;
        b=cR90qpjLF0s9TN5+/tmfd7tRVhzAw6Rgcp1bmgNs6j2lfN/LDqZYdNhcaIXKiZMO/5
         fCHJ+cLyou32ow4gj+JQD8M47sayLWMuqhytBxmsrrMgJh784Y0FcJBSjaoMZTl/a0Ee
         uiGnFvZpZog9cICQuFau+R4G03yPe1jBNJ2LF1giFjkkEPHIMcuZel8Gu5eT7q+Whwx9
         B88Hdsg9JO30Lea971VElBKwttjn1vh3H5gNRKgO8XdOosayy4Tq/MDyVIjp94eIVyqz
         FPGzj7TTFGr4Y8Pw+6tnH6g7s2iWxY7x2EG4qk90xSy10Gmp79kNCIj3J/PgXJGZ6oTb
         flrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=aYp862D2P9rwZ8w0k1RYiGcPZn0LcpIwaRufe0fXT+Y=;
        b=stVUZSwdY9z2bPoVDb7B+VvIkJEOzCAvPL1eia5DkR2ZVrBZ6VauIDwcRWThb52SKt
         mHXoQee2L8KCT6ulXPEjLIJJCY4P9+q9kr4f5ZwS6dC7VjfW31cq/j1a0F2UU5p/TKZ/
         pcgHKJ2SWNFnMcb0vDJNFUr9SjAf3KTzxCVSyLxC8PLO62+dm22i2J6ia0gPOQ9HfizV
         Qzvs2ndcXGqbNA13c/3ozF4MI0VhuKpYIuqc2Bt0crhrpsKnEFcVTUwsC0DDLKaubwUd
         OgbwatKddOgnrA17z4bIHJdj7v7Bfqg4Y+sBVUjwERJr2vPtLxX+pg18m9wwcHQw4WnE
         91oA==
X-Gm-Message-State: AOAM531dpfCbnsZw6AG6RUiJEiXSvL6x4jmZx27E8eoXV/7LM5ZRd54q
        I++fpmL3y1XoigMbVMCHoiIFUQ==
X-Google-Smtp-Source: ABdhPJy2vP197SYrTV+OCDd087GwI8iQmVI39nnJ2WNSiTv31PP7MRAc4GpXIwLVD8UeXqi3YbAXsA==
X-Received: by 2002:a17:90a:31cf:b0:1c9:f9b8:68c7 with SMTP id j15-20020a17090a31cf00b001c9f9b868c7mr14145759pjf.34.1648848981896;
        Fri, 01 Apr 2022 14:36:21 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d24-20020a637358000000b003823aefde04sm3228507pgn.86.2022.04.01.14.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:36:21 -0700 (PDT)
Subject: [PATCH v3] dt-bindings: Fix phandle-array issues in the idle-states bindings
Date:   Fri,  1 Apr 2022 14:26:59 -0700
Message-Id: <20220401212658.30607-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup@brainfault.org, guoren@kernel.org, krzk@kernel.org,
        lorenzo.pieralisi@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Rob Herring <robh@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

As per 39bd2b6a3783 ("dt-bindings: Improve phandle-array schemas"), the
phandle-array bindings have been disambiguated.  This fixes the new
RISC-V idle-states bindings to comply with the schema.

Fixes: 1bd524f7e8d8 ("dt-bindings: Add common bindings for ARM and RISC-V idle states")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
Changes since v2:

* Add the missing schema requirement to riscv/cpus.yaml

Changes since v1:

* Only fix the RISC-V bindings, to avoid a merge conflict.

---
 .../devicetree/bindings/cpu/idle-states.yaml     | 16 ++++++++--------
 .../devicetree/bindings/riscv/cpus.yaml          |  2 ++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpu/idle-states.yaml b/Documentation/devicetree/bindings/cpu/idle-states.yaml
index 95506ffb816c..0e89c469d0fc 100644
--- a/Documentation/devicetree/bindings/cpu/idle-states.yaml
+++ b/Documentation/devicetree/bindings/cpu/idle-states.yaml
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
diff --git a/Documentation/devicetree/bindings/riscv/cpus.yaml b/Documentation/devicetree/bindings/riscv/cpus.yaml
index f62f646bc695..d632ac76532e 100644
--- a/Documentation/devicetree/bindings/riscv/cpus.yaml
+++ b/Documentation/devicetree/bindings/riscv/cpus.yaml
@@ -101,6 +101,8 @@ properties:
 
   cpu-idle-states:
     $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    items:
+      maxItems: 1
     description: |
       List of phandles to idle state nodes supported
       by this hart (see ./idle-states.yaml).
-- 
2.34.1

