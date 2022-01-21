Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8066F49650F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 19:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382104AbiAUSbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 13:31:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351379AbiAUSbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 13:31:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C149CC06173B;
        Fri, 21 Jan 2022 10:30:59 -0800 (PST)
Date:   Fri, 21 Jan 2022 19:30:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642789857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RGb5PAlG03cK5bw7bemykzwplQPNvycd8MM7tJme+Fw=;
        b=SqK1Eh284Dm/BnQQ29UHCuaUfkQpe/dxb7YD7uyOiWPPtdVEn6W3vRpCBgB+KDe6Q4xXUE
        wEqLCC9OrMfuR1WL4gjux5MbztsdlBpasltPaDnzMOcJmVLN6Nw8Tfh3cLZ5FX7deGJPqc
        xtBXLx9otKYIrnP9tC+EF1cblGhSpeP/TDgwpX6/h0JWg7pQK/qwg27+L1vwywWkyoS1S/
        ldr5ZK7C85sKQr07+QDk+dFXZTh7sZHt+Ks8kpdixWpPQ1KTT1qemKJ8qRrHXcJ46LTr0F
        M9ceTipCNXp/jAwWxoUv0KLI2ZsU7YAu2YSA/iiqmXHslGt6wo5t3cqPDH95Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642789857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RGb5PAlG03cK5bw7bemykzwplQPNvycd8MM7tJme+Fw=;
        b=G8LywykJ0v7Q2hE2spzrby0J254d3HYB8Svjctz1Ukxbn8i+8JB2nv8LA7PS75tkGjWFXh
        L5GotdBoksDS0IAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v5.16.2-rt19
Message-ID: <Yer73zjSLXFooB1+@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v5.16.2-rt19 patch set. 

Changes since v5.16.2-rt18:

  - Update the printk series. Patches by John Ogness.

  - Redo the i2c patches introduced in the previous release to address
    other driver which look also broken.

Known issues
     - netconsole triggers WARN.

     - Valentin Schneider reported a few splats on ARM64, see
          https://lkml.kernel.org/r/20210810134127.1394269-1-valentin.schneider@arm.com

The delta patch against v5.16.2-rt18 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/incr/patch-5.16.2-rt18-rt19.patch.xz

You can get this release via the git tree at:

    git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v5.16.2-rt19

The RT patch against v5.16.2 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patch-5.16.2-rt19.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/5.16/older/patches-5.16.2-rt19.tar.xz

Sebastian

diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
index bcf3222301c5e..cde5b6d8bac5d 100644
--- a/arch/arm/kernel/smp.c
+++ b/arch/arm/kernel/smp.c
@@ -676,7 +676,9 @@ static void do_handle_IPI(int ipinr)
 		break;
 
 	case IPI_CPU_BACKTRACE:
+		printk_deferred_enter();
 		nmi_cpu_backtrace(get_irq_regs());
+		printk_deferred_exit();
 		break;
 
 	default:
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 3d3c9ba50f442..007332a4a7325 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -62,7 +62,6 @@ struct smp_ops_t {
 
 extern int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
 extern int smp_send_safe_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us);
-extern void smp_send_debugger_break_cpu(unsigned int cpu);
 extern void smp_send_debugger_break(void);
 extern void start_secondary_resume(void);
 extern void smp_generic_give_timebase(void);
diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
index d57d374978627..bdee7262c080a 100644
--- a/arch/powerpc/kernel/kgdb.c
+++ b/arch/powerpc/kernel/kgdb.c
@@ -120,19 +120,11 @@ int kgdb_skipexception(int exception, struct pt_regs *regs)
 
 static int kgdb_debugger_ipi(struct pt_regs *regs)
 {
-	int cpu = raw_smp_processor_id();
-
-	if (!kgdb_roundup_delay(cpu))
-		kgdb_nmicallback(cpu, regs);
+	kgdb_nmicallback(raw_smp_processor_id(), regs);
 	return 0;
 }
 
 #ifdef CONFIG_SMP
-void kgdb_roundup_cpu(unsigned int cpu)
-{
-	smp_send_debugger_break_cpu(cpu);
-}
-
 void kgdb_roundup_cpus(void)
 {
 	smp_send_debugger_break();
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4ebf21908237c..c23ee842c4c33 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -589,11 +589,6 @@ static void debugger_ipi_callback(struct pt_regs *regs)
 	debugger_ipi(regs);
 }
 
-void smp_send_debugger_break_cpu(unsigned int cpu)
-{
-	smp_send_nmi_ipi(cpu, debugger_ipi_callback, 1000000);
-}
-
 void smp_send_debugger_break(void)
 {
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, debugger_ipi_callback, 1000000);
diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
index d5359701f787f..22ceeeb705abd 100644
--- a/arch/powerpc/kexec/crash.c
+++ b/arch/powerpc/kexec/crash.c
@@ -312,6 +312,9 @@ void default_machine_crash_shutdown(struct pt_regs *regs)
 	unsigned int i;
 	int (*old_handler)(struct pt_regs *regs);
 
+	/* Avoid hardlocking with irresponsive CPU holding logbuf_lock */
+	printk_deferred_enter();
+
 	/*
 	 * This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
diff --git a/arch/x86/kernel/dumpstack_32.c b/arch/x86/kernel/dumpstack_32.c
index 82cc3a7be6bd2..722fd712e1cf0 100644
--- a/arch/x86/kernel/dumpstack_32.c
+++ b/arch/x86/kernel/dumpstack_32.c
@@ -141,7 +141,7 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	 */
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
-			pr_warn_once("WARNING: stack recursion on stack type %d\n", info->type);
+			printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/dumpstack_64.c b/arch/x86/kernel/dumpstack_64.c
index 5f725b0ceb297..6c5defd6569a3 100644
--- a/arch/x86/kernel/dumpstack_64.c
+++ b/arch/x86/kernel/dumpstack_64.c
@@ -207,8 +207,7 @@ int get_stack_info(unsigned long *stack, struct task_struct *task,
 	if (visit_mask) {
 		if (*visit_mask & (1UL << info->type)) {
 			if (task == current)
-				pr_warn_once("WARNING: stack recursion on stack type %d\n",
-					     info->type);
+				printk_deferred_once(KERN_WARNING "WARNING: stack recursion on stack type %d\n", info->type);
 			goto unknown;
 		}
 		*visit_mask |= 1UL << info->type;
diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 52af9a89ad478..15aefa3f3e18e 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -207,7 +207,8 @@ static void mask_and_ack_8259A(struct irq_data *data)
 		 * lets ACK and report it. [once per IRQ]
 		 */
 		if (!(spurious_irq_mask & irqmask)) {
-			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
+			printk_deferred(KERN_DEBUG
+			       "spurious 8259A interrupt: IRQ%d.\n", irq);
 			spurious_irq_mask |= irqmask;
 		}
 		atomic_inc(&irq_err_count);
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 37bd37cdf2b60..3a43a2dee6581 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -502,12 +502,9 @@ static int kgdb_nmi_handler(unsigned int cmd, struct pt_regs *regs)
 		if (atomic_read(&kgdb_active) != -1) {
 			/* KGDB CPU roundup */
 			cpu = raw_smp_processor_id();
-
-			if (!kgdb_roundup_delay(cpu)) {
-				kgdb_nmicallback(cpu, regs);
-				set_bit(cpu, was_in_debug_nmi);
-				touch_nmi_watchdog();
-			}
+			kgdb_nmicallback(cpu, regs);
+			set_bit(cpu, was_in_debug_nmi);
+			touch_nmi_watchdog();
 
 			return NMI_HANDLED;
 		}
diff --git a/arch/x86/kernel/unwind_frame.c b/arch/x86/kernel/unwind_frame.c
index 06080d9546e53..8e1c50c86e5db 100644
--- a/arch/x86/kernel/unwind_frame.c
+++ b/arch/x86/kernel/unwind_frame.c
@@ -41,9 +41,9 @@ static void unwind_dump(struct unwind_state *state)
 
 	dumped_before = true;
 
-	printk("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
-	       state->stack_info.type, state->stack_info.next_sp,
-	       state->stack_mask, state->graph_idx);
+	printk_deferred("unwind stack type:%d next_sp:%p mask:0x%lx graph_idx:%d\n",
+			state->stack_info.type, state->stack_info.next_sp,
+			state->stack_mask, state->graph_idx);
 
 	for (sp = PTR_ALIGN(state->orig_sp, sizeof(long)); sp;
 	     sp = PTR_ALIGN(stack_info.next_sp, sizeof(long))) {
@@ -59,11 +59,13 @@ static void unwind_dump(struct unwind_state *state)
 
 			if (zero) {
 				if (!prev_zero)
-					printk("%p: %0*x ...\n", sp, BITS_PER_LONG/4, 0);
+					printk_deferred("%p: %0*x ...\n",
+							sp, BITS_PER_LONG/4, 0);
 				continue;
 			}
 
-			printk("%p: %0*lx (%pB)\n", sp, BITS_PER_LONG/4, word, (void *)word);
+			printk_deferred("%p: %0*lx (%pB)\n",
+					sp, BITS_PER_LONG/4, word, (void *)word);
 		}
 	}
 }
@@ -339,13 +341,13 @@ bool unwind_next_frame(struct unwind_state *state)
 		goto the_end;
 
 	if (state->regs) {
-		pr_warn_once(
+		printk_deferred_once(KERN_WARNING
 			"WARNING: kernel stack regs at %p in %s:%d has bad 'bp' value %p\n",
 			state->regs, state->task->comm,
 			state->task->pid, next_bp);
 		unwind_dump(state);
 	} else {
-		pr_warn_once(
+		printk_deferred_once(KERN_WARNING
 			"WARNING: kernel stack frame pointer at %p in %s:%d has bad value %p\n",
 			state->bp, state->task->comm,
 			state->task->pid, next_bp);
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 9cf5bd20e48af..2de3c8c5eba9f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -9,7 +9,7 @@
 #include <asm/orc_lookup.h>
 
 #define orc_warn(fmt, ...) \
-	pr_warn_once("WARNING: " fmt, ##__VA_ARGS__)
+	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
 
 #define orc_warn_current(args...)					\
 ({									\
diff --git a/drivers/char/random.c b/drivers/char/random.c
index d15f58be924e0..4b93ca6ecef94 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1566,8 +1566,9 @@ static void _warn_unseeded_randomness(const char *func_name, void *caller,
 	print_once = true;
 #endif
 	if (__ratelimit(&unseeded_warning))
-		pr_notice("random: %s called from %pS with crng_init=%d\n",
-			  func_name, caller, crng_init);
+		printk_deferred(KERN_NOTICE "random: %s called from %pS "
+				"with crng_init=%d\n", func_name, caller,
+				crng_init);
 }
 
 /*
diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 1cf68f85b2e11..8ccf0c928bb44 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -99,15 +99,8 @@ static irqreturn_t cht_wc_i2c_adap_thread_handler(int id, void *data)
 	 * interrupt handler as well, so running the client irq handler from
 	 * this thread will cause things to lock up.
 	 */
-	if (reg & CHT_WC_EXTCHGRIRQ_CLIENT_IRQ) {
-		/*
-		 * generic_handle_irq expects local IRQs to be disabled
-		 * as normally it is called from interrupt context.
-		 */
-		local_irq_disable();
-		generic_handle_irq(adap->client_irq);
-		local_irq_enable();
-	}
+	if (reg & CHT_WC_EXTCHGRIRQ_CLIENT_IRQ)
+		generic_handle_irq_safe(adap->client_irq);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
index 37e7bf4c14cea..fc13511f4562c 100644
--- a/drivers/i2c/busses/i2c-rcar.c
+++ b/drivers/i2c/busses/i2c-rcar.c
@@ -1025,6 +1025,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	struct rcar_i2c_priv *priv;
 	struct i2c_adapter *adap;
 	struct device *dev = &pdev->dev;
+	unsigned long irqflags = 0;
 	irqreturn_t (*irqhandler)(int irq, void *ptr) = rcar_i2c_gen3_irq;
 	int ret;
 
@@ -1075,6 +1076,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	rcar_i2c_write(priv, ICSAR, 0); /* Gen2: must be 0 if not using slave */
 
 	if (priv->devtype < I2C_RCAR_GEN3) {
+		irqflags |= IRQF_NO_THREAD;
 		irqhandler = rcar_i2c_gen2_irq;
 	}
 
@@ -1100,7 +1102,7 @@ static int rcar_i2c_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto out_pm_disable;
 	priv->irq = ret;
-	ret = devm_request_irq(dev, priv->irq, irqhandler, 0, dev_name(dev), priv);
+	ret = devm_request_irq(dev, priv->irq, irqhandler, irqflags, dev_name(dev), priv);
 	if (ret < 0) {
 		dev_err(dev, "cannot get irq %d\n", priv->irq);
 		goto out_pm_disable;
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 30e93651d5b6b..698f3e928fcf7 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -1423,10 +1423,7 @@ int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr)
 	if (irq <= 0)
 		return -ENXIO;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		generic_handle_irq(irq);
-	else
-		handle_nested_irq(irq);
+	generic_handle_irq_safe(irq);
 
 	return 0;
 }
diff --git a/drivers/mfd/ezx-pcap.c b/drivers/mfd/ezx-pcap.c
index 70fa18b04ad2b..b14d3f98e1ebd 100644
--- a/drivers/mfd/ezx-pcap.c
+++ b/drivers/mfd/ezx-pcap.c
@@ -193,13 +193,11 @@ static void pcap_isr_work(struct work_struct *work)
 		ezx_pcap_write(pcap, PCAP_REG_MSR, isr | msr);
 		ezx_pcap_write(pcap, PCAP_REG_ISR, isr);
 
-		local_irq_disable();
 		service = isr & ~msr;
 		for (irq = pcap->irq_base; service; service >>= 1, irq++) {
 			if (service & 1)
-				generic_handle_irq(irq);
+				generic_handle_irq_safe(irq);
 		}
-		local_irq_enable();
 		ezx_pcap_write(pcap, PCAP_REG_MSR, pcap->msr);
 	} while (gpio_get_value(pdata->gpio));
 }
diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 1c763796cf1fa..caa3de37698b0 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -117,8 +117,8 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *__priv)
 			 * If both powerkey down and up IRQs are received,
 			 * handle them at the right order
 			 */
-			generic_handle_irq(priv->irqs[POWERKEY_DOWN]);
-			generic_handle_irq(priv->irqs[POWERKEY_UP]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_DOWN]);
+			generic_handle_irq_safe(priv->irqs[POWERKEY_UP]);
 			pending &= ~HISI_IRQ_POWERKEY_UP_DOWN;
 		}
 
@@ -126,7 +126,7 @@ static irqreturn_t hi6421v600_irq_handler(int irq, void *__priv)
 			continue;
 
 		for_each_set_bit(offset, &pending, BITS_PER_BYTE) {
-			generic_handle_irq(priv->irqs[offset + i * BITS_PER_BYTE]);
+			generic_handle_irq_safe(priv->irqs[offset + i * BITS_PER_BYTE]);
 		}
 	}
 
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 075f8abde5cd7..6cf28f6881906 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1367,11 +1367,8 @@ static void lan78xx_status(struct lan78xx_net *dev, struct urb *urb)
 		netif_dbg(dev, link, dev->net, "PHY INTR: 0x%08x\n", intdata);
 		lan78xx_defer_kevent(dev, EVENT_LINK_RESET);
 
-		if (dev->domain_data.phyirq > 0) {
-			local_irq_disable();
-			generic_handle_irq(dev->domain_data.phyirq);
-			local_irq_enable();
-		}
+		if (dev->domain_data.phyirq > 0)
+			generic_handle_irq_safe(dev->domain_data.phyirq);
 	} else {
 		netdev_warn(dev->net,
 			    "unexpected interrupt: 0x%08x\n", intdata);
diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
index 7e6347fe93f99..8a7cf1d0e9688 100644
--- a/drivers/staging/greybus/gpio.c
+++ b/drivers/staging/greybus/gpio.c
@@ -391,10 +391,7 @@ static int gb_gpio_request_handler(struct gb_operation *op)
 		return -EINVAL;
 	}
 
-	local_irq_disable();
-	ret = generic_handle_irq(irq);
-	local_irq_enable();
-
+	ret = generic_handle_irq_safe(irq);
 	if (ret)
 		dev_err(dev, "failed to invoke irq handler\n");
 
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 2321d02e9b7a9..7b1a88934d6ff 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -142,12 +142,12 @@ static inline void serial8250_set_IER(struct uart_8250_port *up,
 	is_console = uart_console(port);
 
 	if (is_console)
-		console_atomic_lock(flags);
+		printk_cpu_sync_get_irqsave(flags);
 
 	serial_out(up, UART_IER, ier);
 
 	if (is_console)
-		console_atomic_unlock(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 }
 
 static inline unsigned char serial8250_clear_IER(struct uart_8250_port *up)
@@ -164,13 +164,13 @@ static inline unsigned char serial8250_clear_IER(struct uart_8250_port *up)
 		clearval = UART_IER_UUE;
 
 	if (is_console)
-		console_atomic_lock(flags);
+		printk_cpu_sync_get_irqsave(flags);
 
 	prior = serial_port_in(port, UART_IER);
 	serial_port_out(port, UART_IER, clearval);
 
 	if (is_console)
-		console_atomic_unlock(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 
 	return prior;
 }
diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index ea06cb67cf58f..d9b651290e1c7 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -63,10 +63,10 @@ int fsl8250_handle_irq(struct uart_port *port)
 		is_console = uart_console(port);
 
 		if (is_console)
-			console_atomic_lock(flags);
+			printk_cpu_sync_get_irqsave(flags);
 		up->ier = port->serial_in(port, UART_IER);
 		if (is_console)
-			console_atomic_unlock(flags);
+			printk_cpu_sync_put_irqrestore(flags);
 
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
index 8122645ab05c9..061d8e4072c65 100644
--- a/drivers/tty/serial/8250/8250_ingenic.c
+++ b/drivers/tty/serial/8250/8250_ingenic.c
@@ -171,10 +171,10 @@ static void ingenic_uart_serial_out(struct uart_port *p, int offset, int value)
 		 */
 		is_console = uart_console(p);
 		if (is_console)
-			console_atomic_lock(flags);
+			printk_cpu_sync_get_irqsave(flags);
 		ier = p->serial_in(p, UART_IER);
 		if (is_console)
-			console_atomic_unlock(flags);
+			printk_cpu_sync_put_irqrestore(flags);
 
 		if (ier & UART_IER_MSI)
 			value |= UART_MCR_MDCE | UART_MCR_FCM;
diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 9af18b5d8296f..e5032e5abd8ea 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -226,13 +226,13 @@ static void mtk8250_disable_intrs(struct uart_8250_port *up, int mask)
 	is_console = uart_console(port);
 
 	if (is_console)
-		console_atomic_lock(flags);
+		printk_cpu_sync_get_irqsave(flags);
 
 	ier = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, ier & (~mask));
 
 	if (is_console)
-		console_atomic_unlock(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 }
 
 static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
@@ -242,13 +242,13 @@ static void mtk8250_enable_intrs(struct uart_8250_port *up, int mask)
 	unsigned int ier;
 
 	if (uart_console(port))
-		console_atomic_lock(flags);
+		printk_cpu_sync_get_irqsave(flags);
 
 	ier = serial_in(up, UART_IER);
 	serial_out(up, UART_IER, ier | mask);
 
 	if (uart_console(port))
-		console_atomic_unlock(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 }
 
 static void mtk8250_set_flow_ctrl(struct uart_8250_port *up, int mode)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index e57282bad6ea1..49883a0a58a5b 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -3304,9 +3304,9 @@ static void serial8250_console_putchar(struct uart_port *port, int ch)
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 
-	console_atomic_lock(flags);
+	printk_cpu_sync_get_irqsave(flags);
 	serial8250_console_putchar_locked(port, ch);
-	console_atomic_unlock(flags);
+	printk_cpu_sync_put_irqrestore(flags);
 }
 
 /*
@@ -3337,7 +3337,7 @@ void serial8250_console_write_atomic(struct uart_8250_port *up,
 	unsigned long flags;
 	unsigned int ier;
 
-	console_atomic_lock(flags);
+	printk_cpu_sync_get_irqsave(flags);
 
 	touch_nmi_watchdog();
 
@@ -3353,7 +3353,7 @@ void serial8250_console_write_atomic(struct uart_8250_port *up,
 	wait_for_xmitr(up, BOTH_EMPTY);
 	serial8250_set_IER(up, ier);
 
-	console_atomic_unlock(flags);
+	printk_cpu_sync_put_irqrestore(flags);
 }
 
 /*
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index 8cd11aa63ed57..9b6695bdafc98 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -9,6 +9,7 @@ config SERIAL_8250
 	depends on !S390
 	select SERIAL_CORE
 	select SERIAL_MCTRL_GPIO if GPIOLIB
+	select HAVE_ATOMIC_CONSOLE
 	help
 	  This selects whether you want to include the driver for the standard
 	  serial ports.  The standard answer is Y.  People who might say N
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7359c3e80d63e..ab4712cc93270 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3161,7 +3161,7 @@ static struct console vt_console_driver = {
 	.write		= vt_console_print,
 	.device		= vt_console_device,
 	.unblank	= unblank_screen,
-	.flags		= CON_PRINTBUFFER,
+	.flags		= CON_PRINTBUFFER|CON_MIGHT_SLEEP,
 	.index		= -1,
 };
 #endif
diff --git a/include/linux/console.h b/include/linux/console.h
index 606fdf91001f0..15432b6e11a45 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -16,13 +16,7 @@
 
 #include <linux/atomic.h>
 #include <linux/types.h>
-#include <linux/printk.h>
-#include <linux/seqlock.h>
-
-struct latched_seq {
-	seqcount_latch_t	latch;
-	u64			val[2];
-};
+#include <linux/mutex.h>
 
 struct vc_data;
 struct console_font_op;
@@ -140,15 +134,25 @@ static inline int con_debug_leave(void)
 #define CON_CONSDEV	(2) /* Preferred console, /dev/console */
 #define CON_ENABLED	(4)
 #define CON_BOOT	(8)
-#define CON_ANYTIME	(16) /* Safe to call when cpu is offline */
+#define CON_ANYTIME	(16) /* Safe to call before per-cpu resources ready */
 #define CON_BRL		(32) /* Used for a braille device */
 #define CON_EXTENDED	(64) /* Use the extended output format a la /dev/kmsg */
-#define CON_HANDOVER	(128) /* Device was previously a boot console. */
+#define CON_PAUSED	(128) /* Sleep while console is locked */
+#define CON_MIGHT_SLEEP	(256) /* Can only be called from sleepable context */
+
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+struct console_atomic_data {
+	u64	seq;
+	char	*text;
+	char	*ext_text;
+	char	*dropped_text;
+};
+#endif
 
 struct console {
 	char	name[16];
 	void	(*write)(struct console *, const char *, unsigned);
-	void	(*write_atomic)(struct console *co, const char *s, unsigned int count);
+	void	(*write_atomic)(struct console *, const char *, unsigned);
 	int	(*read)(struct console *, char *, unsigned);
 	struct tty_driver *(*device)(struct console *, int *);
 	void	(*unblank)(void);
@@ -158,17 +162,28 @@ struct console {
 	short	flags;
 	short	index;
 	int	cflag;
-#ifdef CONFIG_PRINTK
-	char	sync_buf[CONSOLE_LOG_MAX];
-	struct latched_seq printk_seq;
-	struct latched_seq printk_sync_seq;
-#ifdef CONFIG_HAVE_NMI
-	struct latched_seq printk_sync_nmi_seq;
-#endif
-#endif	/* CONFIG_PRINTK */
 	uint	ispeed;
 	uint	ospeed;
+	u64	seq;
+	atomic_long_t dropped;
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	struct console_atomic_data *atomic_data;
+#endif
 	struct task_struct *thread;
+
+	/*
+	 * The per-console lock is used by printing kthreads to synchronize
+	 * this console with callers of console_lock(). This is necessary in
+	 * order to allow printing kthreads to run in parallel to each other,
+	 * while each safely accessing their own @flags and synchronizing
+	 * against direct printing via console_lock/console_unlock.
+	 *
+	 * Note: For synchronizing against direct printing via
+	 *       console_trylock/console_unlock, see the static global
+	 *       variable @console_lock_count.
+	 */
+	struct mutex lock;
+
 	void	*data;
 	struct	 console *next;
 };
@@ -183,6 +198,7 @@ extern int console_set_on_cmdline;
 extern struct console *early_console;
 
 enum con_flush_mode {
+	CONSOLE_ATOMIC_FLUSH_PENDING,
 	CONSOLE_FLUSH_PENDING,
 	CONSOLE_REPLAY_ALL,
 };
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index 93d270ca0c567..a77584593f7d1 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -160,6 +160,7 @@ static inline void generic_handle_irq_desc(struct irq_desc *desc)
 
 int handle_irq_desc(struct irq_desc *desc);
 int generic_handle_irq(unsigned int irq);
+int generic_handle_irq_safe(unsigned int irq);
 
 #ifdef CONFIG_IRQ_DOMAIN
 /*
diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
index 9bca0d98db5a1..258cdde8d356b 100644
--- a/include/linux/kgdb.h
+++ b/include/linux/kgdb.h
@@ -212,8 +212,6 @@ extern void kgdb_call_nmi_hook(void *ignored);
  */
 extern void kgdb_roundup_cpus(void);
 
-extern void kgdb_roundup_cpu(unsigned int cpu);
-
 /**
  *	kgdb_arch_set_pc - Generic call back to the program counter
  *	@regs: Current &struct pt_regs.
@@ -367,6 +365,5 @@ extern void kgdb_free_init_mem(void);
 #define dbg_late_init()
 static inline void kgdb_panic(const char *msg) {}
 static inline void kgdb_free_init_mem(void) { }
-static inline void kgdb_roundup_cpu(unsigned int cpu) {}
 #endif /* ! CONFIG_KGDB */
 #endif /* _KGDB_H_ */
diff --git a/include/linux/printk.h b/include/linux/printk.h
index f1b9cd8d11d6e..6596f02d1f055 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -47,12 +47,6 @@ static inline const char *printk_skip_headers(const char *buffer)
 
 #define CONSOLE_EXT_LOG_MAX	8192
 
-/*
- * The maximum size of a record formatted for console printing
- * (i.e. with the prefix prepended to every line).
- */
-#define CONSOLE_LOG_MAX		1024
-
 /* printk's without a loglevel use this.. */
 #define MESSAGE_LOGLEVEL_DEFAULT CONFIG_MESSAGE_LOGLEVEL_DEFAULT
 
@@ -161,7 +155,22 @@ int vprintk(const char *fmt, va_list args);
 asmlinkage __printf(1, 2) __cold
 int _printk(const char *fmt, ...);
 
-bool pr_flush(int timeout_ms, bool reset_on_progress);
+/*
+ * Special printk facility for scheduler/timekeeping use only, _DO_NOT_USE_ !
+ */
+__printf(1, 2) __cold int _printk_deferred(const char *fmt, ...);
+
+extern void __printk_safe_enter(void);
+extern void __printk_safe_exit(void);
+/*
+ * The printk_deferred_enter/exit macros are available only as a hack for
+ * some code paths that need to defer all printk console printing. Interrupts
+ * must be disabled for the deferred duration.
+ */
+#define printk_deferred_enter __printk_safe_enter
+#define printk_deferred_exit __printk_safe_exit
+
+extern bool pr_flush(int timeout_ms, bool reset_on_progress);
 
 /*
  * Please don't use printk_ratelimit(), because it shares ratelimiting state
@@ -203,6 +212,19 @@ int _printk(const char *s, ...)
 {
 	return 0;
 }
+static inline __printf(1, 2) __cold
+int _printk_deferred(const char *s, ...)
+{
+	return 0;
+}
+
+static inline void printk_deferred_enter(void)
+{
+}
+
+static inline void printk_deferred_exit(void)
+{
+}
 
 static inline bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
@@ -266,67 +288,46 @@ static inline void printk_trigger_flush(void)
 #endif
 
 #ifdef CONFIG_SMP
-extern int __printk_cpu_trylock(void);
-extern void __printk_wait_on_cpu_lock(void);
-extern void __printk_cpu_unlock(void);
-extern bool kgdb_roundup_delay(unsigned int cpu);
+extern int __printk_cpu_sync_try_get(void);
+extern void __printk_cpu_sync_wait(void);
+extern void __printk_cpu_sync_put(void);
 
 #else
 
-#define __printk_cpu_trylock()		1
-#define __printk_wait_on_cpu_lock()
-#define __printk_cpu_unlock()
-
-static inline bool kgdb_roundup_delay(unsigned int cpu)
-{
-	return false;
-}
+#define __printk_cpu_sync_try_get() true
+#define __printk_cpu_sync_wait()
+#define __printk_cpu_sync_put()
 #endif /* CONFIG_SMP */
 
 /**
- * raw_printk_cpu_lock_irqsave() - Acquire the printk cpu-reentrant spinning
- *                                 lock and disable interrupts.
+ * printk_cpu_sync_get_irqsave() - Disable interrupts and acquire the printk
+ *                                 cpu-reentrant spinning lock.
  * @flags: Stack-allocated storage for saving local interrupt state,
- *         to be passed to raw_printk_cpu_unlock_irqrestore().
+ *         to be passed to printk_cpu_sync_put_irqrestore().
  *
  * If the lock is owned by another CPU, spin until it becomes available.
  * Interrupts are restored while spinning.
  */
-#define raw_printk_cpu_lock_irqsave(flags)	\
-	for (;;) {				\
-		local_irq_save(flags);		\
-		if (__printk_cpu_trylock())	\
-			break;			\
-		local_irq_restore(flags);	\
-		__printk_wait_on_cpu_lock();	\
+#define printk_cpu_sync_get_irqsave(flags)		\
+	for (;;) {					\
+		local_irq_save(flags);			\
+		if (__printk_cpu_sync_try_get())	\
+			break;				\
+		local_irq_restore(flags);		\
+		__printk_cpu_sync_wait();		\
 	}
 
 /**
- * raw_printk_cpu_unlock_irqrestore() - Release the printk cpu-reentrant
- *                                      spinning lock and restore interrupts.
- * @flags: Caller's saved interrupt state from raw_printk_cpu_lock_irqsave().
+ * printk_cpu_sync_put_irqrestore() - Release the printk cpu-reentrant spinning
+ *                                    lock and restore interrupts.
+ * @flags: Caller's saved interrupt state, from printk_cpu_sync_get_irqsave().
  */
-#define raw_printk_cpu_unlock_irqrestore(flags)	\
+#define printk_cpu_sync_put_irqrestore(flags)	\
 	do {					\
-		__printk_cpu_unlock();		\
+		__printk_cpu_sync_put();	\
 		local_irq_restore(flags);	\
 	} while (0)
 
-/*
- * Used to synchronize atomic consoles.
- *
- * The same as raw_printk_cpu_lock_irqsave() except that hardware interrupts
- * are _not_ restored while spinning.
- */
-#define console_atomic_lock(flags)		\
-	do {					\
-		local_irq_save(flags);		\
-		while (!__printk_cpu_trylock())	\
-			cpu_relax();		\
-	} while (0)
-
-#define console_atomic_unlock raw_printk_cpu_unlock_irqrestore
-
 extern int kptr_restrict;
 
 /**
@@ -454,6 +455,8 @@ struct pi_entry {
  * See the vsnprintf() documentation for format string extensions over C99.
  */
 #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
+#define printk_deferred(fmt, ...)					\
+	printk_index_wrap(_printk_deferred, fmt, ##__VA_ARGS__)
 
 /**
  * pr_emerg - Print an emergency-level message
@@ -591,9 +594,13 @@ struct pi_entry {
 #ifdef CONFIG_PRINTK
 #define printk_once(fmt, ...)					\
 	DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
+#define printk_deferred_once(fmt, ...)				\
+	DO_ONCE_LITE(printk_deferred, fmt, ##__VA_ARGS__)
 #else
 #define printk_once(fmt, ...)					\
 	no_printk(fmt, ##__VA_ARGS__)
+#define printk_deferred_once(fmt, ...)				\
+	no_printk(fmt, ##__VA_ARGS__)
 #endif
 
 #define pr_emerg_once(fmt, ...)					\
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 79b6933ef8a03..8af13ba60c7e4 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -550,17 +550,23 @@ static inline void unlock_system_sleep(void) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
-extern __printf(1, 2) void pm_pr_dbg(const char *fmt, ...);
+extern __printf(2, 3) void __pm_pr_dbg(bool defer, const char *fmt, ...);
 #else
 #define pm_print_times_enabled	(false)
 #define pm_debug_messages_on	(false)
 
 #include <linux/printk.h>
 
-#define pm_pr_dbg(fmt, ...) \
+#define __pm_pr_dbg(defer, fmt, ...) \
 	no_printk(KERN_DEBUG fmt, ##__VA_ARGS__)
 #endif
 
+#define pm_pr_dbg(fmt, ...) \
+	__pm_pr_dbg(false, fmt, ##__VA_ARGS__)
+
+#define pm_deferred_pr_dbg(fmt, ...) \
+	__pm_pr_dbg(true, fmt, ##__VA_ARGS__)
+
 #ifdef CONFIG_PM_AUTOSLEEP
 
 /* kernel/power/autosleep.c */
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d3..732dbb61ec7e2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1542,6 +1542,10 @@ config PRINTK
 	  very difficult to diagnose system problems, saying N here is
 	  strongly discouraged.
 
+config HAVE_ATOMIC_CONSOLE
+	bool
+	default n
+
 config BUG
 	bool "BUG() support" if EXPERT
 	default y
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 3e39636da8427..da06a5553835b 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -238,42 +238,35 @@ NOKPROBE_SYMBOL(kgdb_call_nmi_hook);
 static DEFINE_PER_CPU(call_single_data_t, kgdb_roundup_csd) =
 	CSD_INIT(kgdb_call_nmi_hook, NULL);
 
-void __weak kgdb_roundup_cpu(unsigned int cpu)
-{
-	call_single_data_t *csd;
-	int ret;
-
-	csd = &per_cpu(kgdb_roundup_csd, cpu);
-
-	/*
-	 * If it didn't round up last time, don't try again
-	 * since smp_call_function_single_async() will block.
-	 *
-	 * If rounding_up is false then we know that the
-	 * previous call must have at least started and that
-	 * means smp_call_function_single_async() won't block.
-	 */
-	if (kgdb_info[cpu].rounding_up)
-		return;
-	kgdb_info[cpu].rounding_up = true;
-
-	ret = smp_call_function_single_async(cpu, csd);
-	if (ret)
-		kgdb_info[cpu].rounding_up = false;
-}
-NOKPROBE_SYMBOL(kgdb_roundup_cpu);
-
 void __weak kgdb_roundup_cpus(void)
 {
+	call_single_data_t *csd;
 	int this_cpu = raw_smp_processor_id();
 	int cpu;
+	int ret;
 
 	for_each_online_cpu(cpu) {
 		/* No need to roundup ourselves */
 		if (cpu == this_cpu)
 			continue;
 
-		kgdb_roundup_cpu(cpu);
+		csd = &per_cpu(kgdb_roundup_csd, cpu);
+
+		/*
+		 * If it didn't round up last time, don't try again
+		 * since smp_call_function_single_async() will block.
+		 *
+		 * If rounding_up is false then we know that the
+		 * previous call must have at least started and that
+		 * means smp_call_function_single_async() won't block.
+		 */
+		if (kgdb_info[cpu].rounding_up)
+			continue;
+		kgdb_info[cpu].rounding_up = true;
+
+		ret = smp_call_function_single_async(cpu, csd);
+		if (ret)
+			kgdb_info[cpu].rounding_up = false;
 	}
 }
 NOKPROBE_SYMBOL(kgdb_roundup_cpus);
diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
index 539a2f0dc89d9..6735ac36b7187 100644
--- a/kernel/debug/kdb/kdb_io.c
+++ b/kernel/debug/kdb/kdb_io.c
@@ -559,17 +559,23 @@ static void kdb_msg_write(const char *msg, int msg_len)
 		cp++;
 	}
 
-	/* mirror output on atomic consoles */
 	for_each_console(c) {
 		if (!(c->flags & CON_ENABLED))
 			continue;
 		if (c == dbg_io_ops->cons)
 			continue;
-
-		if (!c->write_atomic)
-			continue;
-		c->write_atomic(c, msg, msg_len);
-
+		/*
+		 * Set oops_in_progress to encourage the console drivers to
+		 * disregard their internal spin locks: in the current calling
+		 * context the risk of deadlock is a bigger problem than risks
+		 * due to re-entering the console driver. We operate directly on
+		 * oops_in_progress rather than using bust_spinlocks() because
+		 * the calls bust_spinlocks() makes on exit are not appropriate
+		 * for this calling context.
+		 */
+		++oops_in_progress;
+		c->write(c, msg, msg_len);
+		--oops_in_progress;
 		touch_nmi_watchdog();
 	}
 }
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2267e6527db3c..97223df2f460e 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -662,6 +662,27 @@ int generic_handle_irq(unsigned int irq)
 }
 EXPORT_SYMBOL_GPL(generic_handle_irq);
 
+/**
+ * generic_handle_irq_safe - Invoke the handler for a particular irq
+ * @irq:	The irq number to handle
+ *
+ * Returns:	0 on success, or -EINVAL if conversion has failed
+ *
+ * This function must be called either from an IRQ context with irq regs
+ * initialized or with care from any context.
+ */
+int generic_handle_irq_safe(unsigned int irq)
+{
+	unsigned long flags;
+	int ret;
+
+	local_irq_save(flags);
+	ret = handle_irq_desc(irq_to_desc(irq));
+	local_irq_restore(flags);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(generic_handle_irq_safe);
+
 #ifdef CONFIG_IRQ_DOMAIN
 /**
  * generic_handle_domain_irq - Invoke the handler for a HW irq belonging
diff --git a/kernel/panic.c b/kernel/panic.c
index f4c7c77595bd2..556665ef11522 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -178,28 +178,12 @@ static void panic_print_sys_info(void)
 void panic(const char *fmt, ...)
 {
 	static char buf[1024];
-	va_list args2;
 	va_list args;
 	long i, i_next = 0, len;
 	int state = 0;
 	int old_cpu, this_cpu;
 	bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;
 
-	console_verbose();
-	pr_emerg("Kernel panic - not syncing:\n");
-	va_start(args2, fmt);
-	va_copy(args, args2);
-	vprintk(fmt, args2);
-	va_end(args2);
-#ifdef CONFIG_DEBUG_BUGVERBOSE
-	/*
-	 * Avoid nested stack-dumping if a panic occurs during oops processing
-	 */
-	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
-		dump_stack();
-#endif
-	pr_flush(1000, true);
-
 	/*
 	 * Disable local interrupts. This will prevent panic_smp_self_stop
 	 * from deadlocking the first cpu that invokes the panic, since
@@ -230,13 +214,23 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
-	bust_spinlocks(1);
+	console_verbose();
+	va_start(args, fmt);
 	len = vscnprintf(buf, sizeof(buf), fmt, args);
 	va_end(args);
 
 	if (len && buf[len - 1] == '\n')
 		buf[len - 1] = '\0';
 
+	pr_emerg("Kernel panic - not syncing: %s\n", buf);
+#ifdef CONFIG_DEBUG_BUGVERBOSE
+	/*
+	 * Avoid nested stack-dumping if a panic occurs during oops processing
+	 */
+	if (!test_taint(TAINT_DIE) && oops_in_progress <= 1)
+		dump_stack();
+#endif
+
 	/*
 	 * If kgdb is enabled, give it a chance to run before we stop all
 	 * the other CPUs or else we won't be able to debug processes left
@@ -244,6 +238,11 @@ void panic(const char *fmt, ...)
 	 */
 	kgdb_panic(buf);
 
+	/* Use atomic consoles to dump the kernel log. */
+	console_flush_on_panic(CONSOLE_ATOMIC_FLUSH_PENDING);
+
+	bust_spinlocks(1);
+
 	/*
 	 * If we have crashed and we have a crash kernel loaded let it handle
 	 * everything else.
@@ -541,7 +540,6 @@ void oops_enter(void)
 static void print_oops_end_marker(void)
 {
 	pr_warn("---[ end trace %016llx ]---\n", 0ULL);
-	pr_flush(1000, true);
 }
 
 /*
diff --git a/kernel/power/main.c b/kernel/power/main.c
index eaa725ca079cb..44169f3081fdc 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -543,13 +543,14 @@ static int __init pm_debug_messages_setup(char *str)
 __setup("pm_debug_messages", pm_debug_messages_setup);
 
 /**
- * pm_pr_dbg - Print a suspend debug message to the kernel log.
+ * __pm_pr_dbg - Print a suspend debug message to the kernel log.
+ * @defer: Whether or not to use printk_deferred() to print the message.
  * @fmt: Message format.
  *
  * The message will be emitted if enabled through the pm_debug_messages
  * sysfs attribute.
  */
-void pm_pr_dbg(const char *fmt, ...)
+void __pm_pr_dbg(bool defer, const char *fmt, ...)
 {
 	struct va_format vaf;
 	va_list args;
@@ -562,7 +563,10 @@ void pm_pr_dbg(const char *fmt, ...)
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	printk(KERN_DEBUG "PM: %pV", &vaf);
+	if (defer)
+		printk_deferred(KERN_DEBUG "PM: %pV", &vaf);
+	else
+		printk(KERN_DEBUG "PM: %pV", &vaf);
 
 	va_end(args);
 }
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index bc6b856a0ff41..d118739874c0d 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	= printk.o
+obj-$(CONFIG_PRINTK)	+= printk_safe.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK)	+= printk_ringbuffer.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index de8ab059dd961..9f3ed2fdb7211 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -2,6 +2,7 @@
 /*
  * internal.h - printk internal definitions
  */
+#include <linux/percpu.h>
 
 #ifdef CONFIG_PRINTK
 
@@ -11,6 +12,41 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+__printf(4, 0)
+int vprintk_store(int facility, int level,
+		  const struct dev_printk_info *dev_info,
+		  const char *fmt, va_list args);
+
+__printf(1, 0) int vprintk_default(const char *fmt, va_list args);
+__printf(1, 0) int vprintk_deferred(const char *fmt, va_list args);
+
+bool printk_percpu_data_ready(void);
+
+#define printk_safe_enter_irqsave(flags)	\
+	do {					\
+		local_irq_save(flags);		\
+		__printk_safe_enter();		\
+	} while (0)
+
+#define printk_safe_exit_irqrestore(flags)	\
+	do {					\
+		__printk_safe_exit();		\
+		local_irq_restore(flags);	\
+	} while (0)
+
+void defer_console_output(void);
+
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+#else
+
+/*
+ * In !PRINTK builds we still export console_sem
+ * semaphore and some of console functions (console_unlock()/etc.), so
+ * printk-safe must preserve the existing local IRQ guarantees.
+ */
+#define printk_safe_enter_irqsave(flags) local_irq_save(flags)
+#define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
+
+static inline bool printk_percpu_data_ready(void) { return false; }
 #endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d7dee184ad402..20453a3bc429b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -44,9 +44,6 @@
 #include <linux/irq_work.h>
 #include <linux/ctype.h>
 #include <linux/uio.h>
-#include <linux/kdb.h>
-#include <linux/kgdb.h>
-#include <linux/kthread.h>
 #include <linux/clocksource.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
@@ -218,6 +215,26 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 /* Number of registered extended console drivers. */
 static int nr_ext_console_drivers;
 
+/*
+ * Used to synchronize printing kthreads against direct printing via
+ * console_trylock/console_unlock.
+ *
+ * Values:
+ * -1 = console locked (via trylock), kthreads will not print
+ *  0 = no kthread printing, console not locked (via trylock)
+ * >0 = kthread(s) actively printing
+ *
+ * Note: For synchronizing against direct printing via
+ *       console_lock/console_unlock, see the @lock variable in
+ *       struct console.
+ */
+static atomic_t console_lock_count = ATOMIC_INIT(0);
+
+#define console_excl_trylock() (atomic_cmpxchg(&console_lock_count, 0, -1) == 0)
+#define console_excl_unlock() atomic_cmpxchg(&console_lock_count, -1, 0)
+#define console_printer_tryenter() atomic_inc_unless_negative(&console_lock_count)
+#define console_printer_exit() atomic_dec(&console_lock_count)
+
 /*
  * Helper macros to handle lockdep when locking/unlocking console_sem. We use
  * macros instead of functions so that _RET_IP_ contains useful information.
@@ -229,7 +246,19 @@ static int nr_ext_console_drivers;
 
 static int __down_trylock_console_sem(unsigned long ip)
 {
-	if (down_trylock(&console_sem))
+	int lock_failed;
+	unsigned long flags;
+
+	/*
+	 * Here and in __up_console_sem() we need to be in safe mode,
+	 * because spindump/WARN/etc from under console ->lock will
+	 * deadlock in printk()->down_trylock_console_sem() otherwise.
+	 */
+	printk_safe_enter_irqsave(flags);
+	lock_failed = down_trylock(&console_sem);
+	printk_safe_exit_irqrestore(flags);
+
+	if (lock_failed)
 		return 1;
 	mutex_acquire(&console_lock_dep_map, 0, 1, ip);
 	return 0;
@@ -238,21 +267,48 @@ static int __down_trylock_console_sem(unsigned long ip)
 
 static void __up_console_sem(unsigned long ip)
 {
+	unsigned long flags;
+
 	mutex_release(&console_lock_dep_map, ip);
 
+	printk_safe_enter_irqsave(flags);
 	up(&console_sem);
+	printk_safe_exit_irqrestore(flags);
 }
 #define up_console_sem() __up_console_sem(_RET_IP_)
 
 /*
- * This is used for debugging the mess that is the VT code by
- * keeping track if we have the console semaphore held. It's
- * definitely not the perfect debug tool (we don't know if _WE_
- * hold it and are racing, but it helps tracking those weird code
- * paths in the console code where we end up in places I want
- * locked without the console semaphore held).
+ * Tracks whether kthread printers are all paused. A value of true implies
+ * that the console is locked via console_lock() or the console is suspended.
+ * Reading and writing to this variable requires holding @console_sem.
  */
-static int console_locked, console_suspended;
+static bool consoles_paused;
+
+/*
+ * Pause or unpause all kthread printers.
+ *
+ * Requires the console_lock.
+ */
+static void __pause_all_consoles(bool do_pause)
+{
+	struct console *con;
+
+	for_each_console(con) {
+		mutex_lock(&con->lock);
+		if (do_pause)
+			con->flags |= CON_PAUSED;
+		else
+			con->flags &= ~CON_PAUSED;
+		mutex_unlock(&con->lock);
+	}
+
+	consoles_paused = do_pause;
+}
+
+#define pause_all_consoles() __pause_all_consoles(true)
+#define unpause_all_consoles() __pause_all_consoles(false)
+
+static int console_suspended;
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -333,13 +389,24 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
  * non-prinatable characters are escaped in the "\xff" notation.
  */
 
-#ifdef CONFIG_PRINTK
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
-/* Set to enable sync mode. Once set, it is never cleared. */
-static bool sync_mode;
+/*
+ * A flag to signify if printk_late_init() has already started the kthread
+ * printers. If true, any later registered consoles must start their own
+ * kthread directly. The flag is write protected by the console_lock.
+ */
+static bool kthreads_started;
 
+static inline bool kthread_printers_active(void)
+{
+	return (kthreads_started &&
+		system_state == SYSTEM_RUNNING &&
+		!oops_in_progress);
+}
+
+#ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
 /* the next printk record to read by syslog(READ) or /proc/kmsg */
@@ -347,6 +414,11 @@ static u64 syslog_seq;
 static size_t syslog_partial;
 static bool syslog_time;
 
+struct latched_seq {
+	seqcount_latch_t	latch;
+	u64			val[2];
+};
+
 /*
  * The next printk record to read after the last 'clear' command. There are
  * two copies (updated with seqcount_latch) so that reads can locklessly
@@ -364,6 +436,12 @@ static struct latched_seq clear_seq = {
 #define PREFIX_MAX		32
 #endif
 
+/* the maximum size of a formatted record (i.e. with prefix added per line) */
+#define CONSOLE_LOG_MAX		1024
+
+/* the maximum size for a dropped text message */
+#define DROPPED_TEXT_MAX	64
+
 /* the maximum size allowed to be reserved for a record */
 #define LOG_LINE_MAX		(CONSOLE_LOG_MAX - PREFIX_MAX)
 
@@ -402,12 +480,12 @@ static struct printk_ringbuffer *prb = &printk_rb_static;
  */
 static bool __printk_percpu_data_ready __read_mostly;
 
-static bool printk_percpu_data_ready(void)
+bool printk_percpu_data_ready(void)
 {
 	return __printk_percpu_data_ready;
 }
 
-/* Must be called under associated write-protection lock. */
+/* Must be called under syslog_lock. */
 static void latched_seq_write(struct latched_seq *ls, u64 val)
 {
 	raw_write_seqcount_latch(&ls->latch);
@@ -1719,152 +1797,178 @@ SYSCALL_DEFINE3(syslog, int, type, char __user *, buf, int, len)
 	return do_syslog(type, buf, len, SYSLOG_FROM_READER);
 }
 
-int printk_delay_msec __read_mostly;
+/*
+ * Special console_lock variants that help to reduce the risk of soft-lockups.
+ * They allow to pass console_lock to another printk() call using a busy wait.
+ */
 
-static inline void printk_delay(int level)
-{
-	boot_delay_msec(level);
-
-	if (unlikely(printk_delay_msec)) {
-		int m = printk_delay_msec;
-
-		while (m--) {
-			mdelay(1);
-			touch_nmi_watchdog();
-		}
-	}
-}
-
-static bool kernel_sync_mode(void)
-{
-	return (oops_in_progress || sync_mode);
-}
-
-static bool console_may_sync(struct console *con)
-{
-	if (!(con->flags & CON_ENABLED))
-		return false;
-	if (con->write_atomic && kernel_sync_mode())
-		return true;
-	if (con->write_atomic && (con->flags & CON_HANDOVER) && !con->thread)
-		return true;
-	if (con->write && (con->flags & CON_BOOT) && !con->thread)
-		return true;
-	return false;
-}
-
-static bool call_sync_console_driver(struct console *con, const char *text, size_t text_len)
-{
-	if (!(con->flags & CON_ENABLED))
-		return false;
-
-	if (con->write_atomic && kernel_sync_mode()) {
-		con->write_atomic(con, text, text_len);
-		return true;
-	}
-
-	if (con->write_atomic && (con->flags & CON_HANDOVER) && !con->thread) {
-		if (console_trylock()) {
-			con->write_atomic(con, text, text_len);
-			console_unlock();
-			return true;
-		}
-
-	} else if (con->write && (con->flags & CON_BOOT) && !con->thread) {
-		if (console_trylock()) {
-			con->write(con, text, text_len);
-			console_unlock();
-			return true;
-		}
-	}
-
-	return false;
-}
-
-static bool have_atomic_console(void)
-{
-	struct console *con;
-
-	for_each_console(con) {
-		if (!(con->flags & CON_ENABLED))
-			continue;
-		if (con->write_atomic)
-			return true;
-	}
-	return false;
-}
-
-static bool print_sync(struct console *con, u64 *seq)
-{
-	struct printk_info info;
-	struct printk_record r;
-	size_t text_len;
-
-	prb_rec_init_rd(&r, &info, &con->sync_buf[0], sizeof(con->sync_buf));
-
-	if (!prb_read_valid(prb, *seq, &r))
-		return false;
-
-	text_len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
-
-	if (!call_sync_console_driver(con, &con->sync_buf[0], text_len))
-		return false;
-
-	*seq = r.info->seq;
-
-	touch_softlockup_watchdog_sync();
-	clocksource_touch_watchdog();
-	rcu_cpu_stall_reset();
-	touch_nmi_watchdog();
-
-	if (text_len)
-		printk_delay(r.info->level);
-
-	return true;
-}
-
-static u64 read_console_seq(struct console *con)
-{
-	u64 seq2;
-	u64 seq;
-
-	seq = latched_seq_read_nolock(&con->printk_seq);
-	seq2 = latched_seq_read_nolock(&con->printk_sync_seq);
-	if (seq2 > seq)
-		seq = seq2;
-#ifdef CONFIG_HAVE_NMI
-	seq2 = latched_seq_read_nolock(&con->printk_sync_nmi_seq);
-	if (seq2 > seq)
-		seq = seq2;
+#ifdef CONFIG_LOCKDEP
+static struct lockdep_map console_owner_dep_map = {
+	.name = "console_owner"
+};
 #endif
-	return seq;
+
+static DEFINE_RAW_SPINLOCK(console_owner_lock);
+static struct task_struct *console_owner;
+static bool console_waiter;
+
+/**
+ * console_lock_spinning_enable - mark beginning of code where another
+ *	thread might safely busy wait
+ *
+ * This basically converts console_lock into a spinlock. This marks
+ * the section where the console_lock owner can not sleep, because
+ * there may be a waiter spinning (like a spinlock). Also it must be
+ * ready to hand over the lock at the end of the section.
+ */
+static void console_lock_spinning_enable(void)
+{
+	raw_spin_lock(&console_owner_lock);
+	console_owner = current;
+	raw_spin_unlock(&console_owner_lock);
+
+	/* The waiter may spin on us after setting console_owner */
+	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
 
-static void print_sync_until(struct console *con, u64 seq, bool is_locked)
+/**
+ * console_lock_spinning_disable_and_check - mark end of code where another
+ *	thread was able to busy wait and check if there is a waiter
+ *
+ * This is called at the end of the section where spinning is allowed.
+ * It has two functions. First, it is a signal that it is no longer
+ * safe to start busy waiting for the lock. Second, it checks if
+ * there is a busy waiter and passes the lock rights to her.
+ *
+ * Important: Callers lose the lock if there was a busy waiter.
+ *	They must not touch items synchronized by console_lock
+ *	in this case.
+ *
+ * Return: 1 if the lock rights were passed, 0 otherwise.
+ */
+static int console_lock_spinning_disable_and_check(void)
 {
-	u64 printk_seq;
+	int waiter;
 
-	while (!__printk_cpu_trylock())
+	raw_spin_lock(&console_owner_lock);
+	waiter = READ_ONCE(console_waiter);
+	console_owner = NULL;
+	raw_spin_unlock(&console_owner_lock);
+
+	if (!waiter) {
+		spin_release(&console_owner_dep_map, _THIS_IP_);
+		return 0;
+	}
+
+	/* The waiter is now free to continue */
+	WRITE_ONCE(console_waiter, false);
+
+	spin_release(&console_owner_dep_map, _THIS_IP_);
+
+	/*
+	 * Hand off console_lock to waiter. The waiter will perform
+	 * the up(). After this, the waiter is the console_lock owner.
+	 */
+	mutex_release(&console_lock_dep_map, _THIS_IP_);
+	return 1;
+}
+
+#if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+/**
+ * console_trylock_spinning - try to get console_lock by busy waiting
+ *
+ * This allows to busy wait for the console_lock when the current
+ * owner is running in specially marked sections. It means that
+ * the current owner is running and cannot reschedule until it
+ * is ready to lose the lock.
+ *
+ * Return: 1 if we got the lock, 0 othrewise
+ */
+static int console_trylock_spinning(void)
+{
+	struct task_struct *owner = NULL;
+	bool waiter;
+	bool spin = false;
+	unsigned long flags;
+
+	if (console_trylock())
+		return 1;
+
+	printk_safe_enter_irqsave(flags);
+
+	raw_spin_lock(&console_owner_lock);
+	owner = READ_ONCE(console_owner);
+	waiter = READ_ONCE(console_waiter);
+	if (!waiter && owner && owner != current) {
+		WRITE_ONCE(console_waiter, true);
+		spin = true;
+	}
+	raw_spin_unlock(&console_owner_lock);
+
+	/*
+	 * If there is an active printk() writing to the
+	 * consoles, instead of having it write our data too,
+	 * see if we can offload that load from the active
+	 * printer, and do some printing ourselves.
+	 * Go into a spin only if there isn't already a waiter
+	 * spinning, and there is an active printer, and
+	 * that active printer isn't us (recursive printk?).
+	 */
+	if (!spin) {
+		printk_safe_exit_irqrestore(flags);
+		return 0;
+	}
+
+	/* We spin waiting for the owner to release us */
+	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
+	/* Owner will clear console_waiter on hand off */
+	while (READ_ONCE(console_waiter))
 		cpu_relax();
+	spin_release(&console_owner_dep_map, _THIS_IP_);
 
-	for (;;) {
-		printk_seq = read_console_seq(con);
-		if (printk_seq >= seq)
-			break;
-		if (!print_sync(con, &printk_seq))
-			break;
+	printk_safe_exit_irqrestore(flags);
+	/*
+	 * The owner passed the console lock to us.
+	 * Since we did not spin on console lock, annotate
+	 * this as a trylock. Otherwise lockdep will
+	 * complain.
+	 */
+	mutex_acquire(&console_lock_dep_map, 0, 1, _THIS_IP_);
 
-		if (is_locked)
-			latched_seq_write(&con->printk_seq, printk_seq + 1);
-#ifdef CONFIG_PRINTK_NMI
-		else if (in_nmi())
-			latched_seq_write(&con->printk_sync_nmi_seq, printk_seq + 1);
-#endif
+	return 1;
+}
+#endif /* CONFIG_PREEMPT_RT */
+
+/*
+ * Call the specified console driver, asking it to write out the specified
+ * text and length. If @dropped_text is non-NULL and any records have been
+ * dropped, a dropped message will be written out first.
+ */
+static void call_console_driver(struct console *con, const char *text, size_t len,
+				char *dropped_text, bool atomic_printing)
+{
+	unsigned long dropped = 0;
+	size_t dropped_len;
+
+	trace_console_rcuidle(text, len);
+
+	if (dropped_text)
+		dropped = atomic_long_xchg_relaxed(&con->dropped, 0);
+
+	if (dropped) {
+		dropped_len = snprintf(dropped_text, DROPPED_TEXT_MAX,
+				       "** %lu printk messages dropped **\n",
+				       dropped);
+		if (atomic_printing)
+			con->write_atomic(con, dropped_text, dropped_len);
 		else
-			latched_seq_write(&con->printk_sync_seq, printk_seq + 1);
+			con->write(con, dropped_text, dropped_len);
 	}
 
-	__printk_cpu_unlock();
+	if (atomic_printing)
+		con->write_atomic(con, text, len);
+	else
+		con->write(con, text, len);
 }
 
 /*
@@ -1937,10 +2041,24 @@ static u8 *__printk_recursion_counter(void)
 		local_irq_restore(flags);		\
 	} while (0)
 
+int printk_delay_msec __read_mostly;
+
+static inline void printk_delay(void)
+{
+	if (unlikely(printk_delay_msec)) {
+		int m = printk_delay_msec;
+
+		while (m--) {
+			mdelay(1);
+			touch_nmi_watchdog();
+		}
+	}
+}
+
 static inline u32 printk_caller_id(void)
 {
 	return in_task() ? task_pid_nr(current) :
-		0x80000000 + raw_smp_processor_id();
+		0x80000000 + smp_processor_id();
 }
 
 /**
@@ -2018,14 +2136,12 @@ static u16 printk_sprint(char *text, u16 size, int facility,
 }
 
 __printf(4, 0)
-static int vprintk_store(int facility, int level,
-			 const struct dev_printk_info *dev_info,
-			 const char *fmt, va_list args)
+int vprintk_store(int facility, int level,
+		  const struct dev_printk_info *dev_info,
+		  const char *fmt, va_list args)
 {
-	const u32 caller_id = printk_caller_id();
 	struct prb_reserved_entry e;
 	enum printk_info_flags flags = 0;
-	bool final_commit = false;
 	struct printk_record r;
 	unsigned long irqflags;
 	u16 trunc_msg_len = 0;
@@ -2033,10 +2149,13 @@ static int vprintk_store(int facility, int level,
 	u8 *recursion_ptr;
 	u16 reserve_size;
 	va_list args2;
+	u32 caller_id;
 	u16 text_len;
 	int ret = 0;
 	u64 ts_nsec;
-	u64 seq;
+
+	if (!printk_enter_irqsave(recursion_ptr, irqflags))
+		return 0;
 
 	/*
 	 * Since the duration of printk() can vary depending on the message
@@ -2046,8 +2165,7 @@ static int vprintk_store(int facility, int level,
 	 */
 	ts_nsec = local_clock();
 
-	if (!printk_enter_irqsave(recursion_ptr, irqflags))
-		return 0;
+	caller_id = printk_caller_id();
 
 	/*
 	 * The sprintf needs to come first since the syslog prefix might be
@@ -2075,7 +2193,6 @@ static int vprintk_store(int facility, int level,
 	if (flags & LOG_CONT) {
 		prb_rec_init_wr(&r, reserve_size);
 		if (prb_reserve_in_last(&e, prb, &r, caller_id, LOG_LINE_MAX)) {
-			seq = r.info->seq;
 			text_len = printk_sprint(&r.text_buf[r.info->text_len], reserve_size,
 						 facility, &flags, fmt, args);
 			r.info->text_len += text_len;
@@ -2083,7 +2200,6 @@ static int vprintk_store(int facility, int level,
 			if (flags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
 				prb_final_commit(&e);
-				final_commit = true;
 			} else {
 				prb_commit(&e);
 			}
@@ -2107,7 +2223,6 @@ static int vprintk_store(int facility, int level,
 		if (!prb_reserve(&e, prb, &r))
 			goto out;
 	}
-	seq = r.info->seq;
 
 	/* fill message */
 	text_len = printk_sprint(&r.text_buf[0], reserve_size, facility, &flags, fmt, args);
@@ -2123,25 +2238,13 @@ static int vprintk_store(int facility, int level,
 		memcpy(&r.info->dev_info, dev_info, sizeof(r.info->dev_info));
 
 	/* A message without a trailing newline can be continued. */
-	if (!(flags & LOG_NEWLINE)) {
+	if (!(flags & LOG_NEWLINE))
 		prb_commit(&e);
-	} else {
+	else
 		prb_final_commit(&e);
-		final_commit = true;
-	}
 
 	ret = text_len + trunc_msg_len;
 out:
-	/* only the kernel may perform synchronous printing */
-	if (facility == 0 && final_commit) {
-		struct console *con;
-
-		for_each_console(con) {
-			if (console_may_sync(con))
-				print_sync_until(con, seq + 1, false);
-		}
-	}
-
 	printk_exit_irqrestore(recursion_ptr, irqflags);
 	return ret;
 }
@@ -2151,43 +2254,59 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const char *fmt, va_list args)
 {
 	int printed_len;
+	bool in_sched = false;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (level == LOGLEVEL_SCHED)
+	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
+		in_sched = true;
+	}
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
+	/* If called from the scheduler, we can not call up(). */
+	if (!in_sched && !kthread_printers_active()) {
+		/*
+		 * Try to acquire and then immediately release the console
+		 * semaphore.  The release will print out buffers.
+		 */
+#if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		/*
+		 * Use the non-spinning trylock since PREEMPT_RT does not
+		 * support console lock handovers.
+		 *
+		 * Direct printing will most likely involve taking spinlocks.
+		 * For PREEMPT_RT, this is only allowed if in a preemptible
+		 * context.
+		 */
+		if (preemptible() && console_trylock())
+			console_unlock();
+#else
+		/*
+		 * Disable preemption to avoid being preempted while holding
+		 * console_sem which would prevent anyone from printing to
+		 * console
+		 */
+		preempt_disable();
+		if (console_trylock_spinning())
+			console_unlock();
+		preempt_enable();
+#endif
+	}
+
 	wake_up_klogd();
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
 
-__printf(1, 0)
-static int vprintk_default(const char *fmt, va_list args)
+int vprintk_default(const char *fmt, va_list args)
 {
 	return vprintk_emit(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
 }
-
-__printf(1, 0)
-static int vprintk_func(const char *fmt, va_list args)
-{
-#ifdef CONFIG_KGDB_KDB
-	/* Allow to pass printk() to kdb but avoid a recursion. */
-	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
-		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
-#endif
-	return vprintk_default(fmt, args);
-}
-
-asmlinkage int vprintk(const char *fmt, va_list args)
-{
-	return vprintk_func(fmt, args);
-}
-EXPORT_SYMBOL(vprintk);
+EXPORT_SYMBOL_GPL(vprintk_default);
 
 asmlinkage __visible int _printk(const char *fmt, ...)
 {
@@ -2202,163 +2321,112 @@ asmlinkage __visible int _printk(const char *fmt, ...)
 }
 EXPORT_SYMBOL(_printk);
 
-static int printk_kthread_func(void *data)
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+static void __free_atomic_data(struct console_atomic_data *d)
 {
-	struct console *con = data;
-	unsigned long dropped = 0;
-	char *dropped_text = NULL;
-	struct printk_info info;
-	struct printk_record r;
-	char *ext_text = NULL;
-	size_t dropped_len;
-	int ret = -ENOMEM;
-	char *text = NULL;
-	char *write_text;
-	size_t len;
-	int error;
-	u64 seq;
-
-	if (con->flags & CON_EXTENDED) {
-		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
-		if (!ext_text)
-			goto out;
-	}
-	text = kmalloc(LOG_LINE_MAX + PREFIX_MAX, GFP_KERNEL);
-	dropped_text = kmalloc(64, GFP_KERNEL);
-	if (!text || !dropped_text)
-		goto out;
-	if (con->flags & CON_EXTENDED)
-		write_text = ext_text;
-	else
-		write_text = text;
-
-	seq = read_console_seq(con);
-
-	prb_rec_init_rd(&r, &info, text, LOG_LINE_MAX + PREFIX_MAX);
-
-	for (;;) {
-		error = wait_event_interruptible(log_wait,
-						 prb_read_valid(prb, seq, &r) || kthread_should_stop());
-
-		if (kthread_should_stop())
-			break;
-
-		if (error)
-			continue;
-
-		if (seq != r.info->seq) {
-			dropped += r.info->seq - seq;
-			seq = r.info->seq;
-		}
-
-		seq++;
-
-		if (!(con->flags & CON_ENABLED))
-			continue;
-
-		if (suppress_message_printing(r.info->level))
-			continue;
-
-		if (con->flags & CON_EXTENDED) {
-			len = info_print_ext_header(ext_text,
-						    CONSOLE_EXT_LOG_MAX,
-						    r.info);
-			len += msg_print_ext_body(ext_text + len,
-						  CONSOLE_EXT_LOG_MAX - len,
-						  &r.text_buf[0], r.info->text_len,
-						  &r.info->dev_info);
-		} else {
-			len = record_print_text(&r,
-						console_msg_format & MSG_FORMAT_SYSLOG,
-						printk_time);
-		}
-
-		console_lock();
-
-		/*
-		 * Even though the printk kthread is always preemptible, it is
-		 * still not allowed to call cond_resched() from within
-		 * console drivers. The task may become non-preemptible in the
-		 * console driver call chain. For example, vt_console_print()
-		 * takes a spinlock and then can call into fbcon_redraw(),
-		 * which can conditionally invoke cond_resched().
-		 */
-		console_may_schedule = 0;
-
-		if (kernel_sync_mode() && con->write_atomic) {
-			console_unlock();
-			break;
-		}
-
-		if (!(con->flags & CON_EXTENDED) && dropped) {
-			dropped_len = snprintf(dropped_text, 64,
-					       "** %lu printk messages dropped **\n",
-					       dropped);
-			dropped = 0;
-
-			con->write(con, dropped_text, dropped_len);
-			printk_delay(r.info->level);
-		}
-
-		con->write(con, write_text, len);
-		if (len)
-			printk_delay(r.info->level);
-
-		latched_seq_write(&con->printk_seq, seq);
-
-		console_unlock();
-	}
-	ret = 0;
-out:
-	kfree(dropped_text);
-	kfree(text);
-	kfree(ext_text);
-	pr_info("%sconsole [%s%d]: printing thread stopped\n",
-		(con->flags & CON_BOOT) ? "boot" : "",
-		con->name, con->index);
-	return ret;
+	kfree(d->text);
+	kfree(d->ext_text);
+	kfree(d->dropped_text);
 }
 
-/* Must be called within console_lock(). */
-static void start_printk_kthread(struct console *con)
+static void free_atomic_data(struct console_atomic_data *d)
 {
-	con->thread = kthread_run(printk_kthread_func, con,
-				  "pr/%s%d", con->name, con->index);
-	if (IS_ERR(con->thread)) {
-		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
-		       (con->flags & CON_BOOT) ? "boot" : "",
-		       con->name, con->index);
+	int count = 1;
+	int i;
+
+	if (!d)
 		return;
-	}
-	pr_info("%sconsole [%s%d]: printing thread started\n",
-		(con->flags & CON_BOOT) ? "boot" : "",
-		con->name, con->index);
+
+#ifdef CONFIG_HAVE_NMI
+	count = 2;
+#endif
+
+	for (i = 0; i < count; i++)
+		__free_atomic_data(&d[i]);
+	kfree(d);
 }
 
-/* protected by console_lock */
-static bool kthreads_started;
-
-/* Must be called within console_lock(). */
-static void console_try_thread(struct console *con)
+static int __alloc_atomic_data(struct console_atomic_data *d, short flags)
 {
-	if (kthreads_started) {
-		start_printk_kthread(con);
-		return;
+	d->text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	if (!d->text)
+		return -1;
+
+	if (flags & CON_EXTENDED) {
+		d->ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!d->ext_text)
+			return -1;
+	} else {
+		d->dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
+		if (!d->dropped_text)
+			return -1;
 	}
 
-	/*
-	 * The printing threads have not been started yet. If this console
-	 * can print synchronously, print all unprinted messages.
-	 */
-	if (console_may_sync(con)) {
-		unsigned long flags;
-
-		local_irq_save(flags);
-		print_sync_until(con, prb_next_seq(prb), true);
-		local_irq_restore(flags);
-	}
+	return 0;
 }
 
+static struct console_atomic_data *alloc_atomic_data(short flags)
+{
+	struct console_atomic_data *d;
+	int count = 1;
+	int i;
+
+#ifdef CONFIG_HAVE_NMI
+	count = 2;
+#endif
+
+	d = kzalloc(sizeof(*d) * count, GFP_KERNEL);
+	if (!d)
+		goto err_out;
+
+	for (i = 0; i < count; i++) {
+		if (__alloc_atomic_data(&d[i], flags) != 0)
+			goto err_out;
+	}
+
+	return d;
+err_out:
+	free_atomic_data(d);
+	return NULL;
+}
+#endif /* CONFIG_HAVE_ATOMIC_CONSOLE */
+
+static void start_printk_kthread(struct console *con);
+
+#else /* CONFIG_PRINTK */
+
+#define CONSOLE_LOG_MAX		0
+#define DROPPED_TEXT_MAX	0
+#define printk_time		false
+
+#define prb_read_valid(rb, seq, r)	false
+#define prb_first_valid_seq(rb)		0
+#define prb_next_seq(rb)		0
+
+#define free_atomic_data(d)
+
+static u64 syslog_seq;
+
+static size_t record_print_text(const struct printk_record *r,
+				bool syslog, bool time)
+{
+	return 0;
+}
+static ssize_t info_print_ext_header(char *buf, size_t size,
+				     struct printk_info *info)
+{
+	return 0;
+}
+static ssize_t msg_print_ext_body(char *buf, size_t size,
+				  char *text, size_t text_len,
+				  struct dev_printk_info *dev_info) { return 0; }
+static void console_lock_spinning_enable(void) { }
+static int console_lock_spinning_disable_and_check(void) { return 0; }
+static void call_console_driver(struct console *con, const char *text, size_t len,
+				char *dropped_text, bool atomic_printing) {}
+static bool suppress_message_printing(int level) { return false; }
+static void start_printk_kthread(struct console *con) {}
+
 #endif /* CONFIG_PRINTK */
 
 #ifdef CONFIG_EARLY_PRINTK
@@ -2533,6 +2601,7 @@ void suspend_console(void)
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
+	pr_flush(1000, true);
 	console_lock();
 	console_suspended = 1;
 	up_console_sem();
@@ -2545,6 +2614,7 @@ void resume_console(void)
 	down_console_sem();
 	console_suspended = 0;
 	console_unlock();
+	pr_flush(1000, true);
 }
 
 /**
@@ -2581,7 +2651,7 @@ void console_lock(void)
 	down_console_sem();
 	if (console_suspended)
 		return;
-	console_locked = 1;
+	pause_all_consoles();
 	console_may_schedule = 1;
 }
 EXPORT_SYMBOL(console_lock);
@@ -2602,18 +2672,387 @@ int console_trylock(void)
 		up_console_sem();
 		return 0;
 	}
-	console_locked = 1;
+	if (!console_excl_trylock()) {
+		up_console_sem();
+		return 0;
+	}
 	console_may_schedule = 0;
 	return 1;
 }
 EXPORT_SYMBOL(console_trylock);
 
+/*
+ * This is used to help to make sure that certain paths within the VT code are
+ * running with the console lock held. It is definitely not the perfect debug
+ * tool (it is not known if the VT code is the task holding the console lock),
+ * but it helps tracking those weird code paths in the console code such as
+ * when the console is suspended: where the console is not locked but no
+ * console printing may occur.
+ *
+ * Note: This returns true when the console is suspended but is not locked.
+ *       This is intentional because the VT code must consider that situation
+ *       the same as if the console was locked.
+ */
 int is_console_locked(void)
 {
-	return console_locked;
+	return (consoles_paused || atomic_read(&console_lock_count));
 }
 EXPORT_SYMBOL(is_console_locked);
 
+/*
+ * Check if the given console is currently capable and allowed to print
+ * records.
+ *
+ * Requires the console_lock.
+ */
+static inline bool console_is_usable(struct console *con, bool atomic_printing)
+{
+	if (!(con->flags & CON_ENABLED))
+		return false;
+
+	if (atomic_printing) {
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+		if (!con->write_atomic)
+			return false;
+		if (!con->atomic_data)
+			return false;
+#else
+		return false;
+#endif
+	} else if (!con->write) {
+		return false;
+	}
+
+	/*
+	 * Console drivers may assume that per-cpu resources have been
+	 * allocated. So unless they're explicitly marked as being able to
+	 * cope (CON_ANYTIME) don't call them until per-cpu resources have
+	 * been allocated.
+	 */
+	if (!printk_percpu_data_ready() &&
+	    !(con->flags & CON_ANYTIME))
+		return false;
+
+	return true;
+}
+
+static void __console_unlock(void)
+{
+	/*
+	 * Depending on whether console_lock() or console_trylock() was used,
+	 * appropriately allow the kthread printers to continue.
+	 */
+	if (consoles_paused)
+		unpause_all_consoles();
+	else
+		console_excl_unlock();
+
+	/* Wake the kthread printers. */
+	wake_up_klogd();
+
+	up_console_sem();
+}
+
+static u64 read_console_seq(struct console *con)
+{
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	unsigned long flags;
+	u64 seq2;
+	u64 seq;
+
+	if (!con->atomic_data)
+		return con->seq;
+
+	printk_cpu_sync_get_irqsave(flags);
+
+	seq = con->seq;
+	seq2 = con->atomic_data[0].seq;
+	if (seq2 > seq)
+		seq = seq2;
+#ifdef CONFIG_HAVE_NMI
+	seq2 = con->atomic_data[1].seq;
+	if (seq2 > seq)
+		seq = seq2;
+#endif
+
+	printk_cpu_sync_put_irqrestore(flags);
+
+	return seq;
+#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
+	return con->seq;
+#endif
+}
+
+static void write_console_seq(struct console *con, u64 val, bool atomic_printing)
+{
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	unsigned long flags;
+	u64 *seq;
+
+	if (!con->atomic_data) {
+		con->seq = val;
+		return;
+	}
+
+	printk_cpu_sync_get_irqsave(flags);
+
+	if (atomic_printing) {
+		seq = &con->atomic_data[0].seq;
+#ifdef CONFIG_HAVE_NMI
+		if (in_nmi())
+			seq = &con->atomic_data[1].seq;
+#endif
+	} else {
+		seq = &con->seq;
+	}
+	*seq = val;
+
+	printk_cpu_sync_put_irqrestore(flags);
+#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
+	con->seq = val;
+#endif
+}
+
+/*
+ * Print one record for the given console. The record printed is whatever
+ * record is the next available record for the given console.
+ *
+ * @text is a buffer of size CONSOLE_LOG_MAX.
+ *
+ * If extended messages should be printed, @ext_text is a buffer of size
+ * CONSOLE_EXT_LOG_MAX. Otherwise @ext_text must be NULL.
+ *
+ * If dropped messages should be printed, @dropped_text is a buffer of size
+ * DROPPED_TEXT_MAX. Otherise @dropped_text must be NULL.
+ *
+ * @atomic_printing specifies if atomic printing should be used.
+ *
+ * Requires the console_lock.
+ *
+ * Returns false if the given console has no next record to print, otherwise
+ * true.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock. A NULL pointer may be provided to disable allowing
+ * the console_lock to be taken over by a printk waiter.
+ */
+static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
+				     char *dropped_text, bool atomic_printing,
+				     bool *handover)
+{
+	struct printk_info info;
+	struct printk_record r;
+	unsigned long flags;
+	bool allow_handover;
+	char *write_text;
+	size_t len;
+	u64 seq;
+
+	prb_rec_init_rd(&r, &info, text, CONSOLE_LOG_MAX);
+
+	if (handover)
+		*handover = false;
+
+	seq = read_console_seq(con);
+
+	if (!prb_read_valid(prb, seq, &r))
+		return false;
+
+	if (seq != r.info->seq) {
+		atomic_long_add((unsigned long)(r.info->seq - seq), &con->dropped);
+		write_console_seq(con, r.info->seq, atomic_printing);
+		seq = r.info->seq;
+	}
+
+	/* Skip record that has level above the console loglevel. */
+	if (suppress_message_printing(r.info->level)) {
+		write_console_seq(con, seq + 1, atomic_printing);
+		goto skip;
+	}
+
+	if (ext_text) {
+		write_text = ext_text;
+		len = info_print_ext_header(ext_text, CONSOLE_EXT_LOG_MAX, r.info);
+		len += msg_print_ext_body(ext_text + len, CONSOLE_EXT_LOG_MAX - len,
+					  &r.text_buf[0], r.info->text_len, &r.info->dev_info);
+	} else {
+		write_text = text;
+		len = record_print_text(&r, console_msg_format & MSG_FORMAT_SYSLOG, printk_time);
+	}
+
+#if (IS_ENABLED(CONFIG_PREEMPT_RT))
+	/* PREEMPT_RT does not support console lock handovers. */
+	allow_handover = false;
+#else
+	/* Handovers may only happen between trylock contexts. */
+	allow_handover = (handover && atomic_read(&console_lock_count) == -1);
+#endif
+
+	if (allow_handover) {
+		/*
+		 * While actively printing out messages, if another printk()
+		 * were to occur on another CPU, it may wait for this one to
+		 * finish. This task can not be preempted if there is a
+		 * waiter waiting to take over.
+		 *
+		 * Interrupts are disabled because the hand over to a waiter
+		 * must not be interrupted until the hand over is completed
+		 * (@console_waiter is cleared).
+		 */
+		printk_safe_enter_irqsave(flags);
+		console_lock_spinning_enable();
+	}
+
+	stop_critical_timings();	/* don't trace print latency */
+	call_console_driver(con, write_text, len, dropped_text, atomic_printing);
+	start_critical_timings();
+
+	write_console_seq(con, seq + 1, atomic_printing);
+
+	if (allow_handover) {
+		*handover = console_lock_spinning_disable_and_check();
+		printk_safe_exit_irqrestore(flags);
+	}
+
+	boot_delay_msec(r.info->level);
+	printk_delay();
+skip:
+	return true;
+}
+
+/*
+ * Print out all remaining records to all consoles.
+ *
+ * Requires the console_lock.
+ *
+ * Returns true if a console was available for flushing, otherwise false.
+ *
+ * @next_seq is set to the highest sequence number of all of the consoles that
+ * were flushed.
+ *
+ * @handover will be set to true if a printk waiter has taken over the
+ * console_lock, in which case the caller is no longer holding the
+ * console_lock.
+ */
+static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
+{
+	static char dropped_text[DROPPED_TEXT_MAX];
+	static char ext_text[CONSOLE_EXT_LOG_MAX];
+	static char text[CONSOLE_LOG_MAX];
+	bool any_usable = false;
+	struct console *con;
+	bool any_progress;
+
+	*next_seq = 0;
+	*handover = false;
+
+	do {
+		/* Let the kthread printers do the work if they can. */
+		if (kthread_printers_active())
+			return false;
+
+		any_progress = false;
+
+		for_each_console(con) {
+			bool progress;
+
+			if (!console_is_usable(con, false))
+				continue;
+			if ((con->flags & CON_MIGHT_SLEEP) && !do_cond_resched)
+				continue;
+			any_usable = true;
+
+			if (con->flags & CON_EXTENDED) {
+				/* Extended consoles do not print "dropped messages". */
+				progress = console_emit_next_record(con, &text[0],
+								    &ext_text[0], NULL,
+								    false, handover);
+			} else {
+				progress = console_emit_next_record(con, &text[0],
+								    NULL, &dropped_text[0],
+								    false, handover);
+			}
+			if (*handover)
+				return true;
+
+			/* Track the highest seq flushed. */
+			if (con->seq > *next_seq)
+				*next_seq = con->seq;
+
+			if (!progress)
+				continue;
+			any_progress = true;
+
+			if (do_cond_resched)
+				cond_resched();
+		}
+	} while (any_progress);
+
+	return any_usable;
+}
+
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+static void atomic_console_flush_all(void)
+{
+	bool any_usable = false;
+	unsigned long flags;
+	struct console *con;
+	bool any_progress;
+	int index = 0;
+
+	if (console_suspended)
+		return;
+
+#ifdef CONFIG_HAVE_NMI
+	if (in_nmi())
+		index = 1;
+#endif
+
+	printk_cpu_sync_get_irqsave(flags);
+
+	do {
+		any_progress = false;
+
+		for_each_console(con) {
+			bool progress;
+
+			if (!console_is_usable(con, true))
+				continue;
+			any_usable = true;
+
+			if (con->flags & CON_EXTENDED) {
+				/* Extended consoles do not print "dropped messages". */
+				progress = console_emit_next_record(con,
+							&con->atomic_data->text[index],
+							&con->atomic_data->ext_text[index],
+							NULL,
+							true, NULL);
+			} else {
+				progress = console_emit_next_record(con,
+							&con->atomic_data->text[index],
+							NULL,
+							&con->atomic_data->dropped_text[index],
+							true, NULL);
+			}
+
+			if (!progress)
+				continue;
+			any_progress = true;
+
+			touch_softlockup_watchdog_sync();
+			clocksource_touch_watchdog();
+			rcu_cpu_stall_reset();
+			touch_nmi_watchdog();
+		}
+	} while (any_progress);
+
+	printk_cpu_sync_put_irqrestore(flags);
+}
+#else /* CONFIG_HAVE_ATOMIC_CONSOLE */
+#define atomic_console_flush_all()
+#endif
+
 /**
  * console_unlock - unlock the console system
  *
@@ -2630,13 +3069,52 @@ EXPORT_SYMBOL(is_console_locked);
  */
 void console_unlock(void)
 {
+	bool do_cond_resched;
+	bool handover;
+	bool flushed;
+	u64 next_seq;
+
 	if (console_suspended) {
 		up_console_sem();
 		return;
 	}
 
-	console_locked = 0;
-	up_console_sem();
+	/*
+	 * Console drivers are called with interrupts disabled, so
+	 * @console_may_schedule should be cleared before; however, we may
+	 * end up dumping a lot of lines, for example, if called from
+	 * console registration path, and should invoke cond_resched()
+	 * between lines if allowable.  Not doing so can cause a very long
+	 * scheduling stall on a slow console leading to RCU stall and
+	 * softlockup warnings which exacerbate the issue with more
+	 * messages practically incapacitating the system.
+	 *
+	 * console_trylock() is not able to detect the preemptive
+	 * context reliably. Therefore the value must be stored before
+	 * and cleared after the "again" goto label.
+	 */
+	do_cond_resched = console_may_schedule;
+
+	do {
+		console_may_schedule = 0;
+
+		flushed = console_flush_all(do_cond_resched, &next_seq, &handover);
+		if (handover)
+			break;
+
+		__console_unlock();
+
+		/* Were there any consoles available for flushing? */
+		if (!flushed)
+			break;
+
+		/*
+		 * Some context may have added new records after
+		 * console_flush_all() but before unlocking the console.
+		 * Re-check if there is a new record to flush. If the trylock
+		 * fails, another context is already handling the printing.
+		 */
+	} while (prb_read_valid(prb, next_seq, NULL) && console_trylock());
 }
 EXPORT_SYMBOL(console_unlock);
 
@@ -2667,10 +3145,15 @@ void console_unblank(void)
 	if (oops_in_progress) {
 		if (down_trylock_console_sem() != 0)
 			return;
-	} else
+		if (!console_excl_trylock()) {
+			up_console_sem();
+			return;
+		}
+	} else {
+		pr_flush(1000, true);
 		console_lock();
+	}
 
-	console_locked = 1;
 	console_may_schedule = 0;
 	for_each_console(c)
 		if ((c->flags & CON_ENABLED) && c->unblank)
@@ -2686,20 +3169,29 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
-	if (!console_trylock())
+	if (mode == CONSOLE_ATOMIC_FLUSH_PENDING) {
+		atomic_console_flush_all();
 		return;
+	}
+
+	/*
+	 * If someone else is holding the console lock, trylock will fail
+	 * and may_schedule may be set.  Ignore and proceed to unlock so
+	 * that messages are flushed out.  As this can be called from any
+	 * context and we don't want to get preempted while flushing,
+	 * ensure may_schedule is cleared.
+	 */
+	console_trylock();
+	console_may_schedule = 0;
 
-#ifdef CONFIG_PRINTK
 	if (mode == CONSOLE_REPLAY_ALL) {
 		struct console *c;
 		u64 seq;
 
 		seq = prb_first_valid_seq(prb);
 		for_each_console(c)
-			latched_seq_write(&c->printk_seq, seq);
+			write_console_seq(c, seq, false);
 	}
-#endif
-
 	console_unlock();
 }
 
@@ -2730,6 +3222,7 @@ struct tty_driver *console_device(int *index)
  */
 void console_stop(struct console *console)
 {
+	pr_flush(1000, true);
 	console_lock();
 	console->flags &= ~CON_ENABLED;
 	console_unlock();
@@ -2741,6 +3234,7 @@ void console_start(struct console *console)
 	console_lock();
 	console->flags |= CON_ENABLED;
 	console_unlock();
+	pr_flush(1000, true);
 }
 EXPORT_SYMBOL(console_start);
 
@@ -2835,7 +3329,6 @@ static int try_enable_new_console(struct console *newcon, bool user_specified)
 void register_console(struct console *newcon)
 {
 	struct console *bcon = NULL;
-	u64 __maybe_unused seq = 0;
 	int err;
 
 	for_each_console(bcon) {
@@ -2858,8 +3351,6 @@ void register_console(struct console *newcon)
 		}
 	}
 
-	newcon->thread = NULL;
-
 	if (console_drivers && console_drivers->flags & CON_BOOT)
 		bcon = console_drivers;
 
@@ -2901,10 +3392,8 @@ void register_console(struct console *newcon)
 	 * the real console are the same physical device, it's annoying to
 	 * see the beginning boot messages twice
 	 */
-	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV)) {
+	if (bcon && ((newcon->flags & (CON_CONSDEV | CON_BOOT)) == CON_CONSDEV))
 		newcon->flags &= ~CON_PRINTBUFFER;
-		newcon->flags |= CON_HANDOVER;
-	}
 
 	/*
 	 *	Put this console in the list - keep the
@@ -2926,21 +3415,25 @@ void register_console(struct console *newcon)
 	if (newcon->flags & CON_EXTENDED)
 		nr_ext_console_drivers++;
 
-#ifdef CONFIG_PRINTK
-	if (!(newcon->flags & CON_PRINTBUFFER))
-		seq = prb_next_seq(prb);
+	if (consoles_paused)
+		newcon->flags |= CON_PAUSED;
 
-	seqcount_latch_init(&newcon->printk_seq.latch);
-	latched_seq_write(&newcon->printk_seq, seq);
-	seqcount_latch_init(&newcon->printk_sync_seq.latch);
-	latched_seq_write(&newcon->printk_sync_seq, seq);
-#ifdef CONFIG_HAVE_NMI
-	seqcount_latch_init(&newcon->printk_sync_nmi_seq.latch);
-	latched_seq_write(&newcon->printk_sync_nmi_seq, seq);
+	atomic_long_set(&newcon->dropped, 0);
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	newcon->atomic_data = NULL;
 #endif
-
-	console_try_thread(newcon);
-#endif /* CONFIG_PRINTK */
+	mutex_init(&newcon->lock);
+	if (newcon->flags & CON_PRINTBUFFER) {
+		/* Get a consistent copy of @syslog_seq. */
+		mutex_lock(&syslog_lock);
+		write_console_seq(newcon, syslog_seq, false);
+		mutex_unlock(&syslog_lock);
+	} else {
+		/* Begin with next message. */
+		write_console_seq(newcon, prb_next_seq(prb), false);
+	}
+	if (kthreads_started)
+		start_printk_kthread(newcon);
 	console_unlock();
 	console_sysfs_notify();
 
@@ -2997,6 +3490,11 @@ int unregister_console(struct console *console)
 		}
 	}
 
+	if (console->thread) {
+		kthread_stop(console->thread);
+		console->thread = NULL;
+	}
+
 	if (res)
 		goto out_disable_unlock;
 
@@ -3014,8 +3512,9 @@ int unregister_console(struct console *console)
 	console_unlock();
 	console_sysfs_notify();
 
-	if (console->thread && !IS_ERR(console->thread))
-		kthread_stop(console->thread);
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	free_atomic_data(console->atomic_data);
+#endif
 
 	if (console->exit)
 		res = console->exit(console);
@@ -3099,30 +3598,216 @@ static int __init printk_late_init(void)
 			unregister_console(con);
 		}
 	}
-
-#ifdef CONFIG_PRINTK
-	console_lock();
-	for_each_console(con)
-		start_printk_kthread(con);
-	kthreads_started = true;
-	console_unlock();
-#endif
-
 	ret = cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
 					console_cpu_notify);
 	WARN_ON(ret < 0);
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "printk:online",
 					console_cpu_notify, NULL);
 	WARN_ON(ret < 0);
+
+	console_lock();
+	for_each_console(con)
+		start_printk_kthread(con);
+	kthreads_started = true;
+	console_unlock();
+
 	return 0;
 }
 late_initcall(printk_late_init);
 
 #if defined CONFIG_PRINTK
+/**
+ * pr_flush() - Wait for printing threads to catch up.
+ *
+ * @timeout_ms:        The maximum time (in ms) to wait.
+ * @reset_on_progress: Reset the timeout if forward progress is seen.
+ *
+ * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
+ * represents infinite waiting.
+ *
+ * If @reset_on_progress is true, the timeout will be reset whenever any
+ * printer has been seen to make some forward progress.
+ *
+ * Context: Process context. May sleep while acquiring console lock.
+ * Return: true if all enabled printers are caught up.
+ */
+bool pr_flush(int timeout_ms, bool reset_on_progress)
+{
+	int remaining = timeout_ms;
+	struct console *con;
+	u64 last_diff = 0;
+	u64 printk_seq;
+	u64 diff;
+	u64 seq;
+
+	might_sleep();
+
+	seq = prb_next_seq(prb);
+
+	for (;;) {
+		diff = 0;
+
+		console_lock();
+		for_each_console(con) {
+			if (!console_is_usable(con, false))
+				continue;
+			printk_seq = con->seq;
+			if (printk_seq < seq)
+				diff += seq - printk_seq;
+		}
+		console_unlock();
+
+		if (diff != last_diff && reset_on_progress)
+			remaining = timeout_ms;
+
+		if (diff == 0 || remaining == 0)
+			break;
+
+		if (remaining < 0) {
+			/* no timeout limit */
+			msleep(100);
+		} else if (remaining < 100) {
+			msleep(remaining);
+			remaining = 0;
+		} else {
+			msleep(100);
+			remaining -= 100;
+		}
+
+		last_diff = diff;
+	}
+
+	return (diff == 0);
+}
+EXPORT_SYMBOL(pr_flush);
+
+static bool printer_should_wake(struct console *con, u64 seq)
+{
+	short flags;
+
+	if (kthread_should_stop())
+		return true;
+
+	/*
+	 * This is an unsafe read to con->flags, but false positives
+	 * are not an issue as long as they are rare.
+	 */
+	flags = data_race(READ_ONCE(con->flags));
+
+	if (!(flags & CON_ENABLED) ||
+	    (flags & CON_PAUSED) ||
+	    atomic_read(&console_lock_count) == -1) {
+		return false;
+	}
+
+	return prb_read_valid(prb, seq, NULL);
+}
+
+static int printk_kthread_func(void *data)
+{
+	struct console *con = data;
+	char *dropped_text = NULL;
+	char *ext_text = NULL;
+	bool progress;
+	u64 seq = 0;
+	char *text;
+	int error;
+
+	pr_info("%sconsole [%s%d]: printing thread started\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+
+#ifdef CONFIG_HAVE_ATOMIC_CONSOLE
+	if (con->write_atomic)
+		con->atomic_data = alloc_atomic_data(con->flags);
+#endif
+
+	text = kmalloc(CONSOLE_LOG_MAX, GFP_KERNEL);
+	if (!text)
+		goto out;
+
+	if (con->flags & CON_EXTENDED) {
+		ext_text = kmalloc(CONSOLE_EXT_LOG_MAX, GFP_KERNEL);
+		if (!ext_text)
+			goto out;
+	} else {
+		dropped_text = kmalloc(DROPPED_TEXT_MAX, GFP_KERNEL);
+		if (!dropped_text)
+			goto out;
+	}
+
+	for (;;) {
+		error = wait_event_interruptible(log_wait, printer_should_wake(con, seq));
+
+		if (kthread_should_stop())
+			break;
+
+		if (error)
+			continue;
+
+		do {
+			error = mutex_lock_interruptible(&con->lock);
+			if (error)
+				break;
+
+			if (!console_is_usable(con, false)) {
+				mutex_unlock(&con->lock);
+				break;
+			}
+
+			if ((con->flags & CON_PAUSED) || !console_printer_tryenter()) {
+				mutex_unlock(&con->lock);
+				break;
+			}
+
+			/*
+			 * Even though the printk kthread is always preemptible, it is
+			 * still not allowed to call cond_resched() from within
+			 * console drivers. The task may become non-preemptible in the
+			 * console driver call chain. For example, vt_console_print()
+			 * takes a spinlock and then can call into fbcon_redraw(),
+			 * which can conditionally invoke cond_resched().
+			 */
+			console_may_schedule = 0;
+			progress = console_emit_next_record(con, text, ext_text,
+							    dropped_text, false, NULL);
+
+			seq = con->seq;
+
+			console_printer_exit();
+
+			mutex_unlock(&con->lock);
+		} while (progress);
+	}
+out:
+	kfree(dropped_text);
+	kfree(ext_text);
+	kfree(text);
+	pr_info("%sconsole [%s%d]: printing thread stopped\n",
+		(con->flags & CON_BOOT) ? "boot" : "",
+		con->name, con->index);
+	return 0;
+}
+
+/* Must be called within console_lock(). */
+static void start_printk_kthread(struct console *con)
+{
+	con->thread = kthread_run(printk_kthread_func, con,
+				  "pr/%s%d", con->name, con->index);
+	if (IS_ERR(con->thread)) {
+		con->thread = NULL;
+		pr_err("%sconsole [%s%d]: unable to start printing thread\n",
+			(con->flags & CON_BOOT) ? "boot" : "",
+			con->name, con->index);
+		return;
+	}
+}
+
 /*
  * Delayed printk version, for scheduler-internal messages:
  */
 #define PRINTK_PENDING_WAKEUP	0x01
+#define PRINTK_PENDING_OUTPUT	0x02
 
 static DEFINE_PER_CPU(int, printk_pending);
 
@@ -3130,6 +3815,12 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
 {
 	int pending = __this_cpu_xchg(printk_pending, 0);
 
+	if (pending & PRINTK_PENDING_OUTPUT) {
+		/* If trylock fails, someone else is doing the printing */
+		if (console_trylock())
+			console_unlock();
+	}
+
 	if (pending & PRINTK_PENDING_WAKEUP)
 		wake_up_interruptible_all(&log_wait);
 }
@@ -3150,9 +3841,42 @@ void wake_up_klogd(void)
 	preempt_enable();
 }
 
+void defer_console_output(void)
+{
+	if (!printk_percpu_data_ready())
+		return;
+
+	preempt_disable();
+	__this_cpu_or(printk_pending, PRINTK_PENDING_OUTPUT);
+	irq_work_queue(this_cpu_ptr(&wake_up_klogd_work));
+	preempt_enable();
+}
+
 void printk_trigger_flush(void)
 {
-	wake_up_klogd();
+	defer_console_output();
+}
+
+int vprintk_deferred(const char *fmt, va_list args)
+{
+	int r;
+
+	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
+	defer_console_output();
+
+	return r;
+}
+
+int _printk_deferred(const char *fmt, ...)
+{
+	va_list args;
+	int r;
+
+	va_start(args, fmt);
+	r = vprintk_deferred(fmt, args);
+	va_end(args);
+
+	return r;
 }
 
 /*
@@ -3281,24 +4005,6 @@ void kmsg_dump(enum kmsg_dump_reason reason)
 {
 	struct kmsg_dumper *dumper;
 
-	if (!oops_in_progress) {
-		/*
-		 * If atomic consoles are available, activate kernel sync mode
-		 * to make sure any final messages are visible. The trailing
-		 * printk message is important to flush any pending messages.
-		 */
-		if (have_atomic_console()) {
-			sync_mode = true;
-			pr_info("enabled sync mode\n");
-		}
-
-		/*
-		 * Give the printing threads time to flush, allowing up to
-		 * 1s of no printing forward progress before giving up.
-		 */
-		pr_flush(1000, true);
-	}
-
 	rcu_read_lock();
 	list_for_each_entry_rcu(dumper, &dump_list, list) {
 		enum kmsg_dump_reason max_reason = dumper->max_reason;
@@ -3479,27 +4185,26 @@ EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
 #endif
 
 #ifdef CONFIG_SMP
-static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
-static atomic_t printk_cpulock_nested = ATOMIC_INIT(0);
-static unsigned int kgdb_cpu = -1;
+static atomic_t printk_cpu_sync_owner = ATOMIC_INIT(-1);
+static atomic_t printk_cpu_sync_nested = ATOMIC_INIT(0);
 
 /**
- * __printk_wait_on_cpu_lock() - Busy wait until the printk cpu-reentrant
- *                               spinning lock is not owned by any CPU.
+ * __printk_cpu_sync_wait() - Busy wait until the printk cpu-reentrant
+ *                            spinning lock is not owned by any CPU.
  *
  * Context: Any context.
  */
-void __printk_wait_on_cpu_lock(void)
+void __printk_cpu_sync_wait(void)
 {
 	do {
 		cpu_relax();
-	} while (atomic_read(&printk_cpulock_owner) != -1);
+	} while (atomic_read(&printk_cpu_sync_owner) != -1);
 }
-EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
+EXPORT_SYMBOL(__printk_cpu_sync_wait);
 
 /**
- * __printk_cpu_trylock() - Try to acquire the printk cpu-reentrant
- *                          spinning lock.
+ * __printk_cpu_sync_try_get() - Try to acquire the printk cpu-reentrant
+ *                               spinning lock.
  *
  * If no processor has the lock, the calling processor takes the lock and
  * becomes the owner. If the calling processor is already the owner of the
@@ -3508,7 +4213,7 @@ EXPORT_SYMBOL(__printk_wait_on_cpu_lock);
  * Context: Any context. Expects interrupts to be disabled.
  * Return: 1 on success, otherwise 0.
  */
-int __printk_cpu_trylock(void)
+int __printk_cpu_sync_try_get(void)
 {
 	int cpu;
 	int old;
@@ -3518,180 +4223,80 @@ int __printk_cpu_trylock(void)
 	/*
 	 * Guarantee loads and stores from this CPU when it is the lock owner
 	 * are _not_ visible to the previous lock owner. This pairs with
-	 * __printk_cpu_unlock:B.
+	 * __printk_cpu_sync_put:B.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B, then
-	 * __printk_cpu_unlock:A can never read from __printk_cpu_trylock:B.
+	 * If __printk_cpu_sync_try_get:A reads from __printk_cpu_sync_put:B,
+	 * then __printk_cpu_sync_put:A can never read from
+	 * __printk_cpu_sync_try_get:B.
 	 *
 	 * Relies on:
 	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * RELEASE from __printk_cpu_sync_put:A to __printk_cpu_sync_put:B
 	 * of the previous CPU
 	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of this CPU
+	 * ACQUIRE from __printk_cpu_sync_try_get:A to
+	 * __printk_cpu_sync_try_get:B of this CPU
 	 */
-	old = atomic_cmpxchg_acquire(&printk_cpulock_owner, -1,
-				     cpu); /* LMM(__printk_cpu_trylock:A) */
+	old = atomic_cmpxchg_acquire(&printk_cpu_sync_owner, -1,
+				     cpu); /* LMM(__printk_cpu_sync_try_get:A) */
 	if (old == -1) {
 		/*
 		 * This CPU is now the owner and begins loading/storing
-		 * data: LMM(__printk_cpu_trylock:B)
+		 * data: LMM(__printk_cpu_sync_try_get:B)
 		 */
 		return 1;
 
 	} else if (old == cpu) {
 		/* This CPU is already the owner. */
-		atomic_inc(&printk_cpulock_nested);
+		atomic_inc(&printk_cpu_sync_nested);
 		return 1;
 	}
 
 	return 0;
 }
-EXPORT_SYMBOL(__printk_cpu_trylock);
+EXPORT_SYMBOL(__printk_cpu_sync_try_get);
 
 /**
- * __printk_cpu_unlock() - Release the printk cpu-reentrant spinning lock.
+ * __printk_cpu_sync_put() - Release the printk cpu-reentrant spinning lock.
  *
  * The calling processor must be the owner of the lock.
  *
  * Context: Any context. Expects interrupts to be disabled.
  */
-void __printk_cpu_unlock(void)
+void __printk_cpu_sync_put(void)
 {
-	bool trigger_kgdb = false;
-	unsigned int cpu;
-
-	if (atomic_read(&printk_cpulock_nested)) {
-		atomic_dec(&printk_cpulock_nested);
+	if (atomic_read(&printk_cpu_sync_nested)) {
+		atomic_dec(&printk_cpu_sync_nested);
 		return;
 	}
 
 	/*
 	 * This CPU is finished loading/storing data:
-	 * LMM(__printk_cpu_unlock:A)
+	 * LMM(__printk_cpu_sync_put:A)
 	 */
 
-	cpu = smp_processor_id();
-	if (kgdb_cpu == cpu) {
-		trigger_kgdb = true;
-		kgdb_cpu = -1;
-	}
-
 	/*
 	 * Guarantee loads and stores from this CPU when it was the
 	 * lock owner are visible to the next lock owner. This pairs
-	 * with __printk_cpu_trylock:A.
+	 * with __printk_cpu_sync_try_get:A.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If __printk_cpu_trylock:A reads from __printk_cpu_unlock:B,
-	 * then __printk_cpu_trylock:B reads from __printk_cpu_unlock:A.
+	 * If __printk_cpu_sync_try_get:A reads from __printk_cpu_sync_put:B,
+	 * then __printk_cpu_sync_try_get:B reads from __printk_cpu_sync_put:A.
 	 *
 	 * Relies on:
 	 *
-	 * RELEASE from __printk_cpu_unlock:A to __printk_cpu_unlock:B
+	 * RELEASE from __printk_cpu_sync_put:A to __printk_cpu_sync_put:B
 	 * of this CPU
 	 *    matching
-	 * ACQUIRE from __printk_cpu_trylock:A to __printk_cpu_trylock:B
-	 * of the next CPU
+	 * ACQUIRE from __printk_cpu_sync_try_get:A to
+	 * __printk_cpu_sync_try_get:B of the next CPU
 	 */
-	atomic_set_release(&printk_cpulock_owner,
-			   -1); /* LMM(__printk_cpu_unlock:B) */
-
-	if (trigger_kgdb) {
-		pr_warn("re-triggering kgdb roundup for CPU#%d\n", cpu);
-		kgdb_roundup_cpu(cpu);
-	}
+	atomic_set_release(&printk_cpu_sync_owner,
+			   -1); /* LMM(__printk_cpu_sync_put:B) */
 }
-EXPORT_SYMBOL(__printk_cpu_unlock);
-
-bool kgdb_roundup_delay(unsigned int cpu)
-{
-	if (cpu != atomic_read(&printk_cpulock_owner))
-		return false;
-
-	kgdb_cpu = cpu;
-	return true;
-}
-EXPORT_SYMBOL(kgdb_roundup_delay);
+EXPORT_SYMBOL(__printk_cpu_sync_put);
 #endif /* CONFIG_SMP */
-
-#ifdef CONFIG_PRINTK
-static void pr_msleep(bool may_sleep, int ms)
-{
-	if (may_sleep) {
-		msleep(ms);
-	} else {
-		while (ms--)
-			udelay(1000);
-	}
-}
-
-/**
- * pr_flush() - Wait for printing threads to catch up.
- *
- * @timeout_ms:        The maximum time (in ms) to wait.
- * @reset_on_progress: Reset the timeout if forward progress is seen.
- *
- * A value of 0 for @timeout_ms means no waiting will occur. A value of -1
- * represents infinite waiting.
- *
- * If @reset_on_progress is true, the timeout will be reset whenever any
- * printer has been seen to make some forward progress.
- *
- * Context: Any context.
- * Return: true if all enabled printers are caught up.
- */
-bool pr_flush(int timeout_ms, bool reset_on_progress)
-{
-	int remaining = timeout_ms;
-	struct console *con;
-	u64 last_diff = 0;
-	bool may_sleep;
-	u64 printk_seq;
-	u64 diff;
-	u64 seq;
-
-	may_sleep = (preemptible() &&
-		     !in_softirq() &&
-		     system_state >= SYSTEM_RUNNING);
-
-	seq = prb_next_seq(prb);
-
-	for (;;) {
-		diff = 0;
-
-		for_each_console(con) {
-			if (!(con->flags & CON_ENABLED))
-				continue;
-			printk_seq = read_console_seq(con);
-			if (printk_seq < seq)
-				diff += seq - printk_seq;
-		}
-
-		if (diff != last_diff && reset_on_progress)
-			remaining = timeout_ms;
-
-		if (diff == 0 || remaining == 0)
-			break;
-
-		if (remaining < 0) {
-			pr_msleep(may_sleep, 100);
-		} else if (remaining < 100) {
-			pr_msleep(may_sleep, remaining);
-			remaining = 0;
-		} else {
-			pr_msleep(may_sleep, 100);
-			remaining -= 100;
-		}
-
-		last_diff = diff;
-	}
-
-	return (diff == 0);
-}
-EXPORT_SYMBOL(pr_flush);
-#endif /* CONFIG_PRINTK */
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
new file mode 100644
index 0000000000000..ef0f9a2044da1
--- /dev/null
+++ b/kernel/printk/printk_safe.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * printk_safe.c - Safe printk for printk-deadlock-prone contexts
+ */
+
+#include <linux/preempt.h>
+#include <linux/kdb.h>
+#include <linux/smp.h>
+#include <linux/cpumask.h>
+#include <linux/printk.h>
+#include <linux/kprobes.h>
+
+#include "internal.h"
+
+static DEFINE_PER_CPU(int, printk_context);
+
+/* Can be preempted by NMI. */
+void __printk_safe_enter(void)
+{
+	this_cpu_inc(printk_context);
+}
+
+/* Can be preempted by NMI. */
+void __printk_safe_exit(void)
+{
+	this_cpu_dec(printk_context);
+}
+
+asmlinkage int vprintk(const char *fmt, va_list args)
+{
+#ifdef CONFIG_KGDB_KDB
+	/* Allow to pass printk() to kdb but avoid a recursion. */
+	if (unlikely(kdb_trap_printk && kdb_printf_cpu < 0))
+		return vkdb_printf(KDB_MSGSRC_PRINTK, fmt, args);
+#endif
+
+	/*
+	 * Use the main logbuf even in NMI. But avoid calling console
+	 * drivers that might have their own locks.
+	 */
+	if (this_cpu_read(printk_context) || in_nmi()) {
+		int len;
+
+		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
+		defer_console_output();
+		return len;
+	}
+
+	/* No obstacles. */
+	return vprintk_default(fmt, args);
+}
+EXPORT_SYMBOL(vprintk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c36ba56de8f75..04165fa6ff25a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3011,8 +3011,9 @@ void force_compatible_cpus_allowed_ptr(struct task_struct *p)
 
 out_set_mask:
 	if (printk_ratelimit()) {
-		printk("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
-		       task_pid_nr(p), p->comm, cpumask_pr_args(override_mask));
+		printk_deferred("Overriding affinity for process %d (%s) to CPUs %*pbl\n",
+				task_pid_nr(p), p->comm,
+				cpumask_pr_args(override_mask));
 	}
 
 	WARN_ON(set_cpus_allowed_ptr(p, override_mask));
@@ -3442,8 +3443,8 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 		 * leave kernel.
 		 */
 		if (p->mm && printk_ratelimit()) {
-			printk("process %d (%s) no longer affine to cpu%d\n",
-			       task_pid_nr(p), p->comm, cpu);
+			printk_deferred("process %d (%s) no longer affine to cpu%d\n",
+					task_pid_nr(p), p->comm, cpu);
 		}
 	}
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 65d4cc198e44c..d2c072b0ef01f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -800,7 +800,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	 * entity.
 	 */
 	if (dl_time_before(dl_se->deadline, rq_clock(rq))) {
-		printk_once("sched: DL replenish lagged too much\n");
+		printk_deferred_once("sched: DL replenish lagged too much\n");
 		dl_se->deadline = rq_clock(rq) + pi_of(dl_se)->dl_deadline;
 		dl_se->runtime = pi_of(dl_se)->dl_runtime;
 	}
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index ab54b2012469f..1652f2bb54b79 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -710,10 +710,10 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (groupc->tasks[t]) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			pr_err("psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
-			       cpu, t, groupc->tasks[0],
-			       groupc->tasks[1], groupc->tasks[2],
-			       groupc->tasks[3], clear, set);
+			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+					cpu, t, groupc->tasks[0],
+					groupc->tasks[1], groupc->tasks[2],
+					groupc->tasks[3], clear, set);
 			psi_bug = 1;
 		}
 	}
@@ -779,9 +779,9 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 	if (((task->psi_flags & set) ||
 	     (task->psi_flags & clear) != clear) &&
 	    !psi_bug) {
-		pr_err("psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
-		       task->pid, task->comm, task_cpu(task),
-		       task->psi_flags, clear, set);
+		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
+				task->pid, task->comm, task_cpu(task),
+				task->psi_flags, clear, set);
 		psi_bug = 1;
 	}
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7a5948eeb57b9..b48baaba2fc2e 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -977,7 +977,7 @@ static int sched_rt_runtime_exceeded(struct rt_rq *rt_rq)
 		 */
 		if (likely(rt_b->rt_runtime)) {
 			rt_rq->rt_throttled = 1;
-			printk_once("sched: RT throttling activated\n");
+			printk_deferred_once("sched: RT throttling activated\n");
 		} else {
 			/*
 			 * In case we did anyway, make it go away,
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 429182f6e7b0f..cfb0893a83d45 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -62,7 +62,7 @@ check_schedstat_required(void)
 	    trace_sched_stat_iowait_enabled()  ||
 	    trace_sched_stat_blocked_enabled() ||
 	    trace_sched_stat_runtime_enabled())
-		printk_once("Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1\n");
+		printk_deferred_once("Scheduler tracepoints stat_sleep, stat_iowait, stat_blocked and stat_runtime require the kernel parameter schedstats=enable or kernel.sched_schedstats=1\n");
 }
 
 #else /* !CONFIG_SCHEDSTATS: */
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 00fc43605c6b1..003ccf338d201 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -203,7 +203,8 @@ static int clockevents_increase_min_delta(struct clock_event_device *dev)
 {
 	/* Nothing to do if we already reached the limit */
 	if (dev->min_delta_ns >= MIN_DELTA_LIMIT) {
-		pr_warn("CE: Reprogramming failure. Giving up\n");
+		printk_deferred(KERN_WARNING
+				"CE: Reprogramming failure. Giving up\n");
 		dev->next_event = KTIME_MAX;
 		return -ETIME;
 	}
@@ -216,8 +217,10 @@ static int clockevents_increase_min_delta(struct clock_event_device *dev)
 	if (dev->min_delta_ns > MIN_DELTA_LIMIT)
 		dev->min_delta_ns = MIN_DELTA_LIMIT;
 
-	pr_warn("CE: %s increased min_delta_ns to %llu nsec\n",
-		dev->name ? dev->name : "?", (unsigned long long) dev->min_delta_ns);
+	printk_deferred(KERN_WARNING
+			"CE: %s increased min_delta_ns to %llu nsec\n",
+			dev->name ? dev->name : "?",
+			(unsigned long long) dev->min_delta_ns);
 	return 0;
 }
 
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 829d7797811fb..406dccb79c2b6 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -939,7 +939,9 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 		time_status |= STA_PPSERROR;
 		pps_errcnt++;
 		pps_dec_freq_interval();
-		pr_err("hardpps: PPSERROR: interval too long - %lld s\n", freq_norm.sec);
+		printk_deferred(KERN_ERR
+			"hardpps: PPSERROR: interval too long - %lld s\n",
+			freq_norm.sec);
 		return 0;
 	}
 
@@ -952,7 +954,8 @@ static long hardpps_update_freq(struct pps_normtime freq_norm)
 	delta = shift_right(ftemp - pps_freq, NTP_SCALE_SHIFT);
 	pps_freq = ftemp;
 	if (delta > PPS_MAXWANDER || delta < -PPS_MAXWANDER) {
-		pr_warn("hardpps: PPSWANDER: change=%ld\n", delta);
+		printk_deferred(KERN_WARNING
+				"hardpps: PPSWANDER: change=%ld\n", delta);
 		time_status |= STA_PPSWANDER;
 		pps_stbcnt++;
 		pps_dec_freq_interval();
@@ -996,8 +999,9 @@ static void hardpps_update_phase(long error)
 	 * the time offset is updated.
 	 */
 	if (jitter > (pps_jitter << PPS_POPCORN)) {
-		pr_warn("hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
-			jitter, (pps_jitter << PPS_POPCORN));
+		printk_deferred(KERN_WARNING
+				"hardpps: PPSJITTER: jitter=%ld, limit=%ld\n",
+				jitter, (pps_jitter << PPS_POPCORN));
 		time_status |= STA_PPSJITTER;
 		pps_jitcnt++;
 	} else if (time_status & STA_PPSTIME) {
@@ -1054,7 +1058,7 @@ void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_t
 		time_status |= STA_PPSJITTER;
 		/* restart the frequency calibration interval */
 		pps_fbase = *raw_ts;
-		pr_err("hardpps: PPSJITTER: bad pulse\n");
+		printk_deferred(KERN_ERR "hardpps: PPSJITTER: bad pulse\n");
 		return;
 	}
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 5714e8b281eeb..dcdcb85121e40 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -203,23 +203,22 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	const char *name = tk->tkr_mono.clock->name;
 
 	if (offset > max_cycles) {
-		printk("WARNING: timekeeping: Cycle offset (%lld) is larger than allowed by the '%s' clock's max_cycles value (%lld): time overflow danger\n",
-		       offset, name, max_cycles);
-		printk("         timekeeping: Your kernel is sick, but tries to cope by capping time updates\n");
+		printk_deferred("WARNING: timekeeping: Cycle offset (%lld) is larger than allowed by the '%s' clock's max_cycles value (%lld): time overflow danger\n",
+				offset, name, max_cycles);
+		printk_deferred("         timekeeping: Your kernel is sick, but tries to cope by capping time updates\n");
 	} else {
 		if (offset > (max_cycles >> 1)) {
-			printk("INFO: timekeeping: Cycle offset (%lld) is larger than the '%s' clock's 50%% safety margin (%lld)\n",
-			       offset, name, max_cycles >> 1);
-			printk("      timekeeping: Your kernel is still fine, but is feeling a bit nervous\n");
+			printk_deferred("INFO: timekeeping: Cycle offset (%lld) is larger than the '%s' clock's 50%% safety margin (%lld)\n",
+					offset, name, max_cycles >> 1);
+			printk_deferred("      timekeeping: Your kernel is still fine, but is feeling a bit nervous\n");
 		}
 	}
 
 	if (tk->underflow_seen) {
 		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n",
-			       name);
-			printk("         Please report this, consider using a different clocksource, if possible.\n");
-			printk("         Your kernel is probably still fine.\n");
+			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
+			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
+			printk_deferred("         Your kernel is probably still fine.\n");
 			tk->last_warning = jiffies;
 		}
 		tk->underflow_seen = 0;
@@ -227,10 +226,9 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 
 	if (tk->overflow_seen) {
 		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk("WARNING: Overflow in clocksource '%s' observed, time update capped.\n",
-			       name);
-			printk("         Please report this, consider using a different clocksource, if possible.\n");
-			printk("         Your kernel is probably still fine.\n");
+			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
+			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
+			printk_deferred("         Your kernel is probably still fine.\n");
 			tk->last_warning = jiffies;
 		}
 		tk->overflow_seen = 0;
@@ -1670,7 +1668,9 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 					   const struct timespec64 *delta)
 {
 	if (!timespec64_valid_strict(delta)) {
-		pr_warn("%s: Invalid sleep delta value!\n", __func__);
+		printk_deferred(KERN_WARNING
+				"__timekeeping_inject_sleeptime: Invalid "
+				"sleep delta value!\n");
 		return;
 	}
 	tk_xtime_add(tk, delta);
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 149cc4b08d8eb..b73e8850e58d9 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -49,7 +49,7 @@ void tk_debug_account_sleep_time(const struct timespec64 *t)
 	int bin = min(fls(t->tv_sec), NUM_BINS-1);
 
 	sleep_time_bin[bin]++;
-	pm_pr_dbg("Timekeeping suspended for %lld.%03lu seconds\n",
+	pm_deferred_pr_dbg("Timekeeping suspended for %lld.%03lu seconds\n",
 			   (s64)t->tv_sec, t->tv_nsec / NSEC_PER_MSEC);
 }
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 51bbd54a0485d..c55004cbf48ee 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4845,7 +4845,9 @@ void show_one_workqueue(struct workqueue_struct *wq)
 			 * drivers that queue work while holding locks
 			 * also taken in their write paths.
 			 */
+			printk_deferred_enter();
 			show_pwq(pwq);
+			printk_deferred_exit();
 		}
 		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
 		/*
@@ -4876,6 +4878,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 	 * queue work while holding locks also taken in their write
 	 * paths.
 	 */
+	printk_deferred_enter();
 	pr_info("pool %d:", pool->id);
 	pr_cont_pool_info(pool);
 	pr_cont(" hung=%us workers=%d",
@@ -4890,6 +4893,7 @@ static void show_one_worker_pool(struct worker_pool *pool)
 		first = false;
 	}
 	pr_cont("\n");
+	printk_deferred_exit();
 next_pool:
 	raw_spin_unlock_irqrestore(&pool->lock, flags);
 	/*
diff --git a/lib/bug.c b/lib/bug.c
index 03a87df69ed23..45a0584f65417 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -206,7 +206,6 @@ enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 	else
 		pr_crit("Kernel BUG at %pB [verbose debug info unavailable]\n",
 			(void *)bugaddr);
-	pr_flush(1000, true);
 
 	return BUG_TRAP_TYPE_BUG;
 }
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 6e8ae42c7e273..83471e81501a7 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -102,9 +102,9 @@ asmlinkage __visible void dump_stack_lvl(const char *log_lvl)
 	 * Permit this cpu to perform nested stack dumps while serialising
 	 * against other CPUs
 	 */
-	raw_printk_cpu_lock_irqsave(flags);
+	printk_cpu_sync_get_irqsave(flags);
 	__dump_stack(log_lvl);
-	raw_printk_cpu_unlock_irqrestore(flags);
+	printk_cpu_sync_put_irqrestore(flags);
 }
 EXPORT_SYMBOL(dump_stack_lvl);
 
diff --git a/lib/nmi_backtrace.c b/lib/nmi_backtrace.c
index 06410209197ae..d01aec6ae15c8 100644
--- a/lib/nmi_backtrace.c
+++ b/lib/nmi_backtrace.c
@@ -99,7 +99,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 		 * Allow nested NMI backtraces while serializing
 		 * against other CPUs.
 		 */
-		raw_printk_cpu_lock_irqsave(flags);
+		printk_cpu_sync_get_irqsave(flags);
 		if (!READ_ONCE(backtrace_idle) && regs && cpu_in_idle(instruction_pointer(regs))) {
 			pr_warn("NMI backtrace for cpu %d skipped: idling at %pS\n",
 				cpu, (void *)instruction_pointer(regs));
@@ -110,7 +110,7 @@ bool nmi_cpu_backtrace(struct pt_regs *regs)
 			else
 				dump_stack();
 		}
-		raw_printk_cpu_unlock_irqrestore(flags);
+		printk_cpu_sync_put_irqrestore(flags);
 		cpumask_clear_cpu(cpu, to_cpumask(backtrace_mask));
 		return true;
 	}
diff --git a/lib/ratelimit.c b/lib/ratelimit.c
index 524cf65dce53c..e01a93f46f833 100644
--- a/lib/ratelimit.c
+++ b/lib/ratelimit.c
@@ -47,7 +47,9 @@ int ___ratelimit(struct ratelimit_state *rs, const char *func)
 	if (time_is_before_jiffies(rs->begin + rs->interval)) {
 		if (rs->missed) {
 			if (!(rs->flags & RATELIMIT_MSG_ON_RELEASE)) {
-				pr_warn("%s: %d callbacks suppressed\n", func, rs->missed);
+				printk_deferred(KERN_WARNING
+						"%s: %d callbacks suppressed\n",
+						func, rs->missed);
 				rs->missed = 0;
 			}
 		}
diff --git a/localversion-rt b/localversion-rt
index 9e7cd66d9f44f..483ad771f201a 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt18
+-rt19
