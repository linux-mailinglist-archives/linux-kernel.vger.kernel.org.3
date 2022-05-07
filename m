Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E17F751E2FB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 03:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445159AbiEGB1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 21:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbiEGB1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 21:27:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD721A074;
        Fri,  6 May 2022 18:23:16 -0700 (PDT)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kw8kj5qmCzGpXk;
        Sat,  7 May 2022 09:20:29 +0800 (CST)
Received: from dggpeml500008.china.huawei.com (7.185.36.147) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 09:23:14 +0800
Received: from [127.0.0.1] (10.67.111.83) by dggpeml500008.china.huawei.com
 (7.185.36.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 7 May
 2022 09:23:14 +0800
Message-ID: <c395bed5-8701-de91-feaf-ceeda95702e3@huawei.com>
Date:   Sat, 7 May 2022 09:23:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] platform/x86: amd-pmc: Fix build error
 unused-function
To:     Hans de Goede <hdegoede@redhat.com>, <Shyam-sundar.S-k@amd.com>,
        <markgross@kernel.org>
CC:     <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20220505121958.138905-1-renzhijie2@huawei.com>
 <f73836d2-913a-87c1-af44-56429ffcb963@redhat.com>
From:   Ren Zhijie <renzhijie2@huawei.com>
In-Reply-To: <f73836d2-913a-87c1-af44-56429ffcb963@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.83]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500008.china.huawei.com (7.185.36.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/5/6 18:37, Hans de Goede 写道:
> Hi,
>
> On 5/5/22 14:19, Ren Zhijie wrote:
>> If CONFIG_SUSPEND and CONFIG_DEBUG_FS are not set.
>>
>> compile error:
>> drivers/platform/x86/amd-pmc.c:323:12: error: ‘get_metrics_table’ defined but not used [-Werror=unused-function]
>>   static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table)
>>              ^~~~~~~~~~~~~~~~~
>> drivers/platform/x86/amd-pmc.c:298:12: error: ‘amd_pmc_idlemask_read’ defined but not used [-Werror=unused-function]
>>   static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
>>              ^~~~~~~~~~~~~~~~~~~~~
>> drivers/platform/x86/amd-pmc.c:196:12: error: ‘amd_pmc_get_smu_version’ defined but not used [-Werror=unused-function]
>>   static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>>              ^~~~~~~~~~~~~~~~~~~~~~~
>> cc1: all warnings being treated as errors
>>
>> To fix building warning, wrap all related code with CONFIG_SUSPEND or CONFIG_DEBUG_FS.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> Thanks for the patch, the issue with amd_pmc_get_smu_version() not being
> wrapped in #ifdef CONFIG_DEBUG_FS was already fixed by:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?h=for-next&id=acd51562e07d17aaf4ac652f1dc55c743685bf41
>
> Moving amd_pmc_setup_smu_logging + amd_pmc_idlemask_read +
> get_metrics_table under:
>
> #if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>
> is still necessary though, so I've merged that part of your patch:
>
> Thank you for your patch, I've applied this patch to my review-hans
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
>
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.
>
> Regards,
>
> Hans

Glad that I could help

Regards,

Ren

>
>> ---
>>   drivers/platform/x86/amd-pmc.c | 72 ++++++++++++++++++----------------
>>   1 file changed, 39 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>> index 668a1d6c11ee..8f004673b23f 100644
>> --- a/drivers/platform/x86/amd-pmc.c
>> +++ b/drivers/platform/x86/amd-pmc.c
>> @@ -164,7 +164,6 @@ static int amd_pmc_read_stb(struct amd_pmc_dev *dev, u32 *buf);
>>   #ifdef CONFIG_SUSPEND
>>   static int amd_pmc_write_stb(struct amd_pmc_dev *dev, u32 data);
>>   #endif
>> -static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev);
>>   
>>   static inline u32 amd_pmc_reg_read(struct amd_pmc_dev *dev, int reg_offset)
>>   {
>> @@ -193,6 +192,7 @@ struct smu_metrics {
>>   	u64 timecondition_notmet_totaltime[SOC_SUBSYSTEM_IP_MAX];
>>   } __packed;
>>   
>> +#ifdef CONFIG_DEBUG_FS
>>   static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>>   {
>>   	int rc;
>> @@ -212,6 +212,7 @@ static int amd_pmc_get_smu_version(struct amd_pmc_dev *dev)
>>   
>>   	return 0;
>>   }
>> +#endif /* CONFIG_DEBUG_FS */
>>   
>>   static int amd_pmc_stb_debugfs_open(struct inode *inode, struct file *filp)
>>   {
>> @@ -295,6 +296,9 @@ static const struct file_operations amd_pmc_stb_debugfs_fops_v2 = {
>>   	.release = amd_pmc_stb_debugfs_release_v2,
>>   };
>>   
>> +#if defined(CONFIG_SUSPEND) || defined(CONFIG_DEBUG_FS)
>> +static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev);
>> +
>>   static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
>>   				 struct seq_file *s)
>>   {
>> @@ -335,6 +339,40 @@ static int get_metrics_table(struct amd_pmc_dev *pdev, struct smu_metrics *table
>>   	return 0;
>>   }
>>   
>> +static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
>> +{
>> +	if (dev->cpu_id == AMD_CPU_ID_PCO) {
>> +		dev_warn_once(dev->dev, "SMU debugging info not supported on this platform\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Get Active devices list from SMU */
>> +	if (!dev->active_ips)
>> +		amd_pmc_send_cmd(dev, 0, &dev->active_ips, SMU_MSG_GET_SUP_CONSTRAINTS, 1);
>> +
>> +	/* Get dram address */
>> +	if (!dev->smu_virt_addr) {
>> +		u32 phys_addr_low, phys_addr_hi;
>> +		u64 smu_phys_addr;
>> +
>> +		amd_pmc_send_cmd(dev, 0, &phys_addr_low, SMU_MSG_LOG_GETDRAM_ADDR_LO, 1);
>> +		amd_pmc_send_cmd(dev, 0, &phys_addr_hi, SMU_MSG_LOG_GETDRAM_ADDR_HI, 1);
>> +		smu_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
>> +
>> +		dev->smu_virt_addr = devm_ioremap(dev->dev, smu_phys_addr,
>> +						  sizeof(struct smu_metrics));
>> +		if (!dev->smu_virt_addr)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	/* Start the logging */
>> +	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_RESET, 0);
>> +	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_START, 0);
>> +
>> +	return 0;
>> +}
>> +#endif /* CONFIG_SUSPEND || CONFIG_DEBUG_FS */
>> +
>>   #ifdef CONFIG_SUSPEND
>>   static void amd_pmc_validate_deepest(struct amd_pmc_dev *pdev)
>>   {
>> @@ -475,38 +513,6 @@ static inline void amd_pmc_dbgfs_unregister(struct amd_pmc_dev *dev)
>>   }
>>   #endif /* CONFIG_DEBUG_FS */
>>   
>> -static int amd_pmc_setup_smu_logging(struct amd_pmc_dev *dev)
>> -{
>> -	if (dev->cpu_id == AMD_CPU_ID_PCO) {
>> -		dev_warn_once(dev->dev, "SMU debugging info not supported on this platform\n");
>> -		return -EINVAL;
>> -	}
>> -
>> -	/* Get Active devices list from SMU */
>> -	if (!dev->active_ips)
>> -		amd_pmc_send_cmd(dev, 0, &dev->active_ips, SMU_MSG_GET_SUP_CONSTRAINTS, 1);
>> -
>> -	/* Get dram address */
>> -	if (!dev->smu_virt_addr) {
>> -		u32 phys_addr_low, phys_addr_hi;
>> -		u64 smu_phys_addr;
>> -
>> -		amd_pmc_send_cmd(dev, 0, &phys_addr_low, SMU_MSG_LOG_GETDRAM_ADDR_LO, 1);
>> -		amd_pmc_send_cmd(dev, 0, &phys_addr_hi, SMU_MSG_LOG_GETDRAM_ADDR_HI, 1);
>> -		smu_phys_addr = ((u64)phys_addr_hi << 32 | phys_addr_low);
>> -
>> -		dev->smu_virt_addr = devm_ioremap(dev->dev, smu_phys_addr,
>> -						  sizeof(struct smu_metrics));
>> -		if (!dev->smu_virt_addr)
>> -			return -ENOMEM;
>> -	}
>> -
>> -	/* Start the logging */
>> -	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_RESET, 0);
>> -	amd_pmc_send_cmd(dev, 0, NULL, SMU_MSG_LOG_START, 0);
>> -
>> -	return 0;
>> -}
>>   
>>   static void amd_pmc_dump_registers(struct amd_pmc_dev *dev)
>>   {
> .

