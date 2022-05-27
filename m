Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B046F5358B4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 07:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243112AbiE0FSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 01:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbiE0FR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 01:17:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B503136F
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:17:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c2so3237539plh.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 22:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bL6Df2//IX4pFAb3Mx3gzCPAvEMkloxMnWPx42+jX1U=;
        b=d7xy2wQwMsehdJ8/csAbRhdFHRV18FJbDigzTsdFFlSSx18qbpjC0am5y6/QiAfpcj
         nmlTpbhkNfvsqn0wbUmI3ZITCQuL5/Jhr8HQX26cMTHpYFzMYmIZBaZARS6wYNjGB3vU
         OM3OxoDyqQREhDzMtEfgnp8bf9uA5r1Z1yvF1AaU9kC8grC/YiEGX9KxN1vSwu4JFUMA
         rmdwqsfr4uTr1haJds9+Khdj+hSRoPEHGohpTWp+q3IMM7bL7ZNnmkMq0I8ea2v61M7g
         CltUt6/M4IpCeVd43fOOoANadsC8yFQ8YCa6835W/ofGDyfCsSyDgY0UTwE2aBlEEdbF
         5KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bL6Df2//IX4pFAb3Mx3gzCPAvEMkloxMnWPx42+jX1U=;
        b=vo53qI8V/HShVYVowuA51SzX/xPLj1VkOhj5hS2I5X1ID3+WBp7ZNCtSX68EjJqog3
         Vsl7bCt7ZqLl+KaSM7T5b01VRnKLIkR/xG34qy+U3yLiFqVqfThfcWfWF75sPRTQj2cF
         n1/VI0INXrRWNjOHoiPCYKOwRzOxxP4r7V5pU5L2ZtmZrAGv/QGW5p/3+XO37Tsjm1bi
         FHmVWrd5993ZQgb/l5qsU+yRzGrHzjMPeWubANboiiMkU47RBXqgqr+UgcTIZ1eMX8oe
         JTSekh36IJE3aVc/xEg1kVQm9FS/1I9tiSxjQsFExxosTi5deYti21KS5vS+fvab1eqt
         fqjg==
X-Gm-Message-State: AOAM531ifyWWJLCHmP5sA3OwRxzC3KidA7dg8yMiwcFverO2MXUvvTXh
        0+VnEKV0kuftdB23tG4I2kNKQA==
X-Google-Smtp-Source: ABdhPJxU939mlWe9n1bFBHQ99ErpSK3PeMu6xqSEXm+Yj6j7Li6zpY/7t6s9OhrsV8MSR7T1bqxiew==
X-Received: by 2002:a17:903:228d:b0:163:8b78:c3c8 with SMTP id b13-20020a170903228d00b001638b78c3c8mr3585464plh.27.1653628674882;
        Thu, 26 May 2022 22:17:54 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id j34-20020a634a62000000b003c14af5063fsm2459003pgl.87.2022.05.26.22.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 22:17:54 -0700 (PDT)
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
Subject: [PATCH V3 1/5] riscv: cpu_ops_sbi: Add 64bit hartid support on RV64
Date:   Fri, 27 May 2022 10:47:39 +0530
Message-Id: <20220527051743.2829940-2-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
References: <20220527051743.2829940-1-sunilvl@ventanamicro.com>
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

The hartid can be a 64bit value on RV64 platforms.

Modify the hartid variable type to unsigned long so that it can
hold 64bit value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Reviewed-by: Atish Patra <atishp@rivosinc.com>
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

