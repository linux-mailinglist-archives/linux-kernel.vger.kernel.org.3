Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820465117ED
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbiD0L7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiD0L7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:59:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B93121E;
        Wed, 27 Apr 2022 04:56:26 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:56:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651060584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBosDWnBLV6rAp4sXkLwdAbmZkXBSaaJRn0sEnYXPrc=;
        b=mTSMo1jZ7PnjOCTIt/VY1dExSclpx56hf45qzeeFlouPhLfpR4vtR+dt751QbmyoSHDy6I
        17sQiYRb6iLmlZ3o2LlrQoIPC7iJilW8IyjmbmlDGkNzEAs8u+DnRmSYSd+92GoyaKdRcd
        S15EY/GdVZl2Eia+cjTHxRTC1PJ47tX1nSWkWaFW1LKNbAWEL6Q9Kllfi6c7fZj793JBPt
        ulTVAkh4Tgmnm3aQzjKF9Gj2EfCDObAG/euAiTz7EF+fQe7V2QwYR0Ce2FLZYvj2Gr17aC
        S8rsf+WSGhlTpOOfvmUT0MJpaXouV0BX3Jp3Nm5lrFxkh694cLD+7u/7mz4+Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651060584;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hBosDWnBLV6rAp4sXkLwdAbmZkXBSaaJRn0sEnYXPrc=;
        b=UD+rrcmy5o86t7u8tvN25BKQzMKvqdfY2IJNdkrAWfQP2kld1dDN4Ec+LyPG+ESRa2rL0g
        Ok6sZCpBTvcQpGBw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Get the AP jump table address from secrets page
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Michael Roth <michael.roth@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220422135624.114172-3-michael.roth@amd.com>
References: <20220422135624.114172-3-michael.roth@amd.com>
MIME-Version: 1.0
Message-ID: <165106058282.4207.6903605581485804335.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
Gitweb:        https://git.kernel.org/tip/c2106a231c2ba36ff9af50cdf2867b9a5f8150a6
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Fri, 22 Apr 2022 08:56:24 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Apr 2022 13:31:38 +02:00

x86/sev: Get the AP jump table address from secrets page

The GHCB specification section 2.7 states that when SEV-SNP is enabled,
a guest should not rely on the hypervisor to provide the address of the
AP jump table. Instead, if a guest BIOS wants to provide an AP jump
table, it should record the address in the SNP secrets page so the guest
operating system can obtain it directly from there.

Fix this on the guest kernel side by having SNP guests use the AP jump
table address published in the secrets page rather than issuing a GHCB
request to get it.

  [ mroth:
    - Improve error handling when ioremap()/memremap() return NULL
    - Don't mix function calls with declarations
    - Add missing __init
    - Tweak commit message ]

Fixes: 0afb6b660a6b ("x86/sev: Use SEV-SNP AP creation to start secondary CPUs")
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220422135624.114172-3-michael.roth@amd.com
---
 arch/x86/include/asm/sev.h              | 35 +++++++++++-
 arch/x86/kernel/sev.c                   | 76 ++++++++++++++++--------
 drivers/virt/coco/sev-guest/sev-guest.h | 35 +-----------
 3 files changed, 87 insertions(+), 59 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 6e3dda4..1951452 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -99,6 +99,41 @@ struct sev_guest_platform_data {
 	u64 secrets_gpa;
 };
 
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPCK.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec version 0.9 for secrets page format */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imien	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern struct static_key_false sev_es_enable_key;
 extern void __sev_es_ist_enter(struct pt_regs *regs);
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index b7fd191..1663750 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -558,6 +558,55 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
+static u64 __init get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	if (!map) {
+		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
+		return 0;
+	}
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static u64 __init get_snp_jump_table_addr(void)
+{
+	struct snp_secrets_page_layout *layout;
+	u64 pa, addr;
+
+	pa = get_secrets_page();
+	if (!pa)
+		return 0;
+
+	layout = (__force void *)ioremap_encrypted(pa, PAGE_SIZE);
+	if (!layout) {
+		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
+		return 0;
+	}
+
+	addr = layout->os_area.ap_jump_table_pa;
+	iounmap(layout);
+
+	return addr;
+}
+
 static u64 __init get_jump_table_addr(void)
 {
 	struct ghcb_state state;
@@ -565,6 +614,9 @@ static u64 __init get_jump_table_addr(void)
 	struct ghcb *ghcb;
 	u64 ret = 0;
 
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return get_snp_jump_table_addr();
+
 	local_irq_save(flags);
 
 	ghcb = __sev_get_ghcb(&state);
@@ -2171,30 +2223,6 @@ static struct platform_device sev_guest_device = {
 	.id		= -1,
 };
 
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
index d39bdd0..21bda26 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.h
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -60,39 +60,4 @@ struct snp_guest_msg {
 	u8 payload[4000];
 } __packed;
 
-/*
- * The secrets page contains 96-bytes of reserved field that can be used by
- * the guest OS. The guest OS uses the area to save the message sequence
- * number for each VMPCK.
- *
- * See the GHCB spec section Secret page layout for the format for this area.
- */
-struct secrets_os_area {
-	u32 msg_seqno_0;
-	u32 msg_seqno_1;
-	u32 msg_seqno_2;
-	u32 msg_seqno_3;
-	u64 ap_jump_table_pa;
-	u8 rsvd[40];
-	u8 guest_usage[32];
-} __packed;
-
-#define VMPCK_KEY_LEN		32
-
-/* See the SNP spec version 0.9 for secrets page format */
-struct snp_secrets_page_layout {
-	u32 version;
-	u32 imien	: 1,
-	    rsvd1	: 31;
-	u32 fms;
-	u32 rsvd2;
-	u8 gosvw[16];
-	u8 vmpck0[VMPCK_KEY_LEN];
-	u8 vmpck1[VMPCK_KEY_LEN];
-	u8 vmpck2[VMPCK_KEY_LEN];
-	u8 vmpck3[VMPCK_KEY_LEN];
-	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
-} __packed;
-
 #endif /* __VIRT_SEVGUEST_H__ */
