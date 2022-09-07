Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6D55AFB7E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiIGE7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 00:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiIGE7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 00:59:38 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787D9BF45
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 21:59:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3454647ff7dso54114687b3.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 21:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=1COoEIPBVX2RpaBUk98TcXRSJaNnm6A+DPC71dE8tyA=;
        b=s3zbhnn4yneYiDRSoLecTRmu6wrM36fumucM96wks5JEOW+winLJxgjTCizxSD0vQQ
         4LIxu9C5zIHRcDqu2u2lNecbhUbn/2TWEkJJNOnQRGTbP/t+N8tSrjmLqoNZ4Hys/YfY
         rXjKvD+IaIth1LIDrIKHqgEj2zf3K/v0DQJ1j8rDMz5MwmTvfUGzUOKJa1lVvGPvqf9P
         +8A42mJo+1FKX2JGEWRbmq1cLWbk1x4A8ndh39gYz9TEaivkCM3GNR8CZxO90PyAaynQ
         mJT0Ist67AYlzVHi98qIbw0zfJsg4FDWxcQitTzHAY11Ikv4I9i0j4cc7EPR5ECWbtGC
         CVKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=1COoEIPBVX2RpaBUk98TcXRSJaNnm6A+DPC71dE8tyA=;
        b=6DytehskD4wFrDyK6WGpV+k9Hu3q4qq+DpXP1plHX6Ge63jgzDzyVK2sU1Pn3urjNU
         Fwob2ub8nPXLwsP9E+0xSZa7erN1Yyz6nCjxoDmDOfgIA6cSWcV1x6pkaMDcGCRHPlUl
         aY0l06ZM0LDJKhy4G6IVQoCMz/SHsV7dtyVdF5Y9TtfYcJCxHT5zIXDId0xHGQ3RBFo7
         WCTHzqqrJEp5z38mg9lqtTULRFerCKx71gkEL3vGKcYp2ttIsaMyPJlb2jyfW2chWp+f
         z8b6mdI7wu2YYziGHgWeeoExQf6F8XDzv3T9L9M97hwHknrSH6OY/RMrC4d2Sd8PeYIO
         pwKA==
X-Gm-Message-State: ACgBeo0YE0wxZQ43hmrcB1+NeMXfnfLWZXwPjkq7dfm4dkd/6GHVfOya
        hcXKp5fXbc0O/6scqfPI6CimRyXq0teJfxGiWlU=
X-Google-Smtp-Source: AA6agR4PDE9DXpqaLgbI/t9G91mUki/RmvatymlHezczkZ1UM0qxH+3O/M1DPc+CuckZPxkGq1Gw30BzmtKEQyH16HA=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:0:100e:712:9755:c523:9dcb:2228])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:72a:b0:69e:f780:4de1 with
 SMTP id l10-20020a056902072a00b0069ef7804de1mr1597326ybt.53.1662526772788;
 Tue, 06 Sep 2022 21:59:32 -0700 (PDT)
Date:   Tue,  6 Sep 2022 21:59:06 -0700
In-Reply-To: <20220907045907.484043-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20220907045907.484043-1-ndesaulniers@google.com>
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=lvO/pmg+aaCb6dPhyGC1GyOCvPueDrrc8Zeso5CaGKE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1662526746; l=3571;
 i=ndesaulniers@google.com; s=20211004; h=from:subject; bh=izinVuTPOGuJAOWpMqC3T3tWj1j7qEU602s5D6R33gQ=;
 b=3HKm8e+bXV4z5Vehfj0HJ55Vwjh98Cw8BeO7rIXrOAoTmo0gFo5f7KN8zo1XTJHURY3xrr+qxu8O
 7wO+MevQBnzuM/Tu/NZEUxCAUC2q1PZIAlDnuHsKyAQG1XPgoYnY
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220907045907.484043-5-ndesaulniers@google.com>
Subject: [PATCH v3 4/5] Makefile.debug: re-enable debug info for .S files
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
        autolearn=ham autolearn_force=no version=3.4.6
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

Link: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;h=31bf18645d98b4d3d7357353be840e320649a67d
Fixes: b8a9092330da ("Kbuild: do not emit debug info for assembly with LLVM_IAS=1")
Reported-by: Alexey Alexandrov <aalexand@google.com>
Reported-by: Bill Wendling <morbo@google.com>
Reported-by: Greg Thelen <gthelen@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Suggested-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes v2 -> v3:
* Replace diff outright with Masahiro's suggestion in
  https://lore.kernel.org/llvm/CAK7LNATWDH01=ZKLnsxc0vcib1zGDbEq8jLQwhWP7HkkmSb_Mw@mail.gmail.com/2-dwarf.diff
  with some modifications, PTAL.
* Pick up Nathan's RB tag and Masahiro's SB tag.
* Cut down commit message.

Changes v1 -> v2:
* Use newly added compiler-specific macros, as per Bill.

 lib/Kconfig.debug      |  4 +++-
 scripts/Makefile.debug | 19 ++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index bcbe60d6c80c..d3e5f36bb01e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -264,8 +264,10 @@ config DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
 config DEBUG_INFO_DWARF4
 	bool "Generate DWARF Version 4 debuginfo"
 	select DEBUG_INFO
+	depends on !CC_IS_CLANG || (CC_IS_CLANG && (AS_IS_LLVM || (AS_IS_GNU && AS_VERSION >= 23502)))
 	help
-	  Generate DWARF v4 debug info. This requires gcc 4.5+ and gdb 7.0+.
+	  Generate DWARF v4 debug info. This requires gcc 4.5+, binutils 2.35.2
+	  if using clang without clang's integrated assembler, and gdb 7.0+.
 
 	  If you have consumers of DWARF debug info that are not ready for
 	  newer revisions of DWARF, you may wish to choose this or have your
diff --git a/scripts/Makefile.debug b/scripts/Makefile.debug
index 9f39b0130551..2845145c1220 100644
--- a/scripts/Makefile.debug
+++ b/scripts/Makefile.debug
@@ -3,17 +3,16 @@ DEBUG_CFLAGS	:=
 ifdef CONFIG_DEBUG_INFO_SPLIT
 DEBUG_CFLAGS	+= -gsplit-dwarf
 else
-DEBUG_CFLAGS	+= -g
+debug-cflags-y	+= -g
 endif
 
-ifndef CONFIG_AS_IS_LLVM
-KBUILD_AFLAGS	+= -Wa,-gdwarf-2
-endif
+debug-flags-$(CONFIG_DEBUG_INFO_DWARF4)	+= -gdwarf-4
+debug-flags-$(CONFIG_DEBUG_INFO_DWARF5)	+= -gdwarf-5
 
-ifndef CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT
-dwarf-version-$(CONFIG_DEBUG_INFO_DWARF4) := 4
-dwarf-version-$(CONFIG_DEBUG_INFO_DWARF5) := 5
-DEBUG_CFLAGS	+= -gdwarf-$(dwarf-version-y)
+ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_AS_IS_GNU),yy)
+# Clang does not pass -g or -gdwarf-* option down to GAS.
+# Add -Wa, prefix to explicitly specify the flags.
+KBUILD_AFLAGS	+= $(addprefix -Wa$(comma), $(debug-flags-y))
 endif
 
 ifdef CONFIG_DEBUG_INFO_REDUCED
@@ -29,5 +28,7 @@ KBUILD_AFLAGS	+= -gz=zlib
 KBUILD_LDFLAGS	+= --compress-debug-sections=zlib
 endif
 
-KBUILD_CFLAGS += $(DEBUG_CFLAGS)
+DEBUG_CFLAGS	+= $(debug-flags-y)
+KBUILD_AFLAGS	+= $(debug-flags-y)
+KBUILD_CFLAGS	+= $(DEBUG_CFLAGS)
 export DEBUG_CFLAGS
-- 
2.37.2.789.g6183377224-goog

