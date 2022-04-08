Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E214F919A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiDHJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiDHJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DF412B5E6;
        Fri,  8 Apr 2022 02:08:52 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRml3TeLzoiycl5104yyMIXM5zcwjJFFUb3+lz2Ojdw=;
        b=SYV1orL4Gto1oFgAkmNewxqAvF5y2qLMsy2VdK1fCUXF8z7GVUXvXREfkk4hXI8aB9CTJv
        3b1PIULAyp9OKTjRFK2l+rP1V88u8XMX2FfKgaUe4QBDqFBn4qD137X+VqkLOpWJy6lRbR
        74E8f9qrbWa1spgqR9A2YyiSZmowbBdaQie2fSmtougrPhG0jcM5Bzl3TyelklXpfr7ld1
        6xDgy4/836eU4IPdwBQ1HDhse/fY66k5MD8ZdMQvmSAI7w4Vr0uMZSQ44MSm5h96Nzlq8O
        ay2qlmcvXTEZl5f715bMYRYWJLBraCnoip7SYc+5XtrpOrdMU3nG1Qo18zWlkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408931;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRml3TeLzoiycl5104yyMIXM5zcwjJFFUb3+lz2Ojdw=;
        b=YscWfSLCgQzdog9x7uWfUAEknYoFiasypGKSO/aeM1sN+ABo2YZvBhawFI2NMWhRdqXvll
        /vxmthqRDib76EAA==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/boot: Add a pointer to Confidential Computing blob
 in bootparams
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-34-brijesh.singh@amd.com>
References: <20220307213356.2797205-34-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892993.389.10760651078197277694.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     8c9c509baf660f1062bc758c26008b7f9bbc39f3
Gitweb:        https://git.kernel.org/tip/8c9c509baf660f1062bc758c26008b7f9bbc39f3
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:13 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/boot: Add a pointer to Confidential Computing blob in bootparams

The previously defined Confidential Computing blob is provided to the
kernel via a setup_data structure or EFI config table entry. Currently,
these are both checked for by boot/compressed kernel to access the CPUID
table address within it for use with SEV-SNP CPUID enforcement.

To also enable that enforcement for the run-time kernel, similar
access to the CPUID table is needed early on while it's still using
the identity-mapped page table set up by boot/compressed, where global
pointers need to be accessed via fixup_pointer().

This isn't much of an issue for accessing setup_data, and the EFI config
table helper code currently used in boot/compressed *could* be used in
this case as well since they both rely on identity-mapping. However, it
has some reliance on EFI helpers/string constants that would need to be
accessed via fixup_pointer(), and fixing it up while making it shareable
between boot/compressed and run-time kernel is fragile and introduces a
good bit of ugliness.

Instead, add a boot_params->cc_blob_address pointer that the
boot/compressed kernel can initialize so that the run-time kernel can
access the CC blob from there instead of re-scanning the EFI config
table.

Also document these in Documentation/x86/zero-page.rst. While there,
add missing documentation for the acpi_rsdp_addr field, which serves a
similar purpose in providing the run-time kernel a pointer to the ACPI
RSDP table so that it does not need to [re-]scan the EFI configuration
table.

  [ bp: Fix typos, massage commit message. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-34-brijesh.singh@amd.com
---
 Documentation/x86/zero-page.rst        | 2 ++
 arch/x86/include/asm/bootparam_utils.h | 1 +
 arch/x86/include/uapi/asm/bootparam.h  | 3 ++-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/x86/zero-page.rst b/Documentation/x86/zero-page.rst
index f088f58..45aa9cc 100644
--- a/Documentation/x86/zero-page.rst
+++ b/Documentation/x86/zero-page.rst
@@ -19,6 +19,7 @@ Offset/Size	Proto	Name			Meaning
 058/008		ALL	tboot_addr      	Physical address of tboot shared page
 060/010		ALL	ist_info		Intel SpeedStep (IST) BIOS support information
 						(struct ist_info)
+070/008		ALL	acpi_rsdp_addr		Physical address of ACPI RSDP table
 080/010		ALL	hd0_info		hd0 disk parameter, OBSOLETE!!
 090/010		ALL	hd1_info		hd1 disk parameter, OBSOLETE!!
 0A0/010		ALL	sys_desc_table		System description table (struct sys_desc_table),
@@ -27,6 +28,7 @@ Offset/Size	Proto	Name			Meaning
 0C0/004		ALL	ext_ramdisk_image	ramdisk_image high 32bits
 0C4/004		ALL	ext_ramdisk_size	ramdisk_size high 32bits
 0C8/004		ALL	ext_cmd_line_ptr	cmd_line_ptr high 32bits
+13C/004		ALL	cc_blob_address		Physical address of Confidential Computing blob
 140/080		ALL	edid_info		Video mode setup (struct edid_info)
 1C0/020		ALL	efi_info		EFI 32 information (struct efi_info)
 1E0/004		ALL	alt_mem_k		Alternative mem check, in KB
diff --git a/arch/x86/include/asm/bootparam_utils.h b/arch/x86/include/asm/bootparam_utils.h
index 981fe92..53e9b06 100644
--- a/arch/x86/include/asm/bootparam_utils.h
+++ b/arch/x86/include/asm/bootparam_utils.h
@@ -74,6 +74,7 @@ static void sanitize_boot_params(struct boot_params *boot_params)
 			BOOT_PARAM_PRESERVE(hdr),
 			BOOT_PARAM_PRESERVE(e820_table),
 			BOOT_PARAM_PRESERVE(eddbuf),
+			BOOT_PARAM_PRESERVE(cc_blob_address),
 		};
 
 		memset(&scratch, 0, sizeof(scratch));
diff --git a/arch/x86/include/uapi/asm/bootparam.h b/arch/x86/include/uapi/asm/bootparam.h
index 1ac5acc..bea5cdc 100644
--- a/arch/x86/include/uapi/asm/bootparam.h
+++ b/arch/x86/include/uapi/asm/bootparam.h
@@ -188,7 +188,8 @@ struct boot_params {
 	__u32 ext_ramdisk_image;			/* 0x0c0 */
 	__u32 ext_ramdisk_size;				/* 0x0c4 */
 	__u32 ext_cmd_line_ptr;				/* 0x0c8 */
-	__u8  _pad4[116];				/* 0x0cc */
+	__u8  _pad4[112];				/* 0x0cc */
+	__u32 cc_blob_address;				/* 0x13c */
 	struct edid_info edid_info;			/* 0x140 */
 	struct efi_info efi_info;			/* 0x1c0 */
 	__u32 alt_mem_k;				/* 0x1e0 */
