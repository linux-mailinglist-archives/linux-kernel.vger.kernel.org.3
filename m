Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA7F4CCC98
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 05:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiCDEhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 23:37:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbiCDEhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 23:37:36 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0EE17ED99
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 20:36:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id r13-20020a25ac4d000000b00628b47f44afso5326934ybd.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 20:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hVhp0B9PQwo3QVpUi+NI1HAAHxq+/43f5jq0h0ON3rc=;
        b=FExUDM+QtGlrpOx9rGz2Fa+bDQpFmka6zCE/rTKzwCcAWIfnoZcXeXrKFxNhFsnE2C
         E6l8TXSOLYl+5HB7NA1NFgtEFjaxCkwRJ42gOFxorun060VHOvwG4dO7+/BFj6P1XBBp
         nnNqyUkTruTkTLp+7GFYOf9jPip2hwzfByNoweGhp1Yt6rqDAcdoNKtbx1MoMT0ytTV3
         w53+7zlLjb5noE0qE49+yuSbpUgIu5MIBlWjYMHaKBHDBc9rcCbm9jI50ZVw73N5mmlk
         Kmfnx62thJdUrj68w3MZObD0sXEixf/K7lcKb3+iemG1wJPFZsf1Mm5aoSazkRYutnH7
         jn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hVhp0B9PQwo3QVpUi+NI1HAAHxq+/43f5jq0h0ON3rc=;
        b=s+tbjBP/HVRu9EuZuur+h+0fclJ0n30iGi+dh3Pvv0qQLsOkpojimQxlsv0uElupsr
         DOB8T9PJJuoNLLYz65NBqeLexhi/J56WdXDGmn/YPmIuM0k0k5pAMG2HS+EdUkIaU/bj
         qS9kbITqSJdjaOqq1R4758e3y2TU9VgqH5hGOOdTdtg/yUcf+C1IO7rRLanKaoiR6goX
         WF7raXZhJc+hpiosH/kaRANrhqirhbVo+Z2WiylfIEFUeXo7tcrEkdnpBcUNqiHkVv8g
         X1g0kQ5GYOmGemNbBpHX6WcewscEJM/xmhINJwnupZKs1lo6Xo0OV26I4E9hNSBIowO6
         /TYw==
X-Gm-Message-State: AOAM530igF/xt3dwYOYKEzFtx9bF5AfHaCyzDJF6aE1JWtC7bhJN/xOR
        lp1m6+dbgDhNLsnMy5mNAmFtHSBww0I=
X-Google-Smtp-Source: ABdhPJxVVZFZHqAwY1fPRX9HI0yIhKH2iiN9GsYqQS6rzxP15cyYglv/sh4CkSy/3rdozBTmFM9ySxJLa2U=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:306])
 (user=ctshao job=sendgmr) by 2002:a25:3252:0:b0:628:a874:e41e with SMTP id
 y79-20020a253252000000b00628a874e41emr9969830yby.484.1646368608392; Thu, 03
 Mar 2022 20:36:48 -0800 (PST)
Date:   Fri,  4 Mar 2022 04:14:51 +0000
Message-Id: <20220304041449.939308-1-ctshao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v3] config: Allow kernel installation packaging to override pkg-config
From:   Chun-Tse Shao <ctshao@google.com>
To:     rostedt@goodmis.org, ndesaulniers@google.com
Cc:     ctshao@google.com, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending as a separate thread ]

Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
what pkg-config and parameters are used.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
Changes from v2: https://lore.kernel.org/all/20220302193638.11034-1-ctshao@google.com/
  - Fix more open coded instance of pkg-config in scripts and certs
  - Tested with make allmodconfig

Changes from v1: https://lore.kernel.org/all/20220301230629.1892828-1-ctshao@google.com/
  - Make the commit message more clearer.
---

 Makefile                     |  3 ++-
 certs/Makefile               |  4 ++--
 scripts/Makefile             |  4 ++--
 scripts/dtc/Makefile         |  6 +++---
 scripts/kconfig/gconf-cfg.sh | 10 +++++-----
 scripts/kconfig/mconf-cfg.sh | 14 +++++++-------
 scripts/kconfig/nconf-cfg.sh | 14 +++++++-------
 scripts/kconfig/qconf-cfg.sh | 14 +++++++-------
 tools/objtool/Makefile       |  4 ++--
 9 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index daeb5c88b50b..f6c5bef7e141 100644
--- a/Makefile
+++ b/Makefile
@@ -430,6 +430,7 @@ else
 HOSTCC	= gcc
 HOSTCXX	= g++
 endif
+HOSTPKG_CONFIG	= pkg-config

 export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
 			      -O2 -fomit-frame-pointer -std=gnu89
@@ -525,7 +526,7 @@ KBUILD_LDFLAGS_MODULE :=
 KBUILD_LDFLAGS :=
 CLANG_FLAGS :=

-export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC
+export ARCH SRCARCH CONFIG_SHELL BASH HOSTCC KBUILD_HOSTCFLAGS CROSS_COMPILE LD CC HOSTPKG_CONFIG
 export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
diff --git a/certs/Makefile b/certs/Makefile
index 3ea7fe60823f..fa540d14ef2d 100644
--- a/certs/Makefile
+++ b/certs/Makefile
@@ -89,5 +89,5 @@ targets += x509_revocation_list

 hostprogs := extract-cert

-HOSTCFLAGS_extract-cert.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
-HOSTLDLIBS_extract-cert = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
+HOSTCFLAGS_extract-cert.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_extract-cert = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
diff --git a/scripts/Makefile b/scripts/Makefile
index ce5aa9030b74..f084f08ed176 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -14,8 +14,8 @@ hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 HOSTCFLAGS_sorttable.o = -I$(srctree)/tools/include
 HOSTLDLIBS_sorttable = -lpthread
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
-HOSTCFLAGS_sign-file.o = $(shell pkg-config --cflags libcrypto 2> /dev/null)
-HOSTLDLIBS_sign-file = $(shell pkg-config --libs libcrypto 2> /dev/null || echo -lcrypto)
+HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)

 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
index 95aaf7431bff..743fc08827ea 100644
--- a/scripts/dtc/Makefile
+++ b/scripts/dtc/Makefile
@@ -18,7 +18,7 @@ fdtoverlay-objs	:= $(libfdt) fdtoverlay.o util.o
 # Source files need to get at the userspace version of libfdt_env.h to compile
 HOST_EXTRACFLAGS += -I $(srctree)/$(src)/libfdt

-ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
+ifeq ($(shell $(HOSTPKG_CONFIG) --exists yaml-0.1 2>/dev/null && echo yes),)
 ifneq ($(CHECK_DT_BINDING)$(CHECK_DTBS),)
 $(error dtc needs libyaml for DT schema validation support. \
 	Install the necessary libyaml development package.)
@@ -27,9 +27,9 @@ HOST_EXTRACFLAGS += -DNO_YAML
 else
 dtc-objs	+= yamltree.o
 # To include <yaml.h> installed in a non-default path
-HOSTCFLAGS_yamltree.o := $(shell pkg-config --cflags yaml-0.1)
+HOSTCFLAGS_yamltree.o := $(shell $(HOSTPKG_CONFIG) --cflags yaml-0.1)
 # To link libyaml installed in a non-default path
-HOSTLDLIBS_dtc	:= $(shell pkg-config yaml-0.1 --libs)
+HOSTLDLIBS_dtc	:= $(shell $(HOSTPKG_CONFIG) yaml-0.1 --libs)
 endif

 # Generated files need one more search path to include headers in source tree
diff --git a/scripts/kconfig/gconf-cfg.sh b/scripts/kconfig/gconf-cfg.sh
index 480ecd8b9f41..267ef6012203 100755
--- a/scripts/kconfig/gconf-cfg.sh
+++ b/scripts/kconfig/gconf-cfg.sh
@@ -3,14 +3,14 @@

 PKG="gtk+-2.0 gmodule-2.0 libglade-2.0"

-if [ -z "$(command -v pkg-config)" ]; then
+if [ -z "$(command -v $(HOSTPKG_CONFIG))" ]; then
 	echo >&2 "*"
 	echo >&2 "* 'make gconfig' requires 'pkg-config'. Please install it."
 	echo >&2 "*"
 	exit 1
 fi

-if ! pkg-config --exists $PKG; then
+if ! $(HOSTPKG_CONFIG) --exists $PKG; then
 	echo >&2 "*"
 	echo >&2 "* Unable to find the GTK+ installation. Please make sure that"
 	echo >&2 "* the GTK+ 2.0 development package is correctly installed."
@@ -19,12 +19,12 @@ if ! pkg-config --exists $PKG; then
 	exit 1
 fi

-if ! pkg-config --atleast-version=2.0.0 gtk+-2.0; then
+if ! $(HOSTPKG_CONFIG) --atleast-version=2.0.0 gtk+-2.0; then
 	echo >&2 "*"
 	echo >&2 "* GTK+ is present but version >= 2.0.0 is required."
 	echo >&2 "*"
 	exit 1
 fi

-echo cflags=\"$(pkg-config --cflags $PKG)\"
-echo libs=\"$(pkg-config --libs $PKG)\"
+echo cflags=\"$($(HOSTPKG_CONFIG) --cflags $PKG)\"
+echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG)\"
diff --git a/scripts/kconfig/mconf-cfg.sh b/scripts/kconfig/mconf-cfg.sh
index b520e407a8eb..21e40e9a7cd6 100755
--- a/scripts/kconfig/mconf-cfg.sh
+++ b/scripts/kconfig/mconf-cfg.sh
@@ -4,16 +4,16 @@
 PKG="ncursesw"
 PKG2="ncurses"

-if [ -n "$(command -v pkg-config)" ]; then
-	if pkg-config --exists $PKG; then
-		echo cflags=\"$(pkg-config --cflags $PKG)\"
-		echo libs=\"$(pkg-config --libs $PKG)\"
+if [ -n "$(command -v $(HOSTPKG_CONFIG))" ]; then
+	if $(HOSTPKG_CONFIG) --exists $PKG; then
+		echo cflags=\"$($(HOSTPKG_CONFIG) --cflags $PKG)\"
+		echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG)\"
 		exit 0
 	fi

-	if pkg-config --exists $PKG2; then
-		echo cflags=\"$(pkg-config --cflags $PKG2)\"
-		echo libs=\"$(pkg-config --libs $PKG2)\"
+	if $(HOSTPKG_CONFIG) --exists $PKG2; then
+		echo cflags=\"$($(HOSTPKG_CONFIG) --cflags $PKG2)\"
+		echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG2)\"
 		exit 0
 	fi
 fi
diff --git a/scripts/kconfig/nconf-cfg.sh b/scripts/kconfig/nconf-cfg.sh
index c212255070c0..eec46e627e5c 100755
--- a/scripts/kconfig/nconf-cfg.sh
+++ b/scripts/kconfig/nconf-cfg.sh
@@ -4,16 +4,16 @@
 PKG="ncursesw menuw panelw"
 PKG2="ncurses menu panel"

-if [ -n "$(command -v pkg-config)" ]; then
-	if pkg-config --exists $PKG; then
-		echo cflags=\"$(pkg-config --cflags $PKG)\"
-		echo libs=\"$(pkg-config --libs $PKG)\"
+if [ -n "$(command -v $(HOSTPKG_CONFIG))" ]; then
+	if $(HOSTPKG_CONFIG) --exists $PKG; then
+		echo cflags=\"$($(HOSTPKG_CONFIG) --cflags $PKG)\"
+		echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG)\"
 		exit 0
 	fi

-	if pkg-config --exists $PKG2; then
-		echo cflags=\"$(pkg-config --cflags $PKG2)\"
-		echo libs=\"$(pkg-config --libs $PKG2)\"
+	if $(HOSTPKG_CONFIG) --exists $PKG2; then
+		echo cflags=\"$($(HOSTPKG_CONFIG) --cflags $PKG2)\"
+		echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG2)\"
 		exit 0
 	fi
 fi
diff --git a/scripts/kconfig/qconf-cfg.sh b/scripts/kconfig/qconf-cfg.sh
index fa564cd795b7..839b45b5746e 100755
--- a/scripts/kconfig/qconf-cfg.sh
+++ b/scripts/kconfig/qconf-cfg.sh
@@ -3,22 +3,22 @@

 PKG="Qt5Core Qt5Gui Qt5Widgets"

-if [ -z "$(command -v pkg-config)" ]; then
+if [ -z "$(command -v $(HOSTPKG_CONFIG))" ]; then
 	echo >&2 "*"
-	echo >&2 "* 'make xconfig' requires 'pkg-config'. Please install it."
+	echo >&2 "* 'make xconfig' requires '$(HOSTPKG_CONFIG)'. Please install it."
 	echo >&2 "*"
 	exit 1
 fi

-if pkg-config --exists $PKG; then
-	echo cflags=\"-std=c++11 -fPIC $(pkg-config --cflags $PKG)\"
-	echo libs=\"$(pkg-config --libs $PKG)\"
-	echo moc=\"$(pkg-config --variable=host_bins Qt5Core)/moc\"
+if $(HOSTPKG_CONFIG) --exists $PKG; then
+	echo cflags=\"-std=c++11 -fPIC $($(HOSTPKG_CONFIG) --cflags $PKG)\"
+	echo libs=\"$($(HOSTPKG_CONFIG) --libs $PKG)\"
+	echo moc=\"$($(HOSTPKG_CONFIG) --variable=host_bins Qt5Core)/moc\"
 	exit 0
 fi

 echo >&2 "*"
-echo >&2 "* Could not find Qt5 via pkg-config."
+echo >&2 "* Could not find Qt5 via $(HOSTPKG_CONFIG)."
 echo >&2 "* Please install Qt5 and make sure it's in PKG_CONFIG_PATH"
 echo >&2 "*"
 exit 1
diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index 92ce4fce7bc7..549acc5859e9 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -19,8 +19,8 @@ LIBSUBCMD		= $(LIBSUBCMD_OUTPUT)libsubcmd.a
 OBJTOOL    := $(OUTPUT)objtool
 OBJTOOL_IN := $(OBJTOOL)-in.o

-LIBELF_FLAGS := $(shell pkg-config libelf --cflags 2>/dev/null)
-LIBELF_LIBS  := $(shell pkg-config libelf --libs 2>/dev/null || echo -lelf)
+LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)

 all: $(OBJTOOL)

--
2.35.1.616.g0bdcbb4464-goog

