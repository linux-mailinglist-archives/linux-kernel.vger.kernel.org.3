Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB845B28C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiIHVz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiIHVz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:55:27 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CFAB0B1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:55:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33d9f6f4656so156983417b3.21
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 14:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date;
        bh=Gg7blUelcbN7qCzxZRpzw0uqSkfWrgRvEPc3Jh+AGuI=;
        b=ia0mK6/3LNsDfoYzbHMLDe/Bm1t826rzdpHAzZD5775IYWo4gZwL/vhPEACv3v4i34
         lq8oC5OmgNyajyhPpb1WyFRIREwi56qcUb0xYjeodQU2bgPGqBYzVvZtVnNOMbs++dUZ
         UEfQ41zDLzfgGBeUZnE84Wg1Xvxk0UFi3F3FTVPpJUrG5dfAqRgKVfuDymS6niBwZv9G
         gJaED/gEDYQP0tRcV7yC8FCnerRS7w/kgE9o2/R8MdsXMYNfRG05I1aGgBTlB+G6Q/jo
         hw9BorlSsY0Byownprpk3/jgEUoE83i7P5H9k/rzRinpjgr9ZLEQhJVy8nl6EUzZSRB1
         oa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=Gg7blUelcbN7qCzxZRpzw0uqSkfWrgRvEPc3Jh+AGuI=;
        b=Vebo4+/qt3aLM9q+LiPT2jz36wLAKcYfteR+T51bzDIOm9d6XiBdiroMZoqZ6stIiS
         tH5jVjisksZl03PVc7Yc7eJkV2YUyfWgsAtYWhRwwuYh/V/1bHw6eV9G4dokhjFIfere
         WAkFir/atXpSqMt0jEOsG/lQV8EZSH8lg+U2izfiEhRDxxjqo7iFyob2YnOVX47T9/vH
         4vxhweBNhyMsow2J/dyJM0O1lzzkyCRzVZP1ibw1jo8cBx4BYN2OBrkfRnVASjpF+zRA
         MZhjZgLZoB0wLwe6eROfdly2HSXtWtdAC9UJtPjfdnYAL5y+phH/6S9Kg7PHD5NdtGLE
         HXVA==
X-Gm-Message-State: ACgBeo0bQp/iDa8U+v4M23DrHbtAtp7waxoA7TyhrDUBIUlh2fBXhrJ0
        mlSrt5IP6vmr4YOVSZ46ydsmiZSYcn/m+6kbK5+KgX+heoqpVLzLypW+1iICrQ849Gp5HEfJnie
        1iqszJ+bs1ZNUMG/f0FVdgh5xefcv/+JnxEAsQgVyydk3naBZ98t2SLTqLD4CSAjKDMHZNvDXbf
        smxeMEDFSpzQ==
X-Google-Smtp-Source: AA6agR4X+8dv6wxztc3FFDp1riYH8GRhKqIOBYUaVMcoH5wOteT0L/O9RmbG5Wnl9HfvSlwB/mJrCWySI3f6n0PQNmI=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:a4e4:e6ec:9fdd:1bdd])
 (user=samitolvanen job=sendgmr) by 2002:a81:6f8b:0:b0:346:4554:9c4c with SMTP
 id k133-20020a816f8b000000b0034645549c4cmr9580284ywc.252.1662674122538; Thu,
 08 Sep 2022 14:55:22 -0700 (PDT)
Date:   Thu,  8 Sep 2022 14:54:48 -0700
In-Reply-To: <20220908215504.3686827-1-samitolvanen@google.com>
Message-Id: <20220908215504.3686827-7-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220908215504.3686827-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=3414; i=samitolvanen@google.com;
 h=from:subject; bh=64pVxZWyQcGNuQmdr6/Dl0+aZxLli0ezdxw+xqvhWN8=;
 b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBjGmSzxWLFazYBWZrnKGdYa76NwTUQXE13SBQSA60z
 IffYke6JAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYxpkswAKCRBMtfaEi7xW7pz3C/
 4nl7102I5DmW5DNSsOybkktukaOfZLGTigGAZeHlmXot3PR3vQifVocPxdq8dFjyHhC27vFzyrj8QW
 2+yeEA2G0hmpDUJosWLHVFqCOtRAnXSYO2Y396cYc4xBWqF8PhMgVltaIJJahzjcdEIOF9fkPt0CBE
 GaG8RtPs4/zr3Pbs9ZC4AdUuvj29Q9ms7vyK5qs994VRWe4SRdQlg0Bj+C6qxvHRWuPMiPaeVmHTHu
 Q/GYlSf+8cwYrZCq7IfSuE7hkYo214TaXi9NwQ9aElLfgyiZHGttxh+ws7Kin1+cVxcdL4wd73m8W5
 NSgriSje09Ch/qPNR4aBDJOZwYxo2OAjCm2Q24l9TrzlbBZqVx+AYH+1xqPbaEwpve/qRRxf8HJ22A
 7ZaVaYp95JhAWDd40cc3La4gZt6i05A0HYpO/XlL62H2TgyEgMI0WfT9xQrQzByi96j6gH2ZS0mVRc
 Nw3RVwbMWguE4ppgggFszxEqZ7Xk/cmKpGUzMTYMj4BKU=
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Subject: [PATCH v5 06/22] cfi: Add type helper macros
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
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

With CONFIG_CFI_CLANG, assembly functions called indirectly
from C code must be annotated with type identifiers to pass CFI
checking.  In order to make this easier, the compiler emits a
__kcfi_typeid_<function> symbol for each address-taken function
declaration in C, which contains the expected type identifier that
we can refer to in assembly code.

Add a typed version of SYM_FUNC_START, which emits the type
identifier before the function. Architectures that support KCFI can
define their own __CFI_TYPE macro to override the default preamble
format.

As an example, for the x86_64 blowfish_dec_blk function, the
compiler emits the following type symbol:

$ readelf -sW vmlinux | grep __kcfi_typeid_blowfish_dec_blk
120204: 00000000ef478db5     0 NOTYPE  WEAK   DEFAULT  ABS
	__kcfi_typeid_blowfish_dec_blk

And SYM_TYPED_FUNC_START will generate the following preamble based
on the __CFI_TYPE definition for the architecture:

$ objdump -dr arch/x86/crypto/blowfish-x86_64-asm_64.o
     ...
0000000000000400 <__cfi_blowfish_dec_blk>:
     ...
     40b:       b8 00 00 00 00          mov    $0x0,%eax
                   40c: R_X86_64_32 __kcfi_typeid_blowfish_dec_blk

0000000000000410 <blowfish_dec_blk>:
     ...

Note that the address of all assembly functions annotated with
SYM_TYPED_FUNC_START must be taken in C code that's linked into the
binary or the missing __kcfi_typeid_ symbol will result in a linker
error with CONFIG_CFI_CLANG. If the code that contains the indirect
call is not always compiled in, __ADDRESSABLE(functionname) can be
used to ensure that the __kcfi_typeid_ symbol is emitted.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Kees Cook <keescook@chromium.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---
 include/linux/cfi_types.h | 45 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 include/linux/cfi_types.h

diff --git a/include/linux/cfi_types.h b/include/linux/cfi_types.h
new file mode 100644
index 000000000000..6b8713675765
--- /dev/null
+++ b/include/linux/cfi_types.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Clang Control Flow Integrity (CFI) type definitions.
+ */
+#ifndef _LINUX_CFI_TYPES_H
+#define _LINUX_CFI_TYPES_H
+
+#ifdef __ASSEMBLY__
+#include <linux/linkage.h>
+
+#ifdef CONFIG_CFI_CLANG
+/*
+ * Use the __kcfi_typeid_<function> type identifier symbol to
+ * annotate indirectly called assembly functions. The compiler emits
+ * these symbols for all address-taken function declarations in C
+ * code.
+ */
+#ifndef __CFI_TYPE
+#define __CFI_TYPE(name)				\
+	.4byte __kcfi_typeid_##name
+#endif
+
+#define SYM_TYPED_ENTRY(name, linkage, align...)	\
+	linkage(name) ASM_NL				\
+	align ASM_NL					\
+	__CFI_TYPE(name) ASM_NL				\
+	name:
+
+#define SYM_TYPED_START(name, linkage, align...)	\
+	SYM_TYPED_ENTRY(name, linkage, align)
+
+#else /* CONFIG_CFI_CLANG */
+
+#define SYM_TYPED_START(name, linkage, align...)	\
+	SYM_START(name, linkage, align)
+
+#endif /* CONFIG_CFI_CLANG */
+
+#ifndef SYM_TYPED_FUNC_START
+#define SYM_TYPED_FUNC_START(name) 			\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)
+#endif
+
+#endif /* __ASSEMBLY__ */
+#endif /* _LINUX_CFI_TYPES_H */
-- 
2.37.2.789.g6183377224-goog

