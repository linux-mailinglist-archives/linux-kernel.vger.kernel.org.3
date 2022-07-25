Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8911A57FB82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbiGYIk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbiGYIkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:40:23 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAAC32
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:22 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r8so1412938plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kSe97Tx8ctZCEn1X6J3jTXp+4FQKjeXptEPACGdKsu4=;
        b=38IdOZqiUSSjfpSN5DaswpKLzz++/3lQOzoZC4Ut2U51DggOBUm5pTe/PQ/doSkYuO
         y0+Wke94niGekams7+xaCPk/FKZYHAbVOR/JI/jY1NFxusaEy64k1b5dvUMuC07SCRbd
         Wd5FXomw1uG5DwpKUr10bW4d/vWWl3qe7nnxJLhw7kwFUk/ykI0+SDW6ppITZPSCj8mn
         CHxh92xmN0EykOCigMNAHgEBRqJKhZlAeZ0MJ5tDaYaBgXI+OuI/Lc3H4+H+vQ/z40do
         s3Z8YXe9qLVk/neXJ5qFMNQ+WPNhOAvEfTWU8f3N5elGga2x1HdMtFs+Rt2e8yACwh1H
         +iUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kSe97Tx8ctZCEn1X6J3jTXp+4FQKjeXptEPACGdKsu4=;
        b=NvVsnD3sB1Gl5DnCgDrRxwzmEwvChwIBe37Xb2/YSexUGfZ0aoirxV2vnnRbhBrsmu
         oFIFYsF1esUjSqBuyMC1J2pxNFgriH6QrHPdCeJfYTmXYR3qr4AxDUGH2gqggsVgooQI
         OTGFuRFQH5o6ZPN1701/hHMyyCRsLecLL8o2Zy6oE+dMseU0Dvzy1hB5ywwlbvuYrkps
         O1yxi+OfjPEQxQW/+AdEXgxHHFb2t0+LaBDI8tsPVRlSnIGbBXOygs+MFtiaqGYZvE/c
         Us0D6jyZo4kH4zBWUCEXu/WVr7g8lxE7ZPOeDaQprqnDwDuiKjOG17M24TSIcLtyucCn
         bh2w==
X-Gm-Message-State: AJIora9QLGOZR/JY4GwCMF+F8MFYzp7zb6wvnL1OuPrfuEfe/+020QFA
        e/rH8j0KFJZHWU6REmIx1yLOuA==
X-Google-Smtp-Source: AGRyM1svbozEeNZXu0H7s4TemfoTbDBbW/i8GL2DnVrh9Dqh48UuMfLqkyU6b9gNMerxnzQoh3m1FA==
X-Received: by 2002:a17:90a:5508:b0:1f2:bedd:980e with SMTP id b8-20020a17090a550800b001f2bedd980emr2882794pji.178.1658738422352;
        Mon, 25 Jul 2022 01:40:22 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.40.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:40:22 -0700 (PDT)
From:   Albert Huang <huangjie.albert@bytedance.com>
Cc:     "huangjie.albert" <huangjie.albert@bytedance.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 3/4] x86: Support the uncompressed kernel to speed up booting
Date:   Mon, 25 Jul 2022 16:38:55 +0800
Message-Id: <20220725083904.56552-4-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "huangjie.albert" <huangjie.albert@bytedance.com>

Although the compressed kernel can save the time of loading the
kernel into the memory and save the disk space for storing the kernel,
but in some time-sensitive scenarios, the time for decompressing the
kernel is intolerable. Therefore, it is necessary to support uncompressed
kernel images, so that the time of kernel decompression can be saved when
the kernel is started.

This part of the time on my machine is approximately:
image type      image  size      times
compressed(gzip) 8.5M            159ms
uncompressed     53M             8.5ms

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/boot/compressed/Makefile |  5 ++++-
 arch/x86/boot/compressed/misc.c   | 13 +++++++++++++
 scripts/Makefile.lib              |  5 +++++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index adbd3a2bd60f..231187624c68 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -221,6 +221,7 @@ config X86
 	select HAVE_KERNEL_LZO
 	select HAVE_KERNEL_XZ
 	select HAVE_KERNEL_ZSTD
+	select HAVE_KERNEL_UNCOMPRESSED
 	select HAVE_KPROBES
 	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 19e1905dcbf6..0c8417a2f792 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -26,7 +26,7 @@ OBJECT_FILES_NON_STANDARD	:= y
 KCOV_INSTRUMENT		:= n
 
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
-	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
+	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst vmlinux.bin.none
 
 # CLANG_FLAGS must come before any cc-disable-warning or cc-option calls in
 # case of cross compiling, as it has the '--target=' flag, which is needed to
@@ -139,6 +139,8 @@ $(obj)/vmlinux.bin.lz4: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,lz4_with_size)
 $(obj)/vmlinux.bin.zst: $(vmlinux.bin.all-y) FORCE
 	$(call if_changed,zstd22_with_size)
+$(obj)/vmlinux.bin.none: $(vmlinux.bin.all-y) FORCE
+	$(call if_changed,none)
 
 suffix-$(CONFIG_KERNEL_GZIP)	:= gz
 suffix-$(CONFIG_KERNEL_BZIP2)	:= bz2
@@ -147,6 +149,7 @@ suffix-$(CONFIG_KERNEL_XZ)	:= xz
 suffix-$(CONFIG_KERNEL_LZO) 	:= lzo
 suffix-$(CONFIG_KERNEL_LZ4) 	:= lz4
 suffix-$(CONFIG_KERNEL_ZSTD)	:= zst
+suffix-$(CONFIG_KERNEL_UNCOMPRESSED)	:= none
 
 quiet_cmd_mkpiggy = MKPIGGY $@
       cmd_mkpiggy = $(obj)/mkpiggy $< > $@
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index cf690d8712f4..c23c0f525d93 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -181,6 +181,19 @@ void __puthex(unsigned long value)
 	}
 }
 
+#ifdef CONFIG_KERNEL_UNCOMPRESSED
+#include <linux/decompress/mm.h>
+static int __decompress(unsigned char *buf, long len,
+				long (*fill)(void*, unsigned long),
+				long (*flush)(void*, unsigned long),
+				unsigned char *outbuf, long olen,
+				long *pos, void (*error)(char *x))
+{
+	memcpy(outbuf, buf, olen);
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_X86_NEED_RELOCS
 static void handle_relocations(void *output, unsigned long output_len,
 			       unsigned long virt_addr)
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 3fb6a99e78c4..c89d5466c617 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -438,6 +438,11 @@ quiet_cmd_lz4 = LZ4     $@
 quiet_cmd_lz4_with_size = LZ4     $@
       cmd_lz4_with_size = { cat $(real-prereqs) | $(LZ4) -l -c1 stdin stdout; \
                   $(size_append); } > $@
+# none
+quiet_cmd_none = NONE     $@
+      cmd_none = (cat $(filter-out FORCE,$^) && \
+      $(call size_append, $(filter-out FORCE,$^))) > $@ || \
+      (rm -f $@ ; false)
 
 # U-Boot mkimage
 # ---------------------------------------------------------------------------
-- 
2.31.1

