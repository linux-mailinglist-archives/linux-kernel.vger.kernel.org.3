Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F355ABA39
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiIBViI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbiIBVh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:37:59 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA50EF5CCF
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 14:37:57 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id a19-20020aa780d3000000b0052bccd363f8so1610934pfn.22
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 14:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=HDZJ0lSRQoma7HASH55s+Lq3/kCI0PVAr3SKG55mmDE=;
        b=rBbZGj2hyaPbBdrQ8ZAtAd8fBVTk/aNT+PMfh4D+6g9Dnr1lJ+8WgvE2JpQSQ5mpKr
         LT2dmPZTqjjH4ka2YE7gNLcVOQ7eD+OWNfyQ2AkU6DMz3lRStI2yu9n2MfIPoTx7L5ey
         +2YIepUmQxsASZ4ckcGjskYeuPdVvt1j/Wcq+jPORMIzjcCPcV4PD0zHxpxeC1Oq2wre
         +8hAszoekk7kAiAJsqgWbZ2ymL+wkxPxV5ctB6USiI8NBgGNkPygEfA6Bm89F2jwk/eS
         piZC+qd+beRl05PxC+rpuQfD/8nEToe3qBGP0kiN2/ERGnRCwcAREuiF7Yu7Hu4WltFr
         fYMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=HDZJ0lSRQoma7HASH55s+Lq3/kCI0PVAr3SKG55mmDE=;
        b=Kn+G9Q0suaGh6iGYP2regRgsv17jpE5UcnanBRA2vj14oscQF2q8p9D319i7DQDO13
         fSzltOHqLAkbPYQ/3tLE0KKbFAG02ImLgaPRv6CYct2xJnKiinQybE1OnmnCFZ0ZElrj
         COzum8crtIXP8ZFaTkj8r4mtm0H/VXi+oNFhnTCQvpw4hMq7EipYTjaxSBcG7H53W3WC
         4PDB9xaLvCK+F7ZOdrjRFbFTOPbDBzFzzNciNyVEngrodQIN9PoYKXoHcMrz0p+rIYX3
         dRXIL7G9kYAzBBVlaB+EyhXOjwMKq+O6qtRbV9Icjy9xnoqVxFytIGWR7v3Nfuto3VYO
         cjhA==
X-Gm-Message-State: ACgBeo2/ACkx4ewNzLFjek5eb8g6EFQfjQ8Td1ZHCURjlV/ktarcng/F
        6xAoQahGDfHIDB02I0mH00kIN5Bi
X-Google-Smtp-Source: AA6agR6rg/qLo+yQa1/A/MnMpENNlMrew4RjKFVFUDSg5m3sigIjZqHtxPyD4LsEch28EwHGn9DhXIq91Q==
X-Received: from fawn.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5795])
 (user=morbo job=sendgmr) by 2002:a17:90b:264a:b0:1fd:f88d:dbad with SMTP id
 pa10-20020a17090b264a00b001fdf88ddbadmr7040192pjb.93.1662154677243; Fri, 02
 Sep 2022 14:37:57 -0700 (PDT)
Date:   Fri,  2 Sep 2022 21:37:50 +0000
In-Reply-To: <20220902213750.1124421-1-morbo@google.com>
Mime-Version: 1.0
References: <20220902213750.1124421-1-morbo@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220902213750.1124421-3-morbo@google.com>
Subject: [PATCH 2/2] x86/paravirt: add extra clobbers with ZERO_CALL_USED_REGS enabled
From:   Bill Wendling <morbo@google.com>
To:     Juergen Gross <jgross@suse.com>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Cc:     Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZERO_CALL_USED_REGS feature may zero out caller-saved registers
before returning.

In spurious_kernel_fault(), the "pte_offset_kernel()" call results in
this assembly code:

.Ltmp151:
        #APP
        # ALT: oldnstr
.Ltmp152:
.Ltmp153:
.Ltmp154:
        .section        .discard.retpoline_safe,"",@progbits
        .quad   .Ltmp154
        .text

        callq   *pv_ops+536(%rip)

.Ltmp155:
        .section        .parainstructions,"a",@progbits
        .p2align        3, 0x0
        .quad   .Ltmp153
        .byte   67
        .byte   .Ltmp155-.Ltmp153
        .short  1
        .text
.Ltmp156:
        # ALT: padding
        .zero   (-(((.Ltmp157-.Ltmp158)-(.Ltmp156-.Ltmp152))>0))*((.Ltmp157-.Ltmp158)-(.Ltmp156-.Ltmp152)),144
.Ltmp159:
        .section        .altinstructions,"a",@progbits
.Ltmp160:
        .long   .Ltmp152-.Ltmp160
.Ltmp161:
        .long   .Ltmp158-.Ltmp161
        .short  33040
        .byte   .Ltmp159-.Ltmp152
        .byte   .Ltmp157-.Ltmp158
        .text

        .section        .altinstr_replacement,"ax",@progbits
        # ALT: replacement 1
.Ltmp158:
        movq    %rdi, %rax
.Ltmp157:
        .text
        #NO_APP
.Ltmp162:
        testb   $-128, %dil

The "testb" here is using %dil, but the %rdi register was cleared before
returning from "callq *pv_ops+536(%rip)". Adding the proper constraints
results in the use of a different register:

        movq    %r11, %rdi

        # Similar to above.

        testb   $-128, %r11b

Link: https://github.com/KSPP/linux/issues/192
Signed-off-by: Bill Wendling <morbo@google.com>
Reported-and-tested-by: Nathan Chancellor <nathan@kernel.org>
---
 arch/x86/include/asm/paravirt_types.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index f04157456a49..b1ab5d94881b 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -414,8 +414,17 @@ int paravirt_disable_iospace(void);
 				"=c" (__ecx)
 #define PVOP_CALL_CLOBBERS	PVOP_VCALL_CLOBBERS, "=a" (__eax)
 
-/* void functions are still allowed [re]ax for scratch */
+/*
+ * void functions are still allowed [re]ax for scratch.
+ *
+ * The ZERO_CALL_USED REGS feature may end up zeroing out callee-saved
+ * registers. Make sure we model this with the appropriate clobbers.
+ */
+#ifdef CONFIG_ZERO_CALL_USED_REGS
+#define PVOP_VCALLEE_CLOBBERS	"=a" (__eax), PVOP_VCALL_CLOBBERS
+#else
 #define PVOP_VCALLEE_CLOBBERS	"=a" (__eax)
+#endif
 #define PVOP_CALLEE_CLOBBERS	PVOP_VCALLEE_CLOBBERS
 
 #define EXTRA_CLOBBERS	 , "r8", "r9", "r10", "r11"
-- 
2.37.2.789.g6183377224-goog

