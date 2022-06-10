Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953FD545CB3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 08:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbiFJGy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 02:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241047AbiFJGyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 02:54:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDDDD113
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 23:54:13 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKBTv5cxkzgYg9;
        Fri, 10 Jun 2022 14:52:19 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 10 Jun 2022 14:54:10 +0800
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>
Subject: Re: [PATCH v4 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_resources API
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20220609120622.47724-1-yangyicong@hisilicon.com>
 <20220609120622.47724-2-yangyicong@hisilicon.com>
 <05472b4ed10c694bce1a2b6dd4a0ef13ea337db3.camel@linux.intel.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <47e3aafa-aae6-051d-99ec-528f7b609b38@huawei.com>
Date:   Fri, 10 Jun 2022 14:54:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <05472b4ed10c694bce1a2b6dd4a0ef13ea337db3.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/10 6:28, Tim Chen wrote:
> On Thu, 2022-06-09 at 20:06 +0800, Yicong Yang wrote:
>>
>>  
>> +/*
>> + * Whether CPUs are share cache resources, which means LLC on non-cluster
>> + * machines and LLC tag or L2 on machines with clusters.
>> + */
>> +bool cpus_share_resources(int this_cpu, int that_cpu)
> 
> Suggest cpus_share_lowest_cache to be a bit more informative
> 
>> +{
>> +	if (this_cpu == that_cpu)
>> +		return true;
>> +
>> +	return per_cpu(sd_share_id, this_cpu) == per_cpu(sd_share_id, that_cpu);
>> +}
>> +
>>  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>  {
>>  	/*
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 01259611beb9..b9bcfcf8d14d 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1753,7 +1753,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>  DECLARE_PER_CPU(int, sd_llc_size);
>>  DECLARE_PER_CPU(int, sd_llc_id);
>> +DECLARE_PER_CPU(int, sd_share_id);
>>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
>> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
>> index 05b6c2ad90b9..0595827d481d 100644
>> --- a/kernel/sched/topology.c
>> +++ b/kernel/sched/topology.c
>> @@ -664,6 +664,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>>  DEFINE_PER_CPU(int, sd_llc_size);
>>  DEFINE_PER_CPU(int, sd_llc_id);
>> +DEFINE_PER_CPU(int, sd_share_id);
> 
> Some minor nits about the name of "sd_share_id".  
> It is not quite obvious what it is.  
> 
> Maybe something like sd_lowest_cache_id to denote
> it is the id of lowest shared cache domain between CPU. 
> 

Thanks for the suggestion! Since Vincent and Gautham have suggested this in v1 [1], I'd like
to wait a bit before changing to this to see if they have any comment.

> Otherwise the patch looks good to me.  You can add
> 
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> 

Thanks.

[1] https://lore.kernel.org/lkml/CAKfTPtBKLDyNPXg7uLbQ3jUnEwppfC+E29=oJ1tWzzqHsNpApw@mail.gmail.com/
