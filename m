Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D25146A102
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387165AbhLFQTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381091AbhLFQTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:19:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713D2C04979F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:12:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1456861370
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13504C341C6;
        Mon,  6 Dec 2021 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638807158;
        bh=FbVUfMtlrUmynM5GSIR2jyniuTQu6HS+1BJoIHuyhIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nvQ+cK5HnoWNb/L0NqoY7XfHUz5r4CqrLksxkylnrp990aoQ1ZBiJZcwZfCTs22p0
         nmIFLmqu9cif6hoTjgAwJNvQzvWHGm8RlixRySanrkS0shvhqTERJEqjAPDBzJR4Ko
         n+QHCF+u4Ew5xuWvsF9/cfMNdUCskqH0g6CgyJNxnSV8Oay7d/mxUs7jBT3gAPzLZp
         eOsqjixa9h1hl5MNrSnfkBZPYi0rtfRr1StTEELG6iJ5JaU68Hax8n7i+31/HfxSnj
         BRu2e0iplUwnUBTlqZbtc4FFlFHKzv73g2WfLrYDsjKsvKOOC0VNbn3pD80tGsmUAm
         8TglsEVNIVBEA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: [PATCH v2 2/5] riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Tue,  7 Dec 2021 00:05:11 +0800
Message-Id: <20211206160514.2000-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index a15640eeb334..84879a5ce818 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -748,7 +748,6 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
-#ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -765,6 +764,8 @@ static void __init reserve_crashkernel(void)
 
 	int ret = 0;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
 	/*
 	 * Don't reserve a region for a crash kernel on a crash kernel
 	 * since it doesn't make much sense and we have limited memory
@@ -805,7 +806,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-#endif /* CONFIG_KEXEC_CORE */
 
 void __init paging_init(void)
 {
@@ -819,9 +819,7 @@ void __init misc_mem_init(void)
 	arch_numa_init();
 	sparse_init();
 	zone_sizes_init();
-#ifdef CONFIG_KEXEC_CORE
 	reserve_crashkernel();
-#endif
 	memblock_dump_all();
 }
 
-- 
2.34.1

