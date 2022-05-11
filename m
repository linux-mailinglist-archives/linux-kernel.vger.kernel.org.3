Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73534523FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 00:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348442AbiEKWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348472AbiEKWAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 18:00:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251D16D48D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c11so3118631plg.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 15:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dq3AsKzhmTYW0tA0YoLO/eJ29e5Y/pkFqc/1LVLFraE=;
        b=luPPOT4miCVo1teeSOsF7DShd10QmT0Q/pEYTDqyZvZZbcXHSvMKoE8hu7mfkshCpN
         PxcN1D2lUcMudG5OFg5gsBygRzGCYDZHB5SUTGYpdm4Yh9tA8hLVFvbXH7OUck7HRwRL
         EZD28u1Tcys04AgzHsl+CNFdvPUqaf9J+PWcN+7y40ai7+8hS0hn7amb+TK7xWTh0jPB
         01aNdeMeJU0iXQzepzv4lt/d5Fsfj21g9/SwYCP5D/OuRbaBduyU+VTInk6sW+0L4a/+
         HSJnzUAsimvAIpgbMAiG9eeWRDnTCILHoUmdi/8/HvPHr/r1xzXtw2eMQSrtJuxceSEs
         WPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dq3AsKzhmTYW0tA0YoLO/eJ29e5Y/pkFqc/1LVLFraE=;
        b=gMeWxJYxYZO3vHBL9r5BZ5NCGHVv97Xi7x3qkO/eJEhizXvNLQngYFzfDOEBRIO6Fm
         hRcvcsOXI9l9ct+qdeRM35LC27qKEdf9/fIo/6gQd0RxoxBRnujS7uqfNaY3Rn7ECAi+
         FAMoVnn89ZDi9uGL1id+Bb26t2oC4e0dLfpN0mIrKt93TTIE6BAAyl4ORoA408WzpiQe
         VZv40eGec84riVfIv9EUAp96CfEvHbL3hGd414PWxAnayrvJ3eOVZ87/LlU1BIAi1nTF
         oWGS/EsFo9PxxUqimrH1J8b/Ioy8qEU4Hivnq1T3/ja5TqtqGHUln+xyPlhUxEQS8/tb
         8OUA==
X-Gm-Message-State: AOAM530VT+y0ntgWAxJF5FP0DKBoG/vf8faUwUfVoUGg7kRYBtOpPJfw
        rlzXBfnlKNzJwyIfNLZYVeWmLcKrREEsXg==
X-Google-Smtp-Source: ABdhPJxkHS5qoqp9G4CK+a3stcKbybihmBdaOg2d4osf7WxNeItfeZXaO9Mz1wVrCxEahOO7UvpLbA==
X-Received: by 2002:a17:90a:e7d2:b0:1dc:e6c6:604b with SMTP id kb18-20020a17090ae7d200b001dce6c6604bmr7447165pjb.183.1652306416147;
        Wed, 11 May 2022 15:00:16 -0700 (PDT)
Received: from atishp.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id r23-20020a62e417000000b0050dc762816asm2261303pfh.68.2022.05.11.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 15:00:15 -0700 (PDT)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bin Meng <bmeng.cn@gmail.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Bin Meng <bin.meng@windriver.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
Subject: [PATCH v8 05/12] target/riscv: Implement mcountinhibit CSR
Date:   Wed, 11 May 2022 14:59:49 -0700
Message-Id: <20220511215956.2351243-6-atishp@rivosinc.com>
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

As per the privilege specification v1.11, mcountinhibit allows to start/stop
a pmu counter selectively.

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 target/riscv/cpu.h      |  2 ++
 target/riscv/cpu_bits.h |  4 ++++
 target/riscv/csr.c      | 25 +++++++++++++++++++++++++
 target/riscv/machine.c  |  1 +
 4 files changed, 32 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 7cbcd8d62fc1..45ac0f2d2614 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -269,6 +269,8 @@ struct CPUArchState {
     target_ulong scounteren;
     target_ulong mcounteren;
 
+    target_ulong mcountinhibit;
+
     target_ulong sscratch;
     target_ulong mscratch;
 
diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 4d04b20d064e..b3f7fa713000 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -367,6 +367,10 @@
 #define CSR_MHPMCOUNTER29   0xb1d
 #define CSR_MHPMCOUNTER30   0xb1e
 #define CSR_MHPMCOUNTER31   0xb1f
+
+/* Machine counter-inhibit register */
+#define CSR_MCOUNTINHIBIT   0x320
+
 #define CSR_MHPMEVENT3      0x323
 #define CSR_MHPMEVENT4      0x324
 #define CSR_MHPMEVENT5      0x325
diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index 7e14f7685fb9..ea1cde68610c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -1475,6 +1475,28 @@ static RISCVException write_mtvec(CPURISCVState *env, int csrno,
     return RISCV_EXCP_NONE;
 }
 
+static RISCVException read_mcountinhibit(CPURISCVState *env, int csrno,
+                                         target_ulong *val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    *val = env->mcountinhibit;
+    return RISCV_EXCP_NONE;
+}
+
+static RISCVException write_mcountinhibit(CPURISCVState *env, int csrno,
+                                          target_ulong val)
+{
+    if (env->priv_ver < PRIV_VERSION_1_11_0) {
+        return RISCV_EXCP_ILLEGAL_INST;
+    }
+
+    env->mcountinhibit = val;
+    return RISCV_EXCP_NONE;
+}
+
 static RISCVException read_mcounteren(CPURISCVState *env, int csrno,
                                       target_ulong *val)
 {
@@ -3741,6 +3763,9 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
     [CSR_MHPMCOUNTER30]  = { "mhpmcounter30",  mctr,   read_zero },
     [CSR_MHPMCOUNTER31]  = { "mhpmcounter31",  mctr,   read_zero },
 
+    [CSR_MCOUNTINHIBIT]  = { "mcountinhibit",   any,    read_mcountinhibit,
+                                                       write_mcountinhibit },
+
     [CSR_MHPMEVENT3]     = { "mhpmevent3",     any,    read_zero },
     [CSR_MHPMEVENT4]     = { "mhpmevent4",     any,    read_zero },
     [CSR_MHPMEVENT5]     = { "mhpmevent5",     any,    read_zero },
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 2a437b29a1ce..87cd55bfd3a7 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -330,6 +330,7 @@ const VMStateDescription vmstate_riscv_cpu = {
         VMSTATE_UINTTL(env.siselect, RISCVCPU),
         VMSTATE_UINTTL(env.scounteren, RISCVCPU),
         VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
+        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
         VMSTATE_UINTTL(env.sscratch, RISCVCPU),
         VMSTATE_UINTTL(env.mscratch, RISCVCPU),
         VMSTATE_UINT64(env.mfromhost, RISCVCPU),
-- 
2.25.1

