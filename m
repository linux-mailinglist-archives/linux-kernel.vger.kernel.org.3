Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB1051FAA2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbiEIK7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiEIK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:59:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49F1D48EE
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 03:55:24 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652093722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYiIxCVx9W1bhOmSmf98b6lgiKtmIYGoNtu68j+dkiI=;
        b=1tuQRLZIrfn6B7U6KKjue24EI8R1NQfjcGLWQBtaNpooDTFAOysw8mOAI4V+96V3wHZtW5
        h10DH9fwCTHTPDeHQXc4ijG8TWRbogjWePYJ1N+3iwQAC86/L4EOVsGK8XgS4N8djiF4X5
        NaHLFm/1LPCjn/SuFFCv+t8kW87d7hjMFAoQoeSTNT2xh45JO51VotPLUQszfuMfEqdbbp
        K2i4xmmCNsWOkW+KDlZrpXVUDgs6e/O0QhoozetiEqF4HoM4QvTgS0zcKgmpxHcaKY9PY4
        t4t6LYVaglUwjHbEs3Z8U+k1FhTZZLKw8cD/nkHgAevC76+E8VnUl3KV5MiFlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652093722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CYiIxCVx9W1bhOmSmf98b6lgiKtmIYGoNtu68j+dkiI=;
        b=MOtniF/K1n+7Mvsl1BAMoj3O5rrAvt73HllS/LwaCcfjbmWfS0ZoCQz6V9aXaIF+YNEwfi
        rE23df0P/pITJaBw==
To:     Pingfan Liu <kernelfans@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Baokun Li <libaokun1@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org
Subject: Re: [PATCHv3 1/2] cpu/hotplug: Keep cpu hotplug disabled until the
 rebooting cpu is stable
In-Reply-To: <20220509041305.15056-2-kernelfans@gmail.com>
References: <20220509041305.15056-1-kernelfans@gmail.com>
 <20220509041305.15056-2-kernelfans@gmail.com>
Date:   Mon, 09 May 2022 12:55:21 +0200
Message-ID: <87ee13rn52.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09 2022 at 12:13, Pingfan Liu wrote:
> The following code chunk repeats in both
> migrate_to_reboot_cpu() and smp_shutdown_nonboot_cpus():
>
> 	if (!cpu_online(primary_cpu))
> 		primary_cpu = cpumask_first(cpu_online_mask);
>
> This is due to a breakage like the following:

I don't see what's broken here.

> kernel_kexec()
>    migrate_to_reboot_cpu();
>    cpu_hotplug_enable();
>                         -----------> comes a cpu_down(this_cpu) on other cpu
>    machine_shutdown();
>      smp_shutdown_nonboot_cpus(); // re-check "if (!cpu_online(primary_cpu))" to protect against the former breakin
>
> Although the kexec-reboot task can get through a cpu_down() on its cpu,
> this code looks a little confusing.

Confusing != broken.

> +/* primary_cpu keeps unchanged after migrate_to_reboot_cpu() */

This comment makes no sense.

>  void smp_shutdown_nonboot_cpus(unsigned int primary_cpu)
>  {
>  	unsigned int cpu;
>  	int error;
>  
> +	/*
> +	 * Block other cpu hotplug event, so primary_cpu is always online if
> +	 * it is not touched by us
> +	 */
>  	cpu_maps_update_begin();
> -
>  	/*
> -	 * Make certain the cpu I'm about to reboot on is online.
> -	 *
> -	 * This is inline to what migrate_to_reboot_cpu() already do.
> +	 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> +	 * no further code needs to use CPU hotplug (which is true in
> +	 * the reboot case). However, the kexec path depends on using
> +	 * CPU hotplug again; so re-enable it here.

You want to reduce confusion, but in reality this is even more confusing
than before.

>  	 */
> -	if (!cpu_online(primary_cpu))
> -		primary_cpu = cpumask_first(cpu_online_mask);
> +	__cpu_hotplug_enable();

How is this decrement solving anything? At the end of this function, the
counter is incremented again. So what's the point of this exercise?

>  	for_each_online_cpu(cpu) {
>  		if (cpu == primary_cpu)
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 68480f731192..db4fa6b174e3 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1168,14 +1168,12 @@ int kernel_kexec(void)
>  		kexec_in_progress = true;
>  		kernel_restart_prepare("kexec reboot");
>  		migrate_to_reboot_cpu();
> -
>  		/*
> -		 * migrate_to_reboot_cpu() disables CPU hotplug assuming that
> -		 * no further code needs to use CPU hotplug (which is true in
> -		 * the reboot case). However, the kexec path depends on using
> -		 * CPU hotplug again; so re-enable it here.
> +		 * migrate_to_reboot_cpu() disables CPU hotplug. If an arch
> +		 * relies on the cpu teardown to achieve reboot, it needs to
> +		 * re-enable CPU hotplug there.

What does that for arch/powerpc/kernel/kexec_machine64.c now?

Nothing, as far as I can tell. Which means you basically reverted
011e4b02f1da ("powerpc, kexec: Fix "Processor X is stuck" issue during
kexec from ST mode") unless I'm completely confused.

>  		 */
> -		cpu_hotplug_enable();

This is tinkering at best. Can we please sit down and rethink this whole
machinery instead of applying random duct tape to it?

Thanks,

        tglx
