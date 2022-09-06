Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022985AEF33
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiIFPpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiIFPor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:44:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FC87F082
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 07:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=AXICyjXYCEm06LBVePasj0pI9g2mYJHnUedxKP9+s/c=; b=Affb1+qhxCfW+yy8GUrH9+M99G
        b6T1xSXYppJFrPPRVayvzaVnoRSS4yvB4I7lvCcLwqltI3N9y54NjU6JM+zsdVk2RfQABjflG6RHA
        MZlo4nvUhPgcFlwXRq7bPK40kJn2nd5CkWJCWXbpfVcb2vFUEv/oOwFOfFz4CSR1X8JmxYTX07KGE
        FcSudyU/GqQ2sVIe86hejXxQgbxM/7t0q74scDQIUjTZ1+DSpNm0vka7j/xovvZrYyza0cCS1Uryi
        29QK+PjzDTos6I0uMUobZqWCV60YPwPXRg16JSZijwic6LRktm3KjgF5dPt3BumKg4cnkoZPFiEBp
        lPH54zMg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVZyX-00AVrj-Fw; Tue, 06 Sep 2022 14:54:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D517300790;
        Tue,  6 Sep 2022 16:54:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3681D2B69DA35; Tue,  6 Sep 2022 16:54:51 +0200 (CEST)
Date:   Tue, 6 Sep 2022 16:54:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yair Podemsky <ypodemsk@redhat.com>
Cc:     x86@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        rafael.j.wysocki@intel.com, pauld@redhat.com, frederic@kernel.org,
        ggherdovich@suse.cz, linux-kernel@vger.kernel.org, lenb@kernel.org,
        vschneid@redhat.com, jlelli@redhat.com, mtosatti@redhat.com,
        ppandit@redhat.com, alougovs@redhat.com, lcapitul@redhat.com,
        nsaenz@kernel.org
Subject: Re: [PATCH] x86/aperfmperf: Fix arch_scale_freq_tick() on tickless
 systems
Message-ID: <YxdfO/5/Yfodm18i@hirez.programming.kicks-ass.net>
References: <20220804131728.58513-1-ypodemsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804131728.58513-1-ypodemsk@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 04:17:28PM +0300, Yair Podemsky wrote:
> In order for the scheduler to be frequency invariant we measure the
> ratio between the maximum cpu frequency and the actual cpu frequency.
> During long tickless periods of time the calculations that keep track
> of that might overflow, in the function scale_freq_tick():
> 
> if (check_shl_overflow(acnt, 2*SCHED_CAPACITY_SHIFT, &acnt))
> »       goto error;
> 
> eventually forcing the kernel to disable the feature with the
> message "Scheduler frequency invariance went wobbly, disabling!".
> Let's avoid that by detecting long tickless periods and bypassing
> the calculation for that tick.
> 
> This calculation updates the value of arch_freq_scale, used by the
> capacity-aware scheduler to correct cpu duty cycles:
> task_util_freq_inv(p) = duty_cycle(p) * (curr_frequency(cpu) /
> max_frequency(cpu))
> 
> However Consider a long tickless period, It takes should take 60 minutes
> for a tickless CPU running at 5GHz to trigger the acnt overflow,
> pick 10 minutes as a staleness threshold to be on the safe side,
> In our testing it took over 30 minutes for the overflow to happen,
> but since it's frequency/platform dependent we choose a smaller value
> to be on the safe side.
> 
> Fixes: e2b0d619b400 ("x86, sched: check for counters overflow in frequency invariant accounting")
> Signed-off-by: Yair Podemsky <ypodemsk@redhat.com>
> ---
>  arch/x86/kernel/cpu/aperfmperf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/aperfmperf.c b/arch/x86/kernel/cpu/aperfmperf.c
> index 1f60a2b27936..dfe356034a60 100644
> --- a/arch/x86/kernel/cpu/aperfmperf.c
> +++ b/arch/x86/kernel/cpu/aperfmperf.c
> @@ -23,6 +23,13 @@
>  
>  #include "cpu.h"
>  
> +/*
> + * Samples older then 10 minutes should not be proccessed,
> + * This time is long enough to prevent unneeded drops of data
> + * But short enough to prevent overflows
> + */
> +#define MAX_SAMPLE_AGE_NOHZ	((unsigned long)HZ * 600)
> +
>  struct aperfmperf {
>  	seqcount_t	seq;
>  	unsigned long	last_update;
> @@ -373,6 +380,7 @@ static inline void scale_freq_tick(u64 acnt, u64 mcnt) { }
>  void arch_scale_freq_tick(void)
>  {
>  	struct aperfmperf *s = this_cpu_ptr(&cpu_samples);
> +	unsigned long last  = s->last_update;
>  	u64 acnt, mcnt, aperf, mperf;
>  
>  	if (!cpu_feature_enabled(X86_FEATURE_APERFMPERF))
> @@ -392,7 +400,12 @@ void arch_scale_freq_tick(void)
>  	s->mcnt = mcnt;
>  	raw_write_seqcount_end(&s->seq);
>  
> -	scale_freq_tick(acnt, mcnt);
> +	/*
> +	 * Avoid calling scale_freq_tick() when the last update was too long ago,
> +	 * as it might overflow during calulation.
> +	 */
> +	if ((jiffies - last) <= MAX_SAMPLE_AGE_NOHZ)
> +		scale_freq_tick(acnt, mcnt);
>  }

All this patch does is avoid the warning; but afaict it doesn't make it
behave in a sane way.

I'm thinking that on nohz_full cpus you don't have load balancing, I'm
also thinking that on nohz_full cpus you don't have DVFS.

So *why* the heck are we setting this stuff to random values ? Should
you not simply kill th entire thing for nohz_full cpus?
