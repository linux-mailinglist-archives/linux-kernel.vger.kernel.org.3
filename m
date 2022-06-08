Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553485437C9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 17:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244496AbiFHPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244495AbiFHPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 11:40:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144921D4DCA
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 08:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A277661660
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:40:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F52DC34116;
        Wed,  8 Jun 2022 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654702845;
        bh=GsWVqc7XzgmQHs4ZWCcfzxRQCgs9g36OS+NZTt7px0k=;
        h=From:To:Cc:Subject:Date:From;
        b=S5pzktxw6sdwCGR9T8aNjCxMkWwPC//aWub0AoSR980/v99s8J7jljm6QgqaIOYn9
         K2bBXzI2fnQaiH+a8gswIjirpuYxYncGu2vHlvsMiFkFEfOqAp65U6qRuveaiS7V8o
         rfh9PmUmAksDUqW65UeRtvQbnZGUA6e+YTFLltrXmU2pYyiHFvlqxfo3PjP3rJi1dw
         gQL6Yd9hyg1GifzkepBmKwY/y9EiELm68g/7TErrmlxUguDl8GCjyHRo93RSFaOPU/
         drZjcGWP6KQh4kahgn+PfaMHO3yY+6+YS35Ho1AADEjbh+PMw5uNgEvW29ZVEFEL1S
         0u89WxZC/fU7A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        jiangshanlai@gmail.com, bp@suse.de, brgerst@gmail.com,
        Joe Damato <jdamato@fastly.com>
Subject: [PATCH] x86/mm: Fix RESERVE_BRK() for older binutils
Date:   Wed,  8 Jun 2022 08:40:42 -0700
Message-Id: <a802eefebee4d2c01f479a7d3f2008fdd32ce270.1654702810.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With binutils 2.26, RESERVE_BRK() causes a build failure:

  /tmp/ccnGOKZ5.s: Assembler messages:
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: missing ')'
  /tmp/ccnGOKZ5.s:98: Error: junk at end of line, first unrecognized
  character is `U'

The problem is this line:

  RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE)

Specifically, the INIT_PGT_BUF_SIZE macro which (via PAGE_SIZE's use
_AC()) has a "1UL", which makes older versions of the assembler unhappy.
Unfortunately the _AC() macro doesn't work for inline asm.

Fix it (and further simplify RESERVE_BRK) by taking a completely
different approach.  Instead of specifying the "nobits" at compile-time,
do so at link-time.  Then the variable can just be allocated in C.

Note this changes the name of the variable from .brk.##name to
__brk_##name.  The variable names aren't actually used anywhere, so it's
harmless.

Reported-by: Joe Damato <jdamato@fastly.com>
Fixes: a1e2c031ec39 ("x86/mm: Simplify RESERVE_BRK()")
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/setup.h  | 35 +++++++++++++++++------------------
 arch/x86/kernel/vmlinux.lds.S |  2 +-
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 7590ac2570b9..ef9bb6caad8c 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,19 +108,11 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within the file,
- * and somewhat descriptive.  The size is in bytes.
- *
- * The allocation is done using inline asm (rather than using a section
- * attribute on a normal variable) in order to allow the use of @nobits, so
- * that it doesn't take up any space in the vmlinux file.
+ * Reserve space in the .brk section.  The size is in bytes.
  */
-#define RESERVE_BRK(name, size)						\
-	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
-	    ".brk." #name ":\n\t"					\
-	    ".skip " __stringify(size) "\n\t"				\
-	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
-	    ".popsection\n\t")
+#define RESERVE_BRK(name, size)					\
+	__section(".brk_reservation") __aligned(1) __used	\
+	static char __brk_##name[size]
 
 extern void probe_roms(void);
 #ifdef __i386__
@@ -133,12 +125,19 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
 #endif /* __i386__ */
 #endif /* _SETUP */
-#else
-#define RESERVE_BRK(name,sz)				\
-	.pushsection .brk_reservation,"aw",@nobits;	\
-.brk.name:						\
-1:	.skip sz;					\
-	.size .brk.name,.-1b;				\
+
+#else  /* __ASSEMBLY */
+
+.macro __RESERVE_BRK name, size
+	.pushsection .brk_reservation, "aw"
+SYM_DATA_START(__brk_\name)
+	.skip \size
+SYM_DATA_END(__brk_\name)
 	.popsection
+.endm
+
+#define RESERVE_BRK(name, size) __RESERVE_BRK name, size
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index f5f6dc2e8007..9b63f8a00b4f 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -385,7 +385,7 @@ SECTIONS
 	__end_of_kernel_reserve = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
 		*(.brk_reservation)	/* areas brk users have reserved */
-- 
2.34.3

