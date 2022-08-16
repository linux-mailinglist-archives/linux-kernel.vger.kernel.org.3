Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2338859563E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 11:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiHPJ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 05:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbiHPJ23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 05:28:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F9751A2E;
        Tue, 16 Aug 2022 00:46:59 -0700 (PDT)
Date:   Tue, 16 Aug 2022 07:46:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660636017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZeZ6FOu0KetfgxCQsOAIM4uKnYMDJaAixztqrpKo3M0=;
        b=kTsUFNw9BrdG+I/JPkSTw8VpKm5Z+Il8BmPLHxzdnfovTNPAHnQQ9tztBcb8D4NCPaUaD3
        x7oZmtNyV6dzs3ZxITsmTqcW0RtzWeFTxyox6IRcncI/F/tu+JwJ/iU14mOz2SC7w8aHbF
        asMAzrbFiE73Nf6yeGQ5uFqfbfJr/TgkGLmQug/XlhRtRl2wRqr6whTQBIUXEqoaFWgeGl
        RhBDPSMEQgrqP1f4CpnE2lxJdfhOmkKq6z8R0lPPLhQYHuob27FngJTniXb4zo9X2Hlhrw
        +twe1nG/O8v4JXX1QlkPpxqH/PZSi1R14t6gyASMMHcn9olPH/7kK7DTh5A06w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660636017;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ZeZ6FOu0KetfgxCQsOAIM4uKnYMDJaAixztqrpKo3M0=;
        b=3Zu9eKW6IF831gTrMEwVGeDWO8aAsafOiCd196CvSG4sdW3OEwHCTMVUxkPlmEgk46tTIg
        sMnWVe3Iv2LK1JDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/AMD: Attempt applying on every
 logical thread
Cc:     stefantalpalaru@yahoo.com, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166063601607.401.15127782241122695343.tip-bot2@tip-bot2>
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

Commit-ID:     df76acb227a08b274fe03d8fc51d3240ea5a83f0
Gitweb:        https://git.kernel.org/tip/df76acb227a08b274fe03d8fc51d3240ea5=
a83f0
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 14 Aug 2022 12:37:49 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 16 Aug 2022 09:35:36 +02:00

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
