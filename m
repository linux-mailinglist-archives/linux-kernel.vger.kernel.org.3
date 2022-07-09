Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9E856C887
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiGIJt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiGIJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:49:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720E1709B9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:49:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22DE9B819CB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:49:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F317CC3411C;
        Sat,  9 Jul 2022 09:49:13 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jUBvyCRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657360152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lsmG4b66Jq4hqJnp47K+8K6B821G8RmKCyl1OKP7vj8=;
        b=jUBvyCRB0J3dYceThWddunOnaZ9XwZqLhDC7Vg7lhXy6mpqhHvXtOA9B0NsKkLqi+ADpZp
        FVK/bVpOLRS+SClR8LMntgWI979bz0MeEoO4XcqpXKbNr+dnageRhEO51qYgRTGvCttVon
        wcuzui6wbQKsgFV+UoWMsjdjHf9Kv4I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id cb9795be (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 9 Jul 2022 09:49:11 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH tip v9] x86/setup: Use rng seeds from setup_data
Date:   Sat,  9 Jul 2022 11:48:53 +0200
Message-Id: <20220709094853.1090735-1-Jason@zx2c4.com>
In-Reply-To: <YslN1bo2jnnxl3E3@zx2c4.com>
References: <YslN1bo2jnnxl3E3@zx2c4.com>
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
Changes v8->v9:
- [hpa] Update SETUP_TYPE_MAX and add SETUP_ENUM_MAX.
Changes v7->v8:
- Rebase against tip.
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


 arch/x86/include/uapi/asm/bootparam.h |  6 ++--
 arch/x86/kernel/kexec-bzimage64.c     | 40 +++++++++++++++++++++++----
 arch/x86/kernel/setup.c               | 10 +++++++
 3 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index ca0796ac4403..342290624040 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -12,11 +12,11 @@
 #define SETUP_JAILHOUSE			6
 #define SETUP_CC_BLOB			7
 #define SETUP_IMA			8
+#define SETUP_RNG_SEED			9
+#define SETUP_ENUM_MAX			SETUP_RNG_SEED
 
 #define SETUP_INDIRECT			(1<<31)
-
-/* SETUP_INDIRECT | max(SETUP_*) */
-#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_JAILHOUSE)
+#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c63974e94272..e39d8932249d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -18,6 +18,7 @@
 #include <linux/mm.h>
 #include <linux/efi.h>
 #include <linux/verification.h>
+#include <linux/random.h>
 
 #include <asm/bootparam.h>
 #include <asm/setup.h>
@@ -110,6 +111,26 @@ static int setup_e820_entries(struct boot_params *params)
 	return 0;
 }
 
+enum { RNG_SEED_LENGTH = 32 };
+
+static void
+setup_rng_seed(struct boot_params *params, unsigned long params_load_addr,
+	       unsigned int rng_seed_setup_data_offset)
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
@@ -191,7 +212,6 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 		unsigned long params_load_addr,
 		unsigned int ima_setup_data_offset)
 {
-#ifdef CONFIG_IMA_KEXEC
 	struct setup_data *sd = (void *)params + ima_setup_data_offset;
 	unsigned long setup_data_phys;
 	struct ima_setup_data *ima;
@@ -210,7 +230,6 @@ setup_ima_state(const struct kimage *image, struct boot_params *params,
 	setup_data_phys = params_load_addr + ima_setup_data_offset;
 	sd->next = params->hdr.setup_data;
 	params->hdr.setup_data = setup_data_phys;
-#endif /* CONFIG_IMA_KEXEC */
 }
 
 static int
@@ -277,9 +296,16 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
 			sizeof(struct efi_setup_data);
 #endif
 
-	/* Setup IMA log buffer state */
-	setup_ima_state(image, params, params_load_addr,
-			setup_data_offset);
+	if (IS_ENABLED(CONFIG_IMA_KEXEC)) {
+		/* Setup IMA log buffer state */
+		setup_ima_state(image, params, params_load_addr,
+				setup_data_offset);
+		setup_data_offset += sizeof(struct setup_data) +
+				     sizeof(struct ima_setup_data);
+	}
+
+	/* Setup RNG seed */
+	setup_rng_seed(params, params_load_addr, setup_data_offset);
 
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
@@ -435,7 +461,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
 	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
 				sizeof(struct setup_data) +
-				sizeof(struct efi_setup_data);
+				sizeof(struct efi_setup_data) +
+				sizeof(struct setup_data) +
+				RNG_SEED_LENGTH;
 
 	if (IS_ENABLED(CONFIG_IMA_KEXEC))
 		kbuf.bufsz += sizeof(struct setup_data) +
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 53f863f28b4c..216fee7144ee 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -24,6 +24,7 @@
 #include <linux/usb/xhci-dbgp.h>
 #include <linux/static_call.h>
 #include <linux/swiotlb.h>
+#include <linux/random.h>
 
 #include <uapi/linux/mount.h>
 
@@ -418,6 +419,15 @@ static void __init parse_setup_data(void)
 		case SETUP_IMA:
 			add_early_ima_buffer(pa_data);
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

