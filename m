Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E15AFC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiIGGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIGGaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:30:00 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A09357C6
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:29:46 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0VOwgIzz_1662532179;
Received: from 30.240.98.182(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOwgIzz_1662532179)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 14:29:40 +0800
Message-ID: <d8fbb0c6-efe5-13bd-fb35-c6cb24ea7ff2@linux.alibaba.com>
Date:   Wed, 7 Sep 2022 14:29:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v6 05/21] x86/resctrl: Add domain offline callback for
 resctrl work
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        shameerali.kolothum.thodi@huawei.com,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        lcherian@marvell.com, bobo.shaobowang@huawei.com,
        tan.shaopeng@fujitsu.com, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com,
        xhao@linux.alibaba.com
References: <20220902154829.30399-1-james.morse@arm.com>
 <20220902154829.30399-6-james.morse@arm.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220902154829.30399-6-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 下午11:48, James Morse 写道:
> Because domains are exposed to user-space via resctrl, the filesystem
> must update its state when CPU hotplug callbacks are triggered.
>
> Some of this work is common to any architecture that would support
> resctrl, but the work is tied up with the architecture code to
> free the memory.
>
> Move the monitor subdir removal and the cancelling of the mbm/limbo
> works into a new resctrl_offline_domain() call. These bits are not
> specific to the architecture. Grouping them in one function allows
> that code to be moved to /fs/ and re-used by another architecture.
>
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> Changes since v2:
>   * Moved kfree()ing to domain_destroy_mon_state() for later re-use.
>
> Changes since v1:
>   * Removed a redundant mon_capable check
>   * Capitalisation
>   * Removed inline comment
>   * Added to the commit message
> ---
>   arch/x86/kernel/cpu/resctrl/core.c     | 26 ++-------------
>   arch/x86/kernel/cpu/resctrl/internal.h |  2 --
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 45 +++++++++++++++++++++++---
>   include/linux/resctrl.h                |  1 +
>   4 files changed, 44 insertions(+), 30 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index e37889f7a1a5..f69182973175 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -523,27 +523,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   
>   	cpumask_clear_cpu(cpu, &d->cpu_mask);
>   	if (cpumask_empty(&d->cpu_mask)) {
> -		/*
> -		 * If resctrl is mounted, remove all the
> -		 * per domain monitor data directories.
> -		 */
> -		if (static_branch_unlikely(&rdt_mon_enable_key))
> -			rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +		resctrl_offline_domain(r, d);
>   		list_del(&d->list);
> -		if (r->mon_capable && is_mbm_enabled())
> -			cancel_delayed_work(&d->mbm_over);
> -		if (is_llc_occupancy_enabled() &&  has_busy_rmid(r, d)) {
> -			/*
> -			 * When a package is going down, forcefully
> -			 * decrement rmid->ebusy. There is no way to know
> -			 * that the L3 was flushed and hence may lead to
> -			 * incorrect counts in rare scenarios, but leaving
> -			 * the RMID as busy creates RMID leaks if the
> -			 * package never comes back.
> -			 */
> -			__check_limbo(d, true);
> -			cancel_delayed_work(&d->cqm_limbo);
> -		}
>   
>   		/*
>   		 * rdt_domain "d" is going to be freed below, so clear
> @@ -551,11 +532,8 @@ static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>   		 */
>   		if (d->plr)
>   			d->plr->d = NULL;
> -
> -		bitmap_free(d->rmid_busy_llc);
> -		kfree(d->mbm_total);
> -		kfree(d->mbm_local);
>   		domain_free(hw_dom);
> +
>   		return;
>   	}
>   
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index be48a682dbdb..e12b55f815bf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -522,8 +522,6 @@ void free_rmid(u32 rmid);
>   int rdt_get_mon_l3_config(struct rdt_resource *r);
>   void mon_event_count(void *info);
>   int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> -void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> -				    unsigned int dom_id);
>   void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>   		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>   		    int evtid, int first);
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 030a70326ccc..5830905a92d2 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2499,14 +2499,12 @@ static int mon_addfile(struct kernfs_node *parent_kn, const char *name,
>    * Remove all subdirectories of mon_data of ctrl_mon groups
>    * and monitor groups with given domain id.
>    */
> -void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r, unsigned int dom_id)
> +static void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
> +					   unsigned int dom_id)
>   {
>   	struct rdtgroup *prgrp, *crgrp;
>   	char name[32];
>   
> -	if (!r->mon_capable)
> -		return;
> -
>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>   		sprintf(name, "mon_%s_%02d", r->name, dom_id);
>   		kernfs_remove_by_name(prgrp->mon.mon_data_kn, name);
> @@ -3233,6 +3231,45 @@ static int __init rdtgroup_setup_root(void)
>   	return ret;
>   }
>   
> +static void domain_destroy_mon_state(struct rdt_domain *d)
add inline ?
> +{
> +	bitmap_free(d->rmid_busy_llc);
> +	kfree(d->mbm_total);
> +	kfree(d->mbm_local);
> +}
> +
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
> +{
> +	lockdep_assert_held(&rdtgroup_mutex);
> +
> +	if (!r->mon_capable)
> +		return;
> +
> +	/*
> +	 * If resctrl is mounted, remove all the
> +	 * per domain monitor data directories.
> +	 */
> +	if (static_branch_unlikely(&rdt_mon_enable_key))
> +		rmdir_mondata_subdir_allrdtgrp(r, d->id);
> +
> +	if (is_mbm_enabled())
> +		cancel_delayed_work(&d->mbm_over);
> +	if (is_llc_occupancy_enabled() && has_busy_rmid(r, d)) {
> +		/*
> +		 * When a package is going down, forcefully
> +		 * decrement rmid->ebusy. There is no way to know
> +		 * that the L3 was flushed and hence may lead to
> +		 * incorrect counts in rare scenarios, but leaving
> +		 * the RMID as busy creates RMID leaks if the
> +		 * package never comes back.
> +		 */
> +		__check_limbo(d, true);
> +		cancel_delayed_work(&d->cqm_limbo);
> +	}
> +
> +	domain_destroy_mon_state(d);
> +}
> +
>   static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>   {
>   	size_t tsize;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index d512455b4c3a..5d283bdd6162 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -193,5 +193,6 @@ int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>   u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>   			    u32 closid, enum resctrl_conf_type type);
>   int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
> +void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d);
>   
>   #endif /* _RESCTRL_H */
