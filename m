Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2075ABDAF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 09:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232158AbiICHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 03:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231938AbiICHhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 03:37:12 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADFA6B647
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 00:37:10 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n65-20020a17090a5ac700b001fbb4fad865so4111208pji.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 00:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=TRjdZ5wv7TGj2dbhnTTosWtWiTwiuyAySTktBtV/oLA=;
        b=fZ7qHg2UkC5J55XwycIcRBo2f1aBd70QTZFgbhHkaYVZ0QEwwCg5W4xbLiGxYW2m4A
         CgFR0V62Vyhx8+fpMrXrw9e1zHZmV4VvofXCV9Ro+pbWe4422LsjwU/8DecQ3ByJJnFH
         FJ5GNOr21p8H7tlY621c8jp2O3pERJXZHIBkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=TRjdZ5wv7TGj2dbhnTTosWtWiTwiuyAySTktBtV/oLA=;
        b=DJ8Jo4wA0MIQo6IU298OouZ5DIGsgh1qs1H5eg8WAARuClMRUVoFyV9bWnqyhXSPBz
         g+M0hpUMtFCVN8MGfW9HYOc0jfFpmFbCCF6xQM2f1uLo1SgItCACHLt8L1pn1luKtpE6
         w1UWq+RP+mKRj9gGIpsOkZlQ4AQU7Zsc6P+xRpcz7m1ZYVu9xmU9JIUxwr1B32VN1o7r
         fFl3SspiSoRjYcxrCf1f+YSXky5LAoPIcV8QCW5OJae/5jQdB301Rn/y3KfZu8HEBVdy
         K6ma1cs5dAOt1kY6yLnc6vBCOCMr+VnYyjGz1CodPPb9haZcTBotcMggfYNyupG74H5v
         JZdw==
X-Gm-Message-State: ACgBeo1K/0cfU8MvcmywjOI1fmxX8i0IQsTrwpQIa6hi0nFwEB5tMc4+
        TY20dPl8axvOxtzvM7AoFE2JBA==
X-Google-Smtp-Source: AA6agR6koJ8Nc5OcljqQD/TIdFP0jZF9IQEZbJjcMcSDGKN3ZQ4h6ti44frnlipIuxFPlQ3D4EUJFQ==
X-Received: by 2002:a17:90b:4c52:b0:1f6:3a26:9f08 with SMTP id np18-20020a17090b4c5200b001f63a269f08mr8988743pjb.206.1662190630094;
        Sat, 03 Sep 2022 00:37:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bj9-20020a056a02018900b0041bcd8f3958sm2576524pgb.44.2022.09.03.00.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Sep 2022 00:37:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     Kees Cook <keescook@chromium.org>,
        "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Bill Wendling <morbo@google.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86/paravirt: Remove clobber bitmask from .parainstructions
Date:   Sat,  3 Sep 2022 00:37:06 -0700
Message-Id: <20220903073706.3193746-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6150; h=from:subject; bh=GlMz8OWkNVbxTaAtgCqIh3RPBynHRYV53eTnQGN6fyc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjEwQinZXGFy/YYoobhm51aQd64HCGonG2x2lG7pbJ Vk+GVHuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYxMEIgAKCRCJcvTf3G3AJi/RD/ wKRO3upEsU/k2VRfMII35z56cSyELpAn5DI2IeUK4RQEG+tgzjx673NruyMrQeB+ziuc87Nwl5sv64 AahmZyybK+FltRFBYlcLkgS1yz7zK1qjqBkYOynoSuJ+s3XgXD+FzLelEp+Qkasslrs3HIR+99rf0G +k4aR6uSejn9nkQTHbkFYZF1aUgX2LFvNzax3wldgpDj1O2z+LpQfpUgiLGE1RfL/TatZ1YZY3mnx1 mZJh8WfJYiPOrdUrpsfjlsm6qUM8WVgW3aXWAQfuX9j7tceDFncZ6sW+Ol3IhryrI+dKXX/bT92wLP hgUcDUZIvk3Yq1+UA4C6SiU0NiEOIGU9KOPgCxvtv49VZFSmRJTZISlRWMgei+4tADhMWUPw/GlKUB p0uASFCy1WDHKRIKu9emFEDTjzZWkwRdsTiIenkNKG4GVkWvuahoJeHBMY/UDsHex753xzByVAVWNu 87rq2DeIKWWM6kBXv/2ocBplO8Zy9jLOYwvz2Vhoa819mgt2UaQG5oA41oPv8CpmWIFvPTIvGjOP1s HEA45PJTSHUE+v1fRaW8UjHDkP2JsTI9dPIgHJdLFqcpvMkJgHGb2vWiM8ADZVx3iFWCQcINog2hEN T+XOo7K6I5FRQGMcbo+3I+UmSxLidCmUdJqxLo09ioAYm3dejSYrOLzeRuew==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The u16 "clobber" value is not used in .parainstructions since commit
27876f3882fd ("x86/paravirt: Remove clobbers from struct paravirt_patch_site")

Remove the u16 from the section macro, the argument from all macros, and
all now-unused CLBR_* macros.

Cc: Juergen Gross <jgross@suse.com>
Cc: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Bill Wendling <morbo@google.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/paravirt_types.h | 61 ++++++---------------------
 1 file changed, 12 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 89df6c6617f5..7869c9e825df 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -2,37 +2,6 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_H
 #define _ASM_X86_PARAVIRT_TYPES_H
 
-/* Bitmask of what can be clobbered: usually at least eax. */
-#define CLBR_EAX  (1 << 0)
-#define CLBR_ECX  (1 << 1)
-#define CLBR_EDX  (1 << 2)
-#define CLBR_EDI  (1 << 3)
-
-#ifdef CONFIG_X86_32
-/* CLBR_ANY should match all regs platform has. For i386, that's just it */
-#define CLBR_ANY  ((1 << 4) - 1)
-
-#define CLBR_ARG_REGS	(CLBR_EAX | CLBR_EDX | CLBR_ECX)
-#define CLBR_RET_REG	(CLBR_EAX | CLBR_EDX)
-#else
-#define CLBR_RAX  CLBR_EAX
-#define CLBR_RCX  CLBR_ECX
-#define CLBR_RDX  CLBR_EDX
-#define CLBR_RDI  CLBR_EDI
-#define CLBR_RSI  (1 << 4)
-#define CLBR_R8   (1 << 5)
-#define CLBR_R9   (1 << 6)
-#define CLBR_R10  (1 << 7)
-#define CLBR_R11  (1 << 8)
-
-#define CLBR_ANY  ((1 << 9) - 1)
-
-#define CLBR_ARG_REGS	(CLBR_RDI | CLBR_RSI | CLBR_RDX | \
-			 CLBR_RCX | CLBR_R8 | CLBR_R9)
-#define CLBR_RET_REG	(CLBR_RAX)
-
-#endif /* X86_64 */
-
 #ifndef __ASSEMBLY__
 
 #include <asm/desc_defs.h>
@@ -279,26 +248,22 @@ extern struct paravirt_patch_template pv_ops;
 #define paravirt_type(op)				\
 	[paravirt_typenum] "i" (PARAVIRT_PATCH(op)),	\
 	[paravirt_opptr] "m" (pv_ops.op)
-#define paravirt_clobber(clobber)		\
-	[paravirt_clobber] "i" (clobber)
-
 /*
  * Generate some code, and mark it as patchable by the
  * apply_paravirt() alternate instruction patcher.
  */
-#define _paravirt_alt(insn_string, type, clobber)	\
+#define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
 	_ASM_ALIGN "\n"					\
 	_ASM_PTR " 771b\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	"  .short " clobber "\n"			\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
 #define paravirt_alt(insn_string)					\
-	_paravirt_alt(insn_string, "%c[paravirt_typenum]", "%c[paravirt_clobber]")
+	_paravirt_alt(insn_string, "%c[paravirt_typenum]")
 
 /* Simple instruction patching code. */
 #define NATIVE_LABEL(a,x,b) "\n\t.globl " a #x "_" #b "\n" a #x "_" #b ":\n\t"
@@ -441,20 +406,19 @@ int paravirt_disable_iospace(void);
 	})
 
 
-#define ____PVOP_CALL(ret, op, clbr, call_clbr, extra_clbr, ...)	\
+#define ____PVOP_CALL(ret, op, call_clbr, extra_clbr, ...)	\
 	({								\
 		PVOP_CALL_ARGS;						\
 		PVOP_TEST_NULL(op);					\
 		asm volatile(paravirt_alt(PARAVIRT_CALL)		\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
-#define ____PVOP_ALT_CALL(ret, op, alt, cond, clbr, call_clbr,		\
+#define ____PVOP_ALT_CALL(ret, op, alt, cond, call_clbr,		\
 			  extra_clbr, ...)				\
 	({								\
 		PVOP_CALL_ARGS;						\
@@ -463,45 +427,44 @@ int paravirt_disable_iospace(void);
 					 alt, cond)			\
 			     : call_clbr, ASM_CALL_CONSTRAINT		\
 			     : paravirt_type(op),			\
-			       paravirt_clobber(clbr),			\
 			       ##__VA_ARGS__				\
 			     : "memory", "cc" extra_clbr);		\
 		ret;							\
 	})
 
 #define __PVOP_CALL(rettype, op, ...)					\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op, CLBR_ANY,		\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op,				\
 		      PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_ALT_CALL(rettype, op, alt, cond, ...)			\
-	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op, alt, cond, CLBR_ANY,\
+	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op, alt, cond,		\
 			  PVOP_CALL_CLOBBERS, EXTRA_CLOBBERS,		\
 			  ##__VA_ARGS__)
 
 #define __PVOP_CALLEESAVE(rettype, op, ...)				\
-	____PVOP_CALL(PVOP_RETVAL(rettype), op.func, CLBR_RET_REG,	\
+	____PVOP_CALL(PVOP_RETVAL(rettype), op.func,			\
 		      PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 #define __PVOP_ALT_CALLEESAVE(rettype, op, alt, cond, ...)		\
 	____PVOP_ALT_CALL(PVOP_RETVAL(rettype), op.func, alt, cond,	\
-			  CLBR_RET_REG, PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
+			  PVOP_CALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
 #define __PVOP_VCALL(op, ...)						\
-	(void)____PVOP_CALL(, op, CLBR_ANY, PVOP_VCALL_CLOBBERS,	\
+	(void)____PVOP_CALL(, op, PVOP_VCALL_CLOBBERS,			\
 		       VEXTRA_CLOBBERS, ##__VA_ARGS__)
 
 #define __PVOP_ALT_VCALL(op, alt, cond, ...)				\
-	(void)____PVOP_ALT_CALL(, op, alt, cond, CLBR_ANY,		\
+	(void)____PVOP_ALT_CALL(, op, alt, cond,			\
 				PVOP_VCALL_CLOBBERS, VEXTRA_CLOBBERS,	\
 				##__VA_ARGS__)
 
 #define __PVOP_VCALLEESAVE(op, ...)					\
-	(void)____PVOP_CALL(, op.func, CLBR_RET_REG,			\
+	(void)____PVOP_CALL(, op.func,					\
 			    PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 #define __PVOP_ALT_VCALLEESAVE(op, alt, cond, ...)			\
-	(void)____PVOP_ALT_CALL(, op.func, alt, cond, CLBR_RET_REG,	\
+	(void)____PVOP_ALT_CALL(, op.func, alt, cond,			\
 				PVOP_VCALLEE_CLOBBERS, , ##__VA_ARGS__)
 
 
-- 
2.34.1

