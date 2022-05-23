Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EAE530B7E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbiEWICN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbiEWICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:02:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194C17043
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:02:10 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653292928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=De6fE+5zaqZacnGfO6NGKcPy43hfV1easliwHk0nhyk=;
        b=RADbQepIzoPuHRSgonToprkI3RSDhVNsRksC/NOrmf2vCuSEWwJh/+BsNktMfIMMjlLJ5U
        sw9paHGDqULqAqq1Fr+rZYHoQhpZBgDfn3eDUbEicsmYcGtkKRafIWc5kZk8UXPCr8epf7
        BmfPHVGC60Lzzmc5kE8f3p6xFUFNzgrgEKIZKJ4bkzwotdRzQQ/iKNEPoshSDfMwH/FZSU
        SYNhCxCs8HhsCe9WZnrnomWqfSv0ClRRvnC/aY5Hqd2mqmV9v7otXTMorrTr6/jy5Jcq0F
        HbtiWLUAZwpn8lOPP5LJ4TFdmYeRHcQLbDvPe386K6WN+ON+ai9ZIX+yUGJmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653292928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=De6fE+5zaqZacnGfO6NGKcPy43hfV1easliwHk0nhyk=;
        b=3o8Uc5rAKy7WhtrxrepER9U+ZrDpQ0Pe2ranjzG2GoQ7ZafH/eAxfe7vfrUHKEnp5aW53w
        fb6UMsdtSpcGtUBw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/core for 5.19-rc1
References: <165329267741.3801280.534077656528571075.tglx@xen13>
Message-ID: <165329268192.3801280.7168389137324540940.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 23 May 2022 10:02:08 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-core-2022-05=
-23

up to:  d308077e5e4d: cpu/hotplug: Initialise all cpuhp_cpu_state structs ear=
lier


Updates for CPU hotplug:

  - Initialize the per CPU structures during early boot so that the state
    is consistent from the very beginning.

  - Make the virtualization hotplug state handling more robust and let the
    core bringup CPUs which timed out in an earlier attempt again.

  - Make the x86/XEN CPU state tracking consistent on a failed online
    attempt, so a consecutive bringup does not fall over the inconsistent
    state.


Thanks,

	tglx

------------------>
Boris Ostrovsky (1):
      x86/xen: Allow to retry if cpu_initialize_context() failed.

Longpeng(Mike) (1):
      cpu/hotplug: Allow the CPU in CPU_UP_PREPARE state to be brought up aga=
in.

Steven Price (1):
      cpu/hotplug: Initialise all cpuhp_cpu_state structs earlier


 arch/x86/xen/smp_pv.c |  5 ++++-
 kernel/cpu.c          | 22 +++++++++++++---------
 kernel/smpboot.c      |  7 +++++++
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 688aa8b6ae29..ba7af2eca755 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -260,8 +260,11 @@ cpu_initialize_context(unsigned int cpu, struct task_str=
uct *idle)
 		return 0;
=20
 	ctxt =3D kzalloc(sizeof(*ctxt), GFP_KERNEL);
-	if (ctxt =3D=3D NULL)
+	if (ctxt =3D=3D NULL) {
+		cpumask_clear_cpu(cpu, xen_cpu_initialized_map);
+		cpumask_clear_cpu(cpu, cpu_callout_mask);
 		return -ENOMEM;
+	}
=20
 	gdt =3D get_cpu_gdt_rw(cpu);
=20
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d0a9aa0b42e8..02a77ac08399 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -716,14 +716,6 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct c=
puhp_cpu_state *st,
 /*
  * The cpu hotplug threads manage the bringup and teardown of the cpus
  */
-static void cpuhp_create(unsigned int cpu)
-{
-	struct cpuhp_cpu_state *st =3D per_cpu_ptr(&cpuhp_state, cpu);
-
-	init_completion(&st->done_up);
-	init_completion(&st->done_down);
-}
-
 static int cpuhp_should_run(unsigned int cpu)
 {
 	struct cpuhp_cpu_state *st =3D this_cpu_ptr(&cpuhp_state);
@@ -883,15 +875,27 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
=20
 static struct smp_hotplug_thread cpuhp_threads =3D {
 	.store			=3D &cpuhp_state.thread,
-	.create			=3D &cpuhp_create,
 	.thread_should_run	=3D cpuhp_should_run,
 	.thread_fn		=3D cpuhp_thread_fun,
 	.thread_comm		=3D "cpuhp/%u",
 	.selfparking		=3D true,
 };
=20
+static __init void cpuhp_init_state(void)
+{
+	struct cpuhp_cpu_state *st;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		st =3D per_cpu_ptr(&cpuhp_state, cpu);
+		init_completion(&st->done_up);
+		init_completion(&st->done_down);
+	}
+}
+
 void __init cpuhp_threads_init(void)
 {
+	cpuhp_init_state();
 	BUG_ON(smpboot_register_percpu_thread(&cpuhp_threads));
 	kthread_unpark(this_cpu_read(cpuhp_state.thread));
 }
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f6bc0bc8a2aa..b9f54544e749 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -392,6 +392,13 @@ int cpu_check_up_prepare(int cpu)
 		 */
 		return -EAGAIN;
=20
+	case CPU_UP_PREPARE:
+		/*
+		 * Timeout while waiting for the CPU to show up. Allow to try
+		 * again later.
+		 */
+		return 0;
+
 	default:
=20
 		/* Should not happen.  Famous last words. */

