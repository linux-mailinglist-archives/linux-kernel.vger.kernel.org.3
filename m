Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92C57FB7E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbiGYIjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234087AbiGYIjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:39:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6F314090
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:39:46 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y24so9768273plh.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 01:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l2mUZlhHXaJYVViscPjc1ubjCnfx3TCozkJkbzk0hd8=;
        b=0L3lA508COfe7MYrJ4i5QeT8+Aln6nIuQKE4RjJ1Lx3z6h7Hy9kUjWZ0Dtq1oiyrfw
         PTns7AvxZBE1CNzq4WUT071rCS1NHGXXCF7WZaZEf938VsriD1eqv04CegdB7dT6uLgC
         n45h8c6GSP1avg2epBxw/331XhByphoSroy9C5tUw1F2RKtd/suhkKBROlBS9PyCn5kx
         MBEHexqpPKHlAMcBgOVZMIZfQFopzw0/3/4nQRyWQSx9kLldSLNLCkSrOIeR7ZttkNOy
         69niKl5UAS4TQhyHuFiRJXva4MR5Ab7tJcW2fxkEqXfrHoriDinHkKfs98Tc4K0u3mat
         MMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l2mUZlhHXaJYVViscPjc1ubjCnfx3TCozkJkbzk0hd8=;
        b=WiTFOonwduoqsrpe4WMQQHLk4xrjZBGLtCngWwSEy7H8Za6LzV1Mg4r4oTqKmBwEKz
         LqIIgPyzOq3CGuIeo86Lt7Pk64AqNmEKW7R2XZxRx//oJ6coaY5HOQ/m1zjojkJA1+2N
         Lfea6GGDQRX+9MMfqO2ZJNkv4poz67tA/vSmaNYQL44SUaOBqeCQ80JaKkVcca/W2rix
         UeTDIDEudiw0pHrNG+7o5wIC35ydNM2Pr/eoC0krZ+VH6/NMCaCccRgz/mcfGw1vO9zm
         xWilU7WX3YXPrSfX0BxLa5rsOjeOuqqUv5rWxyfz0zt5+NsQ9mizA0Rjlp5gYBu7jqqd
         +WvQ==
X-Gm-Message-State: AJIora8/0/mb5MKBQVffcects4GMwKHBEiBmGEz5LtQPhnBhgz9X0uSR
        bEvZrd16t5x//fW0HCGdhNil9Q==
X-Google-Smtp-Source: AGRyM1siiSysQPlgusyaQKwzG5LJXqkZAwzcxclETgd4W9LqD/TVNYUmNWTVv5wHUkaSyZ+EVYdOQQ==
X-Received: by 2002:a17:90b:4d92:b0:1f0:47e4:f36 with SMTP id oj18-20020a17090b4d9200b001f047e40f36mr13052394pjb.194.1658738385695;
        Mon, 25 Jul 2022 01:39:45 -0700 (PDT)
Received: from C02FG34NMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id 128-20020a621886000000b0052abc2438f1sm8893479pfy.55.2022.07.25.01.39.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 01:39:45 -0700 (PDT)
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
        Michael Roth <michael.roth@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 1/4] kexec: reuse crash kernel reserved memory for normal kexec
Date:   Mon, 25 Jul 2022 16:38:53 +0800
Message-Id: <20220725083904.56552-2-huangjie.albert@bytedance.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20220725083904.56552-1-huangjie.albert@bytedance.com>
References: <20220725083904.56552-1-huangjie.albert@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

normally, for kexec reboot, each segment of the second os
(such as : kernel、initrd、etc.) will be copied to discontinuous
physical memory during kexec load.  and then a memory copy will
be performed when kexec -e is executed to copy each segment of
the second os to contiguous physical memory, which will Affects
the time the kexec switch to the  new os. Therefore, if we reuse
the crash kernel reserved memory for kexec. When kexec loads the
second os, each segment of the second OS is directly copied to the
contiguous physical memory, so there is no need to make a second copy
when kexec -e is executed later.

The kexec userspace tool also needs to add parameter options(-r) that
support the use of reserved memory (see another patch for kexec)

examples:
bzimage: 53M initramfs: 28M
can save aboat 40 ms, The larger the image size, the greater the time
savings

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 include/linux/kexec.h      |  9 +++++----
 include/uapi/linux/kexec.h |  2 ++
 kernel/kexec.c             | 19 ++++++++++++++++++-
 kernel/kexec_core.c        | 16 +++++++++-------
 kernel/kexec_file.c        | 20 ++++++++++++++++++--
 5 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 475683cd67f1..9a8b9932b42a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -305,9 +305,10 @@ struct kimage {
 	unsigned long control_page;
 
 	/* Flags to indicate special processing */
-	unsigned int type : 1;
+	unsigned int type : 2;
 #define KEXEC_TYPE_DEFAULT 0
 #define KEXEC_TYPE_CRASH   1
+#define KEXEC_TYPE_RESERVED_MEM 2
 	unsigned int preserve_context : 1;
 	/* If set, we are using file mode kexec syscall */
 	unsigned int file_mode:1;
@@ -377,14 +378,14 @@ extern int kexec_load_disabled;
 
 /* List of defined/legal kexec flags */
 #ifndef CONFIG_KEXEC_JUMP
-#define KEXEC_FLAGS    KEXEC_ON_CRASH
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_RESERVED_MEM)
 #else
-#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT)
+#define KEXEC_FLAGS    (KEXEC_ON_CRASH | KEXEC_PRESERVE_CONTEXT | KEXEC_RESERVED_MEM)
 #endif
 
 /* List of defined/legal kexec file flags */
 #define KEXEC_FILE_FLAGS	(KEXEC_FILE_UNLOAD | KEXEC_FILE_ON_CRASH | \
-				 KEXEC_FILE_NO_INITRAMFS)
+				 KEXEC_FILE_NO_INITRAMFS | KEXEC_FILE_RESERVED_MEM)
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 981016e05cfa..c29011eb7fc2 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -12,6 +12,7 @@
 /* kexec flags for different usage scenarios */
 #define KEXEC_ON_CRASH		0x00000001
 #define KEXEC_PRESERVE_CONTEXT	0x00000002
+#define KEXEC_RESERVED_MEM	0x00000004
 #define KEXEC_ARCH_MASK		0xffff0000
 
 /*
@@ -24,6 +25,7 @@
 #define KEXEC_FILE_UNLOAD	0x00000001
 #define KEXEC_FILE_ON_CRASH	0x00000002
 #define KEXEC_FILE_NO_INITRAMFS	0x00000004
+#define KEXEC_FILE_RESERVED_MEM 0x00000008
 
 /* These values match the ELF architecture values.
  * Unless there is a good reason that should continue to be the case.
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..0d9ea52c81c1 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -27,8 +27,14 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_ON_CRASH;
+	bool kexec_on_reserved = flags & KEXEC_RESERVED_MEM;
 
-	if (kexec_on_panic) {
+	if (kexec_on_panic && kexec_on_reserved) {
+		pr_err("both kexec_on_panic and kexec_on_reserved is true, they can not coexist");
+		return -EINVAL;
+	}
+
+	if (kexec_on_panic || kexec_on_reserved) {
 		/* Verify we have a valid entry point */
 		if ((entry < phys_to_boot_phys(crashk_res.start)) ||
 		    (entry > phys_to_boot_phys(crashk_res.end)))
@@ -50,6 +56,12 @@ static int kimage_alloc_init(struct kimage **rimage, unsigned long entry,
 		image->type = KEXEC_TYPE_CRASH;
 	}
 
+	if (kexec_on_reserved) {
+		/* Enable special reserved kernel control page alloc policy. */
+		image->control_page = crashk_res.start;
+		image->type = KEXEC_TYPE_RESERVED_MEM;
+	}
+
 	ret = sanity_check_segment_list(image);
 	if (ret)
 		goto out_free_image;
@@ -110,6 +122,11 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
 		dest_image = &kexec_image;
 	}
 
+	if (flags & KEXEC_RESERVED_MEM) {
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+	}
+
 	if (nr_segments == 0) {
 		/* Uninstall image */
 		kimage_free(xchg(dest_image, NULL));
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 4d34c78334ce..6220c2e0d6f7 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -230,13 +230,13 @@ int sanity_check_segment_list(struct kimage *image)
 	 * Verify we have good destination addresses.  Normally
 	 * the caller is responsible for making certain we don't
 	 * attempt to load the new image into invalid or reserved
-	 * areas of RAM.  But crash kernels are preloaded into a
+	 * areas of RAM.  But crash kernels (or we specify to load
+	 * the new image into reserved areas) are preloaded into a
 	 * reserved area of ram.  We must ensure the addresses
 	 * are in the reserved area otherwise preloading the
 	 * kernel could corrupt things.
 	 */
-
-	if (image->type == KEXEC_TYPE_CRASH) {
+	if (image->type == KEXEC_TYPE_CRASH || image->type == KEXEC_TYPE_RESERVED_MEM) {
 		for (i = 0; i < nr_segments; i++) {
 			unsigned long mstart, mend;
 
@@ -414,7 +414,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 	return pages;
 }
 
-static struct page *kimage_alloc_crash_control_pages(struct kimage *image,
+static struct page *kimage_alloc_reserverd_control_pages(struct kimage *image,
 						      unsigned int order)
 {
 	/* Control pages are special, they are the intermediaries
@@ -491,7 +491,8 @@ struct page *kimage_alloc_control_pages(struct kimage *image,
 		pages = kimage_alloc_normal_control_pages(image, order);
 		break;
 	case KEXEC_TYPE_CRASH:
-		pages = kimage_alloc_crash_control_pages(image, order);
+	case KEXEC_TYPE_RESERVED_MEM:
+		pages = kimage_alloc_reserverd_control_pages(image, order);
 		break;
 	}
 
@@ -846,7 +847,7 @@ static int kimage_load_normal_segment(struct kimage *image,
 	return result;
 }
 
-static int kimage_load_crash_segment(struct kimage *image,
+static int kimage_load_reserved_segment(struct kimage *image,
 					struct kexec_segment *segment)
 {
 	/* For crash dumps kernels we simply copy the data from
@@ -924,7 +925,8 @@ int kimage_load_segment(struct kimage *image,
 		result = kimage_load_normal_segment(image, segment);
 		break;
 	case KEXEC_TYPE_CRASH:
-		result = kimage_load_crash_segment(image, segment);
+	case KEXEC_TYPE_RESERVED_MEM:
+		result = kimage_load_reserved_segment(image, segment);
 		break;
 	}
 
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9261c07b048..5242ad7e5302 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -277,7 +277,7 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 	int ret;
 	struct kimage *image;
 	bool kexec_on_panic = flags & KEXEC_FILE_ON_CRASH;
-
+	bool kexec_on_reserved = flags & KEXEC_FILE_RESERVED_MEM;
 	image = do_kimage_alloc_init();
 	if (!image)
 		return -ENOMEM;
@@ -290,6 +290,12 @@ kimage_file_alloc_init(struct kimage **rimage, int kernel_fd,
 		image->type = KEXEC_TYPE_CRASH;
 	}
 
+	if (kexec_on_reserved) {
+		/* Enable special crash kernel control page alloc policy. */
+		image->control_page = crashk_res.start;
+		image->type = KEXEC_TYPE_RESERVED_MEM;
+	}
+
 	ret = kimage_file_prepare_segments(image, kernel_fd, initrd_fd,
 					   cmdline_ptr, cmdline_len, flags);
 	if (ret)
@@ -346,6 +352,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!mutex_trylock(&kexec_mutex))
 		return -EBUSY;
 
+	if ((flags & KEXEC_FILE_ON_CRASH) && (flags & KEXEC_FILE_RESERVED_MEM)) {
+		pr_err("both kexec_on_panic and kexec_on_reserved is true, they can not coexist");
+		return -EINVAL;
+	}
+
 	dest_image = &kexec_image;
 	if (flags & KEXEC_FILE_ON_CRASH) {
 		dest_image = &kexec_crash_image;
@@ -353,6 +364,11 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 			arch_kexec_unprotect_crashkres();
 	}
 
+	if (flags & KEXEC_FILE_RESERVED_MEM) {
+		if (kexec_crash_image)
+			arch_kexec_unprotect_crashkres();
+	}
+
 	if (flags & KEXEC_FILE_UNLOAD)
 		goto exchange;
 
@@ -588,7 +604,7 @@ static int kexec_walk_memblock(struct kexec_buf *kbuf,
 static int kexec_walk_resources(struct kexec_buf *kbuf,
 				int (*func)(struct resource *, void *))
 {
-	if (kbuf->image->type == KEXEC_TYPE_CRASH)
+	if (kbuf->image->type == KEXEC_TYPE_CRASH || kbuf->image->type == KEXEC_TYPE_RESERVED_MEM)
 		return walk_iomem_res_desc(crashk_res.desc,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
-- 
2.31.1

