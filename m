Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D958F45A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbiHJWZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiHJWZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:25:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3048D3E8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:25:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-329a474c437so85699537b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=6I7ngn4/7OB644m4fycU8fbB2CwnISfb8LBYYNMQmtE=;
        b=EFMENVP4gsj1ddaG66twAM7LHLhCRb8PaAswRRJAyWIvE7nwWAfgk8dcaBbouz+6yw
         SMCpNe5KhuQfFD5cc5IeUo9kduUroOD7vfZIrVT2s6tLArPet6dRc10yL0/QKUGnkJwm
         X+uACW502iYbfFJJmktsWJBsFn0mpDLQw8ZQKVDGft5HwdqXdiWjN3Svt6eivHvr3LK9
         mYa2UIZxMZYsHOq98oImEPiVbnaeker7SiffhtD6kQoqcCkQtqymKqXhxxMuPRT3LOHp
         CwepPtXWnQKl87lmCswKvbul2Mim/8svfSir/Rgdk24pvhI75HBXZh8Pc2cEl0WA5dlT
         cZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=6I7ngn4/7OB644m4fycU8fbB2CwnISfb8LBYYNMQmtE=;
        b=zeUi6+MsJKoWdBDtJ+ppYywu50ZOUr/SqVK2LkIEF8XAr0auJN3yaHpmQTusMQRbEH
         OM9A7qQOs+1n67JX4G9CLNZE9ZqbWC2K/FZh/fB1T2lChEoDIFBnI95sxN/vdBXqvYis
         KCHdz5zbxmXCMxd1e+2eLVlDsLxOoZkcoutm0K+WOy80Nj7E62B+m5xHULkTO4ALyT3X
         rEPtk5RwKzxdxkU9sClgkePUBZ8lKeiBluOEcv36hdQqjl3rHgQ0Ezfs1vatj967ckNi
         ASVKYKtoyG3TyiClyGgilb21jZ0s7adyUAAvn2hb3IQ0M4kOAHz3x/RF3fabseK5tttU
         ibMA==
X-Gm-Message-State: ACgBeo3y+LXMk1qOtZY+xKqZNWs9rrRJRFaoxmwALeAGA8nUspnJxLiD
        1cSIh7KNgy2eSWkY4Egi1JHKDYCcCPPE5g/4M5Y=
X-Google-Smtp-Source: AA6agR5tR6VJL1cBM0+0soZnPSPXBTT5jayRGU/k7oxm6GIrojlqN3RVUkVPcdoImbPu0dg4mh37ttIN3gg3W9iHE2M=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:88ad:cd41:8dd7:539])
 (user=ndesaulniers job=sendgmr) by 2002:a81:be0a:0:b0:329:74c3:b7e6 with SMTP
 id i10-20020a81be0a000000b0032974c3b7e6mr21898680ywn.491.1660170302652; Wed,
 10 Aug 2022 15:25:02 -0700 (PDT)
Date:   Wed, 10 Aug 2022 15:24:41 -0700
In-Reply-To: <20220810222442.2296651-1-ndesaulniers@google.com>
Message-Id: <20220810222442.2296651-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220809013653.xtmeekefwkbo46vk@google.com> <20220810222442.2296651-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1660170282; l=3488;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=kNgQ27/vj8X5tCgiHxgAYMfVSnRb71USHhs7hpHOY8Q=;
 b=DjUQeTNVWxqPr0tBXBc+iQXgebieO233lmR8Y9zFr/FGQt5gk+gXLbJMFqL7HDGnfPNDMKujdFmu
 4r4C/HfuDU6KnqTkAAmXxJBLCFR5WiK7jAjlQCFIAqAtLIOfVv3X
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v2 2/2] x86: link vdso and boot with -z noexecstack --no-warn-rwx-segments
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Fangrui Song <maskray@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nick Clifton <nickc@redhat.com>, axboe@kernel.dk,
        brijesh.singh@amd.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, michael.roth@amd.com, n.schier@avm.de,
        nathan@kernel.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        trix@redhat.com, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andy Lutomirski <luto@kernel.org>
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

Users of GNU ld (BFD) from binutils 2.39+ will observe multiple
instances of a new warning when linking kernels in the form:

  ld: warning: arch/x86/boot/pmjump.o: missing .note.GNU-stack section
  implies executable stack
  ld: NOTE: This behaviour is deprecated and will be removed in a future
  version of the linker
  ld: warning: arch/x86/boot/compressed/vmlinux has a LOAD segment with
  RWX permissions

Generally, we would like to avoid the stack being executable. Because
there could be a need for the stack to be executable, assembler sources
have to opt-in to this security feature via explicit creation of the
.note.GNU-stack feature (which compilers create by default) or command
line flag --noexecstack. Or we can simply tell the linker the production
of such sections is irrelevant and to link the stack as --noexecstack.

LLVM's LLD linker defaults to -z noexecstack, so this flag isn't
strictly necessary when linking with LLD, only BFD, but it doesn't hurt
to be explicit here for all linkers IMO. --no-warn-rwx-segments is
currently BFD specific and only available in the current latest release,
so it's wrapped in an ld-option check.

While the kernel makes extensive usage of ELF sections, it doesn't use
permissions from ELF segments.

Link: https://lore.kernel.org/linux-block/3af4127a-f453-4cf7-f133-a181cce06f73@kernel.dk/
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=ba951afb99912da01a6e8434126b8fac7aa75107
Link: https://github.com/llvm/llvm-project/issues/57009
Reported-by: Jens Axboe <axboe@kernel.dk>
Suggested-by: Fangrui Song <maskray@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/boot/Makefile            | 2 +-
 arch/x86/boot/compressed/Makefile | 4 ++++
 arch/x86/entry/vdso/Makefile      | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index b5aecb524a8a..ffec8bb01ba8 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -103,7 +103,7 @@ $(obj)/zoffset.h: $(obj)/compressed/vmlinux FORCE
 AFLAGS_header.o += -I$(objtree)/$(obj)
 $(obj)/header.o: $(obj)/zoffset.h
 
-LDFLAGS_setup.elf	:= -m elf_i386 -T
+LDFLAGS_setup.elf	:= -m elf_i386 -z noexecstack -T
 $(obj)/setup.elf: $(src)/setup.ld $(SETUP_OBJS) FORCE
 	$(call if_changed,ld)
 
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 19e1905dcbf6..35ce1a64068b 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -69,6 +69,10 @@ LDFLAGS_vmlinux := -pie $(call ld-option, --no-dynamic-linker)
 ifdef CONFIG_LD_ORPHAN_WARN
 LDFLAGS_vmlinux += --orphan-handling=warn
 endif
+LDFLAGS_vmlinux += -z noexecstack
+ifeq ($(CONFIG_LD_IS_BFD),y)
+LDFLAGS_vmlinux += $(call ld-option,--no-warn-rwx-segments)
+endif
 LDFLAGS_vmlinux += -T
 
 hostprogs	:= mkpiggy
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 76cd790ed0bd..12f6c4d714cd 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -180,7 +180,7 @@ quiet_cmd_vdso = VDSO    $@
 		 sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
 
 VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 \
-	$(call ld-option, --eh-frame-hdr) -Bsymbolic
+	$(call ld-option, --eh-frame-hdr) -Bsymbolic -z noexecstack
 GCOV_PROFILE := n
 
 quiet_cmd_vdso_and_check = VDSO    $@
-- 
2.37.1.559.g78731f0fdb-goog

