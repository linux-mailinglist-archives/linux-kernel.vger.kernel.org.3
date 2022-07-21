Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9A757D4E6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 22:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbiGUUkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 16:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUUkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 16:40:45 -0400
Received: from outgoing-stata.csail.mit.edu (outgoing-stata.csail.mit.edu [128.30.2.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386C42983D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 13:40:44 -0700 (PDT)
Received: from [128.177.82.146] (helo=[10.118.101.22])
        by outgoing-stata.csail.mit.edu with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.82)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1oEcxv-0004qr-Rg; Thu, 21 Jul 2022 16:40:11 -0400
Subject: [PATCH] smp/hotplug,
 x86/vmware: Put offline vCPUs in halt instead of mwait
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        ganb@vmware.com, sturlapati@vmware.com, bordoloih@vmware.com,
        ankitja@vmware.com, keerthanak@vmware.com, namit@vmware.com,
        srivatsa@csail.mit.edu, srivatsab@vmware.com
Date:   Thu, 21 Jul 2022 13:44:33 -0700
Message-ID: <165843627080.142207.12667479241667142176.stgit@csail.mit.edu>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

VMware ESXi allows enabling a passthru mwait CPU-idle state in the
guest using the following VMX option:

monitor_control.mwait_in_guest = "TRUE"

This lets a vCPU in mwait to remain in guest context (instead of
yielding to the hypervisor via a VMEXIT), which helps speed up
wakeups from idle.

However, this runs into problems with CPU hotplug, because the Linux
CPU offline path prefers to put the vCPU-to-be-offlined in mwait
state, whenever mwait is available. As a result, since a vCPU in mwait
remains in guest context and does not yield to the hypervisor, an
offline vCPU *appears* to be 100% busy as viewed from ESXi, which
prevents the hypervisor from running other vCPUs or workloads on the
corresponding pCPU (particularly when vCPU - pCPU mappings are
statically defined by the user). [ Note that such a vCPU is not
actually busy spinning though; it remains in mwait idle state in the
guest ].

Fix this by overriding the CPU offline play_dead() callback for VMware
hypervisor, by putting the CPU in halt state (which actually yields to
the hypervisor), even if mwait support is available.

Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Alexey Makhalov <amakhalov@vmware.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: x86@kernel.org
Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
---

 arch/x86/kernel/cpu/vmware.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
index c04b933f48d3..420e359ed9bb 100644
--- a/arch/x86/kernel/cpu/vmware.c
+++ b/arch/x86/kernel/cpu/vmware.c
@@ -27,6 +27,7 @@
 #include <linux/clocksource.h>
 #include <linux/cpu.h>
 #include <linux/reboot.h>
+#include <linux/tboot.h>
 #include <linux/static_call.h>
 #include <asm/div64.h>
 #include <asm/x86_init.h>
@@ -312,6 +313,21 @@ static int vmware_cpu_down_prepare(unsigned int cpu)
 	local_irq_enable();
 	return 0;
 }
+
+static void vmware_play_dead(void)
+{
+	play_dead_common();
+	tboot_shutdown(TB_SHUTDOWN_WFS);
+
+	/*
+	 * Put the vCPU going offline in halt instead of mwait (even
+	 * if mwait support is available), to make sure that the
+	 * offline vCPU yields to the hypervisor (which may not happen
+	 * with mwait, for example, if the guest's VMX is configured
+	 * to retain the vCPU in guest context upon mwait).
+	 */
+	hlt_play_dead();
+}
 #endif
 
 static __init int activate_jump_labels(void)
@@ -349,6 +365,7 @@ static void __init vmware_paravirt_ops_setup(void)
 #ifdef CONFIG_SMP
 		smp_ops.smp_prepare_boot_cpu =
 			vmware_smp_prepare_boot_cpu;
+		smp_ops.play_dead = vmware_play_dead;
 		if (cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
 					      "x86/vmware:online",
 					      vmware_cpu_online,


