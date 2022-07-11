Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F372656FEE0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiGKK2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbiGKK2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 06:28:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3B6CFB5B;
        Mon, 11 Jul 2022 02:39:56 -0700 (PDT)
Date:   Mon, 11 Jul 2022 09:39:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657532395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4PtrRyRTEyIFKiEoWBWTZrQsyD29BiNa7vn2sBQ1GM=;
        b=d/In4R1Wo5CNCZyHbWz2/cBO+G1b6RWRroi9zyj/rR2gqMhxJButj8lUJgt8qCQE52rhIh
        mUArZ0Yy/i3DXODW4J/ARxucWdTzOdijBZRRREUsKC4F6GTNN+LIZJFXl/fIVV3zLjpj5q
        ovhJo6FaFnNkMyxcHoDZhlwp3nvABJkmdWtsY+ywEDh4gZo+J/5yVLH4pPaMY6TxIRNuHl
        YJxVPQ8uWcnEfA0j1SGXE8qPwdotvdHi6SADQkViYkbW9kzBESCUCUaRhFHiZaYszoC5AP
        x9/ckRDPUWOLXwDUTrwO86BxWkbfdPQMxFAhMuV2j356dnyd1vzJ+p/W734qwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657532395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S4PtrRyRTEyIFKiEoWBWTZrQsyD29BiNa7vn2sBQ1GM=;
        b=IdozVlifRWu7Vaxm+GCyJDvjxbTKo0sgSWzjZvrBjAlZltsE9Brg932tTNovsDchs6dShJ
        ogJy/6ft8xACFUAA==
From:   "tip-bot2 for Jason A. Donenfeld" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/kdump] x86/setup: Use rng seeds from setup_data
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Borislav Petkov <bp@suse.de>,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220630113300.1892799-1-Jason@zx2c4.com>
References: <20220630113300.1892799-1-Jason@zx2c4.com>
MIME-Version: 1.0
Message-ID: <165753239385.15455.13768399417352293953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/kdump branch of tip:

Commit-ID:     68b8e9713c8ec90af93c16e1de51cca18cefdb56
Gitweb:        https://git.kernel.org/tip/68b8e9713c8ec90af93c16e1de51cca18cefdb56
Author:        Jason A. Donenfeld <Jason@zx2c4.com>
AuthorDate:    Sun, 10 Jul 2022 19:29:21 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jul 2022 09:59:31 +02:00

x86/setup: Use rng seeds from setup_data

Currently, the only way x86 can get an early boot RNG seed is via EFI,
which is generally always used now for physical machines, but is very
rarely used in VMs, especially VMs that are optimized for starting
"instantaneously", such as Firecracker's MicroVM. For tiny fast booting
VMs, EFI is not something you generally need or want.

Rather, the image loader or firmware should be able to pass a single
random seed, exactly as device tree platforms do with the "rng-seed"
property. Additionally, this is something that bootloaders can append,
with their own seed file management, which is something every other
major OS ecosystem has that Linux does not (yet).

Add SETUP_RNG_SEED, similar to the other eight setup_data entries that
are parsed at boot. It also takes care to zero out the seed immediately
after using, in order to retain forward secrecy. This all takes about 7
trivial lines of code.

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

  [ bp: Massage commit message. ]

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Link: https://lore.kernel.org/r/20220630113300.1892799-1-Jason@zx2c4.com
---
 arch/x86/include/uapi/asm/bootparam.h |  6 ++--
 arch/x86/kernel/kexec-bzimage64.c     | 38 +++++++++++++++++++++++---
 arch/x86/kernel/setup.c               | 10 +++++++-
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index be2b9ce..3422906 100644
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
-#define SETUP_TYPE_MAX			(SETUP_INDIRECT | SETUP_CC_BLOB)
+#define SETUP_TYPE_MAX			(SETUP_ENUM_MAX | SETUP_INDIRECT)
 
 /* ram_size flags */
 #define RAMDISK_IMAGE_START_MASK	0x07FF
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index c63974e..b9bdb40 100644
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
@@ -277,9 +298,16 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
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
@@ -435,7 +463,9 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
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
index 53f863f..216fee7 100644
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
