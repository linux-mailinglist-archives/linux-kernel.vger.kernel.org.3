Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104FA4677ED
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352175AbhLCNSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:18:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238833AbhLCNSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:18:17 -0500
Date:   Fri, 3 Dec 2021 14:14:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638537292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gD/yRCj6iH5Z38Ok8ZKXwadPmr3m6EbXsHhsjZCA5Q=;
        b=N/HaGw01Xovigsgb/pbbQDoAjMGfAtO5/iTG5FC7ecYM3OzX3/zWFIWX6BkzbdVkT6SMlT
        TyezQ6QZ28kJTlOCCMJTqGPsX1ylfqTdSqEz+93OcY0dFel8I+PKIOIINTUagaW8cvXydS
        b848hPKGLJSwl7r2NJfUPUaJBtjUGuRuXgqHaRRwgtvBREa9e1VXstSFVhJm4tAiZr2ALV
        VJigq77+9lzFaSGKuZ5tzRCk1UwFu0i0JOt4LTVvOBXjzL0L205hEruSK7rlr6LHLMHQ3e
        +K0N4AES/9u/MPCqw7dCcBu2zf75uVI7bC5hhmRkWdQfz2ewJi7y59X+d35r8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638537292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7gD/yRCj6iH5Z38Ok8ZKXwadPmr3m6EbXsHhsjZCA5Q=;
        b=DR2LOQ8ZcWrmiraBX0Eg8k0YiC9ITwzjvzcdEpUjFmeKwl1t+avEuPAxR4BvdiYe5VUiIz
        VLuDrcTcEIjQBQAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        brian.murray@canonical.com
Subject: Re: [PATCH] panic: Remove oops_id.
Message-ID: <20211203131451.j5zd42flgfyqoyxo@linutronix.de>
References: <20211202142713.ofadr43tawengfw4@linutronix.de>
 <20211202144308.70fd454883c1d1e643491471@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211202144308.70fd454883c1d1e643491471@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-02 14:43:08 [-0800], Andrew Morton wrote:
> On Thu, 2 Dec 2021 15:27:13 +0100 Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:
>=20
> > The oops id has been added as part of the end of trace marker for the
> > kerneloops.org project. The id is used to automatically identify duplic=
ate
> > submissions of the same report. Identical looking reports with different
> > a id can be considered as the same oops occurred again.
> >=20
> > The early initialisation of the oops_id can create a warning if the
> > random core is not yet fully initialized. On PREEMPT_RT it is
> > problematic if the id is initialized on demand from non preemptible
> > context.
>=20
> "problematic" isn't very useful :(
>=20
> What exactly goes wrong under -rt?

Sorry, I indeed forgot that part.
get_random_bytes() acquires crng_state::lock (spinlock_t) which is a
sleeping lock on PREEMPT_RT and can not be acquired in non-preemptible
context.

> > The kernel oops project is not available since 2017.
> > Remove the oops_id.
>=20
> (googles "linux oops_id")
>=20
> https://wiki.ubuntu.com/UbuntuWeeklyNewsletter/Issue565#What.2BIBk-s_the_=
OOPS_ID.3F
>=20
> Seems someone was using it in 2019.  My search was very brief.

The referenced blog entry is gone. So I can't tell what it is used for.
But I noticed whoopsie and added Brian on Cc. Brian, is the oops-id from
kernel backtrace (the numbers after "end trace") used for anything by
oopsie? The source of whoopsie has something named "oopsid" but it
appears to be something sent by the server as a response. So it could be
something different or kernel's oops-id parsed=E2=80=A6

> The world wouldn't end if we removed this.  But perhaps it would be better
> to replace the oops id with "0" to avoid breaking parsers.
>=20
> It's just a fairly unique number.  We could use anything.  Simply
> jiffies or ktime_get() would suffice?

I had a patch to get rid of the RT problem and avoid the
warn_unseeded_randomness() warning but then I was looking at it and
asking myself why keeping it=E2=80=A6
I definitely could replace it with ktime_get() or dig the old patch
fixing it and keeping the random id if there is the need for it.

After looking at it, maybe something like a fingerprint of the warning
would make sense. You could throw it into google and find reports which
might indicate the same warning as you currently having, say something
like:

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ea4fe192189d5..f4bbed25e4dd9 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -23,6 +23,8 @@
 #include <asm/stacktrace.h>
 #include <asm/unwind.h>
=20
+void report_fp_add(const char *s, int len);
+
 int panic_on_unrecovered_nmi;
 int panic_on_io_nmi;
 static int die_counter;
@@ -70,6 +72,14 @@ static void printk_stack_address(unsigned long address, =
int reliable,
 {
 	touch_nmi_watchdog();
 	printk("%s %s%pBb\n", log_lvl, reliable ? "" : "? ", (void *)address);
+	if (reliable) {
+		char buf[64];
+		int len;
+
+		len =3D snprintf(buf, sizeof(buf), "%ps", (void *)address);
+		len =3D min(len, sizeof(buf));
+		report_fp_add(buf, len);
+	}
 }
=20
 static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
diff --git a/init/main.c b/init/main.c
index bb984ed79de0e..70e2c0d6a9c94 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1495,6 +1495,7 @@ static int __ref kernel_init(void *unused)
 	 * Wait until kthreadd is all set-up.
 	 */
 	wait_for_completion(&kthreadd_done);
+	WARN_ON(1);
=20
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
@@ -1520,6 +1521,7 @@ static int __ref kernel_init(void *unused)
 	rcu_end_inkernel_boot();
=20
 	do_sysctl_args();
+	WARN_ON(1);
=20
 	if (ramdisk_execute_command) {
 		ret =3D run_init_process(ramdisk_execute_command);
@@ -1581,6 +1583,7 @@ static noinline void __init kernel_init_freeable(void)
 {
 	/* Now the scheduler is fully set up and can do blocking allocations */
 	gfp_allowed_mask =3D __GFP_BITS_MASK;
+	WARN_ON(1);
=20
 	/*
 	 * init can allocate pages on any node
@@ -1614,6 +1617,7 @@ static noinline void __init kernel_init_freeable(void)
 	wait_for_initramfs();
 	console_on_rootfs();
=20
+	WARN_ON(1);
 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
diff --git a/kernel/panic.c b/kernel/panic.c
index cefd7d82366fb..c6bd135815b0b 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -533,6 +533,20 @@ void oops_enter(void)
 		trigger_all_cpu_backtrace();
 }
=20
+#include <linux/jhash.h>
+
+static unsigned int fingerprint_state;
+
+static void fingerprint_state_init(void)
+{
+	fingerprint_state =3D 0;
+}
+
+void report_fp_add(const char *s, int len)
+{
+	fingerprint_state =3D jhash(s, len, fingerprint_state);
+}
+
 /*
  * 64-bit random ID for oopses:
  */
@@ -552,7 +566,8 @@ late_initcall(init_oops_id);
 static void print_oops_end_marker(void)
 {
 	init_oops_id();
-	pr_warn("---[ end trace %016llx ]---\n", (unsigned long long)oops_id);
+	pr_warn("---[ end trace %016llx fingerprint: %08x ]---\n",
+		(unsigned long long)oops_id, fingerprint_state);
 }
=20
 /*
@@ -574,6 +589,7 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
+	fingerprint_state_init();
 	disable_trace_on_warning();
=20
 	if (file)
--=20

produces four backtraces, two with the same fingerprint.

Adding fingerprint states to lockdep might be able to produce the same
fingerprint for the same report, e.g. same two variables reported in a
circular locking dependency.

Sebastian
