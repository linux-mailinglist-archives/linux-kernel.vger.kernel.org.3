Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3D5954AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232518AbiHPINK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbiHPIMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:12:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B857D5998;
        Mon, 15 Aug 2022 23:26:54 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4M6Lfn3YgtzXdjl;
        Tue, 16 Aug 2022 14:22:41 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 16 Aug 2022 14:26:52 +0800
CC:     <yangyicong@hisilicon.com>, <will@kernel.org>,
        <mark.rutland@arm.com>, <Frank.li@nxp.com>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <zhangshaokun@hisilicon.com>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>,
        <khuong@os.amperecomputing.com>, <john.garry@huawei.com>,
        <jonathan.cameron@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] drivers/perf: Change WARN_ON() to dev_err() on
 irq_set_affinity() failure
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220815092815.11597-1-yangyicong@huawei.com>
 <YvokT+ZQQMlEAga8@kroah.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <d4603a04-c1df-e57a-d167-1d063e8d2f23@huawei.com>
Date:   Tue, 16 Aug 2022 14:26:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YvokT+ZQQMlEAga8@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

On 2022/8/15 18:47, Greg KH wrote:
> On Mon, Aug 15, 2022 at 05:28:15PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> The WARN_ON() on irq_set_affinity() failure is misused according to the [1]
>> and may crash people's box unintentionally. This may also be redundant since
>> in the failure case we may also trigger the WARN and dump the stack in the
>> perf core[2] for a second time.
>>
>> So change the WARN_ON() to dev_err() to just print the failure message.
>>
>> [1] https://github.com/torvalds/linux/blob/master/include/asm-generic/bug.h#L74
>> [2] https://github.com/torvalds/linux/blob/master/kernel/events/core.c#L313
> 
> Please point to git.kernel.org links, we do not control github.com and
> it's random mirrors.
> 

Got it. Will update with a git.kernel.org link. Thanks for point it out!

>>
>> Suggested-by: Greg KH <gregkh@linuxfoundation.org>
>> [https://lore.kernel.org/lkml/YuOi3i0XHV++z1YI@kroah.com/]
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/perf/arm-ccn.c                   | 5 +++--
>>  drivers/perf/arm_dmc620_pmu.c            | 3 ++-
>>  drivers/perf/arm_smmuv3_pmu.c            | 6 ++++--
>>  drivers/perf/fsl_imx8_ddr_perf.c         | 3 ++-
>>  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 6 ++++--
>>  drivers/perf/hisilicon/hisi_uncore_pmu.c | 6 ++++--
>>  drivers/perf/qcom_l2_pmu.c               | 8 ++++++--
>>  drivers/perf/xgene_pmu.c                 | 6 ++++--
>>  8 files changed, 29 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/perf/arm-ccn.c b/drivers/perf/arm-ccn.c
>> index 728d13d8e98a..83abd909ba49 100644
>> --- a/drivers/perf/arm-ccn.c
>> +++ b/drivers/perf/arm-ccn.c
>> @@ -1210,8 +1210,9 @@ static int arm_ccn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
>>  		return 0;
>>  	perf_pmu_migrate_context(&dt->pmu, cpu, target);
>>  	dt->cpu = target;
>> -	if (ccn->irq)
>> -		WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
>> +	if (ccn->irq && irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)))
>> +		dev_err(ccn->dev, "Failed to set interrupt affinity\n");
>> +
>>  	return 0;
> 
> Why are you returning with no error, if an error happened?
> 
> Same everywhere else, you need to explain this in your changelog text.
> 

This patch intends no functional change but to switch the way on the error notification to avoid
crash the box. So just keep the current handling behaviour. Will mention this in the commit in v2.
I think whether we should actually reponse to the error should be according to the driver.

Thanks.
