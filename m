Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B88568595
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiGFKaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbiGFKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:30:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F926541;
        Wed,  6 Jul 2022 03:30:14 -0700 (PDT)
Date:   Wed, 06 Jul 2022 10:30:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657103412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJebcJ+nWiwORwu/EImlYQm0Hspp4x1MdvDNLe/Zgi8=;
        b=DaoDj26VeFMsER6N2v9at3smOsLSw59a6MvxUZln5JGHqXm1qRL7LlIWS/dlGsLKqwkcNU
        H2bZtxk2pMwBfjiyRAENU6sR9Cejmrdfx+rIy1vxcypnQtQsQmJCSv+HsR1Pq2iwtco8mY
        sptIxOcq3M+OfGAD9WReDBQyqb7O9TFfIxSRl++A5nEVbqXOD+jwxB1NpKUkb8MGvPHuPI
        4jL24nIe4liIBqGW0kecfXLolXt6YUzwFwpeOAMsoThRQs+28EE5DXFVe2lG7P02RJMbK+
        OsI7ZgTJ+/JTIkhZTuWrJo4KFnlnJMtbcPCPWpR9tcbinE8K/jhVmBDbJp2GNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657103412;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rJebcJ+nWiwORwu/EImlYQm0Hspp4x1MdvDNLe/Zgi8=;
        b=USx+KihCSiqeGIPSctBU0iDrEVlG5XQ+hyLF/jxFb6kCw0BgQwpKpF69Y3af/LhFg01+Ux
        +Ns0gx2NsGZM+GAg==
From:   "tip-bot2 for Michael Roth" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/compressed/64: Add identity mappings for
 setup_data entries
Cc:     "Jun'ichi Nomura" <junichi.nomura@nec.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3CTYCPR01MB694815CD815E98945F63C99183B49=40TYCPR01MB?=
 =?utf-8?q?6948=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CTYCPR01MB694815CD815E98945F63C99183B49=40TYCPR01M?=
 =?utf-8?q?B6948=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165710341109.15455.1767984177285353783.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
Gitweb:        https://git.kernel.org/tip/b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
Author:        Michael Roth <michael.roth@amd.com>
AuthorDate:    Tue, 05 Jul 2022 21:53:15 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Jul 2022 11:23:39 +02:00

x86/compressed/64: Add identity mappings for setup_data entries

The decompressed kernel initially relies on the identity map set up by
the boot/compressed kernel for accessing things like boot_params. With
the recent introduction of SEV-SNP support, the decompressed kernel
also needs to access the setup_data entries pointed to by
boot_params->hdr.setup_data.

This can lead to a crash in the kexec kernel during early boot due to
these entries not currently being included in the initial identity map,
see thread at Link below.

Include mappings for the setup_data entries in the initial identity map.

  [ bp: Massage commit message and use a helper var for better readability. ]

Fixes: b190a043c49a ("x86/sev: Add SEV-SNP feature detection/setup")
Reported-by: Jun'ichi Nomura <junichi.nomura@nec.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/TYCPR01MB694815CD815E98945F63C99183B49@TYCPR01MB6948.jpnprd01.prod.outlook.com
---
 arch/x86/boot/compressed/ident_map_64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 44c350d..d4a314c 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -110,6 +110,7 @@ void kernel_add_identity_map(unsigned long start, unsigned long end)
 void initialize_identity_maps(void *rmode)
 {
 	unsigned long cmdline;
+	struct setup_data *sd;
 
 	/* Exclude the encryption mask from __PHYSICAL_MASK */
 	physical_mask &= ~sme_me_mask;
@@ -163,6 +164,18 @@ void initialize_identity_maps(void *rmode)
 	cmdline = get_cmd_line_ptr();
 	kernel_add_identity_map(cmdline, cmdline + COMMAND_LINE_SIZE);
 
+	/*
+	 * Also map the setup_data entries passed via boot_params in case they
+	 * need to be accessed by uncompressed kernel via the identity mapping.
+	 */
+	sd = (struct setup_data *)boot_params->hdr.setup_data;
+	while (sd) {
+		unsigned long sd_addr = (unsigned long)sd;
+
+		kernel_add_identity_map(sd_addr, sd_addr + sizeof(*sd) + sd->len);
+		sd = (struct setup_data *)sd->next;
+	}
+
 	sev_prep_identity_maps(top_level_pgt);
 
 	/* Load the new page-table. */
