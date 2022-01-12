Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAE48CE7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 23:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiALWoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 17:44:16 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20917 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234388AbiALWoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 17:44:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642027454; x=1673563454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aSnUNzNu4fdkDZoWyNMpTbF8e00/yoe3/zXs+MhUfC0=;
  b=c+yHlULksF3QnAG2yI3IsJIRPpIDqX4hSZxXu7aNffOyKTE4yyXj9f4Q
   woPZL20BLjjRRczgN+m+/cTX/E3e3S78AbGL46I0iyHLQRFYr06wdlkFp
   M7zakmB6bJqPwpdV0yf0Beev86VpwVXeDLSgqgFq9Ad4R95VJ+CCsJfIe
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 12 Jan 2022 14:44:14 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 14:44:14 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 12 Jan 2022 14:44:13 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Matthias Maennich <maennich@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH] kbuild: Add environment variables for userprogs flags
Date:   Wed, 12 Jan 2022 14:43:42 -0800
Message-ID: <20220112224342.958358-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow additional arguments be passed to userprogs compilation.
Reproducible clang builds need to provide a sysroot and gcc path to
ensure same toolchain is used across hosts. KCFLAGS is not currently
used for any user programs compilation, so add new USERCFLAGS and
USERLDFLAGS which serves similar purpose as HOSTCFLAGS/HOSTLDFLAGS.

Specifically, I'm trying to force CC_CAN_LINK to consistently fail in
an environment where a user sysroot is not specifically available.
Currently, Clang might automatically detect GCC installation on hosts
which have it installed to a default location in /. With addition of
these environment variables, our build environment can do like
"--sysroot=/dev/null" to force sysroot detection to fail.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/kbuild/kbuild.rst | 8 ++++++++
 Makefile                        | 9 ++++++---
 init/Kconfig                    | 8 ++++----
 usr/include/Makefile            | 3 +++
 4 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 2d1fc03d346e..16e90a3ae01b 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -77,6 +77,14 @@ HOSTLDLIBS
 ----------
 Additional libraries to link against when building host programs.
 
+USERCFLAGS
+----------
+Additional options used for $(CC) when compiling userprogs.
+
+USERLDFLAGS
+----------
+Additional options used for $(LD) when linking userprogs.
+
 KBUILD_KCONFIG
 --------------
 Set the top-level Kconfig file to the value of this environment
diff --git a/Makefile b/Makefile
index 45278d508d81..4a55537c8ca0 100644
--- a/Makefile
+++ b/Makefile
@@ -431,15 +431,17 @@ HOSTCC	= gcc
 HOSTCXX	= g++
 endif
 
-export KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
-			      -O2 -fomit-frame-pointer -std=gnu89
-export KBUILD_USERLDFLAGS :=
+KBUILD_USERCFLAGS := -Wall -Wmissing-prototypes -Wstrict-prototypes \
+		     -O2 -fomit-frame-pointer -std=gnu89
+KBUILD_USERLDFLAGS := $(USERLDFLAGGS)
 
 KBUILD_HOSTCFLAGS   := $(KBUILD_USERCFLAGS) $(HOST_LFS_CFLAGS) $(HOSTCFLAGS)
 KBUILD_HOSTCXXFLAGS := -Wall -O2 $(HOST_LFS_CFLAGS) $(HOSTCXXFLAGS)
 KBUILD_HOSTLDFLAGS  := $(HOST_LFS_LDFLAGS) $(HOSTLDFLAGS)
 KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS) $(HOSTLDLIBS)
 
+KBUILD_USERCFLAGS   += $(USERCFLAGS)
+
 # Make variables (CC, etc...)
 CPP		= $(CC) -E
 ifneq ($(LLVM),)
@@ -530,6 +532,7 @@ export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AW
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
 export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
+export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
 
 export KBUILD_CPPFLAGS NOSTDINC_FLAGS LINUXINCLUDE OBJCOPYFLAGS KBUILD_LDFLAGS
 export KBUILD_CFLAGS CFLAGS_KERNEL CFLAGS_MODULE
diff --git a/init/Kconfig b/init/Kconfig
index f2ae41e6717f..164706c38e8b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -62,13 +62,13 @@ config LLD_VERSION
 
 config CC_CAN_LINK
 	bool
-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag)) if 64BIT
-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag))
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag)) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag))
 
 config CC_CAN_LINK_STATIC
 	bool
-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m64-flag) -static) if 64BIT
-	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(m32-flag) -static)
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m64-flag) -static) if 64BIT
+	default $(success,$(srctree)/scripts/cc-can-link.sh $(CC) $(CLANG_FLAGS) $(USERCFLAGS) $(USERLDFLAGS) $(m32-flag) -static)
 
 config CC_HAS_ASM_GOTO
 	def_bool $(success,$(srctree)/scripts/gcc-goto.sh $(CC))
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 1c2ae1368079..6a8c7dd9ccaf 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -12,6 +12,9 @@ UAPI_CFLAGS := -std=c90 -Wall -Werror=implicit-function-declaration
 # It is here just because CONFIG_CC_CAN_LINK is tested with -m32 or -m64.
 UAPI_CFLAGS += $(filter -m32 -m64, $(KBUILD_CFLAGS))
 
+# USERCFLAGS might contain sysroot location for CC
+UAPI_CFLAGS += $(USERCFLAGS)
+
 override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 
 # The following are excluded for now because they fail to build.
-- 
2.25.1

