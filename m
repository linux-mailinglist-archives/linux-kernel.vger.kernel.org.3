Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04ED594A7C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 02:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356511AbiHPACa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 20:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356529AbiHOXyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 19:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C750A115C
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660594760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ovMy9UBv9rqtIlUqp5wGD+98w6B8X4YaLrAOR51fWzw=;
        b=VScc5p0lyBoK3ctfZ1deAnkOpQkfHgJgh0+hCwbJTserlrzYyG4n2d1ToClLByVKkgoVZy
        DrK0JLmX5KYbxwySZWDr2O8yVGcyq3kzaLNkhuAHBIKeYAcfNPE7kKP/7eoz1ddEPVKYhe
        Zo3awSihOwlN+HEJNFyFFKKr8aG+Bp4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-358-jBoGdbQzNaeIU7lXcta-5A-1; Mon, 15 Aug 2022 16:19:19 -0400
X-MC-Unique: jBoGdbQzNaeIU7lXcta-5A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BC95F1019C95;
        Mon, 15 Aug 2022 20:19:18 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 32AE440CFD0A;
        Mon, 15 Aug 2022 20:19:18 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 89043416D5C1; Mon, 15 Aug 2022 17:18:59 -0300 (-03)
Date:   Mon, 15 Aug 2022 17:18:59 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Aaron Tomlin <atomlin@redhat.com>
Cc:     frederic@kernel.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 1/2] mm/vmstat: Use per cpu variable to track a vmstat
 discrepancy
Message-ID: <YvqqM6cxEzTxIUVl@fuller.cnet>
References: <20220808194820.676246-1-atomlin@redhat.com>
 <20220808194820.676246-2-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808194820.676246-2-atomlin@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

On Mon, Aug 08, 2022 at 08:48:19PM +0100, Aaron Tomlin wrote:
> This patch incorporates an idea from Marcelo's patch [1] where a
> CPU-specific variable namely vmstat_dirty is used to indicate if
> a vmstat imbalance is present for a given CPU. Therefore, at the
> appropriate time, we can fold all the remaining differentials.
> 
> [1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  mm/vmstat.c | 46 +++++++++++++++-------------------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 373d2730fcf2..51564b7c85fe 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -195,6 +195,12 @@ void fold_vm_numa_events(void)
>  #endif
>  
>  #ifdef CONFIG_SMP
> +static DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	this_cpu_write(vmstat_dirty, true);
> +}
>  
>  int calculate_pressure_threshold(struct zone *zone)
>  {
> @@ -367,6 +373,7 @@ void __mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -405,6 +412,7 @@ void __mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
>  		x = 0;
>  	}
>  	__this_cpu_write(*p, x);
> +	mark_vmstat_dirty();
>  
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		preempt_enable();
> @@ -603,6 +611,7 @@ static inline void mod_zone_state(struct zone *zone,
>  
>  	if (z)
>  		zone_page_state_add(z, zone, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_zone_page_state(struct zone *zone, enum zone_stat_item item,
> @@ -671,6 +680,7 @@ static inline void mod_node_state(struct pglist_data *pgdat,
>  
>  	if (z)
>  		node_page_state_add(z, pgdat, item);
> +	mark_vmstat_dirty();
>  }
>  
>  void mod_node_page_state(struct pglist_data *pgdat, enum node_stat_item item,
> @@ -1873,6 +1883,7 @@ int sysctl_stat_interval __read_mostly = HZ;
>  static void refresh_vm_stats(struct work_struct *work)
>  {
>  	refresh_cpu_vm_stats(true);

Another task can be scheduled here, set data in
zone->per_cpu_zonestats->vm_stat_diff (after refresh_cpu_vm_stats
has cleared it to zero), and you'll end up marking
per-CPU vmstat_dirty bool as false incorrectly.

Guess it is necessary to disable preemption here.

> +	this_cpu_write(vmstat_dirty, false);
>  }
>  
>  int vmstat_refresh(struct ctl_table *table, int write,
> @@ -1937,6 +1948,7 @@ int vmstat_refresh(struct ctl_table *table, int write,
>  static void vmstat_update(struct work_struct *w)
>  {
>  	if (refresh_cpu_vm_stats(true)) {
> +		this_cpu_write(vmstat_dirty, false);

Same problem.

>  		/*
>  		 * Counters were updated so we expect more updates
>  		 * to occur in the future. Keep on running the
> @@ -1948,35 +1960,6 @@ static void vmstat_update(struct work_struct *w)
>  	}
>  }
>  
> -/*
> - * Check if the diffs for a certain cpu indicate that
> - * an update is needed.
> - */
> -static bool need_update(int cpu)
> -{
> -	pg_data_t *last_pgdat = NULL;
> -	struct zone *zone;
> -
> -	for_each_populated_zone(zone) {
> -		struct per_cpu_zonestat *pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
> -		struct per_cpu_nodestat *n;
> -
> -		/*
> -		 * The fast way of checking if there are any vmstat diffs.
> -		 */
> -		if (memchr_inv(pzstats->vm_stat_diff, 0, sizeof(pzstats->vm_stat_diff)))
> -			return true;
> -
> -		if (last_pgdat == zone->zone_pgdat)
> -			continue;
> -		last_pgdat = zone->zone_pgdat;
> -		n = per_cpu_ptr(zone->zone_pgdat->per_cpu_nodestats, cpu);
> -		if (memchr_inv(n->vm_node_stat_diff, 0, sizeof(n->vm_node_stat_diff)))
> -			return true;
> -	}
> -	return false;
> -}
> -
>  /*
>   * Switch off vmstat processing and then fold all the remaining differentials
>   * until the diffs stay at zero. The function is used by NOHZ and can only be
> @@ -1990,7 +1973,7 @@ void quiet_vmstat(void)
>  	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
>  		return;
>  
> -	if (!need_update(smp_processor_id()))
> +	if (!__this_cpu_read(vmstat_dirty))
>  		return;
>  
>  	/*
> @@ -2000,6 +1983,7 @@ void quiet_vmstat(void)
>  	 * vmstat_shepherd will take care about that for us.
>  	 */
>  	refresh_cpu_vm_stats(false);
> +	__this_cpu_write(vmstat_dirty, false);
>  }

From this context, irqs should be disabled.

>  /*
> @@ -2021,7 +2005,7 @@ static void vmstat_shepherd(struct work_struct *w)
>  	for_each_online_cpu(cpu) {
>  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
>  
> -		if (!delayed_work_pending(dw) && need_update(cpu))
> +		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
>  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
>  
>  		cond_resched();
> -- 
> 2.37.1
> 
> 

