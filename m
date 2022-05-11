Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CCE523FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348446AbiEKWAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiEKWAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AE26F4AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:08 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so3121318pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONhH3JMWgWwbUIcvZD7NSVRWryFx2o7RORVMkeNPFY4=;
        b=jSnL5KATGvc2JdB79nRWmRmWK78stCqG0iX14zmEDsEwCppntNWwTQNw611AT6+TtF
         kNur2kiy3spnoQP1G0SHCGebAgG22cwJzHFgNOEvc1ImMgMSc4sxSSlJK25LoXvoQxum
         q2aUEDukZv9Ahq0CQOzgIV/rhGL1EQscHATegz43zk7ZVdrsttoJqImlPeWOMUl7QDMH
         dITisMOluBdahB+Vi26BICz1bP6EzSzi396rqgJxEb3PUC59Ns+MuFft6WI4jy3oemH7
         4N9zTICCnd7LWPiCIR5Pn8JsSLMS19X9ejxQGyYES3moPGSuD/jOxz3nk1ZzqeiXkn6G
         mDLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONhH3JMWgWwbUIcvZD7NSVRWryFx2o7RORVMkeNPFY4=;
        b=bUXceuhUOSQJAzx8onF7YovdBi5c1+Fe3HKOeiUM81rGg2yQzMICf4nlAta1IQmfK0
         tusKeo9XKeZbGb5DMM1W9H0HW7vpRZqnCXMu4DnHH8jLtsoQYDisCgZ0sGfdQeivPMd3
         Gk60I8dfO2SClW3+SxBd+gzIRKEfrrV83vMV2p+SmV3s0ko+DwqQsUgAQGCAs8k2tPEM
         VArWAeSfVyo7lYOt93C8DWrP/8DFN9V1na1gpmMYsM6Wx5i9rja8C+k9QFeSUQC20Zgz
         Pyeh9bXipjAyhGdTR+igrXE/uOntzYRYEFuwYwLrWtiGiGCjM2Os+RyqP566WN0fDj66
         dkcg==
X-Gm-Message-State: AOAM5318WCaP6kSCd2n5JT4dPGpuR6ACUpb2cMlI/JzGWcfTVwiLfqpu
        X9Ji+tyeMFY73X6PeFsz1e+jC5PWazJq4g==
X-Google-Smtp-Source: ABdhPJzqfDqaifuNzHijb5AxK44u67XJ1WtpCuhjWdxJOfkJN8m89Y3FCMOABikx46OzbZMjvrHxZQ==
X-Received: by 2002:a63:874a:0:b0:3c6:aa29:15f6 with SMTP id i71-20020a63874a000000b003c6aa2915f6mr14748527pge.210.1652306407528;
        Wed, 11 May 2022 15:00:07 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:06 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Alistair Francis <alistair.francis@wdc.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 01/12] target/riscv: Fix PMU CSR predicate function
Date:   Wed, 11 May 2022 14:59:45 -0700
Message-Id: <20220511215956.2351243-2-atishp@rivosinc.com>
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

