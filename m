Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0D925696BD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiGGAJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGGAJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:09:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EC41BEBD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C064B81EFB
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B23DC3411C;
        Thu,  7 Jul 2022 00:09:10 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JLm4OCoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657152548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OAVoRv2MVcDg2zTYQIQOw3ylC2VeCsqBTVsInz/w+fA=;
        b=JLm4OCoSkpb82yVYch6n8PTgbLYaR2DZ3nsIj7WSrGbphF26ydy6HBK4kUtClK2VAUXXMB
        nZc9q3hoWRG0DNtpLwZH46zIM3Hxfnzg66t/+rMYPCAMglzK5c7HDeC+XAutE3hBtCXVuZ
        83BLd3AYvt/j0pxQA6HBGVgxxgg4Dj8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da5e5849 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 7 Jul 2022 00:09:08 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v7] x86/setup: Use rng seeds from setup_data
Date:   Thu,  7 Jul 2022 02:08:52 +0200
Message-Id: <20220707000852.523788-1-Jason@zx2c4.com>
In-Reply-To: <20220703004431.268931-1-Jason@zx2c4.com>
References: <20220703004431.268931-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the only way x86 can get an early boot RNG seed is via EFI,
which is generally always used now for physical machines, but is very
rarely used in VMs, especially VMs that are optimized for starting
"instantaneously", such as Firecracker's MicroVM. For tiny fast booting
VMs, EFI is not something you generally need or want.

Rather, here we want the ability for the image loader or firmware to
pass a single random seed, exactly as device tree platforms do with the
"rng-seed" property. Additionally, this is something that bootloaders
can append, with their own seed file management, which is something
every other major OS ecosystem has that we do not (yet).

This patch adds SETUP_RNG_SEED, similar to the other seven setup_data
entries that are parsed at boot. It also takes care to zero out the seed
immediately after using, in order to retain forward secrecy. This all
takes about 7 trivial lines of code.

Then, on kexec_file_load(), a new fresh seed is generated and passed to
the next kernel, just as is done on device tree architectures when
using kexec. And, importantly, I've tested that QEMU is able to properly
pass SETUP_RNG_SEED as well, making this work for every step of the way.
This code too is pretty straight forward.

Together these measures ensure that VMs and nested kexec()'d kernels
always receive a proper boot time RNG seed at the earliest possible
stage from their parents:

   - Host [already has strongly initialized RNG]
     - QEMU [passes fresh seed in SETUP_RNG_SEED field]
       - Linux [uses parent's seed and gathers entropy of its own]
         - kexec [passes this in SETUP_RNG_SEED field]
           - Linux [uses parent's seed and gathers entropy of its own]
             - kexec [passes this in SETUP_RNG_SEED field]
               - Linux [uses parent's seed and gathers entropy of its own]
                 - kexec [passes this in SETUP_RNG_SEED field]
		   - ...

I've verified in several scenarios that this works quite well from a
host kernel to QEMU and down inwards, mixing and matching loaders, with
every layer providing a seed to the next.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v6->v7:
- [amluto] Add comment about zeroing fields - data for forward secrecy, len in
  case of accidental reset-to-entry-jump bug.
Changes v5->v6:
- [hpa] Rework commit message to be less confusing and not improperly
  mention e820.
Changes v4->v5:
- Populate field when loading bzimages for kexec, just like device tree
  platforms do.
Changes v3->v4:
- Zero out data after using, for forward secrecy.
Changes v2->v3:
- Actually memmap the right area with the random bytes in it. This
  worked before because of page sizes, but the code wasn't right. Now
  it's right.
Changes v1->v2:
- Fix small typo of data_len -> data->len.

 arch/x86/include/uapi/asm/bootparam.h |  1 +
 arch/x86/kernel/kexec-bzimage64.c     | 36 ++++++++++++++++++++++++---
 arch/x86/kernel/setup.c               | 10 ++++++++
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index bea5cdcdf532..a60676b8d1d4 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -11,6 +11,7 @@
 #define SETUP_APPLE_PROPERTIES		5
 #define SETUP_JAILHOUSE			6
 #define SETUP_CC_BLOB			7
+#define SETUP_RNG_SEED			8
 
 #define SETUP_INDIRECT			(1<<31)
 
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..13b2c55ebbf0 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/verification.h>
+#include <linux/random.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -110,6 +111,27 @@ static int setup_e820_entries(struct boot_params *params)
 	return 0;
 }
 
+enum { RNG_SEED_LENGTH = 32 };
+
+static void
+add_rng_seed_setup_data(struct boot_params *params,
+			unsigned long params_load_addr,
+			unsigned int rng_seed_setup_data_offset)
+{
+	struct setup_data *sd = (void *)params + rng_seed_setup_data_offset;
+	unsigned long setup_data_phys;
+
+	if (!rng_is_initialized())
+		return;
+
+	sd->type = SETUP_RNG_SEED;
+	sd->len = RNG_SEED_LENGTH;
+	get_random_bytes(sd->data, RNG_SEED_LENGTH);
+	setup_data_phys = params_load_addr + rng_seed_setup_data_offset;
+	sd->next = params->hdr.setup_data;
+	params->hdr.setup_data = setup_data_phys;
+}
+
 #ifdef CONFIG_EFI
 static int setup_efi_info_memmap(struct boot_params *params,
 				  unsigned long params_load_addr,
@@ -190,7 +212,8 @@ static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
 		      unsigned int efi_map_offset, unsigned int efi_map_sz,
-		      unsigned int efi_setup_data_offset)
+		      unsigned int efi_setup_data_offset,
+		      unsigned int rng_seed_setup_data_offset)
 {
 	unsigned int nr_e820_entries;
 	unsigned long long mem_k, start, end;
@@ -242,6 +265,8 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		}
 	}
 
+	add_rng_seed_setup_data(params, params_load_addr,
+				rng_seed_setup_data_offset);
 #ifdef CONFIG_EFI
 	/* Setup EFI state */
 	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
@@ -337,6 +362,7 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
 	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
+	unsigned int rng_seed_setup_data_offset;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
@@ -401,13 +427,16 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
 	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
-				sizeof(struct efi_setup_data);
+				sizeof(struct efi_setup_data) +
+				sizeof(struct setup_data) +
+				RNG_SEED_LENGTH;
 
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
 	efi_map_offset = params_cmdline_sz;
 	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
+	rng_seed_setup_data_offset = efi_setup_data_offset + sizeof(struct efi_setup_data);
 
 	/* Copy setup header onto bootparams. Documentation/x86/boot.rst */
 	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
@@ -490,7 +519,8 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
 				    efi_map_offset, efi_map_sz,
-				    efi_setup_data_offset);
+				    efi_setup_data_offset,
+				    rng_seed_setup_data_offset);
 	if (ret)
 		goto out_free_params;
 
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index bd6c6fd373ae..409de5308a8c 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -23,6 +23,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/random.h>
 
 #include <uapi/linux/mount.h>
 
@@ -355,6 +356,15 @@ static void __init parse_setup_data(void)
 		case SETUP_EFI:
 			parse_efi_setup(pa_data, data_len);
 			break;
+		case SETUP_RNG_SEED:
+			data = early_memremap(pa_data, data_len);
+			add_bootloader_randomness(data->data, data->len);
+			/* Zero seed for forward secrecy. */
+			memzero_explicit(data->data, data->len);
+			/* Zero length in case we find ourselves back here by accident. */
+			memzero_explicit(&data->len, sizeof(data->len));
+			early_memunmap(data, data_len);
+			break;
 		default:
 			break;
 		}
-- 
2.35.1

