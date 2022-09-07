Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CAC5AFC57
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIGG1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiIGG1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:27:07 -0400
Received: from out199-9.us.a.mail.aliyun.com (out199-9.us.a.mail.aliyun.com [47.90.199.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375DB7C306
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 23:27:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0VOwgIB2_1662532017;
Received: from 30.240.98.182(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VOwgIB2_1662532017)
          by smtp.aliyun-inc.com;
          Wed, 07 Sep 2022 14:26:59 +0800
Message-ID: <539cd9b3-9a2b-47c2-7436-89aedef33d1c@linux.alibaba.com>
Date:   Wed, 7 Sep 2022 14:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.1.2
Subject: Re: [PATCH v6 20/21] x86/resctrl: Add resctrl_rmid_realloc_limit to
 abstract x86's boot_cpu_data
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
References: <20220902154829.30399-1-james.morse@arm.com>
 <20220902154829.30399-21-james.morse@arm.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220902154829.30399-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/2 下午11:48, James Morse 写道:
> resctrl_rmid_realloc_threshold can be set by user-space. The maximum
> value is specified by the architecture.
>
> Currently max_threshold_occ_write() reads the maximum value from
> boot_cpu_data.x86_cache_size, which is not portable to another
> architecture.
>
> Add resctrl_rmid_realloc_limit to describe the maximum size in bytes
> that user-space can set the threshold to.
>
> Reviewed-by: Jamie Iles <quic_jiles@quicinc.com>
> Tested-by: Xin Hao <xhao@linux.alibaba.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@fujitsu.com>
> Tested-by: Cristian Marussi <cristian.marussi@arm.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/monitor.c  | 9 +++++++--
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
>   include/linux/resctrl.h                | 1 +
>   3 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index e91afe99b763..8d15568d7121 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -67,6 +67,11 @@ unsigned int rdt_mon_features;
>    */
>   unsigned int resctrl_rmid_realloc_threshold;
>   
> +/*
> + * This is the maximum value for the reallocation threshold, in bytes.
> + */
> +unsigned int resctrl_rmid_realloc_limit;
> +
>   #define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
>   
>   /*
> @@ -747,10 +752,10 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>   {
>   	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
>   	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
> -	unsigned int cl_size = boot_cpu_data.x86_cache_size;
>   	unsigned int threshold;
>   	int ret;
>   
> +	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
Use SZ_1K instead ?
>   	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
>   	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
>   	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
> @@ -767,7 +772,7 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
>   	 *
>   	 * For a 35MB LLC and 56 RMIDs, this is ~1.8% of the LLC.
>   	 */
> -	threshold = cl_size * 1024 / r->num_rmid;
> +	threshold = resctrl_rmid_realloc_limit / r->num_rmid;
>   
>   	/*
>   	 * Because num_rmid may not be a power of two, round the value
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 849bdec37217..e5a48f05e787 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -1059,7 +1059,7 @@ static ssize_t max_threshold_occ_write(struct kernfs_open_file *of,
>   	if (ret)
>   		return ret;
>   
> -	if (bytes > (boot_cpu_data.x86_cache_size * 1024))
> +	if (bytes > resctrl_rmid_realloc_limit)
>   		return -EINVAL;
>   
>   	resctrl_rmid_realloc_threshold = resctrl_arch_round_mon_val(bytes);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 9995d043650a..cb857f753322 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -251,5 +251,6 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_domain *d,
>   			     u32 rmid, enum resctrl_event_id eventid);
>   
>   extern unsigned int resctrl_rmid_realloc_threshold;
> +extern unsigned int resctrl_rmid_realloc_limit;
>   
>   #endif /* _RESCTRL_H */
