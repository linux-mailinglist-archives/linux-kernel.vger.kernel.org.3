Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C454EB4A2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiC2UYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231857AbiC2UX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36AB23D5A2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:22:02 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ea05573995so78435867b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=flJj5WwMcToXi1b56Elwsvl4AdOiMaR06NtVd0mKQYg=;
        b=RP2ZsEKUP48hXRQKM7Oart+FZGqxiByqHJ4lmyXojWSy1C3upHK2RZ8M7L+CRRtGhE
         QkEihq+J/6d7zdpjwmyV/XXOdX91rU6F49mX6/4P6r7+C6ugXP4oEKP0coT0mnMTihTl
         U3yGkySPjRxU2FH4Zb4IfCOOaP5KgbDbXtvD5Ryo6k40BeHq9CjDlVSHLOiLqnJv1lIJ
         Ot9AVk3eCan7Q8jN1Lm0xCsPg9xBZ1wjqnZky/qE8TQVc1TNmuxq76z/U7RIyvDraDMV
         7IZWm/jc7PsiAhfqfpskqNC+0knTFt7V2LGOz7qnBNJaqmuu1s4PwqZWCgZ3JM7C2XY4
         i8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=flJj5WwMcToXi1b56Elwsvl4AdOiMaR06NtVd0mKQYg=;
        b=zLZFiFOuTrIpafNU6ZI93vjy7E8LQwdgZzLFLN7Riu8W/gOXR1IywNsrsiweSiSRSB
         QUFTLNppns24leUafco6hFRZ7O68xLyl4GJ9jA+zadLrcNc0LQPnPGxbKUVDuaHwQE82
         B/3VNHaWYuz6t962Ha+VILyqA9099+l1UDQu1wzAkRFA1/WIy4UUWWyO0bX/yF6Axn/f
         oiuCeoVnmj0SZWSTJPGcX7rUzUfAo86b168eSPW9tyglocoR1fc16vEMETozT4zfW5Ii
         f2XAtpfRFz4io1U2iUZCnfMyi3c4mSiDINAg3V45MiQgAUTt+W+I01xwBQU2ZNdG1++d
         6cQw==
X-Gm-Message-State: AOAM533ry8PDAL/UvLzPrF/fKkEW7CbFp4IgXtmRmXs4x4XSeSR7H+Bb
        ikkPhQ25RJeXNFuPL2vPuNi8WHQ7JzMits4Qky0=
X-Google-Smtp-Source: ABdhPJzwpjwjrFojlc3EEI1f6mqX3BEtKV20dsZv8c8eYIXG6SAirgvSetAg3HG0rE0G1hKrVZJpm9eJZJ0KKZ/ZtuA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:75a:7c26:987c:fd71])
 (user=ndesaulniers job=sendgmr) by 2002:a81:3492:0:b0:2e5:ab19:1e75 with SMTP
 id b140-20020a813492000000b002e5ab191e75mr32641410ywa.513.1648585322234; Tue,
 29 Mar 2022 13:22:02 -0700 (PDT)
Date:   Tue, 29 Mar 2022 13:21:45 -0700
Message-Id: <20220329202148.2379697-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648585305; l=3195;
 s=20211004; h=from:subject; bh=J1j+c4E43RIi/FG4h/zBq/I6lviJFnKG5oAMR1LP3h8=;
 b=AoKBTaBgS6Gzww/oClM3Ob3UfsNoBSfcj8Lu0oeeeMz6+PSIYMENkObg8uG33U6Ew0paLOr6CC0D
 ziQ9UU9ADM1u7cNE9jVfsC+g4WSZ6rzWNPdCw/HlxTVF2Ne/UzjS
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH] x86/extable: prefer local labels in .set directives
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bernardo Meurer Costa <beme@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        linux-kernel@vger.kernel.org
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

Bernardo reported an error that Nathan bisected down to
(x86_64) defconfig+LTO_CLANG_FULL+X86_PMEM_LEGACY.

    LTO     vmlinux.o
  ld.lld: error: <instantiation>:1:13: redefinition of 'found'
  .set found, 0
              ^

  <inline asm>:29:1: while in macro instantiation
  extable_type_reg reg=%eax, type=(17 | ((0) << 16))
  ^

This appears to be another LTO specific issue similar to what was folded
into commit 4b5305decc84 ("x86/extable: Extend extable functionality"),
where the `.set found, 0` in DEFINE_EXTABLE_TYPE_REG in
arch/x86/include/asm/asm.h conflicts with the symbol for the static
function `found` in arch/x86/kernel/pmem.c.

Assembler .set directive declare symbols with global visibility, so the
assembler may not rename such symbols in the event of a conflict. LTO
could rename static functions if there was a conflict in C sources, but
it cannot see into symbols defined in inline asm.

The symbols are also retained in the symbol table, regardless of LTO.

Give the symbols .L prefixes making them locally visible, so that they
may be renamed for LTO to avoid conflicts, and to drop them from the
symbol table regardless of LTO.

Fixes: 4b5305decc84 ("x86/extable: Extend extable functionality")
Link: https://github.com/ClangBuiltLinux/linux/issues/1612
Link: https://sourceware.org/binutils/docs/as/Symbol-Names.html#Local-Symbol-Names
Reported-by: Bernardo Meurer Costa <beme@google.com>
Debugged-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/include/asm/asm.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/asm.h b/arch/x86/include/asm/asm.h
index c878fed3056f..fbcfec4dc4cc 100644
--- a/arch/x86/include/asm/asm.h
+++ b/arch/x86/include/asm/asm.h
@@ -154,24 +154,24 @@
 
 # define DEFINE_EXTABLE_TYPE_REG \
 	".macro extable_type_reg type:req reg:req\n"						\
-	".set found, 0\n"									\
-	".set regnr, 0\n"									\
+	".set .Lfound, 0\n"									\
+	".set .Lregnr, 0\n"									\
 	".irp rs,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,r15\n"		\
 	".ifc \\reg, %%\\rs\n"									\
-	".set found, found+1\n"									\
-	".long \\type + (regnr << 8)\n"								\
+	".set .Lfound, .Lfound+1\n"								\
+	".long \\type + (.Lregnr << 8)\n"							\
 	".endif\n"										\
-	".set regnr, regnr+1\n"									\
+	".set .Lregnr, .Lregnr+1\n"								\
 	".endr\n"										\
-	".set regnr, 0\n"									\
+	".set .Lregnr, 0\n"									\
 	".irp rs,eax,ecx,edx,ebx,esp,ebp,esi,edi,r8d,r9d,r10d,r11d,r12d,r13d,r14d,r15d\n"	\
 	".ifc \\reg, %%\\rs\n"									\
-	".set found, found+1\n"									\
-	".long \\type + (regnr << 8)\n"								\
+	".set .Lfound, .Lfound+1\n"								\
+	".long \\type + (.Lregnr << 8)\n"							\
 	".endif\n"										\
-	".set regnr, regnr+1\n"									\
+	".set .Lregnr, .Lregnr+1\n"								\
 	".endr\n"										\
-	".if (found != 1)\n"									\
+	".if (.Lfound != 1)\n"									\
 	".error \"extable_type_reg: bad register argument\"\n"					\
 	".endif\n"										\
 	".endm\n"
-- 
2.35.1.1021.g381101b075-goog

