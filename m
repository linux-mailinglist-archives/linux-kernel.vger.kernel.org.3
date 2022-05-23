Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DCB531F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbiEWXvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiEWXv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:51:28 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B117C45067
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:27 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id v11so15007240pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 16:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONhH3JMWgWwbUIcvZD7NSVRWryFx2o7RORVMkeNPFY4=;
        b=becsQZ8lVgmeL6x3bHYJH7GP7lwQbKJePGFqm/juUGoJ+dSz7jVmGqErG99uGxTPfj
         oRcI44+xpEDABRNGS9HJ4tCkdsz5ySwlxM87HpQoXXsAbHryUvhPw+DWHCVwkcpFonJw
         LCJ9SRVLEw8KDJ6WO4U3C4wX450iATxJzS1jEUfM5U1Nryfs5mpDFklGWSNCdCbgVU1e
         VjPjOhTi1rR1tLPOntds8+oymxhMcaDr4Rj3YckR721g18TgIh/j7Y+BVvMlAo33T8VU
         m/77VHxSfyuzrFwAC+nyKNI6wQEHYRJqvNsre33AcTrqaiyr4/OZtlWzLJBNwdFLQ4FZ
         HO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONhH3JMWgWwbUIcvZD7NSVRWryFx2o7RORVMkeNPFY4=;
        b=rlvThTWaQuJZ2WfEww+sgzg5rPDwp0yXkY2F7D7j4l2gnxWPFEKBObHGqBWB+I95mH
         PzqnogdEndTH4ncxzywUHBuMugDtfubn3tS+yLxEn56SnwEJfA4JpioL4VHgEZPG/B11
         3/5UcIM/DzVSQDl06l6/TxEQ0l0Y+9IgN3bzAbQoqPYiKySJtVBz0YeGbgu7a/mZuXs5
         KoYFt56IvzqMKPL0iB4pdlmOU04L3PSnQVDbCa1jZjy6Nw67uDSEPAaGknAR4x2D+OLi
         C9AwSokKQJ2myrJkCEQkc/RuKviwYPqcfuCffg7CLGtKbNcjnspU0m78GHqShH5P9skY
         hUIA==
X-Gm-Message-State: AOAM533v7cr3FA5RJcqAVEzRr2t+dfRiqCSRnkl99QPMPRbtcXxcjM4n
        LZsHaohygSLmkJW5N+C+s39F4U1WLdj6Ag==
X-Google-Smtp-Source: ABdhPJwiBfNzumr8Fq7F4dFvV4WH+GxLTkEtkEmlHzPKXVu97V/KrkG4H6Ykksf1z74FnIW16AyRSQ==
X-Received: by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP id z5-20020a056a00240500b004e15008adccmr25793449pfh.35.1653349886902;
        Mon, 23 May 2022 16:51:26 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id pl15-20020a17090b268f00b001df4b919937sm257084pjb.16.2022.05.23.16.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 16:51:26 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v9 01/12] target/riscv: Fix PMU CSR predicate function
Date:   Mon, 23 May 2022 16:50:46 -0700
Message-Id: <20220523235057.123882-2-atishp@rivosinc.com>
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

The predicate function calculates the counter index incorrectly for
hpmcounterx. Fix the counter index to reflect correct CSR number.

Fixes: e39a8320b088 ("target/riscv: Support the Virtual Instruction fault")

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/csr.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 3500e07f92e1..ee3a35afa256 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -72,6 +72,7 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
 #if !defined(CONFIG_USER_ONLY)
     CPUState *cs = env_cpu(env);
     RISCVCPU *cpu = RISCV_CPU(cs);
+    int ctr_index;
 
     if (!cpu->cfg.ext_counters) {
         /* The Counters extensions is not enabled */
@@ -99,8 +100,9 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
             }
             break;
         case CSR_HPMCOUNTER3...CSR_HPMCOUNTER31:
-            if (!get_field(env->hcounteren, 1 << (csrno - CSR_HPMCOUNTER3)) &&
-                get_field(env->mcounteren, 1 << (csrno - CSR_HPMCOUNTER3))) {
+            ctr_index = csrno - CSR_CYCLE;
+            if (!get_field(env->hcounteren, 1 << ctr_index) &&
+                 get_field(env->mcounteren, 1 << ctr_index)) {
                 return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
             }
             break;
@@ -126,8 +128,9 @@ static RISCVException ctr(CPURISCVState *env, int csrno)
                 }
                 break;
             case CSR_HPMCOUNTER3H...CSR_HPMCOUNTER31H:
-                if (!get_field(env->hcounteren, 1 << (csrno - CSR_HPMCOUNTER3H)) &&
-                    get_field(env->mcounteren, 1 << (csrno - CSR_HPMCOUNTER3H))) {
+                ctr_index = csrno - CSR_CYCLEH;
+                if (!get_field(env->hcounteren, 1 << ctr_index) &&
+                     get_field(env->mcounteren, 1 << ctr_index)) {
                     return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
                 }
                 break;
-- 
2.25.1

