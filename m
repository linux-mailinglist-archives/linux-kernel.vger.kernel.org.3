Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923E457FB84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiGYIko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiGYIkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:40:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB5AF16
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gq7so9767577pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JRx05kPh3Ii0mpG7hTQJSpxflPSjOu6HTrFUf3L55sY=;
        b=b/gJd3iUl8OERmp+WyI5dC15jE1/7lh4kN0ML2m8TDjjg5+A09Zs5c/jcux/umjCNB
         E9b2j3m11+23MfAV2gUuOIwI4Tafw/ldONvsGh4u2J8Vpdcvltmgs6t+k5KXpZzo0VZ9
         Y1b6DFFSZs/j7GucnJod6cEQ+zQ5+1cbLlm3Gk94Vu/bqLd4ImYU+t3/WYn7oY+2dhKr
         B5ZHR1BDmNOKRNaElyjk4HYwq9sdhws0NKdtm4Z0V+ls3QKwWfZFpeMSsVggUD+tsR9v
         ydOTI29C1Ubsavi5EufYYWVC6mJ2f1KC1HCQCHSHAQ8jJXNmCUzdmst8S5xXiUUZic+Q
         lmXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JRx05kPh3Ii0mpG7hTQJSpxflPSjOu6HTrFUf3L55sY=;
        b=jlJm4TKI0Vt4bVvZTu5uddykoH/tnBJfE1YyWCs7ryRu8o4G1RTZz4FGz7xIXv0SbM
         RDMWKu3q44IDYWr9fI7JBhQNa0ymuWQRphs5OrsqNUb4XfhAiBChvTDFTbY0XWH7f8tz
         AO/3d4+/G0c8zzIS53QGiBCKLdtdZPw8qMIJ+BChz6MSDKltEoUg9WDziRWfH3JE4G36
         DGElONZ49sFuszDni4kMF/ipIZizMLopAXAtjkfOdbQb+yr8HEoCFG4z1k/IUTsQzvj3
         OFIn/l0I83o59oSnUXAgs91uhJoeBp9vu6xaTKDRQmuQZ9f73Chor2hDS03Y0H21iDfE
         SX8w==
X-Gm-Message-State: AJIora8d33KnmPY3WNgE8otwHi4ayQVH+2XL0rBWANNRKlWdQ4x3rn5/
        w9LpPtIckCIKHo54T1xFrmVgrQ==
X-Google-Smtp-Source: AGRyM1vlctvOgVdFh/Fgb7CwxXla4DK2/n69hV3Zju/JQYHyXfZs1xGC4mXFAdMg4Fh/tEID47FsXQ==
X-Received: by 2002:a17:902:c401:b0:16d:8109:4f18 with SMTP id k1-20020a170902c40100b0016d81094f18mr2037084plk.32.1658738439453;
        Mon, 25 Jul 2022 01:40:39 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.40.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:40:39 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-kbuild@vger.kernel.org
Subject: [PATCH 4/4] x86: boot: avoid memory copy if kernel is uncompressed
Date:   Mon, 25 Jul 2022 16:38:56 +0800
Message-Id: <20220725083904.56552-5-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

1、if kernel is uncompressed. we do not need to relocate
kernel image for decompression

2、if kaslr is disabled, we do not need to do a memory copy
before prase_elf.

Two memory copies can be skipped with this patch. this can
save aboat 20ms during booting.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/boot/compressed/head_64.S |  8 ++++++--
 arch/x86/boot/compressed/misc.c    | 22 +++++++++++++++++-----
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index d33f060900d2..9e7770c7047b 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -398,10 +398,13 @@ SYM_CODE_START(startup_64)
 1:
 
 	/* Target address to relocate to for decompression */
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+	movq %rbp, %rbx
+#else
 	movl	BP_init_size(%rsi), %ebx
 	subl	$ rva(_end), %ebx
 	addq	%rbp, %rbx
-
+#endif
 	/* Set up the stack */
 	leaq	rva(boot_stack_end)(%rbx), %rsp
 
@@ -522,6 +525,7 @@ trampoline_return:
  * Copy the compressed kernel to the end of our buffer
  * where decompression in place becomes safe.
  */
+#ifndef CONFIG_KERNEL_UNCOMPRESSED
 	pushq	%rsi
 	leaq	(_bss-8)(%rip), %rsi
 	leaq	rva(_bss-8)(%rbx), %rdi
@@ -531,7 +535,7 @@ trampoline_return:
 	rep	movsq
 	cld
 	popq	%rsi
-
+#endif
 	/*
 	 * The GDT may get overwritten either during the copy we just did or
 	 * during extract_kernel below. To avoid any issues, repoint the GDTR
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index c23c0f525d93..d8445562d4e9 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -290,7 +290,7 @@ static inline void handle_relocations(void *output, unsigned long output_len,
 { }
 #endif
 
-static void parse_elf(void *output)
+static void parse_elf(void *output, void *input)
 {
 #ifdef CONFIG_X86_64
 	Elf64_Ehdr ehdr;
@@ -302,7 +302,7 @@ static void parse_elf(void *output)
 	void *dest;
 	int i;
 
-	memcpy(&ehdr, output, sizeof(ehdr));
+	memcpy(&ehdr, input, sizeof(ehdr));
 	if (ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
 	   ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
 	   ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
@@ -317,7 +317,7 @@ static void parse_elf(void *output)
 	if (!phdrs)
 		error("Failed to allocate space for phdrs");
 
-	memcpy(phdrs, output + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
+	memcpy(phdrs, input + ehdr.e_phoff, sizeof(*phdrs) * ehdr.e_phnum);
 
 	for (i = 0; i < ehdr.e_phnum; i++) {
 		phdr = &phdrs[i];
@@ -334,7 +334,7 @@ static void parse_elf(void *output)
 #else
 			dest = (void *)(phdr->p_paddr);
 #endif
-			memmove(dest, output + phdr->p_offset, phdr->p_filesz);
+			memmove(dest, input + phdr->p_offset, phdr->p_filesz);
 			break;
 		default: /* Ignore other PT_* */ break;
 		}
@@ -467,9 +467,21 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 #endif
 
 	debug_putstr("\nDecompressing Linux... ");
+
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+	if (cmdline_find_option_bool("nokaslr")) {
+		parse_elf(output, input_data);
+	} else {
+		__decompress(input_data, input_len, NULL, NULL, output, output_len,
+				NULL, error);
+		parse_elf(output, output);
+	}
+#else
 	__decompress(input_data, input_len, NULL, NULL, output, output_len,
 			NULL, error);
-	parse_elf(output);
+	parse_elf(output, output);
+#endif
+
 	handle_relocations(output, output_len, virt_addr);
 	debug_putstr("done.\nBooting the kernel.\n");
 
-- 
2.31.1

