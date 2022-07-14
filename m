Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD235748CB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 11:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiGNJ0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 05:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbiGNJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 05:26:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D32228710;
        Thu, 14 Jul 2022 02:25:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657790701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sevqOoO0yR+Fu0jMJ1cbzLRwE84EUc3tWuJ6vmCvvM=;
        b=Eoari3iuC1jFcIVGijSMqtUlKrF1361LD/j8a7LCccDCfrYEc78nQ68QBaQ837f5olhy4t
        rWarVSn2BhomTEUGolZ13yWJJ7ekR1WufOKQzNuw801Y7qB8BKLSulOSDG70kCoyjDcrMY
        0oxmw93g5ibXGmrM2mN6XWtWMqS63cGMR2OMMjvIBo/2QFbkCdS7JBf5YkXeS93MoQ4mjv
        ZHHLpUSTvZbv3Uoj2fugqxP5k9HcDdBdvU7ERsD32FGHiIq7cUz6XwbC3ioh6uAKhlzMuK
        JMZkMQbutAG6mdinYrYWqJIAHPlrVQlJzKrZ3CvwIv992a2a4BjhJQAwb1nwKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657790701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0sevqOoO0yR+Fu0jMJ1cbzLRwE84EUc3tWuJ6vmCvvM=;
        b=GdIk5VPtOS9TickkMdzGS8uKNwVQLg0vhPJd4QTmzIOZuNRqSAsB0ErgeTVJnaAH82LdTW
        334lYHgzLKE2JxCg==
To:     Zhouyi Zhou <zhouzhouyi@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, npiggin@gmail.com,
        ldufour@linux.ibm.com, pmladek@suse.com, Julia.Lawall@inria.fr,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        lance@osuosl.org, paulmck@kernel.org, rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: Re: [PATCH linux-next] powerpc: use raw_smp_processor_id in
 arch_touch_nmi_watchdog
In-Reply-To: <20220714013131.12648-1-zhouzhouyi@gmail.com>
References: <20220714013131.12648-1-zhouzhouyi@gmail.com>
Date:   Thu, 14 Jul 2022 11:31:00 +0206
Message-ID: <87tu7k6o7n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-14, Zhouyi Zhou <zhouzhouyi@gmail.com> wrote:
> use raw_smp_processor_id() in arch_touch_nmi_watchdog
> because when called from watchdog, the cpu is preemptible.

I would expect the correct solution is to make it a non-migration
section. Something like the below (untested) patch.

John Ogness

diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index bfc27496fe7e..9d34aa809241 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -450,17 +450,23 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
 void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
-	int cpu = smp_processor_id();
+	int cpu;
 	u64 tb;
 
-	if (!cpumask_test_cpu(cpu, &watchdog_cpumask))
+	cpu = get_cpu();
+
+	if (!cpumask_test_cpu(cpu, &watchdog_cpumask)) {
+		goto out;
 		return;
+	}
 
 	tb = get_tb();
 	if (tb - per_cpu(wd_timer_tb, cpu) >= ticks) {
 		per_cpu(wd_timer_tb, cpu) = tb;
 		wd_smp_clear_cpu_pending(cpu);
 	}
+out:
+	put_cpu();
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
