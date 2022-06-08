Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748845425CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiFHDxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiFHDwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:52:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E869014558D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:00:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BEC7617E8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 00:59:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9947C34114;
        Wed,  8 Jun 2022 00:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654649999;
        bh=D+/cKxFdXXKx+rm/kxaUmCwap5ETjW9x8xpDXmTcQQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=je5O+awFbTyfOxhQBKCKgT6KUCvzk1zrl2ki+WWoJlGB3WoakY8kOWcAlGtEs+0lN
         +uKv/jLSwQTIJTdhP2SsC68UV0Qi6gYqJUZ+FCqCIqiROCmwgIdrUBFMNz7UI0ZLhR
         jJxzFjprih6WDNmaQVpNNQrXjbeeChE9DiwBlUiBckgzEYerBML9//WuFxjoGO92D8
         BEuKn5JF2ARN+aigmlrQ9aa+gETkCVxSjdwreATidURwRPU6yvUiI5f02Emylpxx6t
         f3a8G3gOXBQ3MNtuyVu3rF/c1nNBzpy9r4adZhFXhcHec5u/kr10dLLrMAsbjBcztB
         e5nefTOBMIb0A==
Date:   Tue, 7 Jun 2022 17:59:56 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Joe Damato <jdamato@fastly.com>, "x86@kernel.org" <x86@kernel.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "bp@suse.de" <bp@suse.de>, "brgerst@gmail.com" <brgerst@gmail.com>
Subject: Re: 5.19-rc1 x86 build failure
Message-ID: <20220608005956.hzvx3fapdmp25oun@treble>
References: <CALALjgwSm07Cnbm6WaK74ZSs4wJ7hs4B3wLOe7h4Y-7sJ5cUWg@mail.gmail.com>
 <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74fdda90-f015-5cb9-a2d2-137baf090c59@citrix.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 12:42:33PM +0000, Andrew Cooper wrote:
> On 07/06/2022 13:19, Joe Damato wrote:
> >   96                            .pushsection .brk_reservation,"aw",@nobits
> >   97                            .brk.early_pgt_alloc:
> >   98 ???? 00000000              .skip ((2 * 3) * ((1UL) << 12))
> > ****  Error: missing ')'
> > ****  Error: missing ')'
> > ****  Error: missing ')'
> > ****  Error: junk at end of line, first unrecognized character is `U'
> >   98      0000
> >  100                            .popsection
> >
> > This comes from arch/x86/mm/init.c, which has the following code:
> >
> > RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
> >
> > wherein INIT_PGT_BUF_SIZE (via PAGE_SIZE) has a "1UL" which makes the
> > assembler unhappy.
> >
> > I don't really know what the correct way to fix this is; it seems that the
> > macro _AC should handle this if ASSEMBLY is defined, IIUC, but that does
> > not seem to be the case at this point in init.c.
> >
> > Perhaps I am doing something incorrect during the build process causing
> > this to happen?
> 
> The problem is that _AC() is evaluated in C context (so gains the UL/ULL
> suffix), and the C'd string is fed directly into the assembler (where
> older binutils doesn't tolerate the suffix).
> 
> Short of having a _PAGE_SIZE which is an explicitly non-AC()'d constant,
> I'm not sure what to suggest.  Ideally, you'd want to temporarily define
> __ASSEMBLY__ around the expansion of __stringify(), but I don't think
> that's possible as RESERVE_BRK() is a macro itself.

Joe, what version of binutils do you have?

We can fix this by taking a completely different approach: define the
variable in C and just do the "nobits" in the linker script, like below.
I can work up a proper patch tomorrow.


diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index 7590ac2570b9..4704184a2d78 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -108,19 +108,11 @@ extern unsigned long _brk_end;
 void *extend_brk(size_t size, size_t align);
 
 /*
- * Reserve space in the brk section.  The name must be unique within the file,
+ * Reserve space in the .brk section.  The name must be unique within vmlinux,
  * and somewhat descriptive.  The size is in bytes.
- *
- * The allocation is done using inline asm (rather than using a section
- * attribute on a normal variable) in order to allow the use of @nobits, so
- * that it doesn't take up any space in the vmlinux file.
  */
 #define RESERVE_BRK(name, size)						\
-	asm(".pushsection .brk_reservation,\"aw\",@nobits\n\t"		\
-	    ".brk." #name ":\n\t"					\
-	    ".skip " __stringify(size) "\n\t"				\
-	    ".size .brk." #name ", " __stringify(size) "\n\t"		\
-	    ".popsection\n\t")
+	char __brk_##name[size] __section(".brk_reservation");
 
 extern void probe_roms(void);
 #ifdef __i386__
@@ -133,12 +125,16 @@ asmlinkage void __init x86_64_start_reservations(char *real_mode_data);
 
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
+#define RESERVE_BRK(name, size)				\
+	.pushsection .brk_reservation, "aw";		\
+__brk_##name:						\
+1:	.skip size;					\
+	.size __brk_##name, . - 1b;			\
 	.popsection
+
 #endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_SETUP_H */
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 91831b9d8aa8..f105b8aa055e 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -392,7 +392,7 @@ SECTIONS
 	__end_of_kernel_reserve = .;
 
 	. = ALIGN(PAGE_SIZE);
-	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
+	.brk (NOLOAD) : AT(ADDR(.brk) - LOAD_OFFSET) {
 		__brk_base = .;
 		. += 64 * 1024;		/* 64k alignment slop space */
 		*(.brk_reservation)	/* areas brk users have reserved */
