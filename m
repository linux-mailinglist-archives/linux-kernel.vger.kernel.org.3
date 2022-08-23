Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8ADE59E779
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 18:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbiHWQgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 12:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245289AbiHWQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 12:35:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2519D41A0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 06:06:17 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MBqDn22Y4zGplg;
        Tue, 23 Aug 2022 21:04:09 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 23 Aug 2022 21:05:48 +0800
CC:     <yangyicong@hisilicon.com>, <sudeep.holla@arm.com>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
Subject: Re: [PATCH] arch_topology: Make cluster topology span at least SMT
 CPUs
To:     Ionela Voinescu <ionela.voinescu@arm.com>
References: <20220823073044.58697-1-yangyicong@huawei.com>
 <YwSKnGii2zdd7Fig@arm.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d0bc04af-5481-5df2-ff75-9072b4b047c1@huawei.com>
Date:   Tue, 23 Aug 2022 21:05:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YwSKnGii2zdd7Fig@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/23 16:06, Ionela Voinescu wrote:
> Hi Yicong,
> 
> On Tuesday 23 Aug 2022 at 15:30:44 (+0800), Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently cpu_clustergroup_mask() will return CPU mask if cluster span
>> more or the same CPUs as cpu_coregroup_mask(). This will result topology
>> borken on non-Cluster SMT machines.
> 
> Might be worth adding here:.. "when building with CONFIG_SCHED_CLUSTER=y"
> 

will add this qualifier. thanks.

>>
> 
> I thought I had covered this case, but I think I had considered LLC
> spanning more than one core (tested on TX2 as well).
> 
> So you'd only hit this if LLC and cluster level span the same cores (a
> single core in this case, for non-cluster), in the presence of SMT.
> 

Not sure I understand it correctly but in the below case I think the LLC may span
the same core with socket?

> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> 
> Many thanks,
> Ionela.
> 
>> Test with:
>> qemu-system-aarch64 -enable-kvm -machine virt \
>>  -net none \
>>  -cpu host \
>>  -bios ./QEMU_EFI.fd \
>>  -m 2G \
>>  -smp 48,sockets=2,cores=12,threads=2 \
>>  -kernel $Image \
>>  -initrd $Rootfs \
>>  -nographic
>>  -append "rdinit=init console=ttyAMA0 sched_verbose loglevel=8"
>>
>> We'll get below error:
>> [    3.084568] BUG: arch topology borken
>> [    3.084570]      the SMT domain not a subset of the CLS domain
>>
>> Since cluster is a level higher than SMT, fix this by making cluster
>> spans at least SMT CPUs.
>>
>> Cc: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Ionela Voinescu <ionela.voinescu@arm.com>
>> Fixes: bfcc4397435d ("arch_topology: Limit span of cpu_clustergroup_mask()")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/base/arch_topology.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 0424b59b695e..0056a1273275 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -724,7 +724,7 @@ const struct cpumask *cpu_clustergroup_mask(int cpu)
>>  	 */
>>  	if (cpumask_subset(cpu_coregroup_mask(cpu),
>>  			   &cpu_topology[cpu].cluster_sibling))
>> -		return get_cpu_mask(cpu);
>> +		return cpu_smt_mask(cpu);
>>  
>>  	return &cpu_topology[cpu].cluster_sibling;
>>  }
>> -- 
>> 2.24.0
>>
> 
> .
> 
