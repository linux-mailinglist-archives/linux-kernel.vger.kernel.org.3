Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51465517F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbiECIDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 04:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiECIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 04:03:05 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99F82B254
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:59:32 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VC5Qqjm_1651564766;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VC5Qqjm_1651564766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 May 2022 15:59:28 +0800
Reply-To: xhao@linux.alibaba.com
Subject: Re: [PATCH v4 03/21] x86/resctrl: Add domain online callback for
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
        xingxin.hx@openanolis.org, baolin.wang@linux.alibaba.com
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-4-james.morse@arm.com>
 <3acfb11b-eba2-3eb0-94d1-d24a24d03d1f@linux.alibaba.com>
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <6b96076c-a8f2-2d55-d977-a5e91c2b0cba@linux.alibaba.com>
Date:   Tue, 3 May 2022 15:59:26 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <3acfb11b-eba2-3eb0-94d1-d24a24d03d1f@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/17/22 12:06 AM, Xin Hao wrote:
>
>
> On 4/12/22 8:44 PM, James Morse wrote:
>> Because domains are exposed to user-space via resctrl, the filesystem
>> must update its state when CPU hotplug callbacks are triggered.
>>
>> Some of this work is common to any architecture that would support
>> resctrl, but the work is tied up with the architecture code to
>> allocate the memory.
>>
>> Move domain_setup_mon_state(), the monitor subdir creation call and the
>> mbm/limbo workers into a new resctrl_online_domain() call. These bits
>> are not specific to the architecture. Grouping them in one function
>> allows that code to be moved to /fs/ and re-used by another architecture.
>>
>> Reviewed-by: Jamie Iles<quic_jiles@quicinc.com>
>> Tested-by: Xin Hao<xhao@linux.alibaba.com>
>> Reviewed-by: Shaopeng Tan<tan.shaopeng@fujitsu.com>
>> Tested-by: Shaopeng Tan<tan.shaopeng@fujitsu.com>
>> Tested-by: Cristian Marussi<cristian.marussi@arm.com>
>> Signed-off-by: James Morse<james.morse@arm.com>
>> ---
>> Changes since v2:
>>   * Fixed kfree(d) rebase artefact.
>>
>> Changes since v1:
>>   * Capitalisation
>>   * Removed inline comment
>>   * Added to the commit message
>> ---
>>   arch/x86/kernel/cpu/resctrl/core.c     | 57 ++++------------------
>>   arch/x86/kernel/cpu/resctrl/internal.h |  2 -
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 65 ++++++++++++++++++++++++--
>>   include/linux/resctrl.h                |  1 +
>>   4 files changed, 69 insertions(+), 56 deletions(-)
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
>> index 2f87177f1f69..25f30148478b 100644
>> --- a/arch/x86/kernel/cpu/resctrl/core.c
>> +++ b/arch/x86/kernel/cpu/resctrl/core.c
>> @@ -443,42 +443,6 @@ static int domain_setup_ctrlval(struct rdt_resource *r, struct rdt_domain *d)
>>   	return 0;
>>   }
>>   
>> -static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>> -{
>> -	size_t tsize;
>> -
>> -	if (is_llc_occupancy_enabled()) {
>> -		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
>> -		if (!d->rmid_busy_llc)
>> -			return -ENOMEM;
>> -		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>> -	}
>> -	if (is_mbm_total_enabled()) {
>> -		tsize = sizeof(*d->mbm_total);
>> -		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> -		if (!d->mbm_total) {
>> -			bitmap_free(d->rmid_busy_llc);
>> -			return -ENOMEM;
>> -		}
>> -	}
>> -	if (is_mbm_local_enabled()) {
>> -		tsize = sizeof(*d->mbm_local);
>> -		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> -		if (!d->mbm_local) {
>> -			bitmap_free(d->rmid_busy_llc);
>> -			kfree(d->mbm_total);
>> -			return -ENOMEM;
>> -		}
>> -	}
>> -
>> -	if (is_mbm_enabled()) {
>> -		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
>> -		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>   /*
>>    * domain_add_cpu - Add a cpu to a resource's domain list.
>>    *
>> @@ -498,6 +462,7 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>   	struct list_head *add_pos = NULL;
>>   	struct rdt_hw_domain *hw_dom;
>>   	struct rdt_domain *d;
>> +	int err;
>>   
>>   	d = rdt_find_domain(r, id, &add_pos);
>>   	if (IS_ERR(d)) {
>> @@ -527,21 +492,15 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
>>   		return;
>>   	}
>>   
>> -	if (r->mon_capable && domain_setup_mon_state(r, d)) {
>> -		kfree(hw_dom->ctrl_val);
>> -		kfree(hw_dom->mbps_val);
>> -		kfree(hw_dom);
>> -		return;
>> -	}
>> -
>>   	list_add_tail(&d->list, add_pos);
>>   
>> -	/*
>> -	 * If resctrl is mounted, add
>> -	 * per domain monitor data directories.
>> -	 */
>> -	if (static_branch_unlikely(&rdt_mon_enable_key))
>> -		mkdir_mondata_subdir_allrdtgrp(r, d);
>> +	err = resctrl_online_domain(r, d);
>> +	if (err) {
>> +		list_del(&d->list);
>> +		kfree(hw_dom->ctrl_val);
>> +		kfree(hw_dom->mbps_val);
>> +		kfree(hw_dom);
>> +	}
>>   }
>>   
>>   static void domain_remove_cpu(int cpu, struct rdt_resource *r)
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 8828b5c1b6d2..be48a682dbdb 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -524,8 +524,6 @@ void mon_event_count(void *info);
>>   int rdtgroup_mondata_show(struct seq_file *m, void *arg);
>>   void rmdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>>   				    unsigned int dom_id);
>> -void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>> -				    struct rdt_domain *d);
>>   void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
>>   		    struct rdt_domain *d, struct rdtgroup *rdtgrp,
>>   		    int evtid, int first);
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 651ff5288e85..53bdc07f9dac 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -2565,16 +2565,13 @@ static int mkdir_mondata_subdir(struct kernfs_node *parent_kn,
>>    * Add all subdirectories of mon_data for "ctrl_mon" groups
>>    * and "monitor" groups with given domain id.
>>    */
>> -void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>> -				    struct rdt_domain *d)
>> +static void mkdir_mondata_subdir_allrdtgrp(struct rdt_resource *r,
>> +					   struct rdt_domain *d)
>>   {
>>   	struct kernfs_node *parent_kn;
>>   	struct rdtgroup *prgrp, *crgrp;
>>   	struct list_head *head;
>>   
>> -	if (!r->mon_capable)
>> -		return;
>> -
>>   	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
>>   		parent_kn = prgrp->mon.mon_data_kn;
>>   		mkdir_mondata_subdir(parent_kn, d, r, prgrp);
>> @@ -3236,6 +3233,64 @@ static int __init rdtgroup_setup_root(void)
>>   	return ret;
>>   }
>>   
>> +static int domain_setup_mon_state(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	size_t tsize;
>> +
>> +	if (is_llc_occupancy_enabled()) {
>> +		d->rmid_busy_llc = bitmap_zalloc(r->num_rmid, GFP_KERNEL);
>> +		if (!d->rmid_busy_llc)
>> +			return -ENOMEM;
>> +	}
>> +	if (is_mbm_total_enabled()) {
>> +		tsize = sizeof(*d->mbm_total);
>> +		d->mbm_total = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> +		if (!d->mbm_total) {
>> +			bitmap_free(d->rmid_busy_llc);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +	if (is_mbm_local_enabled()) {
>> +		tsize = sizeof(*d->mbm_local);
>> +		d->mbm_local = kcalloc(r->num_rmid, tsize, GFP_KERNEL);
>> +		if (!d->mbm_local) {
>> +			bitmap_free(d->rmid_busy_llc);
>> +			kfree(d->mbm_total);
>> +			return -ENOMEM;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>> +{
>> +	int err;
>> +
>> +	lockdep_assert_held(&rdtgroup_mutex);
>> +
>> +	if (!r->mon_capable)
>> +		return 0;
>
> This return value "0" may not quite correct, in code where it is 
> called, if err = 0,  i think if  mon_capable is not supported, the 
> hw_dom->mbps_val also need to be released?  if I get this wrong，please 
> let me know.
>
> +	err = resctrl_online_domain(r, d);
> +	if (err) {
> +		list_del(&d->list);
> +		kfree(hw_dom->ctrl_val);
> +		kfree(hw_dom->mbps_val);
> +		kfree(hw_dom);
> +	}
>> +
>> +	err = domain_setup_mon_state(r, d);
>> +	if (err)
>> +		return err;
>> +
>> +	if (is_mbm_enabled()) {
>> +		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
>> +		mbm_setup_overflow_handler(d, MBM_OVERFLOW_INTERVAL);
>> +	}
>> +
>> +	if (is_llc_occupancy_enabled())
>> +		INIT_DELAYED_WORK(&d->cqm_limbo, cqm_handle_limbo);
>> +
>> +	/* If resctrl is mounted, add per domain monitor data directories. */
>> +	if (static_branch_unlikely(&rdt_mon_enable_key))
>> +		mkdir_mondata_subdir_allrdtgrp(r, d);
>> +
>> +	return 0;
>> +}
>> +
>>   /*
>>    * rdtgroup_init - rdtgroup initialization
>>    *
>> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
>> index 8180c539800d..d512455b4c3a 100644
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -192,5 +192,6 @@ u32 resctrl_arch_get_num_closid(struct rdt_resource *r);
>>   int resctrl_arch_update_domains(struct rdt_resource *r, u32 closid);
>>   u32 resctrl_arch_get_config(struct rdt_resource *r, struct rdt_domain *d,
>>   			    u32 closid, enum resctrl_conf_type type);
>> +int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d);
>>   
>>   #endif /* _RESCTRL_H */
> -- 
> Best Regards!
> Xin Hao

-- 
Best Regards!
Xin Hao

