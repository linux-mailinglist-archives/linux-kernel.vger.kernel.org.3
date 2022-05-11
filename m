Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C751E522E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiEKIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiEKIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:31:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964513916D
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:39 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x23so1356073pff.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 01:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=9DDx0IFq0rFZB0Z2ZzpiVoBVEGPTvAItk8MwFiFZRtc=;
        b=YpPl60Nhwk/OdiyJpYlA8Ekm9d8dlN/g8aKTGRzi0aZV1mrWvjSDLrHaHAGKTSQATO
         ypdpf4/+azIERpDxCu3B3iePwgaZakOuCOmYsn5lzEVtNGup2fLSjyFdiJzZ+X/VS7mD
         EszWsPHKq8OYHgl3nhr3KcWsRDJ5xis7H/6viosa0QuMQrnmyht6rFxY7H7gRbrQ8GoE
         Qg/F3iZCG1yc/vyWCTgRMm1ssexS09M7Zyn2598mD1fxhkH+EFpA8mOTJv9YYlBu8PVl
         1OuHZrAfVE3zHuNhqelPjdxBuEn/5LGrkSIaJqvoidRRK3rPsnKlnryskXBwi11miqzd
         w9qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=9DDx0IFq0rFZB0Z2ZzpiVoBVEGPTvAItk8MwFiFZRtc=;
        b=MQCbhb2Pnm9iWd4/NHgoIJK72wWcjgfMwQaGqrCd62tMdp2Nsxo+nZIJ+rRFRCYBsh
         bFDZbPI2zuh0eah1h8rRe1qKk2k6r0QYpiiTIEJHGNu38xajigMPTmRGodj+8rqhaNtV
         nyc/QtQRdiZFeshovx/Bb6UGArBjvmXv6M2w0YJWlwPDV9j2c7+UWZE6QOd/8BebBzZL
         wDCISFybEvWpngBKV5mkktLTP1aLZ7AYxL16pF1ungaUkOPqnG4QLUeRxIS8awV233wi
         kHhY3AuhkjT0uG3K/eawUp40eEvnjbJfeozLKinJSJikFoFqOoghRkLb1djBo+C8QU5w
         U/zg==
X-Gm-Message-State: AOAM533z9XTDoswsJ7BnmEgyq2ics9THWOUTpm/I3EbjMa3D/WtSem5A
        sd51jL0Hg9Mjyen5NFmkn5JFYA==
X-Google-Smtp-Source: ABdhPJxk2oyoniPig7GOpPAx4ynn5C0XjJmrO3QMW/2MjdeED1m2F1kmN59hoKaQCiyREsETUSB+3A==
X-Received: by 2002:a63:5cb:0:b0:3da:fe5d:4448 with SMTP id 194-20020a6305cb000000b003dafe5d4448mr4670383pgf.583.1652257899093;
        Wed, 11 May 2022 01:31:39 -0700 (PDT)
Received: from localhost.localdomain (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id m10-20020aa7900a000000b0050dc7628170sm1020202pfo.74.2022.05.11.01.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 01:31:38 -0700 (PDT)
From:   Greentime Hu <greentime.hu@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu
Subject: [PATCH v10 06/16] riscv: Reset vector register
Date:   Wed, 11 May 2022 08:31:16 +0000
Message-Id: <fe0f0eb84a20891b5867524b5dc5475ea8e4c3cd.1652257230.git.greentime.hu@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
In-Reply-To: <cover.1652257230.git.greentime.hu@sifive.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Reset vector registers at boot-time and disable vector instructions
execution for kernel mode.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Co-developed-by: Vincent Chen <vincent.chen@sifive.com>
Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
Co-developed-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Signed-off-by: Han-Kuan Chen <hankuan.chen@sifive.com>
Co-developed-by: Greentime Hu <greentime.hu@sifive.com>
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/kernel/entry.S |  6 +++---
 arch/riscv/kernel/head.S  | 35 +++++++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index c8b9ce274b9a..559f1418e980 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -77,10 +77,10 @@ _save_context:
 	 * Disable user-mode memory access as it should only be set in the
 	 * actual user copy routines.
 	 *
-	 * Disable the FPU to detect illegal usage of floating point in kernel
-	 * space.
+	 * Disable the FPU/Vector to detect illegal usage of floating point
+	 * or vector in kernel space.
 	 */
-	li t0, SR_SUM | SR_FS
+	li t0, SR_SUM | SR_FS | SR_VS
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 893b8bb69391..2877af90b025 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -139,10 +139,10 @@ secondary_start_sbi:
 	.option pop
 
 	/*
-	 * Disable FPU to detect illegal usage of
-	 * floating point in kernel space
+	 * Disable FPU & VECTOR to detect illegal usage of
+	 * floating point or vector in kernel space
 	 */
-	li t0, SR_FS
+	li t0, SR_FS | SR_VS
 	csrc CSR_STATUS, t0
 
 	/* Set trap vector to spin forever to help debug */
@@ -233,10 +233,10 @@ pmp_done:
 .option pop
 
 	/*
-	 * Disable FPU to detect illegal usage of
-	 * floating point in kernel space
+	 * Disable FPU & VECTOR to detect illegal usage of
+	 * floating point or vector in kernel space
 	 */
-	li t0, SR_FS
+	li t0, SR_FS | SR_VS
 	csrc CSR_STATUS, t0
 
 #ifdef CONFIG_RISCV_BOOT_SPINWAIT
@@ -429,6 +429,29 @@ ENTRY(reset_regs)
 	csrw	fcsr, 0
 	/* note that the caller must clear SR_FS */
 #endif /* CONFIG_FPU */
+
+#ifdef CONFIG_VECTOR
+	csrr	t0, CSR_MISA
+	li	t1, COMPAT_HWCAP_ISA_V
+	and	t0, t0, t1
+	beqz	t0, .Lreset_regs_done
+
+	/*
+	 * Clear vector registers and reset vcsr
+	 * VLMAX has a defined value, VLEN is a constant,
+	 * and this form of vsetvli is defined to set vl to VLMAX.
+	 */
+	li	t1, SR_VS
+	csrs	CSR_STATUS, t1
+	csrs	CSR_VCSR, x0
+	vsetvli t1, x0, e8, m8, ta, ma
+	vmv.v.i v0, 0
+	vmv.v.i v8, 0
+	vmv.v.i v16, 0
+	vmv.v.i v24, 0
+	/* note that the caller must clear SR_VS */
+#endif /* CONFIG_VECTOR */
+
 .Lreset_regs_done:
 	ret
 END(reset_regs)
-- 
2.17.1

