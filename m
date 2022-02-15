Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261504B69D0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 11:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236791AbiBOKyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 05:54:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiBOKyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:54:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B986FD76D4;
        Tue, 15 Feb 2022 02:54:31 -0800 (PST)
Date:   Tue, 15 Feb 2022 10:54:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644922470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIFUKtYJ/5DNXyMxkpy4PvZ4fvsKs+2wos20UTc67s8=;
        b=bsYOnW4nnG4WtC5Ded1e4lGQmFXDokihdcGT+wMkRKpr+7zgXnBxMy542JrYFbMF5GhFo+
        D3zRpuCcLVIAWGFpbH5JGpRyXHwBdjH7a3UD7X5mzORNlYU3G2opiezt/LDDKFbGCp7kHe
        tJDmrWdb0cJNTJm0eERcuQSgVL70Q8HN0B2Jgx7BQ/oLzHmypdj1yXwm6CixnSXy35hJG7
        NoOXQCySZTlg4G8mH9l/ipxdDV9QScA5WCws4+UpSHI3koWEcsxdiMxbwRgo1PHDBfMqh9
        vgxajFhGEKrXhkm7OHx/ORuAc/Sy160QIBZMvQLWsDsJXABqqcd/Ayoto2YXqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644922470;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AIFUKtYJ/5DNXyMxkpy4PvZ4fvsKs+2wos20UTc67s8=;
        b=+SDQl2XQB6bXmi7G+UJGDpd2ThXr915NzINawdrgIm9IpA6dFs1K7ncuqaE8Y2VEfV0j7k
        VPgfseDG4IVdogBQ==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pasid] x86/fpu: Clear PASID when copying fpstate
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220207230254.3342514-7-fenghua.yu@intel.com>
References: <20220207230254.3342514-7-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <164492246930.16921.7851378543426282849.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/pasid branch of tip:

Commit-ID:     dc7507ddce593cbd9c93330024a5658db6f8ef73
Gitweb:        https://git.kernel.org/tip/dc7507ddce593cbd9c93330024a5658db6f8ef73
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Mon, 07 Feb 2022 15:02:49 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Feb 2022 11:31:43 +01:00

x86/fpu: Clear PASID when copying fpstate

The kernel must allocate a Process Address Space ID (PASID) on behalf of
each process which will use ENQCMD and program it into the new MSR to
communicate the process identity to platform hardware. ENQCMD uses the
PASID stored in this MSR to tag requests from this process.

The PASID state must be cleared on fork() since fork creates a
new address space.

For clone(), it would be functionally OK to copy the PASID. However,
clearing it is _also_ functionally OK since any PASID use will trigger
the #GP handler to populate the MSR.

Copying the PASID state has two main downsides:
 * It requires differentiating fork() and clone() in the code,
   both in the FPU code and keeping tsk->pasid_activated consistent.
 * It guarantees that the PASID is out of its init state, which
   incurs small but non-zero cost on every XSAVE/XRSTOR.

The main downside of clearing the PASID at fpstate copy is the future,
one-time #GP for the thread.

Use the simplest approach: clear the PASID state both on clone() and
fork().  Rely on the #GP handler for MSR population in children.

Also, just clear the PASID bit from xfeatures if XSAVE is supported.
This will have no effect on systems that do not have PASID support.  It
is virtually zero overhead because 'dst_fpu' was just written and
the whole thing is cache hot.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220207230254.3342514-7-fenghua.yu@intel.com
---
 arch/x86/kernel/fpu/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8dea01f..19821f0 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -612,6 +612,13 @@ int fpu_clone(struct task_struct *dst, unsigned long clone_flags)
 		fpu_inherit_perms(dst_fpu);
 	fpregs_unlock();
 
+	/*
+	 * Children never inherit PASID state.
+	 * Force it to have its init value:
+	 */
+	if (use_xsave())
+		dst_fpu->fpstate->regs.xsave.header.xfeatures &= ~XFEATURE_MASK_PASID;
+
 	trace_x86_fpu_copy_src(src_fpu);
 	trace_x86_fpu_copy_dst(dst_fpu);
 
