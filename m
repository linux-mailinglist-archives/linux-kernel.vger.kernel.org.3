Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E83BF5A2E07
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbiHZSLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344981AbiHZSKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:10:54 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E02CC9933
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:10:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-33dbfb6d2a3so36977507b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 11:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc;
        bh=y85OHCHx+Vi/sO7g73ubX7Iq+I1fFfBENt1UsLJJtEY=;
        b=Wj6HCEjnqrM+ctPXZ7KiGzIXUgQPn1aBBzqlXzJXgi4UZbJJxcgs2UwkHjll+zpoDb
         QeMdKfqcbQOVp17Y0+gesDEiIBE2NtsbSzBeish3QzVjv+ccDr8N9iBPhNlnJ+YXJgXc
         TvKwx7H5srQaXdmnL0HXDThn+fsOePUCjTuCn0aigqKEnJMlv7h1Xp+qfv8qoTynWxqI
         4txto8tzY+q23E3IEn+vhGNU4fNuv5wFW3EC0z2YsZ+kLvCz3/6YommEVb33Y4oEwDD3
         0L4yDniY0aGOCZ6n2IM+1XskuCSVe+ByexHFTTMple1/llBbEl7kTK+daJJISfnFHL6d
         TeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=y85OHCHx+Vi/sO7g73ubX7Iq+I1fFfBENt1UsLJJtEY=;
        b=zU4rAPtMOzpO2nLA//3PLdHYnmEJOU6OE2oitSXa1cBJmJwBPTU6Qs1vEJ5Hw03Ia4
         pSSQ2TcHyWvUSvjpmOw/GJioucBJwM33pzNsOfACaLBB5zMbOvNjBvfdW2fQYqdqwga+
         /tNK9zsxBltKN9Z+uEjHZacmFFpnm2lYkkiSi2AVAFm3J7HacNotxZhvq8+qHQ/6j/rA
         OF4qKTikzY0035SWo6C1HaQssOQzElXp6haNAssDSyS7AnsNKT7cJGcb+VTYxX8Jn9Fl
         HozoJrGfmul1O2Eq7VI/Vf1sT/Ug0i60mdBHJ2mSpK8LHsM2L/BL+B2Ph41+0yJsWCrp
         YH8Q==
X-Gm-Message-State: ACgBeo02AhEnVGdPvt9JQe9cDGYd1pJj3VfkuqtYqa2SBm/ZNavTgM3a
        zvY4RwPgLfxdT3SIIp8VjVF+Rzd/GaRqjdk3GRU=
X-Google-Smtp-Source: AA6agR5OzcKIoYCg9NU/S1Bt4QZM/GluQ1lilTqv2NoDx2SVtJGQ0ZZoyYauXUteYnrMqBae+wpkPcsEDZ5Oc9etZfQ=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:8d7b:b933:5438:2a88])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:124f:b0:66e:e3da:487e with
 SMTP id t15-20020a056902124f00b0066ee3da487emr973177ybu.310.1661537452858;
 Fri, 26 Aug 2022 11:10:52 -0700 (PDT)
Date:   Fri, 26 Aug 2022 11:10:34 -0700
In-Reply-To: <20220826181035.859042-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220826181035.859042-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1661537435; l=3096;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=WJicEEw1ygkDh8L4szHogyorYbivCBDQ7W9ZrvdhNOc=;
 b=ZWuPxn7dhLiVcgTrvuHdUAPAmyqC6WoqmU5iSPWfVYPAWJqjwzpjYxl1614lFrA0/+q4/P3onXk1
 O00OgL5BCi40Z6C06mizSDk06M74HD6otU8B3ZzdiYDlMTNMCJLe
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220826181035.859042-3-ndesaulniers@google.com>
Subject: [PATCH 2/3] Makefile.debug: re-enable debug info for .S files
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

Alexey reported that the fraction of unknown filename instances in
kallsyms grew from ~0.3% to ~10% recently; Bill and Greg tracked it down
to assembler defined symbols, which regressed as a result of:

commit b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")

In that commit, I allude to restoring debug info for assembler defined
symbols in a follow up patch, but it seems I forgot to do so in

commit a66049e2cf0e ("Kbuild: make DWARF version a choice")

This patch does a few things:
1. Add -g to KBUILD_AFLAGS. This will instruct the compiler to instruct
   the assembler to emit debug info. But this can cause an issue for
   folks using a newer compiler but older assembler, because the
   implicit default DWARF version changed from v4 to v5 in gcc-11 and
   clang-14.
2. If the user is using CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, use a
   version check to explicitly set -Wa,-gdwarf-<version> for the
   assembler. There's another problem with this; GAS only gained support
   for explicit DWARF versions 3-5 in the 2.36 GNU binutils release.
3. Wrap -Wa,-gdwarf-<version> in as-option call to test whether the
   assembler supports that explicit DWARF version.

Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
Reported-by: Alexey Alexandrov <aalexand@google.com>
Reported-by: Bill Wendling <morbo@google.com>
Reported-by: Greg Thelen <gthelen@google.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 scripts/Makefile.debug | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..a7a6da7f6e7d 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -4,18 +4,32 @@ ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
 else
 DEBUG_CFLAGS	+= -g
+KBUILD_AFLAGS	+= -g
 endif
 
-ifndef CONFIG_AS_IS_LLVM
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+ifdef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+# gcc-11+, clang-14+
+ifeq ($(shell [ $(CONFIG_GCC_VERSION) -ge 110000 -o $(CONFIG_CLANG_VERSION) -ge 140000 ] && echo y),y)
+dwarf-version-y := 5
+else
+dwarf-version-y := 4
 endif
-
-ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
+else # !CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
 dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
 DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
 endif
 
+# Binutils 2.35+ (or clang) required for -gdwarf-{4|5}.
+# https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
+ifneq ($(call as-option,-Wa$(comma)-gdwarf-$(dwarf-version-y)),)
+KBUILD_AFLAGS	+= -Wa,-gdwarf-$(dwarf-version-y)
+else
+ifndef CONFIG_AS_IS_LLVM
+KBUILD_AFLAGS	+= -Wa,-gdwarf-2
+endif
+endif
+
 ifdef CONFIG_DEBUG_INFO_REDUCED
 DEBUG_CFLAGS	+= -fno-var-tracking
 ifdef CONFIG_CC_IS_GCC
-- 
2.37.2.672.g94769d06f0-goog

