Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7180347D3AB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241331AbhLVO21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:28:27 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50994 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhLVO20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:28:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DAA9B81CDB
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 14:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B22C36AE5;
        Wed, 22 Dec 2021 14:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640183304;
        bh=fKPYHQMQ71cyDKzqzqXIDTB/qWkF46W+v2jYAbM/08M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eZi3dqDN11H4l/49f6SMeHNJq+G6xbY2XseMkGMGjhCI/daoihBTBTNpYoQ7tgVNH
         ft+ooFdLx9H9ZZWyRkUkhaagVwpmHyIKibnK89JllC6n0TAclTts3Qbtg8TrzYbx4b
         lPwQWYhjzb94c3s3TWn3tgwEDKB4xLNlAnQatFp0cAOR7h5mNU64G22gEC4ZUINte/
         gyrktsdBKhFTlVScSeyadZxr2XoyQhYPkSAWnNY2nCj2f8AYA9B8V7ODHTVQ9n3nSr
         pajM0Ri0B6x50zZ89P+lAdGhccuqKbnFmeLQ4en7zX71F1E9/mu6PulrJHGMMrqSAU
         sgLun6673DLMg==
Date:   Wed, 22 Dec 2021 23:28:20 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kprobe: Remove kprobe_instance and its related
 functions
Message-Id: <20211222232820.df0aafcc3baeb309fadef4d7@kernel.org>
In-Reply-To: <20211222100345.412013-1-jolsa@kernel.org>
References: <20211222100345.412013-1-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Dec 2021 11:03:45 +0100
Jiri Olsa <jolsa@redhat.com> wrote:

> The last user od kprobe_instance got removed in [1],
> now it just occupies space, removing it.
> 
> [1] ec6aba3d2be1 ("kprobes: Remove kprobe::fault_handler")
> 

Good catch! Thank you very much!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>


> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/kprobes.c | 24 ++----------------------
>  1 file changed, 2 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 21eccc961bba..d20ae8232835 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -62,7 +62,6 @@ static bool kprobes_all_disarmed;
>  
>  /* This protects 'kprobe_table' and 'optimizing_list' */
>  static DEFINE_MUTEX(kprobe_mutex);
> -static DEFINE_PER_CPU(struct kprobe *, kprobe_instance);
>  
>  kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
>  					unsigned int __unused)
> @@ -353,17 +352,6 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
>  #endif
>  #endif
>  
> -/* We have preemption disabled.. so it is safe to use __ versions */
> -static inline void set_kprobe_instance(struct kprobe *kp)
> -{
> -	__this_cpu_write(kprobe_instance, kp);
> -}
> -
> -static inline void reset_kprobe_instance(void)
> -{
> -	__this_cpu_write(kprobe_instance, NULL);
> -}
> -
>  /*
>   * This routine is called either:
>   *	- under the 'kprobe_mutex' - during kprobe_[un]register().
> @@ -421,11 +409,8 @@ void opt_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  	struct kprobe *kp;
>  
>  	list_for_each_entry_rcu(kp, &p->list, list) {
> -		if (kp->pre_handler && likely(!kprobe_disabled(kp))) {
> -			set_kprobe_instance(kp);
> +		if (kp->pre_handler && likely(!kprobe_disabled(kp)))
>  			kp->pre_handler(kp, regs);
> -		}
> -		reset_kprobe_instance();
>  	}
>  }
>  NOKPROBE_SYMBOL(opt_pre_handler);
> @@ -1177,11 +1162,9 @@ static int aggr_pre_handler(struct kprobe *p, struct pt_regs *regs)
>  
>  	list_for_each_entry_rcu(kp, &p->list, list) {
>  		if (kp->pre_handler && likely(!kprobe_disabled(kp))) {
> -			set_kprobe_instance(kp);
>  			if (kp->pre_handler(kp, regs))
>  				return 1;
>  		}
> -		reset_kprobe_instance();
>  	}
>  	return 0;
>  }
> @@ -1193,11 +1176,8 @@ static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
>  	struct kprobe *kp;
>  
>  	list_for_each_entry_rcu(kp, &p->list, list) {
> -		if (kp->post_handler && likely(!kprobe_disabled(kp))) {
> -			set_kprobe_instance(kp);
> +		if (kp->post_handler && likely(!kprobe_disabled(kp)))
>  			kp->post_handler(kp, regs, flags);
> -			reset_kprobe_instance();
> -		}
>  	}
>  }
>  NOKPROBE_SYMBOL(aggr_post_handler);
> -- 
> 2.33.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
