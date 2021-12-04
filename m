Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF8468300
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241903AbhLDGvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:51:10 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16340 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhLDGvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:51:10 -0500
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4J5gGg6m2Cz90vh;
        Sat,  4 Dec 2021 14:47:07 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 4 Dec 2021 14:47:42 +0800
CC:     <yangyicong@hisilicon.com>,
        Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Len Brown <len.brown@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        Michael Larabel <Michael@MichaelLarabel.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] scheduler: Add boot time enabling/disabling of
 cluster scheduling
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1638563225.git.tim.c.chen@linux.intel.com>
 <41bf195de9d387ea58c030aec4eaaa8686c9cbb1.1638563225.git.tim.c.chen@linux.intel.com>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <50944873-5efb-ec73-19c9-918e3543b838@hisilicon.com>
Date:   Sat, 4 Dec 2021 14:47:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <41bf195de9d387ea58c030aec4eaaa8686c9cbb1.1638563225.git.tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On 2021/12/4 4:32, Tim Chen wrote:
> Add boot time parameter sched_cluster to enable or disable cluster
> scheduling.  Set boot parameter as follow:
> 
> 	sched_cluster=0 disables cluster scheduling
> 	sched_cluster=1 enables cluster scheduling
> 
> Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  4 ++++
>  kernel/sched/topology.c                         | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9725c546a0d4..40ad997430e1 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5023,6 +5023,10 @@
>  
>  	sched_verbose	[KNL] Enables verbose scheduler debug messages.
>  
> +	sched_cluster=  Enable or disable cluster scheduling.
> +			0 -- disable.
> +			1 -- enable.
> +

One minor question here. We use 0|1 for sched_cluster here, but "enable" or
"disable" for schedstats below. Should we keep consistent?

>  	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
>  			Allowed values are enable and disable. This feature
>  			incurs a small amount of overhead in the scheduler
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index e362bba29f95..087854d505f7 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1697,6 +1697,22 @@ int sched_cluster_handler(struct ctl_table *table, int write,
>  
>  	return ret;
>  }
> +
> +static int __init sched_cluster_option(char *str)
> +{
> +	int enable;
> +
> +	if (get_option(&str, &enable)) {
> +		if (enable != 0 && enable != 1)
> +			return -EINVAL;
> +
> +		sysctl_sched_cluster = enable;
> +		return 0;
> +	}
> +
> +	return -EINVAL;
> +}
> +early_param("sched_cluster", sched_cluster_option);
>  #endif
>  
>  static struct sched_domain_topology_level *next_tl(struct sched_domain_topology_level *tl)
> 
