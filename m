Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B621B51D810
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392102AbiEFMpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354925AbiEFMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:45:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D6DF65;
        Fri,  6 May 2022 05:41:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651840905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4WGFGgH1Q4SMa5YoUWZ2bySKWWiAetNfZl+vB3w1g4=;
        b=ssLWQd2T52Ghu1zVHe5Qn82f4ZxDtqi1VO1p+js7k4oIIp+bx2zvTnLlGLXpTdBNvJ075x
        Who0Oi2gDBU41iJ+B/q+9APXQxg3J5Bxs4J6BtiYx5AqkbU3hf/BC46kxMsCqousGyZ5SY
        flaMOBofMnR9r0e8cp+YFPJj4NRDzye3IlpWMLuTVcP0MwhrfzxiKsQjQTWRdRvur9Xc1I
        FJ1JFaJdY/K0d+AmR7SzZl+OcWZVYeXRXcgyTx7OoC6B8YTm+a7BuxnHPMyhAkVxjqTd4S
        5ACWA7mf2p7tM0DWDl/FAjy57DV23OhSEugu4vSxGUXt/nQ8Y4bNgqOORi8Cbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651840905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w4WGFGgH1Q4SMa5YoUWZ2bySKWWiAetNfZl+vB3w1g4=;
        b=riJkHFdnVFzB/la1KPv0CI9r4BICMN++8Ml01ZcLYycJNNN9rraIAh2kLzIUFbKq+2BP3h
        sc8fjh2VPp13xbDg==
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <bb5cadc3-0940-7f5c-7a1b-8120ddac9039@samsung.com>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de> <Ymfgis0EAw0Oxoa5@alley>
 <Ymfwk+X0CHq6ex3s@alley>
 <2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com>
 <CGME20220506112526eucas1p2a3688f87d3ed8331b99f2f876bf6c2f6@eucas1p2.samsung.com>
 <bb5cadc3-0940-7f5c-7a1b-8120ddac9039@samsung.com>
Date:   Fri, 06 May 2022 14:47:43 +0206
Message-ID: <87h762lto8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-06, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> The Amlogic Meson related issue has been investigated and fixed:
>
> https://lore.kernel.org/all/b7c81f02-039e-e877-d7c3-6834728d2117@samsung.=
com/
>
> but I just found that there is one more issue.
>
> It appears on QCom-based DragonBoard 410c SBC=20
> (arch/arm64/boot/dts/qcom/apq8016-sbc.dts). To see it on today's linux=20
> next-20220506, one has to revert=20
> 42cd402b8fd4672b692400fe5f9eecd55d2794ac, otherwise lockdep triggers=20
> other warning and it is turned off too early:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> WARNING: inconsistent lock state
> 5.18.0-rc5-next-20220506+ #11869 Not tainted
> --------------------------------
> inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> swapper/0/0 [HC1[1]:SC0[0]:HE0:SE1] takes:
> ffff80000aaa8478 (&port_lock_key){?.+.}-{2:2}, at: msm_uart_irq+0x38/0x750
> {HARDIRQ-ON-W} state was registered at:
>  =C2=A0 lock_acquire.part.0+0xe0/0x230
>  =C2=A0 lock_acquire+0x68/0x84
>  =C2=A0 _raw_spin_lock+0x5c/0x80
>  =C2=A0 __msm_console_write+0x1ac/0x220
>  =C2=A0 msm_console_write+0x48/0x60
>  =C2=A0 __console_emit_next_record+0x188/0x420
>  =C2=A0 printk_kthread_func+0x3a0/0x3bc
>  =C2=A0 kthread+0x118/0x11c
>  =C2=A0 ret_from_fork+0x10/0x20
> irq event stamp: 12182
> hardirqs last=C2=A0 enabled at (12181): [<ffff800008e3d2a8>]=20
> cpuidle_enter_state+0xc4/0x30c
>
> stack backtrace:
> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.18.0-rc5-next-20220506+ #11869
> Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
> Call trace:
>  =C2=A0dump_backtrace.part.0+0xd0/0xe0
>  =C2=A0show_stack+0x18/0x6c
>  =C2=A0dump_stack_lvl+0x8c/0xb8
>  =C2=A0dump_stack+0x18/0x34
>  =C2=A0print_usage_bug.part.0+0x208/0x22c
>  =C2=A0mark_lock+0x710/0x954
>  =C2=A0__lock_acquire+0x9fc/0x20cc
>  =C2=A0lock_acquire.part.0+0xe0/0x230
>  =C2=A0lock_acquire+0x68/0x84
>  =C2=A0_raw_spin_lock_irqsave+0x80/0xcc
>  =C2=A0msm_uart_irq+0x38/0x750
>  =C2=A0__handle_irq_event_percpu+0xac/0x3d0
>  =C2=A0handle_irq_event+0x4c/0x120
>  =C2=A0handle_fasteoi_irq+0xa4/0x1a0
>  =C2=A0generic_handle_domain_irq+0x3c/0x60
>  =C2=A0gic_handle_irq+0x44/0xc4
>  =C2=A0call_on_irq_stack+0x2c/0x54
>  =C2=A0do_interrupt_handler+0x80/0x84
>  =C2=A0el1_interrupt+0x34/0x64
>  =C2=A0el1h_64_irq_handler+0x18/0x24
>  =C2=A0el1h_64_irq+0x64/0x68
>  =C2=A0cpuidle_enter_state+0xcc/0x30c
>  =C2=A0cpuidle_enter+0x38/0x50
>  =C2=A0do_idle+0x22c/0x2bc
>  =C2=A0cpu_startup_entry+0x28/0x30
>  =C2=A0rest_init+0x110/0x190
>  =C2=A0arch_post_acpi_subsys_init+0x0/0x18
>  =C2=A0start_kernel+0x6c4/0x704
>  =C2=A0__primary_switched+0xc0/0xc8
>  =C2=A0INIT: version 2.88 booting
> [info] Using makefile-style concurrent boot in runlevel S.

The console write() callback for the msm driver (__msm_console_write)
assumes interrupts are off and is doing a spin_lock(&port->lock) rather
than spin_lock_irqsave(&port->lock, flags).

The following change should address the issue:

John

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_seria=
l.c
index 23c94b927776..ab3f360bd354 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -1599,6 +1599,7 @@ static inline struct uart_port *msm_get_port_from_lin=
e(unsigned int line)
 static void __msm_console_write(struct uart_port *port, const char *s,
 				unsigned int count, bool is_uartdm)
 {
+	unsigned long flags;
 	int i;
 	int num_newlines =3D 0;
 	bool replaced =3D false;
@@ -1621,7 +1622,7 @@ static void __msm_console_write(struct uart_port *por=
t, const char *s,
 	else if (oops_in_progress)
 		locked =3D spin_trylock(&port->lock);
 	else
-		spin_lock(&port->lock);
+		spin_lock_irqsave(&port->lock, flags);
=20
 	if (is_uartdm)
 		msm_reset_dm_count(port, count);
@@ -1660,7 +1661,7 @@ static void __msm_console_write(struct uart_port *por=
t, const char *s,
 	}
=20
 	if (locked)
-		spin_unlock(&port->lock);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
=20
 static void msm_console_write(struct console *co, const char *s,
