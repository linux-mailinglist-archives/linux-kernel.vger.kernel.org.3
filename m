Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90E1E467159
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240900AbhLCFN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:13:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48370 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241336AbhLCFN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:13:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0DE9AB81C9D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26A01C53FAD;
        Fri,  3 Dec 2021 05:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508231;
        bh=wLyXrGyMh/xyPpvoTxp6H3MxZHIYwAnCnaLXA4jnF9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqNMSnrDTGrcmtr8IHC95HsIFwNSqly0CyFS545X9YL2brKGOTnngM9u3Q/HxQScv
         5FarSpg1+rmVsvh6UZ0J91dgpPUUFnx0VCs5/ewvCENGtTVJcDEtjUwWoQJVfjPCa9
         lyYyakwky+J626KhimtR6qj02rHA7U3MMPW1/LExRft7obRuZocuwz1Ak6wiN0s/Xc
         pESAx4fDdmRKO0aDnyLCvyBlSz+CdWteYMHqV/oks63CE4ioh7eelzPfRxia/bnG5a
         I6RZOcD4T84bMYogORfOuNU9YVAimRsazktgurHOdvipiZOS+ohVBJXFvvW3tBeo+I
         hClQGX/iQW1SQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] riscv: mm: init: remove unnecessary "#ifdef CONFIG_CRASH_DUMP"
Date:   Fri,  3 Dec 2021 13:03:13 +0800
Message-Id: <20211203050317.2102-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203050317.2102-1-jszhang@kernel.org>
References: <20211203050317.2102-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The is_kdump_kernel() returns false for !CRASH_DUMP case, so we don't
need the #ifdef CONFIG_CRASH_DUMP for is_kdump_kernel() checking.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 3c0649dba4ff..745f26a3b02e 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -790,12 +790,10 @@ static void __init reserve_crashkernel(void)
 	 * since it doesn't make much sense and we have limited memory
 	 * resources.
 	 */
-#ifdef CONFIG_CRASH_DUMP
 	if (is_kdump_kernel()) {
 		pr_info("crashkernel: ignoring reservation request\n");
 		return;
 	}
-#endif
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
-- 
2.34.1

