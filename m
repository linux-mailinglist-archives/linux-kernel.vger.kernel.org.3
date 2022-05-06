Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8251CE1D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 04:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387791AbiEFBNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 21:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387795AbiEFBNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 21:13:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868B16004A;
        Thu,  5 May 2022 18:10:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5C1562006;
        Fri,  6 May 2022 01:10:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8BEC385A4;
        Fri,  6 May 2022 01:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651799406;
        bh=hzTsanNVV38HYHQUJN2xutlIzXpivxib3Q/T7DjiyGs=;
        h=From:To:Cc:Subject:Date:From;
        b=pZCfAc1mWv3g9kzjL4L0pgUMR/b/yxZ+h/SpIizPx90F+QuOlQZW2S0syqCkEWlTp
         W3iyAkH+a5xIMFtJEMl8hD7Ot8ruqlUYIEmBz4mrDXvC5VGIpsUU6HQqDzXJfOlpc3
         QerSZgKRYjqa7uaN4bkd3Zw2c0NG/7Y77RlEKT5irxHcV4f0WtaObwJSSDsK//2z1r
         SNXP1ftOPnm68VQ8DS5zIvjW7M7XVJR0iMMPXwllXZDvJmkFSBbPTquPpvchGOxEkc
         inqJUN4mnWCA9AJe5I2N22kjCfJ8lLooWI3DEMAMGmcly390GXneDDY6Tpn53akJ+h
         LhArxheKTOkxQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org
Subject: [PATCH] bug: Use normal relative pointers in 'struct bug_entry'
Date:   Thu,  5 May 2022 18:09:45 -0700
Message-Id: <afddb4548e93f6458ec1d9ec185a834c348eda33.1651798983.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_GENERIC_BUG_RELATIVE_POINTERS, the addr/file relative
pointers are calculated weirdly: based on the beginning of the bug_entry
struct address, rather than their respective pointer addresses.

Make the relative pointers less surprising to both humans and tools by
calculating them the normal way.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/arm64/include/asm/asm-bug.h |  4 ++--
 arch/powerpc/include/asm/bug.h   |  5 +++--
 arch/riscv/include/asm/bug.h     |  4 ++--
 arch/s390/include/asm/bug.h      |  5 +++--
 arch/x86/include/asm/bug.h       |  2 +-
 lib/bug.c                        | 15 +++++++--------
 6 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
index 03f52f84a4f3..c762038ba400 100644
--- a/arch/arm64/include/asm/asm-bug.h
+++ b/arch/arm64/include/asm/asm-bug.h
@@ -14,7 +14,7 @@
 	14472:	.string file;					\
 		.popsection;					\
 								\
-		.long 14472b - 14470b;				\
+		.long 14472b - .;				\
 		.short line;
 #else
 #define _BUGVERBOSE_LOCATION(file, line)
@@ -25,7 +25,7 @@
 #define __BUG_ENTRY(flags) 				\
 		.pushsection __bug_table,"aw";		\
 		.align 2;				\
-	14470:	.long 14471f - 14470b;			\
+	14470:	.long 14471f - .;			\
 _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
 		.short flags; 				\
 		.popsection;				\
diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index ecbae1832de3..76252576d889 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -13,7 +13,8 @@
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 .macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
-5001:	 .4byte \addr - 5001b, 5002f - 5001b
+5001:	 .4byte \addr - .
+	 .4byte 5002f - .
 	 .short \line, \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
@@ -24,7 +25,7 @@
 #else
 .macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
-5001:	 .4byte \addr - 5001b
+5001:	 .4byte \addr - .
 	 .short \flags
 	 .org 5001b+BUG_ENTRY_SIZE
 	 .previous
diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index d3804a2f9aad..1aaea81fb141 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -30,8 +30,8 @@
 typedef u32 bug_insn_t;
 
 #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - 2b"
-#define __BUG_ENTRY_FILE	RISCV_INT " %0 - 2b"
+#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
+#define __BUG_ENTRY_FILE	RISCV_INT " %0 - ."
 #else
 #define __BUG_ENTRY_ADDR	RISCV_PTR " 1b"
 #define __BUG_ENTRY_FILE	RISCV_PTR " %0"
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index 0b25f28351ed..aebe1e22c7be 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -15,7 +15,8 @@
 		"1:	.asciz	\""__FILE__"\"\n"		\
 		".previous\n"					\
 		".section __bug_table,\"awM\",@progbits,%2\n"	\
-		"2:	.long	0b-2b,1b-2b\n"			\
+		"2:	.long	0b-.\n"				\
+		"	.long	1b-.\n"				\
 		"	.short	%0,%1\n"			\
 		"	.org	2b+%2\n"			\
 		".previous\n"					\
@@ -30,7 +31,7 @@
 	asm_inline volatile(					\
 		"0:	mc	0,0\n"				\
 		".section __bug_table,\"awM\",@progbits,%1\n"	\
-		"1:	.long	0b-1b\n"			\
+		"1:	.long	0b-.\n"				\
 		"	.short	%0\n"				\
 		"	.org	1b+%1\n"			\
 		".previous\n"					\
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index aaf0cb0db4ae..a3ec87d198ac 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -18,7 +18,7 @@
 #ifdef CONFIG_X86_32
 # define __BUG_REL(val)	".long " __stringify(val)
 #else
-# define __BUG_REL(val)	".long " __stringify(val) " - 2b"
+# define __BUG_REL(val)	".long " __stringify(val) " - ."
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
diff --git a/lib/bug.c b/lib/bug.c
index 45a0584f6541..c223a2575b72 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -6,8 +6,7 @@
 
   CONFIG_BUG - emit BUG traps.  Nothing happens without this.
   CONFIG_GENERIC_BUG - enable this code.
-  CONFIG_GENERIC_BUG_RELATIVE_POINTERS - use 32-bit pointers relative to
-	the containing struct bug_entry for bug_addr and file.
+  CONFIG_GENERIC_BUG_RELATIVE_POINTERS - use 32-bit relative pointers for bug_addr and file
   CONFIG_DEBUG_BUGVERBOSE - emit full file+line information for each BUG
 
   CONFIG_BUG and CONFIG_DEBUG_BUGVERBOSE are potentially user-settable
@@ -53,10 +52,10 @@ extern struct bug_entry __start___bug_table[], __stop___bug_table[];
 
 static inline unsigned long bug_addr(const struct bug_entry *bug)
 {
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	return bug->bug_addr;
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	return (unsigned long)&bug->bug_addr_disp + bug->bug_addr_disp;
 #else
-	return (unsigned long)bug + bug->bug_addr_disp;
+	return bug->bug_addr;
 #endif
 }
 
@@ -131,10 +130,10 @@ void bug_get_file_line(struct bug_entry *bug, const char **file,
 		       unsigned int *line)
 {
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
-	*file = bug->file;
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	*file = (const char *)&bug->file_disp + bug->file_disp;
 #else
-	*file = (const char *)bug + bug->file_disp;
+	*file = bug->file;
 #endif
 	*line = bug->line;
 #else
-- 
2.34.1

