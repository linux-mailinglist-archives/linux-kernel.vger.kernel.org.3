Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302504C2F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236145AbiBXPUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235999AbiBXPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:18:41 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9934316112B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=NdW3vMEHBuZgSQPa2R+CP/mAeeZ+WP0ShbySzxSNg2k=; b=lQLJTgMXY1+KoSqPMyE7Lfsy2A
        MFz1fBUXY4I1bLCbbvM8d4y81Ks52EZmIN6iA8EiZKc4nouMEo9Q77hfbVz+LWGPf8nY8P9tqhhQo
        mPRUDx3Na0OMbZeD6p5W8LIp0dzuoXDLnYK08EUTDNty6ZR5UhomGM+hsdQDduSVokKZTSEaSBfvM
        JnCgc8gzf7fqLmXPhEAcmsSb59zf7gvy8jqyWAo+b72HQa+1zSSI2PcbOsWxqFv/YWNsh+LXMUAsw
        4ikvOVVp5d4/jywdogDWIAqJRZDkoi88k3bA7il/9F6AA8qHKqo1GEbb4/UdvmSQ+gbAD+6DKN4vH
        ohwESpBg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNFs2-00CeLX-JI; Thu, 24 Feb 2022 15:17:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 643AE3005BA;
        Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 1F77529E75E49; Thu, 24 Feb 2022 16:17:28 +0100 (CET)
Message-ID: <20220224151322.072632223@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Feb 2022 15:51:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v2 01/39] kbuild: Fix clang build
References: <20220224145138.952963315@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Debian (and derived) distros ship their compilers as -$ver suffixed
binaries. For gcc it is sufficent to use:

 $ make CC=gcc-12

However, clang builds (esp. clang-lto) need a whole array of tools to be
exactly right, leading to unweildy stuff like:

 $ make CC=clang-13 LD=ld.lld-13 AR=llvm-ar-13 NM=llvm-nm-13 OBJCOPY=llvm-objcopy-13 OBJDUMP=llvm-objdump-13 READELF=llvm-readelf-13 STRIP=llvm-strip-13 LLVM=1

which is, quite franktly, totally insane and unusable. Instead make
the CC variable DTRT, enabling one such as myself to use:

 $ make CC=clang-13

This also lets one quickly test different clang versions.
Additionally, also support path based LLVM suites like:

 $ make CC=/opt/llvm/bin/clang

This changes the default to LLVM=1 when CC is clang, mixing toolchains
is still possible by explicitly adding LLVM=0.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile                       |   45 +++++++++++++++++++++++++++---------
 tools/scripts/Makefile.include |   50 ++++++++++++++++++++++++++++-------------
 2 files changed, 68 insertions(+), 27 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -423,9 +423,29 @@ HOST_LFS_CFLAGS := $(shell getconf LFS_C
 HOST_LFS_LDFLAGS := $(shell getconf LFS_LDFLAGS 2>/dev/null)
 HOST_LFS_LIBS := $(shell getconf LFS_LIBS 2>/dev/null)
 
-ifneq ($(LLVM),)
-HOSTCC	= clang
-HOSTCXX	= clang++
+# powerpc and s390 don't yet work with LLVM as a whole
+ifeq ($(ARCH),powerpc)
+LLVM = 0
+endif
+ifeq ($(ARCH),s390)
+LLVM = 0
+endif
+
+# otherwise, if CC=clang, default to using LLVM to enable LTO
+CC_BASE := $(shell echo $(CC) | sed 's/.*\///')
+CC_NAME := $(shell echo $(CC_BASE) | cut -b "1-5")
+ifeq ($(shell test "$(CC_NAME)" = "clang"; echo $$?),0)
+LLVM ?= 1
+LLVM_PFX := $(shell echo $(CC) | sed 's/\(.*\/\)\?.*/\1/')
+LLVM_SFX := $(shell echo $(CC_BASE) | cut -b "6-")
+endif
+
+# if not set by now, do not use LLVM
+LLVM ?= 0
+
+ifneq ($(LLVM),0)
+HOSTCC	= $(LLVM_PFX)clang$(LLVM_SFX)
+HOSTCXX	= $(LLVM_PFX)clang++$(LLVM_SFX)
 else
 HOSTCC	= gcc
 HOSTCXX	= g++
@@ -442,15 +462,15 @@ KBUILD_HOSTLDLIBS   := $(HOST_LFS_LIBS)
 
 # Make variables (CC, etc...)
 CPP		= $(CC) -E
-ifneq ($(LLVM),)
-CC		= clang
-LD		= ld.lld
-AR		= llvm-ar
-NM		= llvm-nm
-OBJCOPY		= llvm-objcopy
-OBJDUMP		= llvm-objdump
-READELF		= llvm-readelf
-STRIP		= llvm-strip
+ifneq ($(LLVM),0)
+CC		= $(LLVM_PFX)clang$(LLVM_SFX)
+LD		= $(LLVM_PFX)ld.lld$(LLVM_SFX)
+AR		= $(LLVM_PFX)llvm-ar$(LLVM_SFX)
+NM		= $(LLVM_PFX)llvm-nm$(LLVM_SFX)
+OBJCOPY		= $(LLVM_PFX)llvm-objcopy$(LLVM_SFX)
+OBJDUMP		= $(LLVM_PFX)llvm-objdump$(LLVM_SFX)
+READELF		= $(LLVM_PFX)llvm-readelf$(LLVM_SFX)
+STRIP		= $(LLVM_PFX)llvm-strip$(LLVM_SFX)
 else
 CC		= $(CROSS_COMPILE)gcc
 LD		= $(CROSS_COMPILE)ld
@@ -461,6 +481,7 @@ OBJDUMP		= $(CROSS_COMPILE)objdump
 READELF		= $(CROSS_COMPILE)readelf
 STRIP		= $(CROSS_COMPILE)strip
 endif
+
 PAHOLE		= pahole
 RESOLVE_BTFIDS	= $(objtree)/tools/bpf/resolve_btfids/resolve_btfids
 LEX		= flex
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -51,12 +51,32 @@ define allow-override
     $(eval $(1) = $(2)))
 endef
 
-ifneq ($(LLVM),)
-$(call allow-override,CC,clang)
-$(call allow-override,AR,llvm-ar)
-$(call allow-override,LD,ld.lld)
-$(call allow-override,CXX,clang++)
-$(call allow-override,STRIP,llvm-strip)
+# powerpc and s390 don't yet work with LLVM as a whole
+ifeq ($(ARCH),powerpc)
+LLVM = 0
+endif
+ifeq ($(ARCH),s390)
+LLVM = 0
+endif
+
+# otherwise, if CC=clang, default to using LLVM to enable LTO
+CC_BASE := $(shell echo $(CC) | sed 's/.*\///')
+CC_NAME := $(shell echo $(CC_BASE) | cut -b "1-5")
+ifeq ($(shell test "$(CC_NAME)" = "clang"; echo $$?),0)
+LLVM ?= 1
+LLVM_PFX := $(shell echo $(CC) | sed 's/\(.*\/\)\?.*/\1/')
+LLVM_SFX := $(shell echo $(CC_BASE) | cut -b "6-")
+endif
+
+# if not set by now, do not use LLVM
+LLVM ?= 0
+
+ifneq ($(LLVM),0)
+$(call allow-override,CC,$(LLVM_PFX)clang$(LLVM_SFX))
+$(call allow-override,AR,$(LLVM_PFX)llvm-ar$(LLVM_SFX))
+$(call allow-override,LD,$(LLVM_PFX)ld.lld$(LLVM_SFX))
+$(call allow-override,CXX,$(LLVM_PFX)clang++$(LLVM_SFX))
+$(call allow-override,STRIP,$(LLVM_PFX)llvm-strip$(LLVM_SFX))
 else
 # Allow setting various cross-compile vars or setting CROSS_COMPILE as a prefix.
 $(call allow-override,CC,$(CROSS_COMPILE)gcc)
@@ -68,10 +88,10 @@ endif
 
 CC_NO_CLANG := $(shell $(CC) -dM -E -x c /dev/null | grep -Fq "__clang__"; echo $$?)
 
-ifneq ($(LLVM),)
-HOSTAR  ?= llvm-ar
-HOSTCC  ?= clang
-HOSTLD  ?= ld.lld
+ifneq ($(LLVM),0)
+HOSTAR  ?= $(LLVM_PFX)llvm-ar$(LLVM_SFX)
+HOSTCC  ?= $(LLVM_PFX)clang$(LLVM_SFX)
+HOSTLD  ?= $(LLVM_PFX)ld.lld$(LLVM_SFX)
 else
 HOSTAR  ?= ar
 HOSTCC  ?= gcc
@@ -79,11 +99,11 @@ HOSTLD  ?= ld
 endif
 
 # Some tools require Clang, LLC and/or LLVM utils
-CLANG		?= clang
-LLC		?= llc
-LLVM_CONFIG	?= llvm-config
-LLVM_OBJCOPY	?= llvm-objcopy
-LLVM_STRIP	?= llvm-strip
+CLANG		?= $(LLVM_PFX)clang$(LLVM_SFX)
+LLC		?= $(LLVM_PFX)llc$(LLVM_SFX)
+LLVM_CONFIG	?= $(LLVM_PFX)llvm-config$(LLVM_SFX)
+LLVM_OBJCOPY	?= $(LLVM_PFX)llvm-objcopy$(LLVM_SFX)
+LLVM_STRIP	?= $(LLVM_PFX)llvm-strip$(LLVM_SFX)
 
 ifeq ($(CC_NO_CLANG), 1)
 EXTRA_WARNINGS += -Wstrict-aliasing=3


