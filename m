Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C46586EC2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233904AbiHAQjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233274AbiHAQjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:39:13 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35FEC0C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:39:12 -0700 (PDT)
Received: from localhost.localdomain (unknown [92.49.173.143])
        by mail.ispras.ru (Postfix) with ESMTPSA id D9A09407626A;
        Mon,  1 Aug 2022 16:39:10 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH 8/8] x86/boot: Remove mapping from page fault handler
Date:   Mon,  1 Aug 2022 19:39:05 +0300
Message-Id: <25ecf8d7109600757b69ea167cc964419878ec21.1659369873.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1659369873.git.baskov@ispras.ru>
References: <cover.1659369873.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After every implicit mapping is removed, this code is no longer needed.

Remove memory mapping from page fault handler to ensure that there are
no hidden invalid memory accesses.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 04022c080114..ad24289cc224 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -393,27 +393,21 @@ void do_boot_page_fault(struct pt_regs *regs, unsigned long error_code)
 {
 	unsigned long address = native_read_cr2();
 	unsigned long end;
-	bool ghcb_fault;
+	char *msg;
 
-	ghcb_fault = sev_es_check_ghcb_fault(address);
+	if (sev_es_check_ghcb_fault(address))
+		msg = "Page-fault on GHCB page:";
+	else
+		msg = "Unexpected page-fault:";
 
 	address   &= PMD_MASK;
 	end        = address + PMD_SIZE;
 
 	/*
-	 * Check for unexpected error codes. Unexpected are:
-	 *	- Faults on present pages
-	 *	- User faults
-	 *	- Reserved bits set
-	 */
-	if (error_code & (X86_PF_PROT | X86_PF_USER | X86_PF_RSVD))
-		do_pf_error("Unexpected page-fault:", error_code, address, regs->ip);
-	else if (ghcb_fault)
-		do_pf_error("Page-fault on GHCB page:", error_code, address, regs->ip);
-
-	/*
-	 * Error code is sane - now identity map the 2M region around
-	 * the faulting address.
+	 * Since all memory allocations are made explicit
+	 * now, every page fault at this stage is an
+	 * error and the error handler is there only
+	 * for debug purposes.
 	 */
-	kernel_add_identity_map(address, end, MAP_WRITE);
+	do_pf_error(msg, error_code, address, regs->ip);
 }
-- 
2.35.1

