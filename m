Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361854BCC3C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiBTFK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbiBTFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:49 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8B7554BB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:21 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v4so12060510pjh.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=gsu7vUkBTXloZBY5crdjWG0a6kF7Rp2Ufl6WjH9zPwubBpnczQgxvMINFx3UAPUdck
         KlS4IRWAqBOnHgtnkUuInOwXQgCVfVtYHHJxHv52k0eVJKxYQxmKLXKaSZSKhvyMc2lE
         9or9uESFqi+dg0FwIWbOenYCzntChMCJuslU+vDeF1n1JbXpRtH4KTIP2hIxKZPoNNpD
         5P8T2gz09S0UnezL0u3Zm1L+Lrjo2NjueLOme9YaubfxrWp5ht2G7aYZbQSQDF38Tucb
         bPO0/iJoo057zszFRMWRRkQECn1PxqIBbRbF6DcWu6h+ch9DPKb0MH3PyNImUQOfBFv7
         XiLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64Kf1jBnaPXE7HWaq/CWbgAlm0Fq5kx6l/oMdBTVwE8=;
        b=zTNiEqXh8A7irKEwDHo8fH4fJdHyob12oi18n2w+6DRVlGfnvhgrRcqUnJoOUTGrkW
         EMwCnglcSKI+QD0J5b4Va13zEp0teA1S5PEf7bTA1AtJ10QJbeR3IyX6yf9BWW48ynz+
         avI6hVR1+RcZeZDeRBYfFTh5TlbnnTBNhRP73gOKkGEZCLqntqOp7H8CbY36itKpI085
         aiZh+6a1OARAxJBCjqGLteIlMnDCd1Q9AshH0Ka8FP4hOP6fpnB6JkdDzMRddeb7PZtA
         mYmUz5zSMiA804TTxOXZAserxf3rmgVr7c373fdzT7ADghaY+GxDh2vhVQ+j4xw1+FOZ
         KsCg==
X-Gm-Message-State: AOAM531F89qIAhx8zs3sAFbcHAf1rzsA+JC8npy9VK3rza1GM9OdYeLw
        BBIbU5xHdCsYHafu0x/goDm4otiQzn3iiQ==
X-Google-Smtp-Source: ABdhPJy3DExU6NKhqlkQTY+VUHkVb8Ep/VbycLbZh8/S5TbSH+UpC9xVOXzmgADpJWI3zRLlmngV/Q==
X-Received: by 2002:a17:90b:1104:b0:1b8:b90b:22c7 with SMTP id gi4-20020a17090b110400b001b8b90b22c7mr15685794pjb.45.1645333821280;
        Sat, 19 Feb 2022 21:10:21 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:10:20 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 6/6] RISC-V: Use IPIs for remote icache flush when possible
Date:   Sun, 20 Feb 2022 10:38:54 +0530
Message-Id: <20220220050854.743420-7-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220050854.743420-1-apatel@ventanamicro.com>
References: <20220220050854.743420-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IPI calls are injected using SBI IPI calls then remote icache flush
using SBI RFENCE calls is much faster because using IPIs for remote
icache flush would still endup as SBI IPI calls with extra processing
on the kernel side.

It is now possible to have specialized hardware (such as RISC-V AIA
and RISC-V ACLINT) which allows S-mode software to directly inject
IPIs without any assistance from M-mode runtime firmware.

This patch extends remote icache flush functions to use IPIs whenever
underlying IPI operations are suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/mm/cacheflush.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
index 6cb7d96ad9c7..7c7e44aaf791 100644
--- a/arch/riscv/mm/cacheflush.c
+++ b/arch/riscv/mm/cacheflush.c
@@ -18,7 +18,7 @@ void flush_icache_all(void)
 {
 	local_flush_icache_all();
 
-	if (IS_ENABLED(CONFIG_RISCV_SBI))
+	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
 		sbi_remote_fence_i(NULL);
 	else
 		on_each_cpu(ipi_remote_fence_i, NULL, 1);
@@ -66,7 +66,8 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
 		 * with flush_icache_deferred().
 		 */
 		smp_mb();
-	} else if (IS_ENABLED(CONFIG_RISCV_SBI)) {
+	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
+		   !riscv_use_ipi_for_rfence()) {
 		sbi_remote_fence_i(&others);
 	} else {
 		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
-- 
2.25.1

