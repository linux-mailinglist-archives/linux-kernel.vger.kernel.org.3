Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6122346668B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359011AbhLBPhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358986AbhLBPhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:37:18 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B5AC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 07:33:56 -0800 (PST)
Received: from cap.home.8bytes.org (p5b006edb.dip0.t-ipconnect.de [91.0.110.219])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by theia.8bytes.org (Postfix) with ESMTPSA id 76DC8D98;
        Thu,  2 Dec 2021 16:33:50 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>,
        Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v4 1/4] x86/realmode: Add comment for Global bit usage in trampline_pgd
Date:   Thu,  2 Dec 2021 16:32:23 +0100
Message-Id: <20211202153226.22946-2-joro@8bytes.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202153226.22946-1-joro@8bytes.org>
References: <20211202153226.22946-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Document the fact that using the trampoline_pgd will result in the
creation of global TLB entries in the user range of the address
space.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 1895986842b9..4ba024d5b63a 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -714,6 +714,11 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 static void __init init_trampoline(void)
 {
 #ifdef CONFIG_X86_64
+	/*
+	 * The code below will alias kernel page-tables in the user-range of the
+	 * address space, including the Global bit. So global TLB entries will
+	 * be created when using the trampoline page-table.
+	 */
 	if (!kaslr_memory_enabled())
 		trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
 	else
-- 
2.34.0

