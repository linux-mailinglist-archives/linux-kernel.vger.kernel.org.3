Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE45946716E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350423AbhLCFW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:22:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52264 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378497AbhLCFWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:22:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EDCBB825BD
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:19:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A1FC53FAD;
        Fri,  3 Dec 2021 05:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508769;
        bh=kRChCS06ixTKVgpe7b9Wuqso2wFqw6W6lFZFIfBAfZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iE9FKuBVEQloHyNsn2y92aOUC57PTVDh6lCAmD20cAeOCFQUMGhsEPjGXDgPoryte
         Kctd+FU9xSTV1yrHfy9k8eFg57vj4/ezmXf5vLqWZDNF8pfWjTtLaglXNCg75UmdPE
         Wjn1LcXP7SwfC1HFqvSZhp5gzkhzaqkPYbvznZzG07by4zbpgVzbwQdOHngz3aWSWS
         ezpw/2GLRQTVCfT32lpGndQg2Ac52N67WsYfC6XnIexjTGK30ni4fjwHZ/tI3pSCsw
         rFyfAw1RYv/7ktRzNf9B3MouLWlYGP7QyVDkn5WZgu/+ngvWry3x0Su1hRuh+e5d3E
         QyPWDrnYBN1Fg==
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
Subject: [RFC PATCH 4/5] arm64: mm: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Fri,  3 Dec 2021 13:11:56 +0800
Message-Id: <20211203051157.2160-5-jszhang@kernel.org>
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
 arch/arm64/mm/init.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8834434af99..b4b8b4dc2d31 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -64,7 +64,6 @@ EXPORT_SYMBOL(memstart_addr);
  */
 phys_addr_t arm64_dma_phys_limit __ro_after_init;
 
-#ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
  *
@@ -78,6 +77,9 @@ static void __init reserve_crashkernel(void)
 	unsigned long long crash_max = arm64_dma_phys_limit;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
 	/* no crashkernel= or invalid value specified */
@@ -110,11 +112,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.start = crash_base;
 	crashk_res.end = crash_base + crash_size - 1;
 }
-#else
-static void __init reserve_crashkernel(void)
-{
-}
-#endif /* CONFIG_KEXEC_CORE */
 
 /*
  * Return the maximum physical address for a zone accessible by the given bits
-- 
2.34.1

