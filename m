Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF1D518F80
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 22:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiECU7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242174AbiECU6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:58:44 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500363E5E7
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 13:55:10 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id v11so6224189pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0s2l8L34z34MUkPb/xcNxM9oOQ5pfRGE8+PgPesbjxc=;
        b=bhVNBEZ+27B/SccXVadaHG1jvpOqXyYJ+hj8GEC9P9p9MQDKaF4BLipZ7tMCTUGtNz
         PICi0sZeHr7t7kjGGRSBO8mzLluE7LOSWG4BnDKhxnnOuZFtTMVW6xXYTxLuym405lSP
         B3+FxDhigUqiTNZFl1mYMxRpZfBypDicHUpbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0s2l8L34z34MUkPb/xcNxM9oOQ5pfRGE8+PgPesbjxc=;
        b=C5DVAx6iwMu/pVrSbCk4JkmhLhVAmZsLkcKdpL51t9IZTw91/lZDf0aCwE6Usgvo58
         ByHWiHyHXF+hSIyVR8nwvQ4zW90YpYk+6Jty3MWa9vJEMyxCOgwEXwNjQrA9o8ypGHnJ
         /CrgHXXaMcEZmTLzsc7ReSTQ5WLqzpW9pqjWXzU/O/IAJ5YrqcDC8tZmPW4MnAp2XX18
         mDnZMb8Y21IP78SIUNIGfnJSr+f0oxlwKhJ9/Q+p8Kp2/Hng7Fc2TdKD3IJJxANGkANS
         LwQHGfo39cZNzHzIno6u92i3OG9s0ZYr7HFaeXnrfRdT7khHiXASS+DIQNyI/vq8eJSE
         Xl8g==
X-Gm-Message-State: AOAM533EorY+vOVFXssR1b+XnNRlxMX567jzqKnIbrvnvr9lKBdu1rY+
        Ss4Ps7yB20m6JmxoKXFy0yP+XA==
X-Google-Smtp-Source: ABdhPJxNh718o6lZcnrjFVdXM6pAZT3sVcEOZcCHQo1I7zTGHYHYdiEGHt2M12oOpzHuik2BFiOqqA==
X-Received: by 2002:a63:2d46:0:b0:3c1:424a:2a90 with SMTP id t67-20020a632d46000000b003c1424a2a90mr15245588pgt.35.1651611309785;
        Tue, 03 May 2022 13:55:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e24-20020a63f558000000b003c14af50638sm3571630pgk.80.2022.05.03.13.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 13:55:08 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Bill Wendling <morbo@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Howells <dhowells@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 4/6] randstruct: Split randstruct Makefile and CFLAGS
Date:   Tue,  3 May 2022 13:55:01 -0700
Message-Id: <20220503205503.3054173-5-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220503205503.3054173-1-keescook@chromium.org>
References: <20220503205503.3054173-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6703; h=from:subject; bh=ZEmrZ0k2Reix3PKt6lfCkuyHYsw1YqQ5sKxXW11+HTw=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicZam4zhEqDWTM2MIktnKTuhNVNv/8H6Fea3xejgt HnjQkAKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnGWpgAKCRCJcvTf3G3AJq7lEA CuZ+xeZNdVslL1dtCv78SwqgkVF0Irvo2o5Ics+MdKOz0zPRHZP6oMToUFSgisWVwucBw1doPlHwwF zhbFZ5b9Z/mtyEvMqJQMoRsw/4Z7muCHglm3Dv8O47FpzI+yiiO30zPSHWfI74tHx92EWmSpJ/2Gxj R+Q4E8GQUabJY6Jh+dJuOpyF5HHJViaVqL7bdj5/mm5HymCYOEq5Jr71Cw/oyS7FGHAeEqyoaT1KUx srmuQy5RY0pPrL9SMAlO6//qsp85AalH8rgppGOsAl/H2/MkYpbouZtgklux7zpjPVLXrZxWWs3FL8 j0IynPZlYJImwZQlLdXPHm3O1BmKSHCQgQ8932YDoPHTJpTomyOeIjSvUD0FM1CGs4IisY5almpKHa 7mI4Ac0Zq7V2/VjDhtDgt343eONTqXX0hdzLr8CAK/ZlwFgi3TrXwqP7LN+t9Deb3tAzJPl1P4SNPK 09KMgW8IobL0wwL3um45dfvqf4uIvDJyAW1pcWbkWPuanq553xzB0h3RhRqtGB4+2uCCRbl9O1hXrT iBZ1IJYTRPfXawzfDUNGV73thtPTZmvfKZTnocs6/UKcP6sCw3XM8DEYkh/GE0q1u68QlcGu6agRXQ uUIg1L8Hn/FAG0pt19d+14PNYE3uHeKpWoNkw7Dva1Fdd9aWiHHtqQbmnoww==
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

To enable the new Clang randstruct implementation[1], move
randstruct into its own Makefile and split the CFLAGS from
GCC_PLUGINS_CFLAGS into RANDSTRUCT_CFLAGS.

[1] https://reviews.llvm.org/D121556

Cc: linux-hardening@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile                        |  1 +
 arch/arm/vdso/Makefile          |  2 +-
 arch/arm64/kernel/vdso/Makefile |  3 ++-
 arch/sparc/vdso/Makefile        |  3 ++-
 arch/x86/entry/vdso/Makefile    |  3 ++-
 scripts/Makefile.gcc-plugins    |  8 ++------
 scripts/Makefile.randstruct     | 14 ++++++++++++++
 7 files changed, 24 insertions(+), 10 deletions(-)
 create mode 100644 scripts/Makefile.randstruct

diff --git a/Makefile b/Makefile
index 29e273d3f8cc..91c91fcf3c24 100644
--- a/Makefile
+++ b/Makefile
@@ -1011,6 +1011,7 @@ include-$(CONFIG_KASAN)		+= scripts/Makefile.kasan
 include-$(CONFIG_KCSAN)		+= scripts/Makefile.kcsan
 include-$(CONFIG_UBSAN)		+= scripts/Makefile.ubsan
 include-$(CONFIG_KCOV)		+= scripts/Makefile.kcov
+include-$(CONFIG_RANDSTRUCT)	+= scripts/Makefile.randstruct
 include-$(CONFIG_GCC_PLUGINS)	+= scripts/Makefile.gcc-plugins
 
 include $(addprefix $(srctree)/, $(include-y))
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index ec52b776f926..8ca1c9f262a2 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -28,7 +28,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
 CFLAGS_REMOVE_vdso.o = -pg
 
 # Force -O2 to avoid libgcc dependencies
-CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(GCC_PLUGINS_CFLAGS)
+CFLAGS_REMOVE_vgettimeofday.o = -pg -Os $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS)
 ifeq ($(c-gettimeofday-y),)
 CFLAGS_vgettimeofday.o = -O2
 else
diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 172452f79e46..d9147fba1a0b 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -32,7 +32,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # -Wmissing-prototypes and -Wmissing-declarations are removed from
 # the CFLAGS of vgettimeofday.c to make possible to build the
 # kernel with CONFIG_WERROR enabled.
-CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
+CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
+				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
 				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index c5e1545bc5cf..77d7b9032158 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -58,7 +58,7 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64
 
 SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 -fcall-used-g5 -fcall-used-g7
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -88,6 +88,7 @@ $(obj)/vdso32.so.dbg: asflags-$(CONFIG_SPARC64) += -m32
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=medlow,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 693f8b9031fb..c2a8b76ae0bc 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -148,6 +148,7 @@ KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
diff --git a/scripts/Makefile.gcc-plugins b/scripts/Makefile.gcc-plugins
index 827c47ce5c73..692d64a70542 100644
--- a/scripts/Makefile.gcc-plugins
+++ b/scripts/Makefile.gcc-plugins
@@ -22,12 +22,6 @@ export DISABLE_STRUCTLEAK_PLUGIN
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STRUCTLEAK)		\
 		+= -DSTRUCTLEAK_PLUGIN
 
-gcc-plugin-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)	+= randomize_layout_plugin.so
-gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
-		+= -DRANDSTRUCT
-gcc-plugin-cflags-$(CONFIG_RANDSTRUCT_PERFORMANCE)		\
-		+= -fplugin-arg-randomize_layout_plugin-performance-mode
-
 gcc-plugin-$(CONFIG_GCC_PLUGIN_STACKLEAK)	+= stackleak_plugin.so
 gcc-plugin-cflags-$(CONFIG_GCC_PLUGIN_STACKLEAK)		\
 		+= -DSTACKLEAK_PLUGIN
@@ -60,6 +54,8 @@ KBUILD_CFLAGS += $(GCC_PLUGINS_CFLAGS)
 # be included in GCC_PLUGIN so they can get built.
 gcc-plugin-external-$(CONFIG_GCC_PLUGIN_SANCOV)			\
 	+= sancov_plugin.so
+gcc-plugin-external-$(CONFIG_GCC_PLUGIN_RANDSTRUCT)		\
+	+= randomize_layout_plugin.so
 
 # All enabled GCC plugins are collected here for building in
 # scripts/gcc-scripts/Makefile.
diff --git a/scripts/Makefile.randstruct b/scripts/Makefile.randstruct
new file mode 100644
index 000000000000..4d741e6db554
--- /dev/null
+++ b/scripts/Makefile.randstruct
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+randstruct-cflags-y += -DRANDSTRUCT
+
+ifdef CONFIG_GCC_PLUGIN_RANDSTRUCT
+randstruct-cflags-y	\
+	+= -fplugin=$(objtree)/scripts/gcc-plugins/randomize_layout_plugin.so
+randstruct-cflags-$(CONFIG_RANDSTRUCT_PERFORMANCE)		\
+	+= -fplugin-arg-randomize_layout_plugin-performance-mode
+endif
+
+export RANDSTRUCT_CFLAGS := $(randstruct-cflags-y)
+
+KBUILD_CFLAGS	+= $(RANDSTRUCT_CFLAGS)
-- 
2.32.0

