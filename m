Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8555D586EBE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiHAQjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiHAQjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:39:10 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561B38D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:39:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [92.49.173.143])
        by mail.ispras.ru (Postfix) with ESMTPSA id E9E79407625E;
        Mon,  1 Aug 2022 16:39:07 +0000 (UTC)
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
Subject: [PATCH 2/8] x86/build: Remove RWX sections and align on 4KB
Date:   Mon,  1 Aug 2022 19:38:59 +0300
Message-Id: <b8be83a2b27ebf47dc15e650787de01fe277ad83.1659369873.git.baskov@ispras.ru>
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

Avoid creating sections with maximal privileges to prepare for W^X
implementation. Align sections on page size (4KB) to allow protecting
them in page table.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 15f29053cec4..6587e0201b50 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -102,12 +102,11 @@ jiffies = jiffies_64;
 PHDRS {
 	text PT_LOAD FLAGS(5);          /* R_E */
 	data PT_LOAD FLAGS(6);          /* RW_ */
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_SMP
+#if defined(CONFIG_X86_64) && defined(CONFIG_SMP)
 	percpu PT_LOAD FLAGS(6);        /* RW_ */
 #endif
-	init PT_LOAD FLAGS(7);          /* RWE */
-#endif
+	inittext PT_LOAD FLAGS(5);      /* R_E */
+	init PT_LOAD FLAGS(6);          /* RW_ */
 	note PT_NOTE FLAGS(0);          /* ___ */
 }
 
@@ -226,9 +225,10 @@ SECTIONS
 #endif
 
 	INIT_TEXT_SECTION(PAGE_SIZE)
-#ifdef CONFIG_X86_64
-	:init
-#endif
+	:inittext
+
+	. = ALIGN(PAGE_SIZE);
+
 
 	/*
 	 * Section for code used exclusively before alternatives are run. All
@@ -240,6 +240,7 @@ SECTIONS
 	.altinstr_aux : AT(ADDR(.altinstr_aux) - LOAD_OFFSET) {
 		*(.altinstr_aux)
 	}
+	:init
 
 	INIT_DATA_SECTION(16)
 
-- 
2.35.1

