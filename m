Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3DE591FAB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 14:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbiHNMAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 08:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiHNMAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 08:00:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EFBE1D
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 05:00:38 -0700 (PDT)
Received: from zn.tnic (p2e55d27b.dip0.t-ipconnect.de [46.85.210.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CEA681EC0589;
        Sun, 14 Aug 2022 14:00:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660478432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=GIrlzGEFxee285FXDFSCEgMjWYaWpj7OwB8eKwQPA5w=;
        b=X5Xn1aY5WyFFq4f1DpmqrHApTevlen2pdRTWfa2D0TVI3V9YN7VOLFgfW/K3H+J/MOCbMq
        Q5mAMxZ04HUIvrqLCyxAq1JVYpmDzE0Tr2mxLalmItJmo7d3QRhhMazLPhbPieRBm8hkei
        uOzwOtZldzSzN7SUwa0XjE2d2fJnN70=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     Andrew Cooper <amc96@srcf.net>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?=C8=98tefan=20Talpalaru?= <stefantalpalaru@yahoo.com>
Subject: [PATCH] x86/microcode/AMD: Attempt applying on every logical thread
Date:   Sun, 14 Aug 2022 14:00:26 +0200
Message-Id: <20220814120026.16118-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Currently, the patch application logic checks whether patch application
is needed. Therefore, on SMT designs where the microcode engine is
shared between the two threads, the application happens only on one of
them.

However, there are microcode patches which do per-thread modification,
see Link tag below.

Therefore, drop the revision check and try applying on each thread. This
is what the BIOS does too so this method is very much tested.

Reported-by:  Ștefan Talpalaru <stefantalpalaru@yahoo.com>
Tested-by:  Ștefan Talpalaru <stefantalpalaru@yahoo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216211
---
 arch/x86/kernel/cpu/microcode/amd.c | 39 +++++++----------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 8b2fcdfa6d31..a575dbb4d80c 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -420,8 +420,8 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
 	struct cont_desc desc = { 0 };
 	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
-	u32 rev, dummy, *new_rev;
 	bool ret = false;
+	u32 *new_rev;
 
 #ifdef CONFIG_X86_32
 	new_rev = (u32 *)__pa_nodebug(&ucode_new_rev);
@@ -439,10 +439,6 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, size_t size, bool save_p
 	if (!mc)
 		return ret;
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-	if (rev >= mc->hdr.patch_id)
-		return ret;
-
 	if (!__apply_microcode_amd(mc)) {
 		*new_rev = mc->hdr.patch_id;
 		ret      = true;
@@ -516,7 +512,7 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 {
 	struct microcode_amd *mc;
 	struct cpio_data cp;
-	u32 *new_rev, rev, dummy;
+	u32 *new_rev;
 
 	if (IS_ENABLED(CONFIG_X86_32)) {
 		mc	= (struct microcode_amd *)__pa_nodebug(amd_ucode_patch);
@@ -526,10 +522,8 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 		new_rev = &ucode_new_rev;
 	}
 
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/* Check whether we have saved a new patch already: */
-	if (*new_rev && rev < mc->hdr.patch_id) {
+	if (*new_rev) {
 		if (!__apply_microcode_amd(mc)) {
 			*new_rev = mc->hdr.patch_id;
 			return;
@@ -571,23 +565,17 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 
 void reload_ucode_amd(void)
 {
-	struct microcode_amd *mc;
-	u32 rev, dummy __always_unused;
-
-	mc = (struct microcode_amd *)amd_ucode_patch;
+	struct microcode_amd *mc = (struct microcode_amd *)amd_ucode_patch;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev = mc->hdr.patch_id;
-			pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
-		}
+	if (!__apply_microcode_amd(mc)) {
+		ucode_new_rev = mc->hdr.patch_id;
+		pr_info("reload patch_level=0x%08x\n", ucode_new_rev);
 	}
 }
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
+
 	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 }
 
@@ -678,7 +666,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy __always_unused;
+	u32 rev;
 
 	BUG_ON(raw_smp_processor_id() != cpu);
 
@@ -691,14 +679,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	mc_amd  = p->data;
 	uci->mc = p->data;
 
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	/* need to apply patch? */
-	if (rev >= mc_amd->hdr.patch_id) {
-		ret = UCODE_OK;
-		goto out;
-	}
-
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
@@ -710,7 +690,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 
 	pr_info("CPU%d: new patch_level=0x%08x\n", cpu, rev);
 
-out:
 	uci->cpu_sig.rev = rev;
 	c->microcode	 = rev;
 
-- 
2.35.1

