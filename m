Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1F35AC92F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 05:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbiIEDlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 23:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236060AbiIEDlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 23:41:42 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE9C2E695
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 20:41:40 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MLZ5Z45HbzrS77;
        Mon,  5 Sep 2022 11:39:46 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 5 Sep 2022 11:41:38 +0800
CC:     <yangyicong@hisilicon.com>, <sudeep.holla@arm.com>,
        <vincent.guittot@linaro.org>, <ionela.voinescu@arm.com>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <21cnbao@gmail.com>, <jonathan.cameron@huawei.com>,
        <linuxarm@huawei.com>, <prime.zeng@huawei.com>
Subject: Re: [PATCH v2] arch_topology: Make cluster topology span at least SMT
 CPUs
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220825092007.8129-1-yangyicong@huawei.com>
 <YxLtlyIu4hZW+lOo@kroah.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <a76d1153-dc5a-d26c-75d2-4fdb48a9641d@huawei.com>
Date:   Mon, 5 Sep 2022 11:41:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YxLtlyIu4hZW+lOo@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/3 14:00, Greg KH wrote:
> On Thu, Aug 25, 2022 at 05:20:07PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> Currently cpu_clustergroup_mask() will return CPU mask if cluster span more
>> or the same CPUs as cpu_coregroup_mask(). This will result topology borken
>> on non-Cluster SMT machines when building with CONFIG_SCHED_CLUSTER=y.
>>
>> Test with:
>> qemu-system-aarch64 -enable-kvm -machine virt \
>>  -net none \
>>  -cpu host \
>>  -bios ./QEMU_EFI.fd \
>>  -m 2G \
>>  -smp 48,sockets=2,cores=12,threads=2 \
>>  -kernel $Image \
>>  -initrd $Rootfs \
>>  -nographic \
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
>> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>> Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
>> ---
>> Change since v1:
>> - mention the kernel config CONFIG_SCHED_CLUSTER=y, per Ionela
>> Link:https://lore.kernel.org/lkml/20220823073044.58697-1-yangyicong@huawei.com/
>>
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
> 
> As the kernel-test robot reported, this breaks the build on some
> architectures, so I'll go and revert it from my tree now.
> 

Sorry for the regression.

The build error is because cpu_smt_mask() is defined only when CONFIG_SCHED_SMT=y
so we'll fail when CONFIG_SCHED_SMT=n. Should use topology_sibling_cpumask() to
get SMT mask here. Will respin this.

Thanks.
