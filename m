Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FFE4CFD57
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiCGLsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbiCGLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:47:34 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF8266AE8;
        Mon,  7 Mar 2022 03:46:38 -0800 (PST)
Received: from integral2.. (unknown [182.2.38.152])
        by gnuweeb.org (Postfix) with ESMTPSA id 501337E6D0;
        Mon,  7 Mar 2022 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1646653598;
        bh=1JvYn827Bn9nDxhdSAqBIUF9kMGrVjukrbMIHARczbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AOiruQvPP/O3Opa9klPNfqJnq2c3aX34OdRiXUGMq7e29cgpLqZVWxEPdK8+ellAL
         mVMS+CnkphLiI7cWf4RWYWWJh8z3mtmHfqv6KTViq50Kt5z+kpD4lwJbpdFBmix+Am
         YCN6J4xeShFWCyHs7+EEOFlLgN7ttTBIH6hZ92oIa3x9M/tXVUy4AUHQzp+WXEU/L5
         nzSCh5ewc0qsm+qHNPhbJlAV5AHcbkwHUTpg1LxGTzzmfiWvLemLRqnLEa3KRNhnVp
         DbILO3oYqAFVVj8n93Fu+/aWsHIlkcdufTCS6J5shwWtFU7EXHHY+etiOB68m2QSHG
         esbnu3s8Y/Rgw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        gwml@vger.gnuweeb.org, x86@kernel.org
Subject: [PATCH v1 1/2] x86/include/asm: Avoid using INC and DEC instructions on hot paths
Date:   Mon,  7 Mar 2022 18:45:57 +0700
Message-Id: <20220307114558.1234494-2-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
References: <20220307114558.1234494-1-ammarfaizi2@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to take maximum advantage of out-of-order execution,
avoid using INC and DEC instructions when appropriate. INC/DEC
only writes to part of the flags register, which can cause a
partial flag register stall.

Agner Fog's optimization manual says [1]:
"""
  The INC and DEC instructions are inefficient on some CPUs because they
  write to only part of the flags register (excluding the carry flag).
  Use ADD or SUB instead to avoid false dependences or inefficient
  splitting of the flags register, especially if they are followed by
  an instruction that reads the flags.
"""

Intel's optimization manual 3.5.1.1 says [2]:
"""
  The INC and DEC instructions modify only a subset of the bits in the
  flag register. This creates a dependence on all previous writes of
  the flag register. This is especially problematic when these
  instructions are on the critical path because they are used to change
  an address for a load on which many other instructions depend.

  Assembly/Compiler Coding Rule 33. (M impact, H generality) INC and DEC
  instructions should be replaced with ADD or SUB instructions, because
  ADD and SUB overwrite all flags, whereas INC and DEC do not, therefore
  creating false dependencies on earlier instructions that set the flags.
"""

[1]: https://www.agner.org/optimize/optimizing_assembly.pdf
[2]: https://www.intel.com/content/dam/www/public/us/en/documents/manuals/64-ia-32-architectures-optimization-manual.pdf

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 arch/x86/include/asm/xor_32.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/xor_32.h b/arch/x86/include/asm/xor_32.h
index 67ceb790e639..7aa438f3df20 100644
--- a/arch/x86/include/asm/xor_32.h
+++ b/arch/x86/include/asm/xor_32.h
@@ -53,7 +53,7 @@ xor_pII_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 
 	"       addl $128, %1         ;\n"
 	"       addl $128, %2         ;\n"
-	"       decl %0               ;\n"
+	"       subl $1, %0           ;\n"
 	"       jnz 1b                ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2)
@@ -102,7 +102,7 @@ xor_pII_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $128, %1         ;\n"
 	"       addl $128, %2         ;\n"
 	"       addl $128, %3         ;\n"
-	"       decl %0               ;\n"
+	"       subl $1, %0           ;\n"
 	"       jnz 1b                ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
@@ -156,7 +156,7 @@ xor_pII_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $128, %2         ;\n"
 	"       addl $128, %3         ;\n"
 	"       addl $128, %4         ;\n"
-	"       decl %0               ;\n"
+	"       subl $1, %0           ;\n"
 	"       jnz 1b                ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3), "+r" (p4)
@@ -224,7 +224,7 @@ xor_pII_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $128, %3         ;\n"
 	"       addl $128, %4         ;\n"
 	"       addl $128, %5         ;\n"
-	"       decl %0               ;\n"
+	"       subl $1, %0           ;\n"
 	"       jnz 1b                ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
@@ -284,7 +284,7 @@ xor_p5_mmx_2(unsigned long bytes, unsigned long *p1, unsigned long *p2)
 
 	"       addl $64, %1         ;\n"
 	"       addl $64, %2         ;\n"
-	"       decl %0              ;\n"
+	"       subl $1, %0          ;\n"
 	"       jnz 1b               ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2)
@@ -341,7 +341,7 @@ xor_p5_mmx_3(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $64, %1         ;\n"
 	"       addl $64, %2         ;\n"
 	"       addl $64, %3         ;\n"
-	"       decl %0              ;\n"
+	"       subl $1, %0          ;\n"
 	"       jnz 1b               ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
@@ -407,7 +407,7 @@ xor_p5_mmx_4(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $64, %2         ;\n"
 	"       addl $64, %3         ;\n"
 	"       addl $64, %4         ;\n"
-	"       decl %0              ;\n"
+	"       subl $1, %0          ;\n"
 	"       jnz 1b               ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3), "+r" (p4)
@@ -490,7 +490,7 @@ xor_p5_mmx_5(unsigned long bytes, unsigned long *p1, unsigned long *p2,
 	"       addl $64, %3         ;\n"
 	"       addl $64, %4         ;\n"
 	"       addl $64, %5         ;\n"
-	"       decl %0              ;\n"
+	"       subl $1, %0          ;\n"
 	"       jnz 1b               ;\n"
 	: "+r" (lines),
 	  "+r" (p1), "+r" (p2), "+r" (p3)
-- 
2.32.0

