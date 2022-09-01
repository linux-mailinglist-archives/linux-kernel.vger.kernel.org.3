Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414D45A99E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiIAOPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiIAOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:14:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC4A696FC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:14:41 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31114200FC;
        Thu,  1 Sep 2022 14:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1662041680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aHbU7uRbj4BxHL9STRmI+GKXLKBtY/Mix8pYPh/Y38=;
        b=Ft8wEwGVFlP2WWfIqn21mcgtVZjmR/HJRxO2kfx55x7W1LXapaaOFwB1NGbXwMnc9+5Fuk
        dWBUA0aoIrhwH3t5zVc1a8Zz/bdejSnVvpdwJjLH+XHtPGIjJyKY73aq1eNhinFQmDcGTa
        MVvVpg8qb8SFIzfDRfzadDYihfSrXws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1662041680;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6aHbU7uRbj4BxHL9STRmI+GKXLKBtY/Mix8pYPh/Y38=;
        b=F+2K1qG/1WCPl7EcNxJYEeIWFAcVCo4TmRxvZtTldiPidZhoKJwxETdt2TjsOEUuS4pzxO
        c2XkZu/w5XRfOhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0C4C913A79;
        Thu,  1 Sep 2022 14:14:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +uq2AVC+EGMBVwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 01 Sep 2022 14:14:40 +0000
Message-ID: <efa7bebf-b977-dea1-de1a-cbdaffaa165b@suse.cz>
Date:   Thu, 1 Sep 2022 16:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [RFC PATCH] mm: reduce noise in show_mem for lowmem allocations
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <YwScVmVofIZkopkF@dhcp22.suse.cz>
 <Yw29bmJTIkKogTiW@dhcp22.suse.cz>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Yw29bmJTIkKogTiW@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 09:34, Michal Hocko wrote:
> [Cc Dan]
> Dan has brought up[1] that the use of gfp mask has confused his static
> analyzer which assumes that GFP_HIGHUSER_MOVABLE implies a sleeping
> allocation and that wouldn't be a great idea from the panic path. I
> would add that most callers of this function would be really bad to
> allocate.
> 
> The report itself is a false positive but it made me think a bit about
> this. Even if the check is too simplistic I guess it resembles how many
> developers are thinking (including me). If I see GFP_HIGHUSER_MOVABLE or
> GF_KERNEL I automatically assume a sleeping allocation down the road.
> And who know somebody might add one in the future even into show_mem
> because the gfp parameter would be too tempting to not (ab)use.
> 
> My original intention was to use a natural allocation speak but this can
> backfire so maybe it would be better to give the argument its real
> meaning and that is the high_zone_idx. This is cryptic for code outside
> of MM but that is not all that many callers and we can hide this fact
> from them. In other words does the thing below looks better (incremental
> for illustration, I will make it a proper patch if yes)?

Yeah, looks better to me this way. Thanks!

> 
> [1] https://lore.kernel.org/all/Yw2ugrlZ8bwE5/hh@kili/?q=http%3A%2F%2Flkml.kernel.org%2Fr%2FYw2ugrlZ8bwE5%2Fhh%40kili
> 
> --- 
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 19b1a94b0c00..3d9782ea3fa7 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -1086,7 +1086,7 @@ cmds(struct pt_regs *excp)
>  				memzcan();
>  				break;
>  			case 'i':
> -				show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
> +				show_mem(0, NULL);
>  				break;
>  			default:
>  				termch = cmd;
> diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
> index 2a1e5641a7cc..c8e0dd99f370 100644
> --- a/arch/sparc/kernel/setup_32.c
> +++ b/arch/sparc/kernel/setup_32.c
> @@ -83,7 +83,7 @@ static void prom_sync_me(void)
>  			     "nop\n\t" : : "r" (&trapbase));
>  
>  	prom_printf("PROM SYNC COMMAND...\n");
> -	show_free_areas(0, NULL, GFP_HIGHUSER_MOVABLE);
> +	show_free_areas(0, NULL);
>  	if (!is_idle_task(current)) {
>  		local_irq_enable();
>  		ksys_sync();
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index c6b2b42d2367..d2b2720db6ca 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -342,7 +342,7 @@ static const struct sysrq_key_op sysrq_ftrace_dump_op = {
>  
>  static void sysrq_handle_showmem(int key)
>  {
> -	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
> +	show_mem(0, NULL);
>  }
>  static const struct sysrq_key_op sysrq_showmem_op = {
>  	.handler	= sysrq_handle_showmem,
> diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
> index 9ceeea531cf6..be8313cdbac3 100644
> --- a/drivers/tty/vt/keyboard.c
> +++ b/drivers/tty/vt/keyboard.c
> @@ -606,7 +606,7 @@ static void fn_scroll_back(struct vc_data *vc)
>  
>  static void fn_show_mem(struct vc_data *vc)
>  {
> -	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
> +	show_mem(0, NULL);
>  }
>  
>  static void fn_show_state(struct vc_data *vc)
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e0d0ac52770c..0756798feaff 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1827,7 +1827,11 @@ extern void pagefault_out_of_memory(void);
>   */
>  #define SHOW_MEM_FILTER_NODES		(0x0001u)	/* disallowed nodes */
>  
> -extern void show_free_areas(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
> +extern void __show_free_areas(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
> +static void __maybe_unused show_free_areas(unsigned int flags, nodemask_t *nodemask)
> +{
> +	__show_free_areas(flags, nodemask, MAX_NR_ZONES - 1);
> +}
>  
>  #ifdef CONFIG_MMU
>  extern bool can_do_mlock(void);
> @@ -2563,7 +2567,12 @@ extern void calculate_min_free_kbytes(void);
>  extern int __meminit init_per_zone_wmark_min(void);
>  extern void mem_init(void);
>  extern void __init mmap_init(void);
> -extern void show_mem(unsigned int flags, nodemask_t *nodemask, gfp_t gfp_mask);
> +
> +extern void __show_mem(unsigned int flags, nodemask_t *nodemask, int max_zone_idx);
> +static inline void show_mem(unsigned int flags, nodemask_t *nodemask)
> +{
> +	__show_mem(flags, nodemask, MAX_NR_ZONES - 1);
> +}
>  extern long si_mem_available(void);
>  extern void si_meminfo(struct sysinfo * val);
>  extern void si_meminfo_node(struct sysinfo *val, int nid);
> diff --git a/init/initramfs.c b/init/initramfs.c
> index ec966cb78363..18229cfe8906 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -63,7 +63,7 @@ static void panic_show_mem(const char *fmt, ...)
>  {
>  	va_list args;
>  
> -	show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
> +	show_mem(0, NULL);
>  	va_start(args, fmt);
>  	panic(fmt, args);
>  	va_end(args);
> diff --git a/kernel/panic.c b/kernel/panic.c
> index ba5f7691d15c..a3308af28a21 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -187,7 +187,7 @@ static void panic_print_sys_info(bool console_flush)
>  		show_state();
>  
>  	if (panic_print & PANIC_PRINT_MEM_INFO)
> -		show_mem(0, NULL, GFP_HIGHUSER_MOVABLE);
> +		show_mem(0, NULL);
>  
>  	if (panic_print & PANIC_PRINT_TIMER_INFO)
>  		sysrq_timer_list_show();
> diff --git a/lib/show_mem.c b/lib/show_mem.c
> index b97461a6c4bb..ade71096e241 100644
> --- a/lib/show_mem.c
> +++ b/lib/show_mem.c
> @@ -8,13 +8,13 @@
>  #include <linux/mm.h>
>  #include <linux/cma.h>
>  
> -void show_mem(unsigned int filter, nodemask_t *nodemask, gfp_t gfp_mask)
> +void __show_mem(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  {
>  	pg_data_t *pgdat;
>  	unsigned long total = 0, reserved = 0, highmem = 0;
>  
>  	printk("Mem-Info:\n");
> -	show_free_areas(filter, nodemask, gfp_mask);
> +	show_free_areas(filter, nodemask, max_zone_idx);
>  
>  	for_each_online_pgdat(pgdat) {
>  		int zoneid;
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 46cff4a51fa0..9d7afc2d959e 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1047,7 +1047,7 @@ static int do_mmap_private(struct vm_area_struct *vma,
>  enomem:
>  	pr_err("Allocation of length %lu from process %d (%s) failed\n",
>  	       len, current->pid, current->comm);
> -	show_free_areas(0, NULL, GFP_KERNEL);
> +	show_free_areas(0, NULL);
>  	return -ENOMEM;
>  }
>  
> @@ -1270,13 +1270,13 @@ unsigned long do_mmap(struct file *file,
>  	kmem_cache_free(vm_region_jar, region);
>  	pr_warn("Allocation of vma for %lu byte allocation from process %d failed\n",
>  			len, current->pid);
> -	show_free_areas(0, NULL, GFP_KERNEL);
> +	show_free_areas(0, NULL);
>  	return -ENOMEM;
>  
>  error_getting_region:
>  	pr_warn("Allocation of vm region for %lu byte allocation from process %d failed\n",
>  			len, current->pid);
> -	show_free_areas(0, NULL, GFP_KERNEL);
> +	show_free_areas(0, NULL);
>  	return -ENOMEM;
>  }
>  
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index ffeaad3b348d..94804504be9c 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -461,7 +461,7 @@ static void dump_header(struct oom_control *oc, struct task_struct *p)
>  	if (is_memcg_oom(oc))
>  		mem_cgroup_print_oom_meminfo(oc->memcg);
>  	else {
> -		show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, oc->gfp_mask);
> +		__show_mem(SHOW_MEM_FILTER_NODES, oc->nodemask, gfp_zone(oc->gfp_mask));
>  		if (should_dump_unreclaim_slab())
>  			dump_unreclaimable_slab();
>  	}
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 208e3f8b38f8..110a16ea848a 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4248,7 +4248,7 @@ static void warn_alloc_show_mem(gfp_t gfp_mask, nodemask_t *nodemask)
>  	if (!in_task() || !(gfp_mask & __GFP_DIRECT_RECLAIM))
>  		filter &= ~SHOW_MEM_FILTER_NODES;
>  
> -	show_mem(filter, nodemask, gfp_mask);
> +	__show_mem(filter, nodemask, gfp_zone(gfp_mask));
>  }
>  
>  void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
> @@ -5944,10 +5944,9 @@ static bool node_has_managed_zones(pg_data_t *pgdat, int max_zone_idx)
>   * SHOW_MEM_FILTER_NODES: suppress nodes that are not allowed by current's
>   *   cpuset.
>   */
> -void show_free_areas(unsigned int filter, nodemask_t *nodemask, gfp_t gfp_mask)
> +void __show_free_areas(unsigned int filter, nodemask_t *nodemask, int max_zone_idx)
>  {
>  	unsigned long free_pcp = 0;
> -	int max_zone_idx = gfp_zone(gfp_mask);
>  	int cpu;
>  	struct zone *zone;
>  	pg_data_t *pgdat;

