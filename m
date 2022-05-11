Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD30523FD2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbiEKWA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348425AbiEKWAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DDA6F4AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:10 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so3215493pji.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7AhCdNNL1uDdWvnH8n7UysRuRPz3w0BpqFn1GxNQ6wo=;
        b=fytPneEmsny+Pj54XsjvH+yJyKiyIQXqjgxcMFBdfycFD7t0ELgrStCgfZhKF0iO55
         LDrK5qUaSCFmzgdMPxAa0kf6Xthyw3EG5+R2Q+B1ERzA2JAIboEeJfDoKw4qGlv5eVgU
         LabepkR8cYWhInEcTPRbtB4d9xGeGcZrMSL5c5Zm9m3rjxc+QaylulqtTXmLxzKpBqgU
         fMoaOcCaAkAf1fxHTDT+QLLuIPhMkUQvRBxj8H6mjbE+IvU6rVbiOvhqesoHL+oEjYzp
         sXmZiV/X29rj4H46Ix4rZN2wctlsJMqhU1IFVVhv6Rxw4ks63A9c1ZTI8SgKKfHrlPjp
         fQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7AhCdNNL1uDdWvnH8n7UysRuRPz3w0BpqFn1GxNQ6wo=;
        b=CGOeCFuxLaFMCExVKQAXmn2TzrLgECxUaJr2gjupUC8//iJXlQbaAIlCX5CkGpViBr
         N5coQ7r1EGxIIQpOC7SVKBx1ZmRYBNzGlmgi57KtGTjklEWCoPK3Nn4ciLvDGDgDWjFG
         gfHJTJ+xJ7Ks04LjT/euCItws/j3LUOK1AiHbMDqCyvtZAM8d2Ai/OJbwHX6VbW/FUyj
         a97q+Ce7LWRsHElHdJT7DgM0umBl7iMdCef6m/GAhIxyDxu5cPF7RJyd9L1OAqoCseRJ
         JO1aO+7NdZ6EUE5VKZswvlElCJJlmlGEOFqrgnOYuyvwkgQijqBqMlPY+vTQGJXFKd3s
         9RHQ==
X-Gm-Message-State: AOAM53028EwpvnPd6Cpd+ij7DjnuhJsFoHfeGZt2n4JkRoDmPCGRc0/b
        AF1CMSUUYGtzvgFpcu2fQyzRNzUWcoEdkQ==
X-Google-Smtp-Source: ABdhPJxLn0qdk0oErX8E5kMy4li3iexoYy5DTUJmr2ywY2v38wlmMML/4DfUsVIZFyD9QNqCwlySeA==
X-Received: by 2002:a17:90b:3e8b:b0:1dc:e471:1a69 with SMTP id rj11-20020a17090b3e8b00b001dce4711a69mr7517540pjb.60.1652306409472;
        Wed, 11 May 2022 15:00:09 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:08 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 02/12] target/riscv: Implement PMU CSR predicate function for S-mode
Date:   Wed, 11 May 2022 14:59:46 -0700
Message-Id: <20220511215956.2351243-3-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511215956.2351243-1-atishp@rivosinc.com>
References: <20220511215956.2351243-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Currently, the predicate function for PMU related CSRs only works if
virtualization is enabled. It also does not check mcounteren bits before
before cycle/minstret/hpmcounterx access.

Support supervisor mode access in the predicate function as well.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ee3a35afa256..d175fe3f1af3 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -79,6 +79,57 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
         return RISCV_EXCP_ILLEGAL_INST;
     }
 
+    if (env->priv == PRV_S) {
+        switch (csrno) {
+        case CSR_CYCLE:
+            if (!get_field(env->mcounteren, COUNTEREN_CY)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_TIME:
+            if (!get_field(env->mcounteren, COUNTEREN_TM)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_INSTRET:
+            if (!get_field(env->mcounteren, COUNTEREN_IR)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
+            ctr_index = csrno - CSR_CYCLE;
+            if (!get_field(env->mcounteren, 1 << ctr_index)) {
+                return RISCV_EXCP_ILLEGAL_INST;
+            }
+            break;
+        }
+        if (riscv_cpu_mxl(env) == MXL_RV32) {
+            switch (csrno) {
+            case CSR_CYCLEH:
+                if (!get_field(env->mcounteren, COUNTEREN_CY)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_TIMEH:
+                if (!get_field(env->mcounteren, COUNTEREN_TM)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_INSTRETH:
+                if (!get_field(env->mcounteren, COUNTEREN_IR)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
+                ctr_index = csrno - CSR_CYCLEH;
+                if (!get_field(env->mcounteren, 1 << ctr_index)) {
+                    return RISCV_EXCP_ILLEGAL_INST;
+                }
+                break;
+            }
+        }
+    }
+
     if (riscv_cpu_virt_enabled(env)) {
         switch (csrno) {
         case CSR_CYCLE:
-- 
2.25.1

