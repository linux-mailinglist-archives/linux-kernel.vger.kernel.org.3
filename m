Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AC4CAED7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241761AbiCBThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 14:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbiCBThe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:37:34 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98765D76D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:36:50 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id u11-20020a17090ae00b00b001bc4cef20f1so1432396pjy.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 11:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/rFz9WuD68JZvZdSymWTaIZIBcr35Cslo8bOp/2Fz0s=;
        b=Z4dNVLLzNoxuSxQda8ipH6FUJbpN1A5Yyt4TiE7QlIDG6OCU+SMgpd03L2qd+jlK8e
         4k4XCoZwnrytb/orxLBsohQHlnWQqQmsO08rtTNDHVSMe2J3WXgDVsXV5P0/OffCQRcH
         Wvym0V5NY2s9tXPNy8IXmig2GWkYZ8dUqez5IGk/HqpyNfVS5bPTUodnc74DvdvI7J6s
         IDMBKp81GlX4gzm0cSqV7Nhw3VEsNwk52eacNIqToFTjc/clwiEe5k5A0ybJyNT3AMAB
         VP+RIyMbNW7VmxD+YU7N16wS3NRDb4OEkyOjTj/ZbXMpMBU4+3TuD5XgVRMAo4Rrzuqu
         oJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/rFz9WuD68JZvZdSymWTaIZIBcr35Cslo8bOp/2Fz0s=;
        b=ite/4/hZm9LAvzdiWDzs3+88h1JYGeRuhsjr75qiVmMy/vQdTGRDWFlw+k++25w+nh
         5UTswZpoJBvQjJX4tCjd5jzYCNMxxGmeH6tWO022Mp4VOyPgdkTDyChMDMby4hMxryUB
         dcPyYpSqgJhAd+ioJKIO9My40wc0aks+ZtK07y34RiKbt/cY9sJunOgHXK67vWY8b5fz
         bykQXS6BAqF7iTaBSIDAF7BhkCon0zfwt7/sfiA7PUKRppW3pHEv44xQdNRLAhM8XzWN
         QfLVlAjo3gAfl/gMoBksibz10Vdcor1Pcss7OWHf51Lcj0aCs8RBhz8BhGBZB/sU6j95
         M6Vg==
X-Gm-Message-State: AOAM532xIOlYWUHfy1x0gsM6WOAQURYCl+7jPiOD2TTism+1r6oq0sHt
        iepz4xRuu37PbTFNCoHAK9Eq+A0KTm4=
X-Google-Smtp-Source: ABdhPJwOCBzLooZc0i5PnERg9swC5nI04if9PXMoPCbrZH7AGxIoIhWNk5iwcUhjs9Q88WX2SbGsqMkxB8U=
X-Received: from colette.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:306])
 (user=ctshao job=sendgmr) by 2002:a17:902:edcd:b0:14d:c114:b86b with SMTP id
 q13-20020a170902edcd00b0014dc114b86bmr32115492plk.166.1646249810047; Wed, 02
 Mar 2022 11:36:50 -0800 (PST)
Date:   Wed,  2 Mar 2022 19:36:38 +0000
In-Reply-To: <20220302102705.15c32822@gandalf.local.home>
Message-Id: <20220302193638.11034-1-ctshao@google.com>
Mime-Version: 1.0
References: <20220302102705.15c32822@gandalf.local.home>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] config: Allow kernel installation packaging to override pkg-config
From:   Chun-Tse Shao <ctshao@google.com>
To:     rostedt@goodmis.org
Cc:     ctshao@google.com, devicetree@vger.kernel.org,
        frowand.list@gmail.com, jpoimboe@redhat.com,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org, michal.lkml@markovi.net,
        ndesaulniers@google.com, peterz@infradead.org, robh+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HOSTPKG_CONFIG to allow tooling that builds the kernel to override
what pkg-config and parameters are used.

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

