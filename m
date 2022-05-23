Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F409E531F67
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiEWXwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbiEWXvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:37 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B34544DE
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:35 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id ev18so15348940pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ntsk5uGVLj8zoKjT8xtGEo+QfY+LVD2o57Dc+oUaRE=;
        b=QYm7yduf2VWjDXGE49UX5BL/cRCzvNpjv8SbJkeBOYBmvqiIUxKxWJ6iG3ucDdjg+c
         GS1Era1xuhXT5Zlaq+2YZwf48tBeABNeQoULw8PTq6Hp5B+62rWCQKbxqjUl8aFl6Jtb
         riYIiYccS9UNwcTnqr1XuJcyBLQy/rGKhSTYLJcuGcndU9w39d0VM4OQuQgpdB8urzUJ
         zpm3pmmPjLdtgK1A6mM2SdodWZbjvD6Cc54Js2NQzZMGlQ7wEh8F+Y0P/VPtCTvXYuT4
         DVdW3mPOtg3c07aoBrrVwGaNKNB0Im0aoCKszkc6MDuNQQfTFZ0XBUK3xbrIzKUO9G8u
         YDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ntsk5uGVLj8zoKjT8xtGEo+QfY+LVD2o57Dc+oUaRE=;
        b=I2+kBCUIZfwrvWYdihQmLZCfkjtYynGsJeXxOvo8qHQZj+ZqrzR4W6kegbIvM6V5Rs
         Gh68qr91rtg2r2/d0oanSTXhy3U/ck++0pNjY9LZhQnynNT7dxxaQioHHsWIMaooFb3l
         IxN2ZxdATjQiYXWq0yjxqu79uvL+rbpfb+R7S684XMT0kGYg8DJSNNAz2Z16W38u6/jn
         GA08kHcdg6CPD7Wd5T3LxMVuflbfiRemi3Dl5Afph6bV6RGP30gkQnp1UsDmqRmua2jp
         KxS1YdtOWMGTUxP2W18xbuVQXDuWebKH/Bs0cR3arnEGbuIkxtmnAdLHv2wpa8h5lpF6
         NyMQ==
X-Gm-Message-State: AOAM533bpa2ezijcrerAvHKFwGP1xRC/79+xHbHA5Lq39UVhsHxmnQdV
        prjG9rHzihMzEOlPoZG9KvC3jMaeJjOiXw==
X-Google-Smtp-Source: ABdhPJxXPaI038kUrUv+xvAJRWusZtehXIOVBFUwUyvqvywm+Y2y1+nBi0JeHtHc23nQKZuGpHDxpA==
X-Received: by 2002:a17:902:ec8a:b0:161:7ca5:eced with SMTP id x10-20020a170902ec8a00b001617ca5ecedmr25105375plg.17.1653349893970;
        Mon, 23 May 2022 16:51:33 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:33 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 06/12] target/riscv: Add support for hpmcounters/hpmevents
Date:   Mon, 23 May 2022 16:50:51 -0700
Message-Id: <20220523235057.123882-7-atishp@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523235057.123882-1-atishp@rivosinc.com>
References: <20220523235057.123882-1-atishp@rivosinc.com>
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

With SBI PMU extension, user can use any of the available hpmcounters to
track any perf events based on the value written to mhpmevent csr.
Add read/write functionality for these csrs.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h     |  11 +
 target/riscv/csr.c     | 469 ++++++++++++++++++++++++++++-------------
 target/riscv/machine.c |   3 +
 3 files changed, 331 insertions(+), 152 deletions(-)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 45ac0f2d2614..32cdd9070be5 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -111,6 +111,8 @@ typedef struct CPUArchState CPURISCVState;
 #endif
 
 #define RV_VLEN_MAX 1024
+#define RV_MAX_MHPMEVENTS 29
+#define RV_MAX_MHPMCOUNTERS 32
 
 FIELD(VTYPE, VLMUL, 0, 3)
 FIELD(VTYPE, VSEW, 3, 3)
@@ -271,6 +273,15 @@ struct CPUArchState {
 
     target_ulong mcountinhibit;
 
+    /* PMU counter configured values */
+    target_ulong mhpmcounter_val[RV_MAX_MHPMCOUNTERS];
+
+    /* for RV32 */
+    target_ulong mhpmcounterh_val[RV_MAX_MHPMCOUNTERS];
+
+    /* PMU event selector configured values */
+    target_ulong mhpmevent_val[RV_MAX_MHPMEVENTS];
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ea1cde68610c..605591072784 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -230,6 +230,15 @@ static RISCVException mctr(CPURISCVState *env, int csrno)
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException mctr32(CPURISCVState *env, int csrno)
+{
+    if (riscv_cpu_mxl(env) != MXL_RV32) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    return mctr(env, csrno);
+}
+
 static RISCVException any(CPURISCVState *env, int csrno)
 {
     return RISCV_EXCP_NONE;
@@ -635,6 +644,75 @@ static RISCVException read_timeh(CPURISCVState *env, int csrno,
 
 #else /* CONFIG_USER_ONLY */
 
+static int read_mhpmevent(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    int evt_index = csrno - CSR_MHPMEVENT3;
+
+    *val = env->mhpmevent_val[evt_index];
+
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mhpmevent(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int evt_index = csrno - CSR_MHPMEVENT3;
+
+    env->mhpmevent_val[evt_index] = val;
+
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mhpmcounter(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_index = csrno - CSR_MHPMCOUNTER3 + 3;
+
+    env->mhpmcounter_val[ctr_index] = val;
+
+    return RISCV_EXCP_NONE;
+}
+
+static int write_mhpmcounterh(CPURISCVState *env, int csrno, target_ulong val)
+{
+    int ctr_index = csrno - CSR_MHPMCOUNTER3H + 3;
+
+    env->mhpmcounterh_val[ctr_index] = val;
+
+    return RISCV_EXCP_NONE;
+}
+
+static int read_hpmcounter(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    int ctr_index;
+
+    if (csrno >= CSR_MCYCLE && csrno <= CSR_MHPMCOUNTER31) {
+        ctr_index = csrno - CSR_MHPMCOUNTER3 + 3;
+    } else if (csrno >= CSR_CYCLE && csrno <= CSR_HPMCOUNTER31) {
+        ctr_index = csrno - CSR_HPMCOUNTER3 + 3;
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->mhpmcounter_val[ctr_index];
+
+    return RISCV_EXCP_NONE;
+}
+
+static int read_hpmcounterh(CPURISCVState *env, int csrno, target_ulong *val)
+{
+    int ctr_index;
+
+    if (csrno >= CSR_MCYCLEH && csrno <= CSR_MHPMCOUNTER31H) {
+        ctr_index = csrno - CSR_MHPMCOUNTER3H + 3;
+    } else if (csrno >= CSR_CYCLEH && csrno <= CSR_HPMCOUNTER31H) {
+        ctr_index = csrno - CSR_HPMCOUNTER3H + 3;
+    } else {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+    *val = env->mhpmcounterh_val[ctr_index];
+
+    return RISCV_EXCP_NONE;
+}
+
+
 static RISCVException read_time(CPURISCVState *env, int csrno,
                                 target_ulong *val)
 {
@@ -3703,157 +3781,244 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_SPMBASE] =    { "spmbase", pointer_masking, read_spmbase, write_spmbase },
 
     /* Performance Counters */
-    [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_zero },
-    [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_zero },
-    [CSR_HPMCOUNTER5]    = { "hpmcounter5",    ctr,    read_zero },
-    [CSR_HPMCOUNTER6]    = { "hpmcounter6",    ctr,    read_zero },
-    [CSR_HPMCOUNTER7]    = { "hpmcounter7",    ctr,    read_zero },
-    [CSR_HPMCOUNTER8]    = { "hpmcounter8",    ctr,    read_zero },
-    [CSR_HPMCOUNTER9]    = { "hpmcounter9",    ctr,    read_zero },
-    [CSR_HPMCOUNTER10]   = { "hpmcounter10",   ctr,    read_zero },
-    [CSR_HPMCOUNTER11]   = { "hpmcounter11",   ctr,    read_zero },
-    [CSR_HPMCOUNTER12]   = { "hpmcounter12",   ctr,    read_zero },
-    [CSR_HPMCOUNTER13]   = { "hpmcounter13",   ctr,    read_zero },
-    [CSR_HPMCOUNTER14]   = { "hpmcounter14",   ctr,    read_zero },
-    [CSR_HPMCOUNTER15]   = { "hpmcounter15",   ctr,    read_zero },
-    [CSR_HPMCOUNTER16]   = { "hpmcounter16",   ctr,    read_zero },
-    [CSR_HPMCOUNTER17]   = { "hpmcounter17",   ctr,    read_zero },
-    [CSR_HPMCOUNTER18]   = { "hpmcounter18",   ctr,    read_zero },
-    [CSR_HPMCOUNTER19]   = { "hpmcounter19",   ctr,    read_zero },
-    [CSR_HPMCOUNTER20]   = { "hpmcounter20",   ctr,    read_zero },
-    [CSR_HPMCOUNTER21]   = { "hpmcounter21",   ctr,    read_zero },
-    [CSR_HPMCOUNTER22]   = { "hpmcounter22",   ctr,    read_zero },
-    [CSR_HPMCOUNTER23]   = { "hpmcounter23",   ctr,    read_zero },
-    [CSR_HPMCOUNTER24]   = { "hpmcounter24",   ctr,    read_zero },
-    [CSR_HPMCOUNTER25]   = { "hpmcounter25",   ctr,    read_zero },
-    [CSR_HPMCOUNTER26]   = { "hpmcounter26",   ctr,    read_zero },
-    [CSR_HPMCOUNTER27]   = { "hpmcounter27",   ctr,    read_zero },
-    [CSR_HPMCOUNTER28]   = { "hpmcounter28",   ctr,    read_zero },
-    [CSR_HPMCOUNTER29]   = { "hpmcounter29",   ctr,    read_zero },
-    [CSR_HPMCOUNTER30]   = { "hpmcounter30",   ctr,    read_zero },
-    [CSR_HPMCOUNTER31]   = { "hpmcounter31",   ctr,    read_zero },
-
-    [CSR_MHPMCOUNTER3]   = { "mhpmcounter3",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER4]   = { "mhpmcounter4",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER5]   = { "mhpmcounter5",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER6]   = { "mhpmcounter6",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER7]   = { "mhpmcounter7",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER8]   = { "mhpmcounter8",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER9]   = { "mhpmcounter9",   mctr,   read_zero },
-    [CSR_MHPMCOUNTER10]  = { "mhpmcounter10",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER11]  = { "mhpmcounter11",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER12]  = { "mhpmcounter12",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER13]  = { "mhpmcounter13",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER14]  = { "mhpmcounter14",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER15]  = { "mhpmcounter15",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER16]  = { "mhpmcounter16",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER17]  = { "mhpmcounter17",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER18]  = { "mhpmcounter18",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER19]  = { "mhpmcounter19",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER20]  = { "mhpmcounter20",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER21]  = { "mhpmcounter21",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER22]  = { "mhpmcounter22",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER23]  = { "mhpmcounter23",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER24]  = { "mhpmcounter24",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER25]  = { "mhpmcounter25",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER26]  = { "mhpmcounter26",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER27]  = { "mhpmcounter27",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER28]  = { "mhpmcounter28",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER29]  = { "mhpmcounter29",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER30]  = { "mhpmcounter30",  mctr,   read_zero },
-    [CSR_MHPMCOUNTER31]  = { "mhpmcounter31",  mctr,   read_zero },
-
-    [CSR_MCOUNTINHIBIT]  = { "mcountinhibit",   any,    read_mcountinhibit,
-                                                       write_mcountinhibit },
-
-    [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_zero },
-    [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_zero },
-    [CSR_MHPMEVENT5]     = { "mhpmevent5",     any,    read_zero },
-    [CSR_MHPMEVENT6]     = { "mhpmevent6",     any,    read_zero },
-    [CSR_MHPMEVENT7]     = { "mhpmevent7",     any,    read_zero },
-    [CSR_MHPMEVENT8]     = { "mhpmevent8",     any,    read_zero },
-    [CSR_MHPMEVENT9]     = { "mhpmevent9",     any,    read_zero },
-    [CSR_MHPMEVENT10]    = { "mhpmevent10",    any,    read_zero },
-    [CSR_MHPMEVENT11]    = { "mhpmevent11",    any,    read_zero },
-    [CSR_MHPMEVENT12]    = { "mhpmevent12",    any,    read_zero },
-    [CSR_MHPMEVENT13]    = { "mhpmevent13",    any,    read_zero },
-    [CSR_MHPMEVENT14]    = { "mhpmevent14",    any,    read_zero },
-    [CSR_MHPMEVENT15]    = { "mhpmevent15",    any,    read_zero },
-    [CSR_MHPMEVENT16]    = { "mhpmevent16",    any,    read_zero },
-    [CSR_MHPMEVENT17]    = { "mhpmevent17",    any,    read_zero },
-    [CSR_MHPMEVENT18]    = { "mhpmevent18",    any,    read_zero },
-    [CSR_MHPMEVENT19]    = { "mhpmevent19",    any,    read_zero },
-    [CSR_MHPMEVENT20]    = { "mhpmevent20",    any,    read_zero },
-    [CSR_MHPMEVENT21]    = { "mhpmevent21",    any,    read_zero },
-    [CSR_MHPMEVENT22]    = { "mhpmevent22",    any,    read_zero },
-    [CSR_MHPMEVENT23]    = { "mhpmevent23",    any,    read_zero },
-    [CSR_MHPMEVENT24]    = { "mhpmevent24",    any,    read_zero },
-    [CSR_MHPMEVENT25]    = { "mhpmevent25",    any,    read_zero },
-    [CSR_MHPMEVENT26]    = { "mhpmevent26",    any,    read_zero },
-    [CSR_MHPMEVENT27]    = { "mhpmevent27",    any,    read_zero },
-    [CSR_MHPMEVENT28]    = { "mhpmevent28",    any,    read_zero },
-    [CSR_MHPMEVENT29]    = { "mhpmevent29",    any,    read_zero },
-    [CSR_MHPMEVENT30]    = { "mhpmevent30",    any,    read_zero },
-    [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_zero },
-
-    [CSR_HPMCOUNTER3H]   = { "hpmcounter3h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER4H]   = { "hpmcounter4h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER5H]   = { "hpmcounter5h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER6H]   = { "hpmcounter6h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER7H]   = { "hpmcounter7h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER8H]   = { "hpmcounter8h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER9H]   = { "hpmcounter9h",   ctr32,  read_zero },
-    [CSR_HPMCOUNTER10H]  = { "hpmcounter10h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER11H]  = { "hpmcounter11h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER12H]  = { "hpmcounter12h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER13H]  = { "hpmcounter13h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER14H]  = { "hpmcounter14h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER15H]  = { "hpmcounter15h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER16H]  = { "hpmcounter16h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER17H]  = { "hpmcounter17h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER18H]  = { "hpmcounter18h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER19H]  = { "hpmcounter19h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER20H]  = { "hpmcounter20h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER21H]  = { "hpmcounter21h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER22H]  = { "hpmcounter22h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER23H]  = { "hpmcounter23h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER24H]  = { "hpmcounter24h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER25H]  = { "hpmcounter25h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER26H]  = { "hpmcounter26h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER27H]  = { "hpmcounter27h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER28H]  = { "hpmcounter28h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER29H]  = { "hpmcounter29h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER30H]  = { "hpmcounter30h",  ctr32,  read_zero },
-    [CSR_HPMCOUNTER31H]  = { "hpmcounter31h",  ctr32,  read_zero },
-
-    [CSR_MHPMCOUNTER3H]  = { "mhpmcounter3h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER4H]  = { "mhpmcounter4h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER5H]  = { "mhpmcounter5h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER6H]  = { "mhpmcounter6h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER7H]  = { "mhpmcounter7h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER8H]  = { "mhpmcounter8h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER9H]  = { "mhpmcounter9h",  any32,  read_zero },
-    [CSR_MHPMCOUNTER10H] = { "mhpmcounter10h", any32,  read_zero },
-    [CSR_MHPMCOUNTER11H] = { "mhpmcounter11h", any32,  read_zero },
-    [CSR_MHPMCOUNTER12H] = { "mhpmcounter12h", any32,  read_zero },
-    [CSR_MHPMCOUNTER13H] = { "mhpmcounter13h", any32,  read_zero },
-    [CSR_MHPMCOUNTER14H] = { "mhpmcounter14h", any32,  read_zero },
-    [CSR_MHPMCOUNTER15H] = { "mhpmcounter15h", any32,  read_zero },
-    [CSR_MHPMCOUNTER16H] = { "mhpmcounter16h", any32,  read_zero },
-    [CSR_MHPMCOUNTER17H] = { "mhpmcounter17h", any32,  read_zero },
-    [CSR_MHPMCOUNTER18H] = { "mhpmcounter18h", any32,  read_zero },
-    [CSR_MHPMCOUNTER19H] = { "mhpmcounter19h", any32,  read_zero },
-    [CSR_MHPMCOUNTER20H] = { "mhpmcounter20h", any32,  read_zero },
-    [CSR_MHPMCOUNTER21H] = { "mhpmcounter21h", any32,  read_zero },
-    [CSR_MHPMCOUNTER22H] = { "mhpmcounter22h", any32,  read_zero },
-    [CSR_MHPMCOUNTER23H] = { "mhpmcounter23h", any32,  read_zero },
-    [CSR_MHPMCOUNTER24H] = { "mhpmcounter24h", any32,  read_zero },
-    [CSR_MHPMCOUNTER25H] = { "mhpmcounter25h", any32,  read_zero },
-    [CSR_MHPMCOUNTER26H] = { "mhpmcounter26h", any32,  read_zero },
-    [CSR_MHPMCOUNTER27H] = { "mhpmcounter27h", any32,  read_zero },
-    [CSR_MHPMCOUNTER28H] = { "mhpmcounter28h", any32,  read_zero },
-    [CSR_MHPMCOUNTER29H] = { "mhpmcounter29h", any32,  read_zero },
-    [CSR_MHPMCOUNTER30H] = { "mhpmcounter30h", any32,  read_zero },
-    [CSR_MHPMCOUNTER31H] = { "mhpmcounter31h", any32,  read_zero },
+    [CSR_HPMCOUNTER3]    = { "hpmcounter3",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER4]    = { "hpmcounter4",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER5]    = { "hpmcounter5",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER6]    = { "hpmcounter6",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER7]    = { "hpmcounter7",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER8]    = { "hpmcounter8",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER9]    = { "hpmcounter9",    ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER10]   = { "hpmcounter10",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER11]   = { "hpmcounter11",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER12]   = { "hpmcounter12",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER13]   = { "hpmcounter13",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER14]   = { "hpmcounter14",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER15]   = { "hpmcounter15",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER16]   = { "hpmcounter16",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER17]   = { "hpmcounter17",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER18]   = { "hpmcounter18",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER19]   = { "hpmcounter19",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER20]   = { "hpmcounter20",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER21]   = { "hpmcounter21",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER22]   = { "hpmcounter22",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER23]   = { "hpmcounter23",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER24]   = { "hpmcounter24",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER25]   = { "hpmcounter25",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER26]   = { "hpmcounter26",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER27]   = { "hpmcounter27",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER28]   = { "hpmcounter28",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER29]   = { "hpmcounter29",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER30]   = { "hpmcounter30",   ctr,    read_hpmcounter },
+    [CSR_HPMCOUNTER31]   = { "hpmcounter31",   ctr,    read_hpmcounter },
+
+    [CSR_MHPMCOUNTER3]   = { "mhpmcounter3",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER4]   = { "mhpmcounter4",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER5]   = { "mhpmcounter5",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER6]   = { "mhpmcounter6",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER7]   = { "mhpmcounter7",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER8]   = { "mhpmcounter8",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER9]   = { "mhpmcounter9",   mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER10]  = { "mhpmcounter10",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER11]  = { "mhpmcounter11",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER12]  = { "mhpmcounter12",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER13]  = { "mhpmcounter13",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER14]  = { "mhpmcounter14",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER15]  = { "mhpmcounter15",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER16]  = { "mhpmcounter16",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER17]  = { "mhpmcounter17",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER18]  = { "mhpmcounter18",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER19]  = { "mhpmcounter19",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER20]  = { "mhpmcounter20",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER21]  = { "mhpmcounter21",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER22]  = { "mhpmcounter22",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER23]  = { "mhpmcounter23",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER24]  = { "mhpmcounter24",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER25]  = { "mhpmcounter25",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER26]  = { "mhpmcounter26",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER27]  = { "mhpmcounter27",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER28]  = { "mhpmcounter28",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER29]  = { "mhpmcounter29",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER30]  = { "mhpmcounter30",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+    [CSR_MHPMCOUNTER31]  = { "mhpmcounter31",  mctr,    read_hpmcounter,
+                                                       write_mhpmcounter },
+
+    [CSR_MCOUNTINHIBIT]  = { "mcountinhibit",  any, read_mcountinhibit,
+                                                    write_mcountinhibit },
+
+    [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT5]     = { "mhpmevent5",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT6]     = { "mhpmevent6",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT7]     = { "mhpmevent7",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT8]     = { "mhpmevent8",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT9]     = { "mhpmevent9",     any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT10]    = { "mhpmevent10",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT11]    = { "mhpmevent11",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT12]    = { "mhpmevent12",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT13]    = { "mhpmevent13",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT14]    = { "mhpmevent14",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT15]    = { "mhpmevent15",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT16]    = { "mhpmevent16",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT17]    = { "mhpmevent17",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT18]    = { "mhpmevent18",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT19]    = { "mhpmevent19",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT20]    = { "mhpmevent20",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT21]    = { "mhpmevent21",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT22]    = { "mhpmevent22",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT23]    = { "mhpmevent23",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT24]    = { "mhpmevent24",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT25]    = { "mhpmevent25",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT26]    = { "mhpmevent26",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT27]    = { "mhpmevent27",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT28]    = { "mhpmevent28",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT29]    = { "mhpmevent29",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT30]    = { "mhpmevent30",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+    [CSR_MHPMEVENT31]    = { "mhpmevent31",    any,    read_mhpmevent,
+                                                       write_mhpmevent },
+
+    [CSR_HPMCOUNTER3H]   = { "hpmcounter3h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER4H]   = { "hpmcounter4h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER5H]   = { "hpmcounter5h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER6H]   = { "hpmcounter6h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER7H]   = { "hpmcounter7h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER8H]   = { "hpmcounter8h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER9H]   = { "hpmcounter9h",   ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER10H]  = { "hpmcounter10h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER11H]  = { "hpmcounter11h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER12H]  = { "hpmcounter12h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER13H]  = { "hpmcounter13h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER14H]  = { "hpmcounter14h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER15H]  = { "hpmcounter15h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER16H]  = { "hpmcounter16h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER17H]  = { "hpmcounter17h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER18H]  = { "hpmcounter18h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER19H]  = { "hpmcounter19h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER20H]  = { "hpmcounter20h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER21H]  = { "hpmcounter21h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER22H]  = { "hpmcounter22h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER23H]  = { "hpmcounter23h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER24H]  = { "hpmcounter24h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER25H]  = { "hpmcounter25h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER26H]  = { "hpmcounter26h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER27H]  = { "hpmcounter27h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER28H]  = { "hpmcounter28h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER29H]  = { "hpmcounter29h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER30H]  = { "hpmcounter30h",  ctr32,  read_hpmcounterh },
+    [CSR_HPMCOUNTER31H]  = { "hpmcounter31h",  ctr32,  read_hpmcounterh },
+
+    [CSR_MHPMCOUNTER3H]  = { "mhpmcounter3h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER4H]  = { "mhpmcounter4h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER5H]  = { "mhpmcounter5h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER6H]  = { "mhpmcounter6h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER7H]  = { "mhpmcounter7h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER8H]  = { "mhpmcounter8h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER9H]  = { "mhpmcounter9h",  mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER10H] = { "mhpmcounter10h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER11H] = { "mhpmcounter11h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER12H] = { "mhpmcounter12h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER13H] = { "mhpmcounter13h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER14H] = { "mhpmcounter14h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER15H] = { "mhpmcounter15h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER16H] = { "mhpmcounter16h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER17H] = { "mhpmcounter17h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER18H] = { "mhpmcounter18h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER19H] = { "mhpmcounter19h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER20H] = { "mhpmcounter20h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER21H] = { "mhpmcounter21h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER22H] = { "mhpmcounter22h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER23H] = { "mhpmcounter23h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER24H] = { "mhpmcounter24h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER25H] = { "mhpmcounter25h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER26H] = { "mhpmcounter26h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER27H] = { "mhpmcounter27h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER28H] = { "mhpmcounter28h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER29H] = { "mhpmcounter29h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER30H] = { "mhpmcounter30h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
+    [CSR_MHPMCOUNTER31H] = { "mhpmcounter31h", mctr32,  read_hpmcounterh,
+                                                       write_mhpmcounterh },
 #endif /* !CONFIG_USER_ONLY */
 };
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 87cd55bfd3a7..99193c85bb97 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -331,6 +331,9 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.scounteren, RISCVCPU),
         VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
         VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
+        VMSTATE_UINTTL_ARRAY(env.mhpmcounter_val, RISCVCPU, RV_MAX_MHPMCOUNTERS),
+        VMSTATE_UINTTL_ARRAY(env.mhpmcounterh_val, RISCVCPU, RV_MAX_MHPMCOUNTERS),
+        VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVENTS),
         VMSTATE_UINTTL(env.sscratch, RISCVCPU),
         VMSTATE_UINTTL(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.mfromhost, RISCVCPU),
-- 
2.25.1

