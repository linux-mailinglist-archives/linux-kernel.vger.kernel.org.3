Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498B45A2E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbiHZSLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344970AbiHZSKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:10:52 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2429CBD0A0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:10:51 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3360c0f0583so37142217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=+rojwMFSR1ktivBcLatbShichab85h559FFhXLBJsbQ=;
        b=d4+SAZcB49L1Pz5691krlFA1DIyOTvq2Luh257EaP1K/PH0dmddhrS56CK7oNvjTCq
         JYW3is9kyarysYwRgAyND3s3bxVw/jubRHzTepqU8ADf1ANplMvsHHy3sUZbgip1TrYi
         VQMolp4u+aOxwOmOth5Tljke2JmC0du+AIf40liTCnqtb1TQYByhptbt3UfS9P2/7Pn7
         V5D0Be+0FdKEK5I/9qKIW+ZDCqEWhahEwZ+F4wuKJ1GglG/LNWUg3D3IskGzoZvboVlp
         hoMcfu+1N82G+jY1PxSMeTMZaBdq+6+I+UxN62ZsTG3R3DeZx5dd48VB8uYWHkru790q
         LStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=+rojwMFSR1ktivBcLatbShichab85h559FFhXLBJsbQ=;
        b=BdZnM/P7qWTb3nm9xf5YGAKiVZOYUqonsoF6tRbspM5H6OXIdNN6gCVvmBFaUoT7dV
         3MQPWwnZMarOtaSPX0uNukMSoiQeWt3uwv+1SQplSexivNinAGhoXNrZ1oHyEePeefpX
         s5e56hrnmC9BTlG12Spw28urp3yBN3eFSf/Qp2yKPeVOCnguG6QZngtjD0K3okqmmFlk
         4ZFEyVBA08vHyVYUlGkXk/QUboBsZRlyIsLoOji2LtMUdn6UXSz9dGk1aVYTQhKKuyII
         AHtIROHIXHDKpyPabh2q+I72CxVe0VOHVD5dFvOjZ1Oz3TLdVdGd9RFtfYYrX19FSJz7
         wuBA==
X-Gm-Message-State: ACgBeo10zVa9ceg+S1+Myjuf7AEtesd0eiwY6p4CI1CiQDnZjVTp/oMS
        buPaUiW/mJwgfF8NzQBSSSDAO1l0HyPXGTDaFBw=
X-Google-Smtp-Source: AA6agR4ULUmbr1GFgEraiIaT8AxK9RcdvEUmCKesyk2DxFW/lUdbvm5cGag9CLzJsNLFrG4g/doYTURXjga8oVLFUHU=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:8d7b:b933:5438:2a88])
 (user=ndesaulniers job=sendgmr) by 2002:a25:e90e:0:b0:695:64cf:5d2 with SMTP
 id n14-20020a25e90e000000b0069564cf05d2mr832499ybd.541.1661537450473; Fri, 26
 Aug 2022 11:10:50 -0700 (PDT)
Date:   Fri, 26 Aug 2022 11:10:33 -0700
In-Reply-To: <20220826181035.859042-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220826181035.859042-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661537434; l=2534;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=+Ce697Gvc792vtSqpkgUmOwOXeS8MsAAIdR8EYSt4bI=;
 b=D9av99GhEUVuJgb7imYpdihlXqaXba/P8TNNQf7iB27ysvI+vgrjTW1hi6ko1PmKeztnZYwKFkzD
 +kwn7lP+BBx5GbbPxnX3QOnvS+vc5/jOX7d4q9Aev4g8z14GlfxF
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826181035.859042-2-ndesaulniers@google.com>
Subject: [PATCH 1/3] Makefile.compiler: s/KBUILD_CFLAGS/KBUILD_AFLAGS/ for as-option
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev, x86@kernel.org,
        Dmitrii Bundin <dmitrii.bundin.a@gmail.com>,
        Fangrui Song <maskray@google.com>,
        Alexey Alexandrov <aalexand@google.com>,
        Bill Wendling <morbo@google.com>,
        Greg Thelen <gthelen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as-instr uses KBUILD_AFLAGS, but as-option uses KBUILD_CFLAGS.  This can
cause as-option to fail unexpectedly because clang will emit
-Werror,-Wunused-command-line-argument for various -m and -f flags for
assembler sources.

Callers of as-option (and as-instr) likely want to be adding flags to
KBUILD_AFLAGS/aflags-y, not KBUILD_CFLAGS/cflags-y.

Link: https://github.com/ClangBuiltLinux/linux/issues/1699
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/boot/compressed/Makefile | 5 +++--
 scripts/Makefile.compiler         | 6 +++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..fb3db714a028 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -48,8 +48,6 @@ KBUILD_CFLAGS += -Wno-pointer-sign
 KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
 KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 KBUILD_CFLAGS += -D__DISABLE_EXPORTS
-# Disable relocation relaxation in case the link is not PIE.
-KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 
 # sev.c indirectly inludes inat-table.h which is generated during
@@ -58,6 +56,9 @@ KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
+# Disable relocation relaxation in case the link is not PIE.
+KBUILD_AFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
+
 GCOV_PROFILE := n
 UBSAN_SANITIZE :=n
 
diff --git a/scripts/Makefile.compiler b/scripts/Makefile.compiler
index 94d0d40cddb3..d1739f0d3ce3 100644
--- a/scripts/Makefile.compiler
+++ b/scripts/Makefile.compiler
@@ -29,13 +29,13 @@ try-run = $(shell set -e;		\
 	fi)
 
 # as-option
-# Usage: cflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
+# Usage: aflags-y += $(call as-option,-Wa$(comma)-isa=foo,)
 
 as-option = $(call try-run,\
-	$(CC) $(KBUILD_CFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
+	$(CC) $(KBUILD_AFLAGS) $(1) -c -x assembler /dev/null -o "$$TMP",$(1),$(2))
 
 # as-instr
-# Usage: cflags-y += $(call as-instr,instr,option1,option2)
+# Usage: aflags-y += $(call as-instr,instr,option1,option2)
 
 as-instr = $(call try-run,\
 	printf "%b\n" "$(1)" | $(CC) $(KBUILD_AFLAGS) -c -x assembler -o "$$TMP" -,$(2),$(3))
-- 
2.37.2.672.g94769d06f0-goog

