Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 355FE46716B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350457AbhLCFWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:22:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:33374 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349243AbhLCFWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:22:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41F5F6295A
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:19:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F68C53FD0;
        Fri,  3 Dec 2021 05:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508760;
        bh=B71rQ+fNXM16LM47OdH86wRkLVWIAb35br+fzuzSHJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZCbjVkSOnULAfcIFVLS25gQ3yFkJtv6i85o1SvTuCcq8KEA1X7cddy5R12NLvSL/J
         Rq73NTTJvkYyTHkvqW4VRm01m+5JXgVK+jvIHnyYPTXSVfOBETzujMNGTdXNiWCLOS
         VUUcAqi7oA0ZPLV4342e1tEPJT229ZQFOO52RH6rVr5VDsymeHl0ebD2m3Ez+QtNJG
         y9XfLElDn5VhSNwKCNZLqY8B7RNUCdt2v41N1AhbX2ejkzqLhBhrh5fnOC7ifhYVZj
         EBpypc8QsAjBuXJdOYAPnyIJ/2rXojJ4b6Hdho5Gma+5H9s7cjH+TVuj6a0WrvZJDT
         mSvbuFtAPRpAQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Will Deacon <will@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org
Subject: [RFC PATCH 2/5] riscv: mm: init: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Fri,  3 Dec 2021 13:11:54 +0800
Message-Id: <20211203051157.2160-3-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203051157.2160-1-jszhang@kernel.org>
References: <20211203051157.2160-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_BLK_DEV_INITRD)", to simplify the
code and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index aeae7d6b2fee..704e2463e976 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -755,7 +755,6 @@ static inline void setup_vm_final(void)
 }
 #endif /* CONFIG_MMU */
 
-#ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -772,6 +771,8 @@ static void __init reserve_crashkernel(void)
 
 	int ret = 0;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
 	/*
 	 * Don't reserve a region for a crash kernel on a crash kernel
 	 * since it doesn't make much sense and we have limited memory
@@ -812,7 +813,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-#endif /* CONFIG_KEXEC_CORE */
 
 void __init paging_init(void)
 {
@@ -826,9 +826,7 @@ void __init misc_mem_init(void)
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

