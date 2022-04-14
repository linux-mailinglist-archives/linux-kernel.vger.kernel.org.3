Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1CC2501B0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbiDNS2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344620AbiDNS1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 232FBCA6EB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649960711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HL5pQMcLinCa5lpQ9ME/83kavSCXQHBvPwq9DWXG7WM=;
        b=AZdCFhFnhM1nBXpczFzEldhp5Yng22HrN+Ka8yFmuo2dc3k6M5PoBs5cPY3ITvDUq418Zm
        A3Tver7J5CRFtKOCAADnfiE3MhqoCT1RD+cbXAFhk4ZRSUIt1wuJTQL/awXPXgPCNZ+sKh
        4JkcxXoHpqK8ONdqOfoNistSSfbBsuA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-JwvV2MmJPkutwmnJyRDk7w-1; Thu, 14 Apr 2022 14:25:10 -0400
X-MC-Unique: JwvV2MmJPkutwmnJyRDk7w-1
Received: by mail-qv1-f69.google.com with SMTP id 33-20020a0c8024000000b0043d17ffb0bdso5004052qva.18
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 11:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HL5pQMcLinCa5lpQ9ME/83kavSCXQHBvPwq9DWXG7WM=;
        b=MOvq8WuSRnNJ2CnZ5SLRbyJEHx7wSwY6oGeVu+airOdsJvdswWXB3NQHCoz8el8OX8
         9cRqdsZDo0NLYXbac1K5BoxrNdPO2ep7IZ1qYWL8/sgndy7YvnFIsL0Gf/J3BfBG619t
         rdBWOH+2EK8fstcnY0UAUFTXb2XxTh6VI7O74Mw3JLMQP+uxe9yuTFFIIMsmapggDMOY
         74s/YsFOGJuXQ6xzqfli/AlhFfvpIsRiU/bpB2ay1StRBuGWwJqJVRW4SELdzJWMI88H
         63axO6wFmgAsTEKp2Ypskj2ORKSEXZvQxtvVzEIBgzia+SYninneLgWfoPhPY6rpLf/O
         is0A==
X-Gm-Message-State: AOAM530IqpMvdCKv+ZHEumBeEeEd2UBVMUEq7X1RZfRAFQj/UKn4MNsH
        0H6acbQNM8zB/UAkky/9DwAQvaZuoqcatffeU1tcPrvZk5yfYMQMqd7rVNhozLRaQmNvb69s7D/
        4s+h36X8JEn7ROPA1bVisr+rl
X-Received: by 2002:a05:620a:13ed:b0:69c:b127:669e with SMTP id h13-20020a05620a13ed00b0069cb127669emr106162qkl.300.1649960709378;
        Thu, 14 Apr 2022 11:25:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw47oabuLffx/glhktFvdT7iwJ28SPYDL2BL+mN3+y0cB5QGpOTty2S2ZxgrKE/m7ODCJ6Dxg==
X-Received: by 2002:a05:620a:13ed:b0:69c:b127:669e with SMTP id h13-20020a05620a13ed00b0069cb127669emr106150qkl.300.1649960709127;
        Thu, 14 Apr 2022 11:25:09 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id t125-20020a372d83000000b0069c1df12422sm1336097qkh.84.2022.04.14.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 11:25:08 -0700 (PDT)
Date:   Thu, 14 Apr 2022 11:25:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <20220414182505.oirx3znjl7ceozq3@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
 <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
 <20220414170550.v2jmdfhmz7zbuug6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220414170550.v2jmdfhmz7zbuug6@treble>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 10:05:53AM -0700, Josh Poimboeuf wrote:
> On Thu, Apr 14, 2022 at 06:38:16PM +0200, Peter Zijlstra wrote:
> > On Thu, Apr 14, 2022 at 08:44:49AM -0700, Josh Poimboeuf wrote:
> > 
> > > Ok.  That was subtle, it needs a comment or two.  I had the distinct
> > > feeling I was introducing a bug, then I got distracted ;-)
> > 
> > Right, lemme try and not forget to write one ;-)
> 
> I'm rewriting the code anyway, I'll add some comments.
> 
> > > Doesn't the compiler give those special cases ENDBR anyway?  Just
> > > wondering why we avoid the warning for those.
> > 
> > Sure, but this is about not scribbling that ENDBR with a NOP.
> 
> Right, but it only prints warnings for data sections, despite marking
> others:
> 
> -                       dest = validate_ibt_reloc(file, reloc);
> -                       if (is_data && dest && !dest->noendbr)
> -                               warn_noendbr("data ", sec, reloc->offset, dest);


How about this?  This way it doesn't silence warnings for non
.data/.rodata, as other sections (including ksymtab) can also have valid
function pointers.  It also caught a bug(?) in putuser.S, as some of the
exported inner labels didn't have ENDBR.


diff --git a/arch/x86/include/asm/static_call.h b/arch/x86/include/asm/static_call.h
index 2455d721503e..2d8dacd02643 100644
--- a/arch/x86/include/asm/static_call.h
+++ b/arch/x86/include/asm/static_call.h
@@ -26,6 +26,7 @@
 	    ".align 4						\n"	\
 	    ".globl " STATIC_CALL_TRAMP_STR(name) "		\n"	\
 	    STATIC_CALL_TRAMP_STR(name) ":			\n"	\
+	    ANNOTATE_NOENDBR						\
 	    insns "						\n"	\
 	    ".byte 0x53, 0x43, 0x54				\n"	\
 	    ".type " STATIC_CALL_TRAMP_STR(name) ", @function	\n"	\
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index ecb2049c1273..b7dfd60243b7 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -48,6 +48,7 @@ SYM_FUNC_START(__put_user_1)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 1:	movb %al,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -62,6 +63,7 @@ SYM_FUNC_START(__put_user_2)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 2:	movw %ax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -76,6 +78,7 @@ SYM_FUNC_START(__put_user_4)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 3:	movl %eax,(%_ASM_CX)
 	xor %ecx,%ecx
@@ -90,6 +93,7 @@ SYM_FUNC_START(__put_user_8)
 	cmp %_ASM_BX,%_ASM_CX
 	jae .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
+	ENDBR
 	ASM_STAC
 4:	mov %_ASM_AX,(%_ASM_CX)
 #ifdef CONFIG_X86_32
diff --git a/arch/x86/lib/retpoline.S b/arch/x86/lib/retpoline.S
index 5f87bab4fb8d..b2b2366885a2 100644
--- a/arch/x86/lib/retpoline.S
+++ b/arch/x86/lib/retpoline.S
@@ -31,6 +31,7 @@
 	.align RETPOLINE_THUNK_SIZE
 SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 
 	ALTERNATIVE_2 __stringify(ANNOTATE_RETPOLINE_SAFE; jmp *%\reg), \
 		      __stringify(RETPOLINE \reg), X86_FEATURE_RETPOLINE, \
@@ -55,7 +56,6 @@ SYM_INNER_LABEL(__x86_indirect_thunk_\reg, SYM_L_GLOBAL)
 
 	.align RETPOLINE_THUNK_SIZE
 SYM_CODE_START(__x86_indirect_thunk_array)
-	ANNOTATE_NOENDBR // apply_retpolines
 
 #define GEN(reg) THUNK reg
 #include <asm/GEN-for-each-reg.h>
diff --git a/arch/x86/xen/xen-head.S b/arch/x86/xen/xen-head.S
index ac17196e2518..3a2cd93bf059 100644
--- a/arch/x86/xen/xen-head.S
+++ b/arch/x86/xen/xen-head.S
@@ -45,6 +45,7 @@ SYM_CODE_END(hypercall_page)
 	__INIT
 SYM_CODE_START(startup_xen)
 	UNWIND_HINT_EMPTY
+	ANNOTATE_NOENDBR
 	cld
 
 	/* Clear .bss */
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b09c416432b6..10e375c84088 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -3794,7 +3794,10 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 	return 1;
 }
 
-
+/*
+ * Validate IBT rules and mark used ENDBR instructions so the non-used ones can
+ * be sealed later by create_ibt_endbr_seal_sections().
+ */
 static int validate_ibt(struct objtool_file *file)
 {
 	struct section *sec;
@@ -3807,12 +3810,36 @@ static int validate_ibt(struct objtool_file *file)
 
 	for_each_sec(file, sec) {
 
-		if (!strstr(sec->name, ".data") && !strstr(sec->name, ".rodata"))
+		/* Already done by validate_ibt_insn() */
+		if (sec->sh.sh_flags & SHF_EXECINSTR)
 			continue;
 
 		if (!sec->reloc)
 			continue;
 
+		/*
+		 * These sections can reference text addresses, but not with
+		 * the intent to indirect branch to them.
+		 */
+		if (!strncmp(sec->name, ".discard", 8)			||
+		    !strncmp(sec->name, ".debug", 6)			||
+		    !strcmp(sec->name, ".altinstructions")		||
+		    !strcmp(sec->name, ".ibt_endbr_seal")		||
+		    !strcmp(sec->name, ".orc_unwind_ip")		||
+		    !strcmp(sec->name, ".parainstructions")		||
+		    !strcmp(sec->name, ".retpoline_sites")		||
+		    !strcmp(sec->name, ".smp_locks")			||
+		    !strcmp(sec->name, ".static_call_sites")		||
+		    !strcmp(sec->name, ".static_call_tramp_key")	||
+		    !strcmp(sec->name, "_error_injection_whitelist")	||
+		    !strcmp(sec->name, "_kprobe_blacklist")		||
+		    !strcmp(sec->name, "__bug_table")			||
+		    !strcmp(sec->name, "__ex_table")			||
+		    !strcmp(sec->name, "__jump_table")			||
+		    !strcmp(sec->name, "__mcount_loc")			||
+		    !strcmp(sec->name, "__tracepoints"))
+			continue;
+
 		list_for_each_entry(reloc, &sec->reloc->reloc_list, list)
 			warnings += validate_ibt_data_reloc(file, reloc);
 	}

