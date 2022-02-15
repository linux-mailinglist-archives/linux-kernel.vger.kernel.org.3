Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B794B723B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240510AbiBOPnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:43:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240475AbiBOPml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:42:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB42D2047;
        Tue, 15 Feb 2022 07:37:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B965B81AF1;
        Tue, 15 Feb 2022 15:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1349EC340EB;
        Tue, 15 Feb 2022 15:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644939455;
        bh=BsBNZ9apjGJSc2g0ZwEBxAVFFQEqTe0vH5kNc5TqqNU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z6Iki+WPdLb9gpmywemitTCbjFKLwFXyTTkar9otLYCKmkVVJPLCuaNDalikiu+v1
         TFg7/MiGeNkMeC5C+RikqLWr791Vcf3KgyznU/cTJXJwn4KkTeYH5QXgrrDOtIAhzR
         HXFUOcqXeTgSTD2IXcbWEAHEL3htsLHJhtz/sS63033m1wmPOY/h6HTiaccbMIJUMt
         3alZOADJ+zQEo5A/yY2sNEVbLpudzmSGh3At7PAJF7bpC5s4Inb1TFrMCDOxMrFBqZ
         U+gGuiE1GqpSi3wnrtEQO//Mqi29tuq6Bz6N4JtqUeb0zS2jeX1gvVisnLyw0ihv+N
         oDOxIMDwcMJGA==
Date:   Tue, 15 Feb 2022 15:37:27 +0000
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <20220215153726.GA7944@willie-the-truck>
References: <20220127192437.1192957-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127192437.1192957-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

FWIW: There's a patch in the multi-generational LRU series that drops this
WARN_ON() entirely. I'm not sure if/when that lot will land, but just wanted
to let you know.

Will
