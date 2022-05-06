Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 632A251DB9D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359768AbiEFPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442695AbiEFPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B000C6D18E;
        Fri,  6 May 2022 08:09:05 -0700 (PDT)
Date:   Fri, 06 May 2022 15:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EPjCxQti1gT9Rl7reFvr/8P2eXzoNeLa9Vvtum+Gr0=;
        b=2NDqpw7Mivgwn6mCbyrT1BrzO8qOvlAojbBjAhCaL29GynVH2Hd/Bh195BqkRXUaJmJ58L
        TnMzUO8wCOO72DcNxIKGpD70b24LOI6jx+YPVUnfxR5qczdaGUl9fpGZLq0VkHf+2KTGgF
        H4tOCSUqMgWy1PTrlcR/GZSmHA4qA1Qb+HV18S+eiuVY4FexPu0pvkX5D+c6t5TudgC8NI
        82ush/t4OsMjOq1da1Z5PHgaswg83RUXcs8rNstvOB0VP7BxrdPHlEz/rDU+lfdaOMDD60
        lASWvViErw97pXk5hPHki3fezpcIcNRxywDCL3KC7udUc+Aja+4gveIhgYyeVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849744;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6EPjCxQti1gT9Rl7reFvr/8P2eXzoNeLa9Vvtum+Gr0=;
        b=4KnvgdPzoprA13aGy/wDGbUQ21Mcy+8JIeNdUSCDKMZTN+ARP+Xr/rC7RxQLwJ4vQtjD6D
        pKaVITONz2kAo3DQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/mm: Simplify RESERVE_BRK()
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.133110232@infradead.org>
References: <20220506121631.133110232@infradead.org>
MIME-Version: 1.0
Message-ID: <165184974325.4207.14003566040747100498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     a1e2c031ec3949b8c039b739c0b5bf9c30007b00
Gitweb:        https://git.kernel.org/tip/a1e2c031ec3949b8c039b739c0b5bf9c30007b00
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Fri, 06 May 2022 14:14:32 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 15:26:33 +02:00

x86/mm: Simplify RESERVE_BRK()

RESERVE_BRK() reserves data in the .brk_reservation section.  The data
is initialized to zero, like BSS, so the macro specifies 'nobits' to
prevent the data from taking up space in the vmlinux binary.  The only
way to get the compiler to do that (without putting the variable in .bss
proper) is to use inline asm.

The macro also has a hack which encloses the inline asm in a discarded
function, which allows the size to be passed (global inline asm doesn't
allow inputs).

Remove the need for the discarded function hack by just stringifying the
size rather than supplying it as an input to the inline asm.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.133110232@infradead.org
---
 arch/x86/include/asm/setup.h | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 896e48d..bec5ff4 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -109,27 +109,19 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within
- * the file, and somewhat descriptive.  The size is in bytes.  Must be
- * used at file scope.
+ * Reserve space in the brk section.  The name must be unique within the file,
+ * and somewhat descriptive.  The size is in bytes.
  *
- * (This uses a temp function to wrap the asm so we can pass it the
- * size parameter; otherwise we wouldn't be able to.  We can't use a
- * "section" attribute on a normal variable because it always ends up
- * being @progbits, which ends up allocating space in the vmlinux
- * executable.)
+ * The allocation is done using inline asm (rather than using a section
+ * attribute on a normal variable) in order to allow the use of @nobits, so
+ * that it doesn't take up any space in the vmlinux file.
  */
-#define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __noendbr __used notrace	\
-	__brk_reservation_fn_##name##__(void) {				\
-		asm volatile (						\
-			".pushsection .brk_reservation,\"aw\",@nobits;" \
-			".brk." #name ":"				\
-			" 1:.skip %c0;"					\
-			" .size .brk." #name ", . - 1b;"		\
-			" .popsection"					\
-			: : "i" (sz));					\
-	}
+#define RESERVE_BRK(name, size)						\
+	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
+	    ".brk." #name ":\n\t"					\
+	    ".skip " __stringify(size) "\n\t"				\
+	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
+	    ".popsection\n\t")
 
 extern void probe_roms(void);
 #ifdef __i386__
