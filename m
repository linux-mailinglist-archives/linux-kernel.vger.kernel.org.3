Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF554F91CC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbiDHJQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiDHJMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCB11E869F;
        Fri,  8 Apr 2022 02:09:08 -0700 (PDT)
Date:   Fri, 08 Apr 2022 09:09:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649408946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTJSRIIYzR4ZNzP/uEhRKSQ6xdROr8lpeYdbaRvC7oE=;
        b=JKxoNLlsvvKKGvRuZniw32kSOSbXh0K9D/epUhB1XCghdUAUAbw0vna1KlEGB374BB50SR
        1hTQohD4CE3HtUnqvG2Kre+P9y8eoGOH6HhyqCJ7wsldPFctg3PJU98lEsWjxd0Rhuy7am
        ohKueI9htlHW+nhYtht8mSGGAjFI5NjJvM9/MOai5LfY4ultgZtIm3sYbpVHGmuhX0J2B8
        ifmRR3fLv+xkQb5KWLqHPTboEMY74RsXGlQ3f0wjKk/wUD+qo//NEnsfGRthr67UKpDZGN
        eB8cyi9evOqpupIZJXAkR/HW9UaQ5JHhTX/BG2qbQN9YAS8NB73O1KArKYZZcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649408946;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTJSRIIYzR4ZNzP/uEhRKSQ6xdROr8lpeYdbaRvC7oE=;
        b=9nquk1Bthh3ehkq+BcTNenC+RzC4AosoSGELJKimdOjsjEWm+H435YrJRJBFCduDAcobpE
        vUGmvTqK1k+ErTBQ==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/compressed: Register GHCB memory when SEV-SNP is active
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Venu Busireddy <venu.busireddy@oracle.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220307213356.2797205-17-brijesh.singh@amd.com>
References: <20220307213356.2797205-17-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <164940894556.389.6668011278041440932.tip-bot2@tip-bot2>
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

Commit-ID:     87294bdb7b4b73555b0fba45da1cdecdc6a0d5a8
Gitweb:        https://git.kernel.org/tip/87294bdb7b4b73555b0fba45da1cdecdc6a0d5a8
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Wed, 09 Feb 2022 12:10:10 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 Apr 2022 13:14:24 +02:00

x86/compressed: Register GHCB memory when SEV-SNP is active

The SEV-SNP guest is required by the GHCB spec to register the GHCB's
Guest Physical Address (GPA). This is because the hypervisor may prefer
that a guest use a consistent and/or specific GPA for the GHCB associated
with a vCPU. For more information, see the GHCB specification section
"GHCB GPA Registration".

If hypervisor can not work with the guest provided GPA then terminate the
guest boot.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>
Link: https://lore.kernel.org/r/20220307213356.2797205-17-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/sev.c    |  4 ++++
 arch/x86/include/asm/sev-common.h | 13 +++++++++++++
 arch/x86/kernel/sev-shared.c      | 16 ++++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5f2c268..f31b434 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -175,6 +175,10 @@ static bool early_setup_ghcb(void)
 	/* Initialize lookup tables for the instruction decoder */
 	inat_init_tables();
 
+	/* SNP guest requires the GHCB GPA must be registered */
+	if (sev_snp_enabled())
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+
 	return true;
 }
 
diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
index fe7fe16..f077a6c 100644
--- a/arch/x86/include/asm/sev-common.h
+++ b/arch/x86/include/asm/sev-common.h
@@ -57,6 +57,19 @@
 #define GHCB_MSR_AP_RESET_HOLD_REQ	0x006
 #define GHCB_MSR_AP_RESET_HOLD_RESP	0x007
 
+/* GHCB GPA Register */
+#define GHCB_MSR_REG_GPA_REQ		0x012
+#define GHCB_MSR_REG_GPA_REQ_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)((v) & GENMASK_ULL(51, 0)) << 12) |	\
+	/* GHCBData[11:0] */				\
+	GHCB_MSR_REG_GPA_REQ)
+
+#define GHCB_MSR_REG_GPA_RESP		0x013
+#define GHCB_MSR_REG_GPA_RESP_VAL(v)			\
+	/* GHCBData[63:12] */				\
+	(((u64)(v) & GENMASK_ULL(63, 12)) >> 12)
+
 /*
  * SNP Page State Change Operation
  *
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index 4a876e6..e9ff13c 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -68,6 +68,22 @@ static u64 get_hv_features(void)
 	return GHCB_MSR_HV_FT_RESP_VAL(val);
 }
 
+static void __maybe_unused snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
 static bool sev_es_negotiate_protocol(void)
 {
 	u64 val;
