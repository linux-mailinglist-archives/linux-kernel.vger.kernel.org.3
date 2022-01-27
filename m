Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89B1349E994
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 19:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiA0SB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 13:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiA0SBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 13:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D0DC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 10:01:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C1F61B41
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0160C340E4;
        Thu, 27 Jan 2022 18:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643306514;
        bh=JKDmgOY5hCZ3LDdiqBiHV4ClnAUGJtSMpoygbKHjWKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ADumLHnjFuDXg/bFzNe//Niv8HAqZNof679PaDX0AW8jU1E3J8SRQnqSRan+PAK32
         3eKf6Dp6pbo80cZjtR6/X4CkHLJI/aWaMxiYR6iE+Pmjf4hap0iAs1crVvf/fplwew
         0VQoykVDR/mF76JFonGaEYtZVyefpkNkEoSVvI7ewpCwu3IYsylzWOrqhgR2wDMbgc
         N0gQCvmWy8PdQkSKoUPgS28EbASKlMRvnmrI9OB2prGFiK8adove7rlu0MCOah6wGA
         dfkvXz3QbDZRTzHVTtky6bAt2tso2oz5tvrcwEn/e1KXuMvJJecFrN+mX/81HCQfdw
         RIhpKFI6wFZgQ==
Date:   Thu, 27 Jan 2022 19:01:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 03/10] task isolation: sync vmstats on return to
 userspace
Message-ID: <20220127180151.GA308637@lothringen>
References: <20211208161000.714824954@fuller.cnet>
 <20220121120610.GA231488@lothringen>
 <YfLMi4SOvPl5rY5J@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfLMi4SOvPl5rY5J@fuller.cnet>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:47:07PM -0300, Marcelo Tosatti wrote:
> > > @@ -177,6 +179,9 @@ static unsigned long exit_to_user_mode_l
> > >  		/* Architecture specific TIF work */
> > >  		arch_exit_to_user_mode_work(regs, ti_work);
> > >  
> > > +		if (tsk_isol_work)
> > > +			isolation_exit_to_user_mode();
> > > +
> > >  		/*
> > >  		 * Disable interrupts and reevaluate the work flags as they
> > >  		 * might have changed while interrupts and preemption was
> > > @@ -188,6 +193,7 @@ static unsigned long exit_to_user_mode_l
> > >  		tick_nohz_user_enter_prepare();
> > >  
> > >  		ti_work = READ_ONCE(current_thread_info()->flags);
> > > +		tsk_isol_work = task_isol_has_work();
> > 
> > Shouldn't it be a TIF_FLAG part of EXIT_TO_USER_MODE_WORK instead?
> > 
> > Thanks.
> 
> static inline int task_isol_has_work(void)
> {
>        int cpu, ret;
>        struct isol_info *i;
> 
>        if (likely(current->task_isol_info == NULL))
>                return 0;
> 
>        i = current->task_isol_info;
>        if (i->active_mask != ISOL_F_QUIESCE)
>                return 0;
> 
>        if (!(i->quiesce_mask & ISOL_F_QUIESCE_VMSTATS))
>                return 0;
> 
>        cpu = get_cpu();
>        ret = per_cpu(vmstat_dirty, cpu);
>        put_cpu();
> 
>        return ret;
> }
> 
> Well, whether its necessary to call task_isol_exit_to_user_mode depends
> on the state of the enabled/disabled masks _and_ vmstat dirty bit
> information.
> 
> It seems awkward, to me, to condense all that information in a single bit.
> 
> Addressed all other comments, thanks.

You're unconditionally adding overhead to the syscall fastpath when it would
be so easy to set a TIF_FLAG as long as (current->task_isol_info->quiesce_mask
!= 0). vmstat_dirty can be checked afterward.

I suspect your patchset will sell much better if you join the common slowpath
single condition in EXIT_TO_USER_MODE_WORK.

Thanks.
