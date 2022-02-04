Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E74A9F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377782AbiBDSz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:55:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:38176 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBDSzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:55:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A2F961C50;
        Fri,  4 Feb 2022 18:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9E6C340E9;
        Fri,  4 Feb 2022 18:55:20 +0000 (UTC)
Date:   Fri, 4 Feb 2022 18:55:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH v4] arm64: mm: Make arch_faults_on_old_pte() check for
 migratability
Message-ID: <Yf12lXHtPVXgAoFL@arm.com>
References: <20220127192437.1192957-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127192437.1192957-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 07:24:37PM +0000, Valentin Schneider wrote:
> arch_faults_on_old_pte() relies on the calling context being
> non-preemptible. CONFIG_PREEMPT_RT turns the PTE lock into a sleepable
> spinlock, which doesn't disable preemption once acquired, triggering the
> warning in arch_faults_on_old_pte().
> 
> It does however disable migration, ensuring the task remains on the same
> CPU during the entirety of the critical section, making the read of
> cpu_has_hw_af() safe and stable.
> 
> Make arch_faults_on_old_pte() check cant_migrate() instead of preemptible().
> 
> Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Link: https://lore.kernel.org/r/20210811201354.1976839-5-valentin.schneider@arm.com
> ---
> v3 -> v4: Dropped migratable(), reuse cant_migrate() (Sebastian)
> ---
>  arch/arm64/include/asm/pgtable.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index c4ba047a82d2..3caf6346ea95 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1001,7 +1001,8 @@ static inline void update_mmu_cache(struct vm_area_struct *vma,
>   */
>  static inline bool arch_faults_on_old_pte(void)
>  {
> -	WARN_ON(preemptible());
> +	/* The register read below requires a stable CPU to make any sense */
> +	cant_migrate();
>  
>  	return !cpu_has_hw_af();
>  }

The patch looks alright but what's the plan with it? Does it go into the
preempt-rt tree, mainline? It's not a fix to be queued now, so:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
