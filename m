Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BB4A034A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:09:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346887AbiA1WJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:09:30 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:59488 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbiA1WJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:09:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643407767; x=1674943767;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PhNwraqeNzBQCp3DlOoO6HsTUs5QilywxZOxmi80nbQ=;
  b=bBqOeiF+oe/owAWV87fNZyb4beKqzmYUGGynwOL/Fr0u/y/sN97TDozB
   xCcgLuLcTDnL2UlAbiiQOG7s5TVebyODkfKaqL0sEeRJO8oiU/wpRAEmu
   QO2OdtVqLFOZ1wUW5sZ2CxmJA3QtPBJYYvi2TGqk42huuA8E3AXJmBUDc
   U=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Jan 2022 14:09:26 -0800
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:09:26 -0800
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 28 Jan 2022 14:09:26 -0800
From:   Elliot Berman <quic_eberman@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Matthias Maennich <maennich@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <llvm@lists.linux.dev>
Subject: [PATCH v2] kbuild: Add environment variables for userprogs flags
Date:   Fri, 28 Jan 2022 14:08:41 -0800
Message-ID: <20220128220841.3222637-1-quic_eberman@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220112224342.958358-1-quic_eberman@quicinc.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
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
these environment variables, you can specify flags such as:

$ make USERCFLAGS=--sysroot=/dev/null USERLDFLAGS=-Wl,--sysroot=/dev/null

to force sysroot detection to fail.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

Changes since v1: Addressed minor nits from Nick
---
 Documentation/kbuild/kbuild.rst    | 9 +++++++++
 Documentation/kbuild/makefiles.rst | 2 ++
 Makefile                           | 9 ++++++---
 init/Kconfig                       | 8 ++++----
 usr/include/Makefile               | 3 +++
 5 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/Documentation/kbuild/kbuild.rst b/Documentation/kbuild/kbuild.rst
index 2d1fc03d346e..3e7467b19c8f 100644
--- a/Documentation/kbuild/kbuild.rst
+++ b/Documentation/kbuild/kbuild.rst
@@ -77,6 +77,15 @@ HOSTLDLIBS
 ----------
 Additional libraries to link against when building host programs.
 
+USERCFLAGS
+----------
+Additional options used for $(CC) when compiling userprogs.
+
+USERLDFLAGS
+----------
+Additional options used for $(LD) when linking userprogs. userprogs are linked
+with CC, so $(USERLDFLAGS) should include "-Wl," prefix as applicable.
+
 KBUILD_KCONFIG
 --------------
 Set the top-level Kconfig file to the value of this environment
diff --git a/Documentation/kbuild/makefiles.rst b/Documentation/kbuild/makefiles.rst
index b008b90b92c9..39fb70f59429 100644
--- a/Documentation/kbuild/makefiles.rst
+++ b/Documentation/kbuild/makefiles.rst
@@ -982,6 +982,8 @@ The syntax is quite similar. The difference is to use "userprogs" instead of
 
 	When linking bpfilter_umh, it will be passed the extra option -static.
 
+	From command line, USERCFLAGS and USERLDFLAGS will also be used (See kbuild.rst)
+
 5.4 When userspace programs are actually built
 ----------------------------------------------
 
diff --git a/Makefile b/Makefile
index 45278d508d81..8a2324e6bda8 100644
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
+KBUILD_USERLDFLAGS := $(USERLDFLAGS)
 
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

