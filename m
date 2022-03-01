Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0095E4C98BC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 00:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiCAXC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 18:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiCAXCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 18:02:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD1089CC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 15:02:13 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w1-20020a05690204e100b006244315a721so15259923ybs.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 15:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=2MIVdmrF+W5Vu7BwMMSBgT1ZFAbChoQF6V4KQwmEMAY=;
        b=SgcoFHN7sm1xxTbG85D2JV+TDQR6LafJDLLUnt3HC39KlVqYLzaFw9K3kbLMySw+ec
         5OKoxT5qRlZeHziW+iJtmT6UXwdijVM5Grd9pX78uH74FF44JuD0sBjc7jArbUZphKiN
         FsRp9dKaZP0AsKyhxCGn0aQhqvX2w/yP0/TaKAwv4VwsizKPAnrixYn9OIfoTfeIB80/
         JVGc+UbZ/bx0Ys77l/RK0CCR2gH6gild9x9YEFxwH6TsSwu95afLzfYujkHmKC1GDQWO
         ZBHEflxKmdwrxwQOvLMBG8bfCLZXyyM655NMRZwWTMFWoi59It1+tcv0PD2TLwOHruHL
         sdyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=2MIVdmrF+W5Vu7BwMMSBgT1ZFAbChoQF6V4KQwmEMAY=;
        b=Q2LG+0FTT6/W8iB5j4+REB0QTPNIBm5nE79R3cvQoPGbtXxXyk5FaI2ftq7J80kAbD
         onw9X7omd8JpwKZTMAVYeqCWHlGLI1CRJXX+JMVI7zXD2b/urwmzSLmqeCXGWajzC5Jr
         OyKBML+msUWYHVtFdmHsxIroeuVHy/SwIjs+N3XMXPr+TZrtTbTeMz4/3N0aQszzvvyr
         V94QSMvXe24kMsTcE2iulxkW0RgCn3BcovWjm/eC8l2twJnd29J8ZP4yOg8wi7m6R+ov
         sQn/VmDjp54Hpz2Yqj0xKryK1kqVkSpIlYV5dOyXn9AsDVCL+bQhgxvQIeZ+6CrhRalf
         TbBA==
X-Gm-Message-State: AOAM5337PpVJT9wktLxfSUwTMSBbsCPE1j8dOMTk7Po6jjFfw5tHwRDj
        j+OPMivvH4voKWNmUUerD72Gv6Wn3Rlwr1bPcy3uKJTS7Sh+H7vOlqfGuDvLfuGzH2bMzqiGFn6
        A6fKD/q1/6kTb/kSDb+ABLvbLqNMsjvuh9YL75IXhNHpG8KeLIfKA+LGh4NQWiaZt0RxvPA==
X-Google-Smtp-Source: ABdhPJyTIgXTktETeirb8JwTJRa688FDZcKuarPOmy0oMVoBEnVft8AJrr5UOgKNI/Q1IV+c6lkAn9OjILE=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:306])
 (user=ctshao job=sendgmr) by 2002:a25:b098:0:b0:624:634d:c2f5 with SMTP id
 f24-20020a25b098000000b00624634dc2f5mr25702161ybj.214.1646175732332; Tue, 01
 Mar 2022 15:02:12 -0800 (PST)
Date:   Tue,  1 Mar 2022 23:02:08 +0000
Message-Id: <20220301230208.1892023-1-ctshao@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] config: Using HOSTPKG_CONFIG prefix for pkg-config
From:   FirstName LastName <ctshao@google.com>
To:     linux-kernel@vger.kernel.org,
        --cc-cmd=./scripts/get_maintainer.pl@google.com,
        --norolestats@google.com,
        0001-config-Using-HOSTPKG_CONFIG-prefix-for-pkg-config.patch@google.com
Cc:     ctshao@google.com, rostedt@goodmis.org
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

From: Chun-Tse Shao <ctshao@google.com>

In some parts, pkg-config does not use appropriate $BUILDROOT prefix.
The patch adds HOSTPKG_CONFIG prefix for pkg-config to fix the issue.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
---
 Makefile               | 3 ++-
 scripts/Makefile       | 4 ++--
 scripts/dtc/Makefile   | 6 +++---
 tools/objtool/Makefile | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

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
2.35.1.574.g5d30c73bfb-goog

