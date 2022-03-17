Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453884DC946
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbiCQOx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbiCQOxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:53:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BB220215C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:51:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C8161812
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 14:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 996A6C340ED;
        Thu, 17 Mar 2022 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647528706;
        bh=fZj+rNOp1kvEG/TEqImKDeqdq0pbxH0AedICcGLLcDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OiP+9E2DQKHm4+BKWiwbwk4eyuAY1x1E1XSnW3gB4LKLiLUIJbWqowIpmZW/6mdjj
         N3BzQubptsU0P7bYupuBJLuB/h0vB3EHGJcwbslr3NX0EFZYEptUPEKdPpWc3VM4Rd
         UxFw5uwkYMEBUtQSwTwVp4KuaLzncMGRrSZYwO0Gd2phHGa5+gNDg6eAdKpeFOm0HP
         1FL+M7oXEROktoZagnMXRP3wNYWPd87z/E9X+INs4Tnb18u2BRyfZqRn0vxU2BzYDe
         hDY21IuwkzswASTNAYwaDB0TAZigPOuYBtN/LOrzI8lntorZannjTI78CRQLQQ+PEc
         kNwy57g0B9ILg==
Date:   Thu, 17 Mar 2022 15:51:43 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>
Subject: Re: [patch v12 07/13] task isolation: sync vmstats conditional on
 changes
Message-ID: <20220317145143.GA459366@lothringen>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.042469218@fedora.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315153314.042469218@fedora.localdomain>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 12:31:39PM -0300, Marcelo Tosatti wrote:
> Rather than syncing VM-stats on every return to userspace
> (or VM-entry), keep track of changes through a per-CPU bool.
> 
> This improves performance when enabling task isolated
> for vcpu VMs.
> 
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> ---
> v11:
> - Add TIF_TASK_ISOL bit to thread info flags and use it
>   to decide whether to perform task isolation work on
>   return to userspace     
> 
>  include/linux/vmstat.h |   13 ++++++++++++-
>  mm/vmstat.c            |   29 ++++++++++++++++++++++++++++-
>  2 files changed, 40 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/include/linux/vmstat.h
> ===================================================================
> --- linux-2.6.orig/include/linux/vmstat.h
> +++ linux-2.6/include/linux/vmstat.h
> @@ -22,7 +22,18 @@ int sysctl_vm_numa_stat_handler(struct c
>  #endif
>  
>  #if defined(CONFIG_SMP) && defined(CONFIG_TASK_ISOLATION)
> -void sync_vmstat(void);
> +DECLARE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +extern struct static_key vmstat_sync_enabled;
> +
> +void __sync_vmstat(void);
> +static inline void sync_vmstat(void)
> +{
> +	if (static_key_false(&vmstat_sync_enabled))
> +		__sync_vmstat();
> +}
> +
> +void init_sync_vmstat(void);
>  #else
>  static inline void sync_vmstat(void)
>  {
> Index: linux-2.6/mm/vmstat.c
> ===================================================================
> --- linux-2.6.orig/mm/vmstat.c
> +++ linux-2.6/mm/vmstat.c
> @@ -334,6 +334,31 @@ void set_pgdat_percpu_threshold(pg_data_
>  	}
>  }
>  
> +#ifdef CONFIG_TASK_ISOLATION
> +struct static_key vmstat_sync_enabled;
> +DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	if (!static_key_false(&vmstat_sync_enabled))
> +		return;
> +
> +	raw_cpu_write(vmstat_dirty, true);
> +	set_thread_flag(TIF_TASK_ISOL);
> +}
> +
> +void init_sync_vmstat(void)
> +{
> +	raw_cpu_write(vmstat_dirty, true);
> +	set_thread_flag(TIF_TASK_ISOL);
> +}
> +EXPORT_SYMBOL_GPL(vmstat_dirty);
> +#else
> +static inline void mark_vmstat_dirty(void)
> +{
> +}
> +#endif
> +
>  /*
>   * For use when we know that interrupts are disabled,
>   * or when we know that preemption is disabled and that
> @@ -366,6 +391,7 @@ void __mod_zone_page_state(struct zone *
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -404,6 +430,7 @@ void __mod_node_page_state(struct pglist
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -602,6 +629,7 @@ static inline void mod_zone_state(struct
>  
>  	if (z)
>  		zone_page_state_add(z, zone, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> @@ -670,6 +698,7 @@ static inline void mod_node_state(struct
>  
>  	if (z)
>  		node_page_state_add(z, pgdat, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> @@ -1087,6 +1116,7 @@ static void fill_contig_page_info(struct
>  			info->free_blocks_suitable += blocks <<
>  						(order - suitable_order);
>  	}
> +	mark_vmstat_dirty();
>  }
>  
>  /*
> @@ -1443,6 +1473,7 @@ static void walk_zones_in_node(struct se
>  		if (!nolock)
>  			spin_unlock_irqrestore(&zone->lock, flags);
>  	}
> +	mark_vmstat_dirty();
>  }
>  #endif
>  
> @@ -1512,6 +1543,7 @@ static void pagetypeinfo_showfree_print(
>  		}
>  		seq_putc(m, '\n');
>  	}
> +	mark_vmstat_dirty();
>  }
>  
>  /* Print out the free pages at each order for each migatetype */
> @@ -1932,6 +1964,7 @@ static void vmstat_update(struct work_st
>  				this_cpu_ptr(&vmstat_work),
>  				round_jiffies_relative(sysctl_stat_interval));
>  	}
> +	mark_vmstat_dirty();
>  }
>  
>  /*
> @@ -2019,13 +2052,14 @@ static void vmstat_shepherd(struct work_
>  }
>  
>  #ifdef CONFIG_TASK_ISOLATION
> -void sync_vmstat(void)
> +void __sync_vmstat(void)
>  {
>  	int cpu;
>  
>  	cpu = get_cpu();
>  
>  	refresh_cpu_vm_stats(false);
> +	raw_cpu_write(vmstat_dirty, false);

I still see a few raw_cpu_write() here, especially that one should
clearly become __this_cpu_write().

>  	put_cpu();
>  
>  	/*
> 
> 
