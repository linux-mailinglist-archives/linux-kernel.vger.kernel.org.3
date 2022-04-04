Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667114F1481
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 14:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiDDMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238662AbiDDMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 08:14:44 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EBB3DDC2;
        Mon,  4 Apr 2022 05:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649074349;
        bh=v21tH+u/8F6TEa8sT09Fxu0jyYY4D+sWP8+7wd/HBOw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gBFIptL8BOPJ5UEyChdBYa8cmdSim3YYZuKtmPs0GI0aO2oWaW4DNuCPxSI4jxy2g
         GkDhQHtzRlyJChRrzIB1EWbFdqJVeQVlASJz3Ni7/cupgpxghQUf9pgNezTzrvwS4e
         ATmSO+NmqPLXxpTZtkTk6Oiym8KNIqIEzOrpTiHo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.216.17]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Ma20k-1nXxvs3ZbA-00Vy2K; Mon, 04
 Apr 2022 14:12:28 +0200
Message-ID: <dacc7a27f5545714f1f9ab51510e7856d5118b88.camel@gmx.de>
Subject: Re: [PATCH] kasan: Fix sleeping function called from invalid
 context in PREEMPT_RT
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Zqiang <qiang1.zhang@intel.com>
Cc:     ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com, akpm@linux-foundation.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Mon, 04 Apr 2022 14:12:27 +0200
In-Reply-To: <YkbFhgN1jZPTMfnS@linutronix.de>
References: <20220401091006.2100058-1-qiang1.zhang@intel.com>
         <YkbFhgN1jZPTMfnS@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yDD/V6srw+dnsfO45M/ZKWZVHJafFapRqtE2OaaAX2pCN96K+vV
 0vRIAimIchv/3E0kjJ6JluuH/JWs9THUEvij7tCWIeqHvMI2m/P/F1O3L6RyafgGDswHzgY
 Fpp9Y3JDqbBrdh24/cKg1vJ+ynmgcOq5qK2HVVuIGPi2ZHPQOz/+5de1Ws7dD3Sobv9az8Q
 lBYuDXQoDmBFlpaBj3gYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jqVeMoJBa8M=:6VrjVN+reFOb2M3+bsb2Vr
 zw3JsbCCPcpj5plrSTD1u08IFanf95ogTmH5BnDnfuDwtLQt/752WNoOO7t0n+5Hp6RTuIxvI
 rlQmXLvaUTW3skTKpG1FfzP/NKZ+1m/tN+261ePv26XOZ3AT8r8Gy4hCr3wWQZT+Fo+RF8EjT
 GJ5Fzk48VSdRMOWC7NbtJUQ3TAFPO39W2OsRAsZKRPsqN1o1faZmjlaPZS3pg7dyKuhGjZNZa
 YpMp/U9n+jiy+7VsZuRJT/xfGq9vvWxvCU6R/8XlPaEOgNwh91Qxy+MQWumJH0s6AUdVgQfz3
 CXgSE61bbHlnGFR0JgddC89HP5oC2vIy6z+lRo80IZDlNCeGb7ReKXWZMwqbhnaQ32nxticch
 x7wgr3QgU6YnOm8UT9+UYrkjYUsAP6lFaYLf5SAF9bsMRoIWWWZ0c/EO8iAInzpt1GIojF6tS
 oyH/kTbyKgNnIGM/ijh2TAbt4c1gv9OnsKRbYoyODEUcIn+MyQY94eTnvnLy9aERprEm3QZ4w
 mzKhesiNSm6J6H1/KMERpKM/vnONnk/bpXShZvRbnr+lqaqcsR2lCsmweBk2sEHFFCHihAwnG
 Zva+5Y1E1QOGiHPDe7aescz5xbmegw/u38lzu8bta9mqd/V3cOX8Sd6AQDT1LSQ+X4x36noMr
 KQYLosWHvghA62nOP86EpA9hXFvESRg/Q9NW0T8OHU5ZS/96mfw8+HN62wHR05MdK18R2gpMZ
 gCM0loXqFuu7MYA1Y5fS83p2k7EIkbIgqD9t+I1WyLYgrBv72LvKgzyOjOVZjbm03eTyd1M82
 miElQL7PAbvU6i+5OD2Wym9JjgtzAq5TUAx7262qDGQk/aDTIzQ9cb0Gzib6oPnL9qsYLeh/1
 l8sblzdraT+uxle5ePQL4/SlbBFc8eC6qqNMf6HlRBgY03qJ4jIZhynoDDphOkMTKA57sZrAt
 3f3aNdbCMDhBFRKzYEk8t3lzcFnrULuuj3WVjOPP2C7fALqMZ9xVhgmyEUFzejXhiibMetopJ
 GxAEw9DKqskLanw/uIq7u0SZIOo+sqpLEQvMpV/3D/FSg0xPHkNMkmHNu7jeV7oMAFhMOhKIE
 QNX3FQYEmiW6AI=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-01 at 11:27 +0200, Sebastian Andrzej Siewior wrote:
> On 2022-04-01 17:10:06 [+0800], Zqiang wrote:
> > BUG: sleeping function called from invalid context at kernel/locking/s=
pinlock_rt.c:46
> > in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swappe=
r/0
> > preempt_count: 1, expected: 0
> > ...........
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.1-rt16-yocto-preempt-rt=
 #22
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
> > Call Trace:
> > <TASK>
> > dump_stack_lvl+0x60/0x8c
> > dump_stack+0x10/0x12
> > =C2=A0__might_resched.cold+0x13b/0x173
> > rt_spin_lock+0x5b/0xf0
> > =C2=A0___cache_free+0xa5/0x180
> > qlist_free_all+0x7a/0x160
> > per_cpu_remove_cache+0x5f/0x70
> > smp_call_function_many_cond+0x4c4/0x4f0
> > on_each_cpu_cond_mask+0x49/0xc0
> > kasan_quarantine_remove_cache+0x54/0xf0
> > kasan_cache_shrink+0x9/0x10
> > kmem_cache_shrink+0x13/0x20
> > acpi_os_purge_cache+0xe/0x20
> > acpi_purge_cached_objects+0x21/0x6d
> > acpi_initialize_objects+0x15/0x3b
> > acpi_init+0x130/0x5ba
> > do_one_initcall+0xe5/0x5b0
> > kernel_init_freeable+0x34f/0x3ad
> > kernel_init+0x1e/0x140
> > ret_from_fork+0x22/0x30
> >
> > When the kmem_cache_shrink() be called, the IPI was triggered, the
> > ___cache_free() is called in IPI interrupt context, the local lock
> > or spin lock will be acquired. on PREEMPT_RT kernel, these lock is
> > replaced with sleepbale rt spin lock, so the above problem is triggere=
d.
> > fix it by migrating the release action from the IPI interrupt context
> > to the task context on RT kernel.
>
> I haven't seen that while playing with kasan. Is this new?

Don't think so, the rock below was apparently first tossed at 5.12.

=2D--
 lib/stackdepot.c      |    3 +++
 mm/kasan/quarantine.c |   49 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
 2 files changed, 52 insertions(+)

=2D-- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -375,6 +375,9 @@ depot_stack_handle_t __stack_depot_save(
 	if (found)
 		goto exit;

+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && can_alloc && !preemptible())
+		can_alloc =3D false;
+
 	/*
 	 * Check if the current or the next stack slab need to be initialized.
 	 * If so, allocate the memory - we won't be able to do that under the
=2D-- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -19,6 +19,9 @@
 #include <linux/srcu.h>
 #include <linux/string.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
 #include <linux/cpuhotplug.h>

 #include "../slab.h"
@@ -319,6 +322,48 @@ static void per_cpu_remove_cache(void *a
 	qlist_free_all(&to_free, cache);
 }

+#ifdef CONFIG_PREEMPT_RT
+struct remove_cache_work {
+	struct work_struct work;
+	struct kmem_cache *cache;
+};
+
+static DEFINE_MUTEX(remove_caches_lock);
+static DEFINE_PER_CPU(struct remove_cache_work, remove_cache_work);
+
+static void per_cpu_remove_cache_work(struct work_struct *w)
+{
+	struct remove_cache_work *rcw;
+
+	rcw =3D container_of(w, struct remove_cache_work, work);
+	per_cpu_remove_cache(rcw->cache);
+}
+
+static void per_cpu_remove_caches_sync(struct kmem_cache *cache)
+{
+	struct remove_cache_work *rcw;
+	unsigned int cpu;
+
+	cpus_read_lock();
+	mutex_lock(&remove_caches_lock);
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		INIT_WORK(&rcw->work, per_cpu_remove_cache_work);
+		rcw->cache =3D cache;
+		schedule_work_on(cpu, &rcw->work);
+	}
+
+	for_each_online_cpu(cpu) {
+		rcw =3D &per_cpu(remove_cache_work, cpu);
+		flush_work(&rcw->work);
+	}
+
+	mutex_unlock(&remove_caches_lock);
+	cpus_read_unlock();
+}
+#endif
+
 /* Free all quarantined objects belonging to cache. */
 void kasan_quarantine_remove_cache(struct kmem_cache *cache)
 {
@@ -332,7 +377,11 @@ void kasan_quarantine_remove_cache(struc
 	 * achieves the first goal, while synchronize_srcu() achieves the
 	 * second.
 	 */
+#ifndef CONFIG_PREEMPT_RT
 	on_each_cpu(per_cpu_remove_cache, cache, 1);
+#else
+	per_cpu_remove_caches_sync(cache);
+#endif

 	raw_spin_lock_irqsave(&quarantine_lock, flags);
 	for (i =3D 0; i < QUARANTINE_BATCHES; i++) {

