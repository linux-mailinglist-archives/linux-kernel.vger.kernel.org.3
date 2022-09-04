Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D145AC7BE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 23:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbiIDVq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 17:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiIDVpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 17:45:02 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA230576
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 14:42:59 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id r7so3867536ile.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Sep 2022 14:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=KACUwbv9zFDFS+/NnZ2+bHc0BJ5XxAtoDioY/cngaq0=;
        b=VWLo9KQRx3wUEpHavD9gtPYNFllTyy4JKxvs/7m7tkQZM4ST377wbMAzvfbzKUgbOp
         J6WuHZ3P93mqwHnELmx4xWY2iE88bkmZTSJqZgzV49g9rgdp//m9df+iAKw5mapuizNM
         8N7/7jcJanbJgpES8DxAtzXNIpOD8ZbW5WOPK05nV0i1YT9y6m46gm5tX0ZuDvQutVME
         hVXVPzZsqJYaB2x7eaQgiQ5QGXMW5MZGs2s9lLUmDUh275cuM3Hr9LM8UftEseh/RA6Z
         Yc6+zDt9i1m5X50alTa/P6gMXlOYHL2RiMbZY6SXX3tIiEk2zkHyzL+A2td9lp2Hi3c2
         vR2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=KACUwbv9zFDFS+/NnZ2+bHc0BJ5XxAtoDioY/cngaq0=;
        b=vXjYzP9v7C+uaxpH6wOxKAteQHD3A+c3HeXK34TG8+XoECNKSzYg9Fvndzb5V454RS
         XAc3pBEENdGur5yRJCkaio3CUrJRRobwhFixtFzgkpKyKqj6y8rsri9JC55a4v20ZNNV
         yb/5q4t8/COUkwEZQUx7TCfDw61smrdDqYIlXD7xMQdDfZl3Z/8q8xdaaVFY38iGvsOf
         vNPiicG98qijWmAh0xKfWtgIFcExV7Bnf3UFSuRUq1DOgN7IVxRy9kRxxHEYBPbRR0Vm
         CPCJEe4TbMtZ6803UKEvKD7nGVbp6jeAxyaEZTKnQ6XTyD5oQkf7tOL/Z3ovviz8nfvT
         ao0A==
X-Gm-Message-State: ACgBeo3JFRsICJWQn3bDPTxdRAlIHwwVjiFui88HFpl0Blg/j1rEKrAs
        C6tENR5hjZYjqx+lbr6qDrw=
X-Google-Smtp-Source: AA6agR4Fn4lGPNDj+VkdpCwid3ve66XVQ8L4VIZBVbVLfcwMhJmhHwO+CmYwocy3EXC3pDUoc7POZw==
X-Received: by 2002:a05:6e02:1c2b:b0:2e9:f263:2942 with SMTP id m11-20020a056e021c2b00b002e9f2632942mr24514448ilh.74.1662327779197;
        Sun, 04 Sep 2022 14:42:59 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b006889ea7be7bsm3727688iov.29.2022.09.04.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 14:42:58 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        linux@rasmusvillemoes.dk, joe@perches.com,
        Jim Cromie <jim.cromie@gmail.com>, lkp@intel.com
Subject: [PATCH v6 51/57] dyndbg: prevent build bugs via -DNO_DYNAMIC_DEBUG_TABLE
Date:   Sun,  4 Sep 2022 15:41:28 -0600
Message-Id: <20220904214134.408619-52-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220904214134.408619-1-jim.cromie@gmail.com>
References: <20220904214134.408619-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds DEFINE_DYNAMIC_DEBUG_TABLE(), which broke several
subtrees, including efi, vdso, and some of arch/*/boot/compressed,
with various relocation errors, iirc.

Avoid those problems by adding a define to suppress the "transparent"
DEFINE_DYNAMIC_DEBUG_TABLE() invocation.  I found the x86 problems
myself, lkp@intel.com found arm & sparc problems, and may yet find
others.

Reported-by: <lkp@intel.com> # on [jimc:lkp-test/dyndbg-diet] recently
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 arch/arm/boot/compressed/Makefile     | 2 ++
 arch/sparc/vdso/Makefile              | 2 ++
 arch/x86/boot/compressed/Makefile     | 1 +
 arch/x86/entry/vdso/Makefile          | 3 +++
 arch/x86/purgatory/Makefile           | 1 +
 drivers/firmware/efi/libstub/Makefile | 3 ++-
 6 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 41bcbb460fac..f2d7a3b62727 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -81,6 +81,8 @@ compress-$(CONFIG_KERNEL_LZMA) = lzma_with_size
 compress-$(CONFIG_KERNEL_XZ)   = xzkern_with_size
 compress-$(CONFIG_KERNEL_LZ4)  = lz4_with_size
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
 
 ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 77d7b9032158..58ed4d64c978 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -30,6 +30,8 @@ obj-y += $(vdso_img_objs)
 targets += $(vdso_img_cfiles)
 targets += $(vdso_img_sodbg) $(vdso_img-y:%=vdso%.so)
 
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m elf64_sparc -soname linux-vdso.so.1 --no-undefined \
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 35ce1a64068b..b76bbf9fc504 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -36,6 +36,7 @@ KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 12f6c4d714cd..3182728f9f4d 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -29,6 +29,9 @@ vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
 
+# avoid a x86_64_RELATIVE error
+KBUILD_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
+
 # files to link into kernel
 obj-y				+= vma.o extable.o
 KASAN_SANITIZE_vma.o		:= y
diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index 31c634a22818..8d264836ae64 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -35,6 +35,7 @@ PURGATORY_CFLAGS_REMOVE := -mcmodel=kernel
 PURGATORY_CFLAGS := -mcmodel=large -ffreestanding -fno-zero-initialized-in-bss -g0
 PURGATORY_CFLAGS += $(DISABLE_STACKLEAK_PLUGIN) -DDISABLE_BRANCH_PROFILING
 PURGATORY_CFLAGS += -fno-stack-protector
+PURGATORY_CFLAGS += -DNO_DYNAMIC_DEBUG_TABLE
 
 # Default KBUILD_CFLAGS can have -pg option set when FTRACE is enabled. That
 # in turn leaves some undefined symbols like __fentry__ in purgatory and not
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index 3ef67431f05e..2b7e34555c5a 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -14,7 +14,8 @@ cflags-$(CONFIG_X86)		+= -m$(BITS) -D__KERNEL__ \
 				   $(call cc-disable-warning, address-of-packed-member) \
 				   $(call cc-disable-warning, gnu) \
 				   -fno-asynchronous-unwind-tables \
-				   $(CLANG_FLAGS)
+				   $(CLANG_FLAGS) \
+				   -DNO_DYNAMIC_DEBUG_TABLE
 
 # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
 # disable the stackleak plugin
-- 
2.37.2

