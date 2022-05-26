Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92401534D03
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346970AbiEZKLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346960AbiEZKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:11:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACFE10EC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:43 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id n10so1340322pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R1Oz1yAZDHQvhQh2SWx4vMTfkt8zOrGF2iQud75B5Lk=;
        b=MeBvlYLKJh6EnE4Nk4fnvlwLHRYUqSTpb3CTh8pn85TV32ZdSCclJiU4pcvaTDtwkA
         RZbKn8P//rgHWSQg9zJ8xqvTjG1wd8fm2yEN7plSFM4jAukcfO5ZPNZLN62yaHGP446f
         OsYZwKq12ORSAtDuUkFSQa3gr9WaXe7cH1K+StKOeIZS26YGAlqMye3q8lokxQ5dSMcF
         jKEKvVeOJ9qWyneCm3ObTYXlMLJK1mEq5SeCL4CISyt3QDyZVcMYYWoKUkSRXRt/iNOJ
         y+BTc8jKia4Tyw239NwQz9dEOEI5n8gY6PO71NKx3vrvGN9W1RCwgirGLD4gqqsJjqf3
         ohBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R1Oz1yAZDHQvhQh2SWx4vMTfkt8zOrGF2iQud75B5Lk=;
        b=7hrOVCH9iofrklw1ufgyPFRo9o38M4ZYbybKRPX2cOEap86T77pwg8mBtYiU55ZnH5
         eCS4Volaxk2Tbi/JVQdEciAFsSxGBnY3qoyuQ7ystOD6+cBbhVLQ2ZJocEODZSrc1u0J
         3o/US9hM8RgFYLQidXaV4xocGfBugDeDVgyF7uq8aBrcn8zobf2hFuZnNt3kTkRBEiqp
         vkjp+LYHrgeZ1LHrkzauRhnBJyBcyAFHMQNW4pwcrdeCLDkmxdTFhQeNgn+lLSEFnZyz
         fZGqS0jNOksL3ixS9lNP56Ud8vQqzBRYVUBKXrv/lMCL6J/7uQy+wU20ZCVvTDLVeYM6
         MBgQ==
X-Gm-Message-State: AOAM5317YEUO491rFM5YzFTRbYavdIg26IBC7Z90+N/AecJazdFWBR1S
        Gm+KhgcYGJjYVFmO0WDAHbOUVif4WnTg+kbF
X-Google-Smtp-Source: ABdhPJyAv5zPzU2IwZPeCQVSm/VsddqxuggiHGPcUvNa4rsGUhxfdC58ncib9zaXi0NWNziwb/aigQ==
X-Received: by 2002:a17:902:8bca:b0:15f:28b6:ad46 with SMTP id r10-20020a1709028bca00b0015f28b6ad46mr37153228plo.69.1653559902867;
        Thu, 26 May 2022 03:11:42 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:42 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH V2 1/5] riscv: cpu_ops_sbi: Support for 64bit hartid
Date:   Thu, 26 May 2022 15:41:27 +0530
Message-Id: <20220526101131.2340729-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
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

The hartid can be a 64bit value on RV64 platforms. This patch modifies
the hartid variable type to unsigned long so that it can hold 64bit
value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/kernel/cpu_ops_sbi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/cpu_ops_sbi.c b/arch/riscv/kernel/cpu_ops_sbi.c
index 4f5a6f84e2a4..efa0f0816634 100644
--- a/arch/riscv/kernel/cpu_ops_sbi.c
+++ b/arch/riscv/kernel/cpu_ops_sbi.c
@@ -65,7 +65,7 @@ static int sbi_hsm_hart_get_status(unsigned long hartid)
 static int sbi_cpu_start(unsigned int cpuid, struct task_struct *tidle)
 {
 	unsigned long boot_addr = __pa_symbol(secondary_start_sbi);
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 	unsigned long hsm_data;
 	struct sbi_hart_boot_data *bdata = &per_cpu(boot_data, cpuid);
 
@@ -107,7 +107,7 @@ static void sbi_cpu_stop(void)
 static int sbi_cpu_is_stopped(unsigned int cpuid)
 {
 	int rc;
-	int hartid = cpuid_to_hartid_map(cpuid);
+	unsigned long hartid = cpuid_to_hartid_map(cpuid);
 
 	rc = sbi_hsm_hart_get_status(hartid);
 
-- 
2.25.1

