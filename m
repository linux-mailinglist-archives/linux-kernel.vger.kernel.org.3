Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01261530B6B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiEWICb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 04:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiEWICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 04:02:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42713F66
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 01:02:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653292930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=E2Dcdp6GMOMdI+guitOP3+VWx9zFu3DbX8hPWVAkkws=;
        b=zcabAr5BdXL5tx7hLmQj1H9oJEx8kyAU0N17WAQyRTYCOgWES+BoJJE9jgVjoBnZAkLjUB
        R2voO/XR7TTjXAEVIVJIBQz5cpfxM/Los9JLPuGzW0nd0maz29Dnd8dnmbPti5GFik6I2n
        jd53r6hhpHracS7ichRUQRi+FDt43bIUexmRxxepSzEBE8YNr+cYVToKi+rhK63XBxyFhG
        Sn0ENBXDU3qNvQsM7IGYgvt6NRmAcTfIU7pur9seZc2OFpljJRDBDasAD595zfAfK3ZpUk
        c2UB9ISeG7nnfkdazTqoMijIgaZsPYGPvo13HdEIVv+8O28pY04r9dcRs8SWVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653292930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=E2Dcdp6GMOMdI+guitOP3+VWx9zFu3DbX8hPWVAkkws=;
        b=t0CsQhWhnaIZIg93zT9vwNv4gsLkM7eWOoz2kIaBMRfSaY/mI4gEXRU4e6AQEt4L1tq8Su
        VoUTnJWV+GBhgSBA==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] timers/core for 5.19-rc1
References: <165329267741.3801280.534077656528571075.tglx@xen13>
Message-ID: <165329268338.3801280.15015388773053623832.tglx@xen13>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date:   Mon, 23 May 2022 10:02:09 +0200 (CEST)
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

please pull the latest timers/core branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022=
-05-23

up to:  317f29c14d0c: timers: Provide a better debugobjects hint for delayed =
works


Updates for timers and timekeeping core code:

  - Expose CLOCK_TAI to instrumentation to aid with TSN debugging.

  - Ensure that the clockevent is stopped when there is no timer armed to
    avoid pointless wakeups.

  - Make the sched clock frequency handling and rounding consistent.

  - Provide a better debugobject hint for delayed works. The timer callback
    is always the same, which makes it difficult to identify the underlying
    work. Use the work function as a hint instead.

  - Move the timer specific sysctl code into the timer subsystem.

  - The usual set of improvements and cleanups

Thanks,

	tglx

------------------>
Anna-Maria Behnsen (3):
      timers: Fix warning condition in __run_timers()
      timers: Initialize base::next_expiry_recalc in timers_prepare_cpu()
      tracing/timer: Add missing argument documentation of trace points

Jakob Koschel (1):
      clockevents: Use dedicated list iterator variable

Kurt Kanzenbach (1):
      timekeeping: Introduce fast accessor to clock tai

Maciej W. Rozycki (3):
      time/sched_clock: Round the frequency reported to nearest rather than d=
own
      time/sched_clock: Use Hz as the unit for clock rate reporting below 4kHz
      time/sched_clock: Fix formatting of frequency reporting code

Nicholas Piggin (1):
      timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the =
tick is stopped

Stephen Boyd (1):
      timers: Provide a better debugobjects hint for delayed works

Thomas Gleixner (3):
      timers: Simplify calc_index()
      timekeeping: Annotate ktime_get_boot_fast_ns() with data_race()
      timekeeping: Consolidate fast timekeeper

Yury Norov (1):
      clocksource: Replace cpumask_weight() with cpumask_empty()

tangmeng (1):
      timers: Move timer sysctl into the timer code


 Documentation/core-api/timekeeping.rst |  1 +
 include/linux/timekeeping.h            |  1 +
 include/linux/timer.h                  |  8 ---
 include/trace/events/timer.h           |  5 +-
 kernel/sysctl.c                        | 11 ----
 kernel/time/clockevents.c              |  9 ++--
 kernel/time/clocksource.c              |  2 +-
 kernel/time/sched_clock.c              | 13 +++--
 kernel/time/tick-sched.c               | 12 ++++-
 kernel/time/timekeeping.c              | 39 ++++++++++----
 kernel/time/timer.c                    | 99 ++++++++++++++++++++++++++------=
--
 11 files changed, 134 insertions(+), 66 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/=
timekeeping.rst
index 729e24864fe7..22ec68f24421 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -132,6 +132,7 @@ Some additional variants exist for more specialized cases:
 .. c:function:: u64 ktime_get_mono_fast_ns( void )
 		u64 ktime_get_raw_fast_ns( void )
 		u64 ktime_get_boot_fast_ns( void )
+		u64 ktime_get_tai_fast_ns( void )
 		u64 ktime_get_real_fast_ns( void )
=20
 	These variants are safe to call from any context, including from
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 78a98bdff76d..fe1e467ba046 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -177,6 +177,7 @@ static inline u64 ktime_get_raw_ns(void)
 extern u64 ktime_get_mono_fast_ns(void);
 extern u64 ktime_get_raw_fast_ns(void);
 extern u64 ktime_get_boot_fast_ns(void);
+extern u64 ktime_get_tai_fast_ns(void);
 extern u64 ktime_get_real_fast_ns(void);
=20
 /*
diff --git a/include/linux/timer.h b/include/linux/timer.h
index fda13c9d1256..648f00105f58 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -196,14 +196,6 @@ extern void init_timers(void);
 struct hrtimer;
 extern enum hrtimer_restart it_real_fn(struct hrtimer *);
=20
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-struct ctl_table;
-
-extern unsigned int sysctl_timer_migration;
-int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos);
-#endif
-
 unsigned long __round_jiffies(unsigned long j, int cpu);
 unsigned long __round_jiffies_relative(unsigned long j, int cpu);
 unsigned long round_jiffies(unsigned long j);
diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index 6ad031c71be7..2e713a7d9aa3 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -48,6 +48,7 @@ DEFINE_EVENT(timer_class, timer_init,
  * timer_start - called when the timer is started
  * @timer:	pointer to struct timer_list
  * @expires:	the timers expiry time
+ * @flags:	the timers flags
  */
 TRACE_EVENT(timer_start,
=20
@@ -84,6 +85,7 @@ TRACE_EVENT(timer_start,
 /**
  * timer_expire_entry - called immediately before the timer callback
  * @timer:	pointer to struct timer_list
+ * @baseclk:	value of timer_base::clk when timer expires
  *
  * Allows to determine the timer latency.
  */
@@ -190,7 +192,8 @@ TRACE_EVENT(hrtimer_init,
=20
 /**
  * hrtimer_start - called when the hrtimer is started
- * @hrtimer: pointer to struct hrtimer
+ * @hrtimer:	pointer to struct hrtimer
+ * @mode:	the hrtimers mode
  */
 TRACE_EVENT(hrtimer_start,
=20
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 830aaf8ca08e..5b7b1a82ae6a 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2288,17 +2288,6 @@ static struct ctl_table kern_table[] =3D {
 		.extra1		=3D SYSCTL_ZERO,
 		.extra2		=3D SYSCTL_ONE,
 	},
-#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
-	{
-		.procname	=3D "timer_migration",
-		.data		=3D &sysctl_timer_migration,
-		.maxlen		=3D sizeof(unsigned int),
-		.mode		=3D 0644,
-		.proc_handler	=3D timer_migration_handler,
-		.extra1		=3D SYSCTL_ZERO,
-		.extra2		=3D SYSCTL_ONE,
-	},
-#endif
 #ifdef CONFIG_BPF_SYSCALL
 	{
 		.procname	=3D "unprivileged_bpf_disabled",
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 003ccf338d20..5d85014d59b5 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -690,7 +690,7 @@ static ssize_t unbind_device_store(struct device *dev,
 {
 	char name[CS_NAME_LEN];
 	ssize_t ret =3D sysfs_get_uname(buf, name, count);
-	struct clock_event_device *ce;
+	struct clock_event_device *ce =3D NULL, *iter;
=20
 	if (ret < 0)
 		return ret;
@@ -698,9 +698,10 @@ static ssize_t unbind_device_store(struct device *dev,
 	ret =3D -ENODEV;
 	mutex_lock(&clockevents_mutex);
 	raw_spin_lock_irq(&clockevents_lock);
-	list_for_each_entry(ce, &clockevent_devices, list) {
-		if (!strcmp(ce->name, name)) {
-			ret =3D __clockevents_try_unbind(ce, dev->id);
+	list_for_each_entry(iter, &clockevent_devices, list) {
+		if (!strcmp(iter->name, name)) {
+			ret =3D __clockevents_try_unbind(iter, dev->id);
+			ce =3D iter;
 			break;
 		}
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 95d7ca35bdf2..cee5da1e54c4 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -343,7 +343,7 @@ void clocksource_verify_percpu(struct clocksource *cs)
 	cpus_read_lock();
 	preempt_disable();
 	clocksource_verify_choose_cpus();
-	if (cpumask_weight(&cpus_chosen) =3D=3D 0) {
+	if (cpumask_empty(&cpus_chosen)) {
 		preempt_enable();
 		cpus_read_unlock();
 		pr_warn("Not enough CPUs to check clocksource '%s'.\n", cs->name);
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index b1b9b12899f5..8464c5acc913 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -8,6 +8,7 @@
 #include <linux/jiffies.h>
 #include <linux/ktime.h>
 #include <linux/kernel.h>
+#include <linux/math.h>
 #include <linux/moduleparam.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
@@ -199,15 +200,13 @@ sched_clock_register(u64 (*read)(void), int bits, unsig=
ned long rate)
=20
 	r =3D rate;
 	if (r >=3D 4000000) {
-		r /=3D 1000000;
+		r =3D DIV_ROUND_CLOSEST(r, 1000000);
 		r_unit =3D 'M';
+	} else if (r >=3D 4000) {
+		r =3D DIV_ROUND_CLOSEST(r, 1000);
+		r_unit =3D 'k';
 	} else {
-		if (r >=3D 1000) {
-			r /=3D 1000;
-			r_unit =3D 'k';
-		} else {
-			r_unit =3D ' ';
-		}
+		r_unit =3D ' ';
 	}
=20
 	/* Calculate the ns resolution of this counter */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 2d76c91b85de..b1b105db31eb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -928,6 +928,8 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, in=
t cpu)
 	if (unlikely(expires =3D=3D KTIME_MAX)) {
 		if (ts->nohz_mode =3D=3D NOHZ_MODE_HIGHRES)
 			hrtimer_cancel(&ts->sched_timer);
+		else
+			tick_program_event(KTIME_MAX, 1);
 		return;
 	}
=20
@@ -1364,9 +1366,15 @@ static void tick_nohz_handler(struct clock_event_devic=
e *dev)
 	tick_sched_do_timer(ts, now);
 	tick_sched_handle(ts, regs);
=20
-	/* No need to reprogram if we are running tickless  */
-	if (unlikely(ts->tick_stopped))
+	if (unlikely(ts->tick_stopped)) {
+		/*
+		 * The clockevent device is not reprogrammed, so change the
+		 * clock event device to ONESHOT_STOPPED to avoid spurious
+		 * interrupts on devices which might not be truly one shot.
+		 */
+		tick_program_event(KTIME_MAX, 1);
 		return;
+	}
=20
 	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
 	tick_program_event(hrtimer_get_expires(&ts->sched_timer), 1);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index dcdcb85121e4..8895ff20f82d 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -429,6 +429,14 @@ static void update_fast_timekeeper(const struct tk_read_=
base *tkr,
 	memcpy(base + 1, base, sizeof(*base));
 }
=20
+static __always_inline u64 fast_tk_get_delta_ns(struct tk_read_base *tkr)
+{
+	u64 delta, cycles =3D tk_clock_read(tkr);
+
+	delta =3D clocksource_delta(cycles, tkr->cycle_last, tkr->mask);
+	return timekeeping_delta_to_ns(tkr, delta);
+}
+
 static __always_inline u64 __ktime_get_fast_ns(struct tk_fast *tkf)
 {
 	struct tk_read_base *tkr;
@@ -439,12 +447,7 @@ static __always_inline u64 __ktime_get_fast_ns(struct tk=
_fast *tkf)
 		seq =3D raw_read_seqcount_latch(&tkf->seq);
 		tkr =3D tkf->base + (seq & 0x01);
 		now =3D ktime_to_ns(tkr->base);
-
-		now +=3D timekeeping_delta_to_ns(tkr,
-				clocksource_delta(
-					tk_clock_read(tkr),
-					tkr->cycle_last,
-					tkr->mask));
+		now +=3D fast_tk_get_delta_ns(tkr);
 	} while (read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	return now;
@@ -528,10 +531,27 @@ u64 notrace ktime_get_boot_fast_ns(void)
 {
 	struct timekeeper *tk =3D &tk_core.timekeeper;
=20
-	return (ktime_get_mono_fast_ns() + ktime_to_ns(tk->offs_boot));
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_boot)));
 }
 EXPORT_SYMBOL_GPL(ktime_get_boot_fast_ns);
=20
+/**
+ * ktime_get_tai_fast_ns - NMI safe and fast access to tai clock.
+ *
+ * The same limitations as described for ktime_get_boot_fast_ns() apply. The
+ * mono time and the TAI offset are not read atomically which may yield wrong
+ * readouts. However, an update of the TAI offset is an rare event e.g., cau=
sed
+ * by settime or adjtimex with an offset. The user of this function has to d=
eal
+ * with the possibility of wrong timestamps in post processing.
+ */
+u64 notrace ktime_get_tai_fast_ns(void)
+{
+	struct timekeeper *tk =3D &tk_core.timekeeper;
+
+	return (ktime_get_mono_fast_ns() + ktime_to_ns(data_race(tk->offs_tai)));
+}
+EXPORT_SYMBOL_GPL(ktime_get_tai_fast_ns);
+
 static __always_inline u64 __ktime_get_real_fast(struct tk_fast *tkf, u64 *m=
ono)
 {
 	struct tk_read_base *tkr;
@@ -543,10 +563,7 @@ static __always_inline u64 __ktime_get_real_fast(struct =
tk_fast *tkf, u64 *mono)
 		tkr =3D tkf->base + (seq & 0x01);
 		basem =3D ktime_to_ns(tkr->base);
 		baser =3D ktime_to_ns(tkr->base_real);
-
-		delta =3D timekeeping_delta_to_ns(tkr,
-				clocksource_delta(tk_clock_read(tkr),
-				tkr->cycle_last, tkr->mask));
+		delta =3D fast_tk_get_delta_ns(tkr);
 	} while (read_seqcount_latch_retry(&tkf->seq, seq));
=20
 	if (mono)
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 85f1021ad459..a0666d948147 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -44,6 +44,7 @@
 #include <linux/slab.h>
 #include <linux/compat.h>
 #include <linux/random.h>
+#include <linux/sysctl.h>
=20
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -223,7 +224,7 @@ static void timer_update_keys(struct work_struct *work);
 static DECLARE_WORK(timer_update_work, timer_update_keys);
=20
 #ifdef CONFIG_SMP
-unsigned int sysctl_timer_migration =3D 1;
+static unsigned int sysctl_timer_migration =3D 1;
=20
 DEFINE_STATIC_KEY_FALSE(timers_migration_enabled);
=20
@@ -234,7 +235,42 @@ static void timers_update_migration(void)
 	else
 		static_branch_disable(&timers_migration_enabled);
 }
-#else
+
+#ifdef CONFIG_SYSCTL
+static int timer_migration_handler(struct ctl_table *table, int write,
+			    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	mutex_lock(&timer_keys_mutex);
+	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (!ret && write)
+		timers_update_migration();
+	mutex_unlock(&timer_keys_mutex);
+	return ret;
+}
+
+static struct ctl_table timer_sysctl[] =3D {
+	{
+		.procname	=3D "timer_migration",
+		.data		=3D &sysctl_timer_migration,
+		.maxlen		=3D sizeof(unsigned int),
+		.mode		=3D 0644,
+		.proc_handler	=3D timer_migration_handler,
+		.extra1		=3D SYSCTL_ZERO,
+		.extra2		=3D SYSCTL_ONE,
+	},
+	{}
+};
+
+static int __init timer_sysctl_init(void)
+{
+	register_sysctl("kernel", timer_sysctl);
+	return 0;
+}
+device_initcall(timer_sysctl_init);
+#endif /* CONFIG_SYSCTL */
+#else /* CONFIG_SMP */
 static inline void timers_update_migration(void) { }
 #endif /* !CONFIG_SMP */
=20
@@ -251,19 +287,6 @@ void timers_update_nohz(void)
 	schedule_work(&timer_update_work);
 }
=20
-int timer_migration_handler(struct ctl_table *table, int write,
-			    void *buffer, size_t *lenp, loff_t *ppos)
-{
-	int ret;
-
-	mutex_lock(&timer_keys_mutex);
-	ret =3D proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (!ret && write)
-		timers_update_migration();
-	mutex_unlock(&timer_keys_mutex);
-	return ret;
-}
-
 static inline bool is_timers_nohz_active(void)
 {
 	return static_branch_unlikely(&timers_nohz_active);
@@ -502,7 +525,7 @@ static inline unsigned calc_index(unsigned long expires, =
unsigned lvl,
 	 *
 	 * Round up with level granularity to prevent this.
 	 */
-	expires =3D (expires + LVL_GRAN(lvl)) >> LVL_SHIFT(lvl);
+	expires =3D (expires >> LVL_SHIFT(lvl)) + 1;
 	*bucket_expiry =3D expires << LVL_SHIFT(lvl);
 	return LVL_OFFS(lvl) + (expires & LVL_MASK);
 }
@@ -615,9 +638,39 @@ static void internal_add_timer(struct timer_base *base, =
struct timer_list *timer
=20
 static const struct debug_obj_descr timer_debug_descr;
=20
+struct timer_hint {
+	void	(*function)(struct timer_list *t);
+	long	offset;
+};
+
+#define TIMER_HINT(fn, container, timr, hintfn)			\
+	{							\
+		.function =3D fn,					\
+		.offset	  =3D offsetof(container, hintfn) -	\
+			    offsetof(container, timr)		\
+	}
+
+static const struct timer_hint timer_hints[] =3D {
+	TIMER_HINT(delayed_work_timer_fn,
+		   struct delayed_work, timer, work.func),
+	TIMER_HINT(kthread_delayed_work_timer_fn,
+		   struct kthread_delayed_work, timer, work.func),
+};
+
 static void *timer_debug_hint(void *addr)
 {
-	return ((struct timer_list *) addr)->function;
+	struct timer_list *timer =3D addr;
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(timer_hints); i++) {
+		if (timer_hints[i].function =3D=3D timer->function) {
+			void (**fn)(void) =3D addr + timer_hints[i].offset;
+
+			return *fn;
+		}
+	}
+
+	return timer->function;
 }
=20
 static bool timer_is_static_object(void *addr)
@@ -1722,11 +1775,14 @@ static inline void __run_timers(struct timer_base *ba=
se)
 	       time_after_eq(jiffies, base->next_expiry)) {
 		levels =3D collect_expired_timers(base, heads);
 		/*
-		 * The only possible reason for not finding any expired
-		 * timer at this clk is that all matching timers have been
-		 * dequeued.
+		 * The two possible reasons for not finding any expired
+		 * timer at this clk are that all matching timers have been
+		 * dequeued or no timer has been queued since
+		 * base::next_expiry was set to base::clk +
+		 * NEXT_TIMER_MAX_DELTA.
 		 */
-		WARN_ON_ONCE(!levels && !base->next_expiry_recalc);
+		WARN_ON_ONCE(!levels && !base->next_expiry_recalc
+			     && base->timers_pending);
 		base->clk++;
 		base->next_expiry =3D __next_timer_interrupt(base);
=20
@@ -1950,6 +2006,7 @@ int timers_prepare_cpu(unsigned int cpu)
 		base =3D per_cpu_ptr(&timer_bases[b], cpu);
 		base->clk =3D jiffies;
 		base->next_expiry =3D base->clk + NEXT_TIMER_MAX_DELTA;
+		base->next_expiry_recalc =3D false;
 		base->timers_pending =3D false;
 		base->is_idle =3D false;
 	}

