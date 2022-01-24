Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83EC7497FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 13:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241718AbiAXMjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 07:39:15 -0500
Received: from foss.arm.com ([217.140.110.172]:60550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239718AbiAXMjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 07:39:14 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E4AAD6E;
        Mon, 24 Jan 2022 04:39:14 -0800 (PST)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42B8D3F774;
        Mon, 24 Jan 2022 04:39:13 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] irqchip: gic-v3-its: fix build for !SMP
In-Reply-To: <20220122151614.133766-1-ardb@kernel.org>
References: <20220122151614.133766-1-ardb@kernel.org>
Date:   Mon, 24 Jan 2022 12:39:03 +0000
Message-ID: <87bl0148bc.mognet@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/22 16:16, Ard Biesheuvel wrote:
> Commit 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state
> lifetime") added a reference to cpus_booted_once_mask, which does not
> exist on !SMP builds, breaking the build for such configurations.
>
> Given the intent of the check, short circuit it to always pass.
>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Fixes: 835f442fdbce ("irqchip/gic-v3-its: Limit memreserve cpuhp state lifetime")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Sorry about that, and thanks for the fix.

This looks fine to me, though one alternative to prevent future
IS_ENABLED() proliferations would be to make cpus_booted_once_mask exist
for !SMP - the online, active, present and possible masks exist for !SMP
already after all.

---
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 407a2568f35e..7487b7061f2c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -84,9 +84,7 @@ static DEFINE_PER_CPU(struct cpuhp_cpu_state, cpuhp_state) = {
 	.fail = CPUHP_INVALID,
 };
 
-#ifdef CONFIG_SMP
 cpumask_t cpus_booted_once_mask;
-#endif
 
 #if defined(CONFIG_LOCKDEP) && defined(CONFIG_SMP)
 static struct lockdep_map cpuhp_state_up_map =
@@ -2662,9 +2660,7 @@ void __init boot_cpu_init(void)
  */
 void __init boot_cpu_hotplug_init(void)
 {
-#ifdef CONFIG_SMP
 	cpumask_set_cpu(smp_processor_id(), &cpus_booted_once_mask);
-#endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
 
