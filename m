Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD3034F919E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232856AbiDHJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbiDHJKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:10:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8A1105AB2;
        Fri,  8 Apr 2022 02:08:48 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:08:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U/ccW3FF8ZKDhxJFCCtgmZyDy1z41zs5XamkGvo/+c=;
        b=aRD52IvbVaGfuksOCN0SHHE7sx1qPpSLZfHaBF+zdhPHke+liPrDJa/22HZXgoWZwATYOx
        xuA6FoEhsm7M/vkzDVZQ3rx9h+se6HlM7RDj23rxmj+P8Clomqt111fHZNTLDjaYcUduDK
        gbICeQN5LFXZ6pgoDjcLQBBdNInmm/Yw2hLJD/su3NIvcjmrvPsJHK9hxdLFnUT/TtHXqL
        Nr6UskcoGCyLFegSL91GZyGRaXKZIxY6nOylUH2bDzqgQl0AqUZ4els14Rx+IAr43Jh7SV
        eBGCKOoc5kR3O86IzDUOAmcBje2DJY61xwuKyM747tzfbAQkuP9WmgZISDjG8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408926;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8U/ccW3FF8ZKDhxJFCCtgmZyDy1z41zs5XamkGvo/+c=;
        b=+jg6PjJruCkx4RrmXzHx2oEyxYguvv7drrC0yWahI807fgSnuS0R7qC261HPJ6aTNt52+L
        +fI0Ej+GFAd5/nBQ==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed/64: Add identity mapping for
 Confidential Computing blob
Cc:     Michael Roth <michael.roth@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-38-brijesh.singh@amd.com>
References: <20220307213356.2797205-38-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940892576.389.13362789887190299874.tip-bot2@tip-bot2>
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

Commit-ID:     76f61e1e89b32f3e5d639f1b57413a919066da06
Gitweb:        https://git.kernel.org/tip/76f61e1e89b32f3e5d639f1b57413a919066da06
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Thu, 24 Feb 2022 10:56:17 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 16:47:11 +02:00

x86/compressed/64: Add identity mapping for Confidential Computing blob

The run-time kernel will need to access the Confidential Computing blob
very early during boot to access the CPUID table it points to. At that
stage, it will be relying on the identity-mapped page table set up by
the boot/compressed kernel, so make sure the blob and the CPUID table it
points to are mapped in advance.

  [ bp: Massage. ]

Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-38-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/ident_map_64.c |  3 ++-
 arch/x86/boot/compressed/misc.h         |  2 ++
 arch/x86/boot/compressed/sev.c          | 21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 99348ee..44c350d 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -163,8 +163,9 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	sev_prep_identity_maps(top_level_pgt);
+
 	/* Load the new page-table. */
-	sev_verify_cbit(top_level_pgt);
 	write_cr3(top_level_pgt);
 }
 
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index aae2722..75d284e 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -127,6 +127,7 @@ void sev_es_shutdown_ghcb(void);
 extern bool sev_es_check_ghcb_fault(unsigned long address);
 void snp_set_page_private(unsigned long paddr);
 void snp_set_page_shared(unsigned long paddr);
+void sev_prep_identity_maps(unsigned long top_level_pgt);
 #else
 static inline void sev_enable(struct boot_params *bp) { }
 static inline void sev_es_shutdown_ghcb(void) { }
@@ -136,6 +137,7 @@ static inline bool sev_es_check_ghcb_fault(unsigned long address)
 }
 static inline void snp_set_page_private(unsigned long paddr) { }
 static inline void snp_set_page_shared(unsigned long paddr) { }
+static inline void sev_prep_identity_maps(unsigned long top_level_pgt) { }
 #endif
 
 /* acpi.c */
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index dd3cf55..1e4930c 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -478,3 +478,24 @@ bool snp_init(struct boot_params *bp)
 
 	return true;
 }
+
+void sev_prep_identity_maps(unsigned long top_level_pgt)
+{
+	/*
+	 * The Confidential Computing blob is used very early in uncompressed
+	 * kernel to find the in-memory CPUID table to handle CPUID
+	 * instructions. Make sure an identity-mapping exists so it can be
+	 * accessed after switchover.
+	 */
+	if (sev_snp_enabled()) {
+		unsigned long cc_info_pa = boot_params->cc_blob_address;
+		struct cc_blob_sev_info *cc_info;
+
+		kernel_add_identity_map(cc_info_pa, cc_info_pa + sizeof(*cc_info));
+
+		cc_info = (struct cc_blob_sev_info *)cc_info_pa;
+		kernel_add_identity_map(cc_info->cpuid_phys, cc_info->cpuid_phys + cc_info->cpuid_len);
+	}
+
+	sev_verify_cbit(top_level_pgt);
+}
