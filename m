Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAD84F91C0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbiDHJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiDHJLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:11:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24941DFDF4;
        Fri,  8 Apr 2022 02:09:04 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLE/rRva5DLP+aDrv6WhBZoi8F8gBarO4PJbL/K1o3Q=;
        b=BKAWdoNb3kcpVQv6sUQ+qD4KCd+CQMq2pj/3sU0D6l/GyH6cNKA+Mc8Ti68WTdw3ArH+a3
        QkDRlSxEU2qubyf+ddgKgUezcnNn8V+kGx66j4A8omG4oh9gYAsmRFpcLJxYKQqccEKIsY
        jG2dTJs07O2tEMXoQW2vLjg+9TkQyZjiEBm9rMtAttT5iIdvsWhoARD3tlLMSGNoTY1oWF
        /eO3Dr40es8suyWvK8eQ8eVIRvoKnbuNwwQ3C/czaUH2E3RWCJwvgVxeMy6CyoalpKfTqY
        6iHiT8NBX7EHF/6wfNOP6d3gSrmEFuKBMbPq1/vflun37Pm5+YI0pkV4lgcI9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408943;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SLE/rRva5DLP+aDrv6WhBZoi8F8gBarO4PJbL/K1o3Q=;
        b=47S25CrqMHfAre8OEYUrWYG2pHfsggadyQyeAW9hz1qB6Hef9ITxjs7f6KMeHeGgZRO3st
        PbQwFdhZmntE3YBw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/kernel: Validate ROM memory before accessing when
 SEV-SNP is active
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-21-brijesh.singh@amd.com>
References: <20220307213356.2797205-21-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894216.389.2848602772534996789.tip-bot2@tip-bot2>
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

Commit-ID:     9704c07bf9f7682a83aec4e66f2d9154dbd8577f
Gitweb:        https://git.kernel.org/tip/9704c07bf9f7682a83aec4e66f2d9154dbd8577f
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:14 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:23:09 +02:00

x86/kernel: Validate ROM memory before accessing when SEV-SNP is active

probe_roms() accesses the memory range (0xc0000 - 0x10000) to probe
various ROMs. The memory range is not part of the E820 system RAM range.
The memory range is mapped as private (i.e encrypted) in the page table.

When SEV-SNP is active, all the private memory must be validated before
accessing. The ROM range was not part of E820 map, so the guest BIOS
did not validate it. An access to invalidated memory will cause a
exception yet, so validate the ROM memory regions before it is accessed.

  [ bp: Massage commit message. ]

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-21-brijesh.singh@amd.com
---
 arch/x86/kernel/probe_roms.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
index 36e84d9..319fef3 100644
--- a/arch/x86/kernel/probe_roms.c
+++ b/arch/x86/kernel/probe_roms.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <asm/io.h>
 #include <asm/setup_arch.h>
+#include <asm/sev.h>
 
 static struct resource system_rom_resource = {
 	.name	= "System ROM",
@@ -197,11 +198,21 @@ static int __init romchecksum(const unsigned char *rom, unsigned long length)
 
 void __init probe_roms(void)
 {
-	const unsigned char *rom;
 	unsigned long start, length, upper;
+	const unsigned char *rom;
 	unsigned char c;
 	int i;
 
+	/*
+	 * The ROM memory range is not part of the e820 table and is therefore not
+	 * pre-validated by BIOS. The kernel page table maps the ROM region as encrypted
+	 * memory, and SNP requires encrypted memory to be validated before access.
+	 * Do that here.
+	 */
+	snp_prep_memory(video_rom_resource.start,
+			((system_rom_resource.end + 1) - video_rom_resource.start),
+			SNP_PAGE_STATE_PRIVATE);
+
 	/* video rom */
 	upper = adapter_rom_resources[0].start;
 	for (start = video_rom_resource.start; start < upper; start += 2048) {
