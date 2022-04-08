Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64354F91C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiDHJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiDHJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D43E1E8169;
        Fri,  8 Apr 2022 02:09:05 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahf9tUtt2LQHKxFpXkPU/YFIsm9O2TtkPVFU6dIgVNQ=;
        b=FqSsAFdoWVii1ZyQT7rChxAKz4XCqRYYNg1iiMai1mrSYQTF7M8kA/tujmEwvoIv7UQ+OS
        3PvEjzBK3sjJk7lpC7gQ5CBu0TA456tGUZB6I0Q+Enxu7+JMgSsrVb8j9NrBtpx5mmdUpT
        Kg+YHMpXHH97iEc/OR2eZekYk5rA3KyOxJMikc/iWK1uvaUVD5h9ypDIVkm5eT5B5tNKwZ
        q+Dm73I51hM6Yb9h2rohfZ3E9Zmbzp6KHS0iZ5fD90mJ/4nsjEDWFv97u7MTtVO4gC1x0F
        6TQdOSyUCrNAECweul//BDrL49v9en9pS1BMfMM0ty8exKAhGXIQlvdcp6o+fg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408944;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ahf9tUtt2LQHKxFpXkPU/YFIsm9O2TtkPVFU6dIgVNQ=;
        b=VI+MmlYgePCRCk8C9AwbOqcrV5QvQIkZIUnE+IDWQnc7Y6u9WL37fix4KrSLL5Xgnx9a8E
        8l0aB6634KdIdtDA==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/kernel: Mark the .bss..decrypted section as shared
 in the RMP table
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-20-brijesh.singh@amd.com>
References: <20220307213356.2797205-20-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894306.389.1286947681728921474.tip-bot2@tip-bot2>
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

Commit-ID:     efac0eedfab515e523cde5cb7a62289eb2ee58f8
Gitweb:        https://git.kernel.org/tip/efac0eedfab515e523cde5cb7a62289eb2ee58f8
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:13 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:23:00 +02:00

x86/kernel: Mark the .bss..decrypted section as shared in the RMP table

The encryption attribute for the .bss..decrypted section is cleared in the
initial page table build. This is because the section contains the data
that need to be shared between the guest and the hypervisor.

When SEV-SNP is active, just clearing the encryption attribute in the
page table is not enough. The page state needs to be updated in the RMP
table.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220307213356.2797205-20-brijesh.singh@amd.com
---
 arch/x86/kernel/head64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 83514b9..656d2f3 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -143,7 +143,20 @@ static unsigned long __head sme_postprocess_startup(struct boot_params *bp, pmdv
 	if (sme_get_me_mask()) {
 		vaddr = (unsigned long)__start_bss_decrypted;
 		vaddr_end = (unsigned long)__end_bss_decrypted;
+
 		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			/*
+			 * On SNP, transition the page to shared in the RMP table so that
+			 * it is consistent with the page table attribute change.
+			 *
+			 * __start_bss_decrypted has a virtual address in the high range
+			 * mapping (kernel .text). PVALIDATE, by way of
+			 * early_snp_set_memory_shared(), requires a valid virtual
+			 * address but the kernel is currently running off of the identity
+			 * mapping so use __pa() to get a *currently* valid virtual address.
+			 */
+			early_snp_set_memory_shared(__pa(vaddr), __pa(vaddr), PTRS_PER_PMD);
+
 			i = pmd_index(vaddr);
 			pmd[i] -= sme_get_me_mask();
 		}
