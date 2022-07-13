Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8C573F03
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbiGMVbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiGMVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:31:38 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912324948
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:31:37 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id o18so11578902pgu.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 14:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faovg0APXwsBZurX2E7/mhKATFIwpSIytN1XAZxfjKw=;
        b=i4VExXfcxatbto9dlBTX5BnONNJL9cje1H5VnhnKVeIxAYF3UOeA0gvTx0rfr0lVoo
         +0SDB6+elYwaqdbF9OeP/dIAjWKP8TiVMpgbUWfSwbvIvtITt9eqbalnYaEbMhUCoFMk
         QCTu6uOGqeGfnQYFM3gMpQHVoMHREkqk5JtIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=faovg0APXwsBZurX2E7/mhKATFIwpSIytN1XAZxfjKw=;
        b=Tf7ILGqN4N1KxcQco3avH8Ql4HFD82nnAmXwbqmv+cx6c3ZqLTQmPhM+w4TZg7w00U
         F/rm8U+mqM4Yak5kP7KToIK9tj9+4Nk5sjQDHr2DCob4/6KXeTFmLagTGktpUMdXnISR
         kKvJRT2UOZQnE8xamPXN7w1Sf9/CDdP8nqoNhKu4H9fAcrmgD7nXvvKIsf17B36YNtnm
         Ia+2j9ubf/CnXq2m5xSsErIQmNpws4PFQKQA2YGvak02P/P9xt8RVR/anB45WC2uWMO0
         W3RtK7rkJwlk+eIPTklOiUW8DaZK+6rKG3u6D4FF8j9JNKgJTMpvTrLF9/nOmzBlvuiq
         A13w==
X-Gm-Message-State: AJIora/T2v0khhwG+2CHdv5vwzehsSi3shX2zzQ2XxxRRtphBZ269rEI
        AlSTIvfl29qcLnWjZGXKnAGTuw==
X-Google-Smtp-Source: AGRyM1uc/6Ttnj7h1DTVK+hDssQD8GFzCqJaWlnKT5UZwIa636VX5xkmzUmO9kDI7dtgBcmE24k12g==
X-Received: by 2002:a63:195d:0:b0:412:50b8:c410 with SMTP id 29-20020a63195d000000b0041250b8c410mr4373873pgz.520.1657747896992;
        Wed, 13 Jul 2022 14:31:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i5-20020a1709026ac500b0015f2b3bc97asm9313209plt.13.2022.07.13.14.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 14:31:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel test robot <oliver.sang@intel.com>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH] x86: Allow for exclusions in checking RETHUNK
Date:   Wed, 13 Jul 2022 14:31:33 -0700
Message-Id: <20220713213133.455599-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3107; h=from:subject; bh=nO5LJoKss5jfm9QauonmCnKJHsgnROyl7K2WMaRujUk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBizzm1Ea1/Ygk7y0PBrqVq9uV0qdgGqdUf/sxK/Lqv H1702OuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYs85tQAKCRCJcvTf3G3AJt9sEA CF5JHhveuc4pye5WU7x5vXTjLx0VDQ/GExZCJszMeSjOLgmjCYTXHt7Qu++issRGgLfHLfdDi08A8o hbe5Km4c1CB//5jjm/1VTnb8/OAtUAXNZgabLDGA6dFgcGfgnxnn9Uql425TiC93UAw0gfs6iISjP+ VeetRaAFDyaMOEwZrHOOv4wJgX/dWOEpSmW630srgX1S5eG50sEn82mvpX/t6deCRt8gm9xjLTOeOx P9mBkRVnEEelQ831fqPBFyGTSkOcr4AFDeWCBEDVYob76cEJetAg0IB1IOG7q9lt34MvRXBv5qVglZ +7E6jeK0XxplQHMX7kEmI9VttTPukJWB7SbMKv5rQ5s6bt8xa/XOIPw+8MLJBJ5pxEv/ZHKeziiPbB 0n+FL+DFXjxCBrTqVab0PV0QiB9oCBDhHA4hahfEVfrglDi9nvCMW8iCb5PL4dUM8VXIcFNvIJw/Jl GtRuLFNqlFm8dz0UpKCkv2126ZeDIZCjYXz7Ar8nZdU2oyHo4cgq2idwpeTgcp1TOXKfacSvOiD8IM am16Wz0mqB0KDX+Duny3qkzi+re1JzF/967G2wwJy1JlAEXn3Ndm7FTKcas8pVSeHsLe8DSlkiRXza y1XUL0bi0Z0o2xH0PDuxND2kM1HWK8m0rBvwPfaMxnC6lLTgdmfBqnME9f4w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKDTM builds a "just return" function that lives in .rodata, but this
creates problems when validating alternatives in the face of RETHUNK.
Export RETHUNK_CFLAGS so they can be disabled for the LKDTM function,
and ask objtool to ignore this function. (Use of STACK_FRAME_NON_STANDARD
here seems to generate a non-.rela section, that needed to be adjusted.)

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/lkml/Ys58BxHxoDZ7rfpr@xsang-OptiPlex-9020/
Debugged-by: Peter Zijlstra <peterz@infradead.org>
Fixes: ee88d363d156 ("x86,static_call: Use alternative RET encoding")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Makefile           | 1 +
 drivers/misc/lkdtm/Makefile | 2 +-
 drivers/misc/lkdtm/rodata.c | 4 ++++
 tools/objtool/check.c       | 4 +++-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1f40dad30d50..7854685c5f25 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -27,6 +27,7 @@ RETHUNK_CFLAGS		:= -mfunction-return=thunk-extern
 RETPOLINE_CFLAGS	+= $(RETHUNK_CFLAGS)
 endif
 
+export RETHUNK_CFLAGS
 export RETPOLINE_CFLAGS
 export RETPOLINE_VDSO_CFLAGS
 
diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 2e0aa74ac185..fd96ac1617f7 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -16,7 +16,7 @@ lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 KASAN_SANITIZE_rodata.o		:= n
 KASAN_SANITIZE_stackleak.o	:= n
 KCOV_INSTRUMENT_rodata.o	:= n
-CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO)
+CFLAGS_REMOVE_rodata.o		+= $(CC_FLAGS_LTO) $(RETHUNK_CFLAGS)
 
 OBJCOPYFLAGS :=
 OBJCOPYFLAGS_rodata_objcopy.o	:= \
diff --git a/drivers/misc/lkdtm/rodata.c b/drivers/misc/lkdtm/rodata.c
index baacb876d1d9..708a2558a7ac 100644
--- a/drivers/misc/lkdtm/rodata.c
+++ b/drivers/misc/lkdtm/rodata.c
@@ -4,8 +4,12 @@
  * (via objcopy tricks), to validate the non-executability of .rodata.
  */
 #include "lkdtm.h"
+#include <linux/objtool.h>
 
 void noinstr lkdtm_rodata_do_nothing(void)
 {
 	/* Does nothing. We just want an architecture agnostic "return". */
 }
+
+/* This is a lie, but given the objcopy, we need objtool to ignore it. */
+STACK_FRAME_NON_STANDARD(lkdtm_rodata_do_nothing);
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index b341f8a8c7c5..c1b58a682ace 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -902,6 +902,8 @@ static void add_ignores(struct objtool_file *file)
 	struct reloc *reloc;
 
 	sec = find_section_by_name(file->elf, ".rela.discard.func_stack_frame_non_standard");
+	if (!sec)
+		sec = find_section_by_name(file->elf, ".discard.func_stack_frame_non_standard");
 	if (!sec)
 		return;
 
@@ -3719,7 +3721,7 @@ static int validate_retpoline(struct objtool_file *file)
 		    insn->type != INSN_RETURN)
 			continue;
 
-		if (insn->retpoline_safe)
+		if (insn->retpoline_safe || insn->ignore)
 			continue;
 
 		/*
-- 
2.32.0

