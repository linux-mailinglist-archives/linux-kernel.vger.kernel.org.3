Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B7947199B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 11:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhLLKeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 05:34:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57604 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhLLKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 05:34:23 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639305262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nmPU5W/USa6qcERz4EFyZJzj0XHhXr5jnkCMjm2NA28=;
        b=tUWtxc3f82sn6bNNI/peaF01zke6DBzcw+E+Z89n+wNrk3mSXQD4gKAwbvOYQ0yz3pFLj6
        V9cr4qOsZ1vUuLzd4GoQdgjUvD3sHE2pVtaXrY/+86kScAApqSgmH1zteceAoyz7pkbz8Y
        EqaouzKx6PBjjewAw+yZq+MfgMgYWjmd4Mo5yHbZyyDas+QnGYzvBOERuzOlZIy1LLNmvu
        vOFGitO18u6Nddd/ilWGtsIyDnKgzB1hlrNczUeCwize91G720f1ed4EifexZ8AE9D7Jen
        Hp4xdnOY2HOk6F9YhgB/Q3JEkfugo51jOKdieMir6yASr6qZBhfJX9+GwylHiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639305262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nmPU5W/USa6qcERz4EFyZJzj0XHhXr5jnkCMjm2NA28=;
        b=BXU2RidrSigoSSiWrsjLCJUwWa70+ZTZXdbdGRIjjNsM0hFdVlmybKfuaFYufp3eURwvGM
        6SwZtlgES8ZwpABg==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] sched/urgent for v5.16-rc5
References: <163930519667.2118055.7751610896538340816.tglx@xen13>
Message-ID: <163930519817.2118055.7014553397541088230.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Sun, 12 Dec 2021 11:34:22 +0100 (CET)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest sched/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched-urgent-202=
1-12-12

up to:  cabdc3a8475b: sched,x86: Don't use cluster topology for x86 hybrid CP=
Us


A single fix for the x86 scheduler topology:

  Using cluster topology on hybrid CPUs, e.g. Alder Lake, biases the
  scheduler towards the ATOM cluster as that has more total capacity.
  Use selection based on CPU priority instead.

Thanks,

	tglx

------------------>
Peter Zijlstra (1):
      sched,x86: Don't use cluster topology for x86 hybrid CPUs


 arch/x86/kernel/smpboot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index ac2909f0cab3..617012f4619f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -579,6 +579,17 @@ static struct sched_domain_topology_level x86_numa_in_pa=
ckage_topology[] =3D {
 	{ NULL, },
 };
=20
+static struct sched_domain_topology_level x86_hybrid_topology[] =3D {
+#ifdef CONFIG_SCHED_SMT
+	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
+#endif
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 static struct sched_domain_topology_level x86_topology[] =3D {
 #ifdef CONFIG_SCHED_SMT
 	{ cpu_smt_mask, x86_smt_flags, SD_INIT_NAME(SMT) },
@@ -1469,8 +1480,11 @@ void __init native_smp_cpus_done(unsigned int max_cpus)
=20
 	calculate_max_logical_packages();
=20
+	/* XXX for now assume numa-in-package and hybrid don't overlap */
 	if (x86_has_numa_in_package)
 		set_sched_topology(x86_numa_in_package_topology);
+	if (cpu_feature_enabled(X86_FEATURE_HYBRID_CPU))
+		set_sched_topology(x86_hybrid_topology);
=20
 	nmi_selftest();
 	impress_friends();

