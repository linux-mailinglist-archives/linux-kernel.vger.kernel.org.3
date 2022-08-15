Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2145943C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 00:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbiHOW0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348533AbiHOWQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:16:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119E97A76E;
        Mon, 15 Aug 2022 12:40:11 -0700 (PDT)
Date:   Mon, 15 Aug 2022 19:40:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660592406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dDSkv5MwGBvgI78bM5xANHUjiQSD2UHZhDvpjhNR+Zg=;
        b=IDGATL8v0xndArtTjxMUmTEUjjWnHF5XDE9sFAE0ZOp+CFULFXzgLL4m/NGuggm06pzj0h
        jOyaURGGtXPp978tgbrkMkT3lyUzzHxdESg3FcN4sTVCj8ZDO2DOQBP9QAXnI5sKeJM0tG
        WxjldCNLUkN5mL/2WTvQSFitw+mdylIHAPL/4oW0Ge0cZBtJB/PmIkOi3Qn1WmxqOD+kH2
        ypPE7mZaSPDYsQgzA+4ZWn/xKgAP2A+Lg8w2CRhzyOFXE2nk3/dWB9odL2yqTRcVycdHwL
        814v6/AXNote7OE/TkZ+ogD7nfy1QKciVK2Bjx135nM/eRQS1nmak2ZW7uQZDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660592406;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dDSkv5MwGBvgI78bM5xANHUjiQSD2UHZhDvpjhNR+Zg=;
        b=ddwH8zwXcnyClJcJEABIanPqp0rpb0yiUXTK0YsjHMbcSY6gPIcSuHPWaugNWKskB43MtX
        oBzP3t7xdSOSVGCw==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Attempt applying on every
 logical thread
Cc:     stefantalpalaru@yahoo.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166059240449.401.10624523214894054628.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     71da8a554f25713964a919311c324e5a32f08239
Gitweb:        https://git.kernel.org/tip/71da8a554f25713964a919311c324e5a32f=
08239
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 14 Aug 2022 12:37:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Aug 2022 21:25:31 +02:00

x86/microcode/AMD: Attempt applying on every logical thread

Currently, the patch application logic checks whether patch application
is needed on each CPU. Therefore, on SMT designs where the microcode
engine is shared between the two threads, the application happens only
on one of them.

However, there are microcode patches which do per-thread modification,
see Link tag below.

Therefore, drop the revision check and try applying on each thread. This
is what the BIOS does too so this method is very much tested.

Reported-by:  =C8=98tefan Talpalaru <stefantalpalaru@yahoo.com>
Tested-by:  =C8=98tefan Talpalaru <stefantalpalaru@yahoo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216211
---
 arch/x86/kernel/cpu/microcode/amd.c | 39 ++++++----------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microc=
ode/amd.c
index 8b2fcdf..a575dbb 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -420,8 +420,8 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, s=
ize_t size, bool save_p
 	struct cont_desc desc =3D { 0 };
 	u8 (*patch)[PATCH_MAX_SIZE];
 	struct microcode_amd *mc;
-	u32 rev, dummy, *new_rev;
 	bool ret =3D false;
+	u32 *new_rev;
=20
 #ifdef CONFIG_X86_32
 	new_rev =3D (u32 *)__pa_nodebug(&ucode_new_rev);
@@ -439,10 +439,6 @@ apply_microcode_early_amd(u32 cpuid_1_eax, void *ucode, =
size_t size, bool save_p
 	if (!mc)
 		return ret;
=20
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-	if (rev >=3D mc->hdr.patch_id)
-		return ret;
-
 	if (!__apply_microcode_amd(mc)) {
 		*new_rev =3D mc->hdr.patch_id;
 		ret      =3D true;
@@ -516,7 +512,7 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 {
 	struct microcode_amd *mc;
 	struct cpio_data cp;
-	u32 *new_rev, rev, dummy;
+	u32 *new_rev;
=20
 	if (IS_ENABLED(CONFIG_X86_32)) {
 		mc	=3D (struct microcode_amd *)__pa_nodebug(amd_ucode_patch);
@@ -526,10 +522,8 @@ void load_ucode_amd_ap(unsigned int cpuid_1_eax)
 		new_rev =3D &ucode_new_rev;
 	}
=20
-	native_rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
 	/* Check whether we have saved a new patch already: */
-	if (*new_rev && rev < mc->hdr.patch_id) {
+	if (*new_rev) {
 		if (!__apply_microcode_amd(mc)) {
 			*new_rev =3D mc->hdr.patch_id;
 			return;
@@ -571,23 +565,17 @@ int __init save_microcode_in_initrd_amd(unsigned int cp=
uid_1_eax)
=20
 void reload_ucode_amd(void)
 {
-	struct microcode_amd *mc;
-	u32 rev, dummy __always_unused;
-
-	mc =3D (struct microcode_amd *)amd_ucode_patch;
+	struct microcode_amd *mc =3D (struct microcode_amd *)amd_ucode_patch;
=20
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	if (rev < mc->hdr.patch_id) {
-		if (!__apply_microcode_amd(mc)) {
-			ucode_new_rev =3D mc->hdr.patch_id;
-			pr_info("reload patch_level=3D0x%08x\n", ucode_new_rev);
-		}
+	if (!__apply_microcode_amd(mc)) {
+		ucode_new_rev =3D mc->hdr.patch_id;
+		pr_info("reload patch_level=3D0x%08x\n", ucode_new_rev);
 	}
 }
 static u16 __find_equiv_id(unsigned int cpu)
 {
 	struct ucode_cpu_info *uci =3D ucode_cpu_info + cpu;
+
 	return find_equiv_id(&equiv_table, uci->cpu_sig.sig);
 }
=20
@@ -678,7 +666,7 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	struct ucode_cpu_info *uci;
 	struct ucode_patch *p;
 	enum ucode_state ret;
-	u32 rev, dummy __always_unused;
+	u32 rev;
=20
 	BUG_ON(raw_smp_processor_id() !=3D cpu);
=20
@@ -691,14 +679,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
 	mc_amd  =3D p->data;
 	uci->mc =3D p->data;
=20
-	rdmsr(MSR_AMD64_PATCH_LEVEL, rev, dummy);
-
-	/* need to apply patch? */
-	if (rev >=3D mc_amd->hdr.patch_id) {
-		ret =3D UCODE_OK;
-		goto out;
-	}
-
 	if (__apply_microcode_amd(mc_amd)) {
 		pr_err("CPU%d: update failed for patch_level=3D0x%08x\n",
 			cpu, mc_amd->hdr.patch_id);
@@ -710,7 +690,6 @@ static enum ucode_state apply_microcode_amd(int cpu)
=20
 	pr_info("CPU%d: new patch_level=3D0x%08x\n", cpu, rev);
=20
-out:
 	uci->cpu_sig.rev =3D rev;
 	c->microcode	 =3D rev;
=20
