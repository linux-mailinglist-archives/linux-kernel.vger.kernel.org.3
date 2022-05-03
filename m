Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A2518F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242437AbiECU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242360AbiECU6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:49 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DCB3E5FC
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:12 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id j14so544699plx.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=71QHvmVbzbum/E3ZAVgy97tXOS8tK26BfXNggSRktyw=;
        b=mNBJz/XxKt2KFJk2CFepuhN/xZJ9Uv/rz50WON+4ZRBqQGxaTvzRxuzOr8mgvdSLb1
         NPLtvHfakt3e74WR26Z3Hp3lQMac4mwkW+TTeTMhZW7eR4xkAOhBJl89txhv7sIl6ZU3
         R/p0OcsGRJ9TZUFVA94bG5hnIYF/Me0VROUlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=71QHvmVbzbum/E3ZAVgy97tXOS8tK26BfXNggSRktyw=;
        b=gNwtOWyIjy3QsQ/j1BbmFN7bBJHTMwl4omW/RbXxRuAXoeZ8phcrHDhhsk+syNDUfM
         revmsK23HC5gvncfZ7uF9IN3Q5LpjIIHSxGc4pU5P4KNVWBjX9L1CS5tW5fbDoZQBKqw
         w+6vke0sgajxmq+hdo0ez9F4hEaUiK70trWfeP0LHmcZPVR8wYdz1Susr5MBi7CVAZO3
         vcn1X2Shva71fcESH6z6nb6ix3X+AlxlRzZVMvw8WOh0apHkGJSzpp4tvAhFAVmfLSjy
         YZf43fNpERseiU6v0Qhi6IzPLTm/zhAvmDfVlWVLRy2pbpVM759pdfX0+e5VTBnRzkk3
         /UHQ==
X-Gm-Message-State: AOAM533r4MxoRy1cYaUITuiZtJx+BEtcqv4NhQMF7eIpXPqFUp02tszZ
        jUwq6RjMj/vaEb5AHsForl29H0d5X4nQvw==
X-Google-Smtp-Source: ABdhPJwVWBkyzyFxX6liiB55m10I4fUKnwsv3ihyDoa4NBY+1rzycYUA4hGuRSyZWfG4uHgq2ucCWg==
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id c20-20020a170902b69400b001531d9a11a5mr18075548pls.151.1651611311893;
        Tue, 03 May 2022 13:55:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t7-20020a62ea07000000b0050dc76281f1sm6709358pfh.203.2022.05.03.13.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:10 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 5/6] randstruct: Move seed generation into scripts/basic/
Date:   Tue,  3 May 2022 13:55:02 -0700
Message-Id: <20220503205503.3054173-6-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6991; h=from:subject; bh=POSwG5vGM5ePjK+NnCJy7zXZuBYgVkMBrdQajWqSdos=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZamheMTQbFPcgMuGPTOLLAi+SSC63O6IOd2ZB8G s01qn/WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpgAKCRCJcvTf3G3AJmrYD/ 9/S4SyNCCc6JysEizCShXfywKRGd/VypdZzFIpfGVbMWoWwduoZHcTO2KvS/88sMU72c4E6tNHVTRW JNSdq6HqbNyLDa2c3Dr07Ke9TEO3YZJ/bWwUeEOvEiKdyRNOMFU5picScsWYclKC8xdqB/Nq3wXBbd Syaf1Pdc6CFYgTnv6Ve4xYPoQAl0Pl4SxmPZV7QhdnJlRh0sGZzcRQJHdIn2MKAzEJLjCdPSTPJeqV OympuT/CPrl65t1f3iQN/m62UbI2nL8alWR7RHtr3qQ4HhZYIh+b2JufhOxFBEW/4BGFvEPSA3UsOG Q0SZwl70gwV44QEX/3jgTI86Lyld20sO8Px5z9cwUb0L004gQA+AR9sPwkEfe7QOEqEwDXJfyqtfMP cjy+VOCP7JFHS07booUAPGlUozGNlpzI2aT4rC4QiBQa0lcOEwXEzy8D9RrGj1zD0V/dz0e65UeQrg 2+Ibt4ziS+cHW6V+xUWPVZiQEKR+KyFb4aoHY+KCo3WR4LxiNbBNYWL6rUOXurCrSohkdU5mhkXyMH BmD60mww0e9EASzMySkYpkNIdlzimz0ekp8TAxceKDEb206dnxQOucbY9ntdg07Ffyf3pC5dywOqgy quouzBQoX6hoUJwnW2nDegfzTxW0QgU8tYhLnXP0sZvayjjDxnZhkl0UpOig==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable Clang randstruct support, move the structure layout
randomization seed generation out of scripts/gcc-plugins/ into
scripts/basic/ so it happens early enough that it can be used by either
compiler implementation. The gcc-plugin still builds its own header file,
but now does so from the common "randstruct.seed" file.

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/dontdiff                       |  1 +
 Documentation/kbuild/reproducible-builds.rst |  5 +++--
 include/linux/vermagic.h                     |  2 +-
 scripts/basic/.gitignore                     |  1 +
 scripts/basic/Makefile                       | 11 +++++++++++
 scripts/gcc-plugins/Makefile                 | 15 ++++++++++-----
 scripts/gcc-plugins/gen-random-seed.sh       |  9 ---------
 scripts/gen-randstruct-seed.sh               |  7 +++++++
 security/Kconfig.hardening                   |  9 +++++----
 9 files changed, 39 insertions(+), 21 deletions(-)
 delete mode 100755 scripts/gcc-plugins/gen-random-seed.sh
 create mode 100755 scripts/gen-randstruct-seed.sh

diff --git a/Documentation/dontdiff b/Documentation/dontdiff
index 910b30a2a7d9..352ff53a2306 100644
--- a/Documentation/dontdiff
+++ b/Documentation/dontdiff
@@ -211,6 +211,7 @@ r200_reg_safe.h
 r300_reg_safe.h
 r420_reg_safe.h
 r600_reg_safe.h
+randstruct.seed
 randomize_layout_hash.h
 randomize_layout_seed.h
 recordmcount
diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index 81ff30505d35..071f0151a7a4 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -100,8 +100,9 @@ Structure randomisation
 -----------------------
 
 If you enable ``CONFIG_RANDSTRUCT``, you will need to pre-generate
-the random seed in ``scripts/gcc-plugins/randomize_layout_seed.h``
-so the same value is used in rebuilds.
+the random seed in ``scripts/basic/randstruct.seed`` so the same
+value is used by each build. See ``scripts/gen-randstruct-seed.sh``
+for details.
 
 Debug info conflicts
 --------------------
diff --git a/include/linux/vermagic.h b/include/linux/vermagic.h
index efb51a2da599..a54046bf37e5 100644
--- a/include/linux/vermagic.h
+++ b/include/linux/vermagic.h
@@ -33,7 +33,7 @@
 #define MODULE_VERMAGIC_MODVERSIONS ""
 #endif
 #ifdef RANDSTRUCT
-#include <generated/randomize_layout_hash.h>
+#include <generated/randstruct_hash.h>
 #define MODULE_RANDSTRUCT "RANDSTRUCT_" RANDSTRUCT_HASHED_SEED
 #else
 #define MODULE_RANDSTRUCT
diff --git a/scripts/basic/.gitignore b/scripts/basic/.gitignore
index 961c91c8a884..07c195f605a1 100644
--- a/scripts/basic/.gitignore
+++ b/scripts/basic/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 /fixdep
+/randstruct.seed
diff --git a/scripts/basic/Makefile b/scripts/basic/Makefile
index eeb6a38c5551..dd289a6725ac 100644
--- a/scripts/basic/Makefile
+++ b/scripts/basic/Makefile
@@ -3,3 +3,14 @@
 # fixdep: used to generate dependency information during build process
 
 hostprogs-always-y	+= fixdep
+
+# randstruct: the seed is needed before building the gcc-plugin or
+# before running a Clang kernel build.
+gen-randstruct-seed	:= $(srctree)/scripts/gen-randstruct-seed.sh
+quiet_cmd_create_randstruct_seed = GENSEED $@
+cmd_create_randstruct_seed = \
+	$(CONFIG_SHELL) $(gen-randstruct-seed) \
+		$@ $(objtree)/include/generated/randstruct_hash.h
+$(obj)/randstruct.seed: $(gen-randstruct-seed) FORCE
+	$(call if_changed,create_randstruct_seed)
+always-$(CONFIG_RANDSTRUCT) += randstruct.seed
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index 1952d3bb80c6..148f4639cf09 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -1,12 +1,17 @@
 # SPDX-License-Identifier: GPL-2.0
 
-$(obj)/randomize_layout_plugin.so: $(objtree)/$(obj)/randomize_layout_seed.h
-quiet_cmd_create_randomize_layout_seed = GENSEED $@
+$(obj)/randomize_layout_plugin.so: $(obj)/randomize_layout_seed.h
+quiet_cmd_create_randomize_layout_seed = SEEDHDR $@
 cmd_create_randomize_layout_seed = \
-  $(CONFIG_SHELL) $(srctree)/$(src)/gen-random-seed.sh $@ $(objtree)/include/generated/randomize_layout_hash.h
-$(objtree)/$(obj)/randomize_layout_seed.h: FORCE
+	SEED=$$(cat $(filter-out FORCE,$^) </dev/null); \
+	echo '/*' > $@; \
+	echo ' * This file is automatically generated. Keep it private.' >> $@; \
+	echo ' * Exposing this value will expose the layout of randomized structures.' >> $@; \
+	echo ' */' >> $@; \
+	echo "const char *randstruct_seed = \"$$SEED\";" >> $@
+$(obj)/randomize_layout_seed.h: $(objtree)/scripts/basic/randstruct.seed FORCE
 	$(call if_changed,create_randomize_layout_seed)
-targets += randomize_layout_seed.h randomize_layout_hash.h
+targets += randomize_layout_seed.h
 
 # Build rules for plugins
 #
diff --git a/scripts/gcc-plugins/gen-random-seed.sh b/scripts/gcc-plugins/gen-random-seed.sh
deleted file mode 100755
index 68af5cc20a64..000000000000
--- a/scripts/gcc-plugins/gen-random-seed.sh
+++ /dev/null
@@ -1,9 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-if [ ! -f "$1" ]; then
-	SEED=`od -A n -t x8 -N 32 /dev/urandom | tr -d ' \n'`
-	echo "const char *randstruct_seed = \"$SEED\";" > "$1"
-	HASH=`echo -n "$SEED" | sha256sum | cut -d" " -f1 | tr -d ' \n'`
-	echo "#define RANDSTRUCT_HASHED_SEED \"$HASH\"" > "$2"
-fi
diff --git a/scripts/gen-randstruct-seed.sh b/scripts/gen-randstruct-seed.sh
new file mode 100755
index 000000000000..61017b36c464
--- /dev/null
+++ b/scripts/gen-randstruct-seed.sh
@@ -0,0 +1,7 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+SEED=$(od -A n -t x8 -N 32 /dev/urandom | tr -d ' \n')
+echo "$SEED" > "$1"
+HASH=$(echo -n "$SEED" | sha256sum | cut -d" " -f1)
+echo "#define RANDSTRUCT_HASHED_SEED \"$HASH\"" > "$2"
diff --git a/security/Kconfig.hardening b/security/Kconfig.hardening
index 364e3f8c6eea..0277ba578779 100644
--- a/security/Kconfig.hardening
+++ b/security/Kconfig.hardening
@@ -284,10 +284,11 @@ choice
 	  tools like Volatility against the system (unless the kernel
 	  source tree isn't cleaned after kernel installation).
 
-	  The seed used for compilation is located at
-	  scripts/randomize_layout_seed.h. It remains after a "make clean"
-	  to allow for external modules to be compiled with the existing
-	  seed and will be removed by a "make mrproper" or "make distclean".
+	  The seed used for compilation is in scripts/basic/randomize.seed.
+	  It remains after a "make clean" to allow for external modules to
+	  be compiled with the existing seed and will be removed by a
+	  "make mrproper" or "make distclean". This file should not be made
+	  public, or the structure layout can be determined.
 
 	config RANDSTRUCT_NONE
 		bool "Disable structure layout randomization"
-- 
2.32.0

