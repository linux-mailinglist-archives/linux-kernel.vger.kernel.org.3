Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F1F588C72
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiHCMyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiHCMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:54:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3421932D94
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:54:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8EDB811FB;
        Wed,  3 Aug 2022 05:54:09 -0700 (PDT)
Received: from [10.57.12.36] (unknown [10.57.12.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED83C3F70D;
        Wed,  3 Aug 2022 05:54:06 -0700 (PDT)
Message-ID: <d14dd7d2-e144-6d1b-7450-a68330c8cbb6@arm.com>
Date:   Wed, 3 Aug 2022 13:54:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] iommu/arm-smmu-v3: fixed check process for disable_bypass
 module parameter
Content-Language: en-GB
To:     "ishii.shuuichir@fujitsu.com" <ishii.shuuichir@fujitsu.com>,
        "will@kernel.org" <will@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "thunder.leizhen@huawei.com" <thunder.leizhen@huawei.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chenxiang66@hisilicon.com" <chenxiang66@hisilicon.com>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220802234207.1994093-1-ishii.shuuichir@fujitsu.com>
 <5bce32f7-c3c2-7750-2c48-1d54eb645607@arm.com>
 <TYCPR01MB6160FF56DA7F9DEB2841C656E99C9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <TYCPR01MB6160FF56DA7F9DEB2841C656E99C9@TYCPR01MB6160.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-03 13:45, ishii.shuuichir@fujitsu.com wrote:
> Hi, Robin,
> Thank you for your comments.
> 
>>>    	/* Enable the SMMU interface, or ensure bypass */
>>> -	if (!bypass || disable_bypass) {
>>> +	if (!bypass && disable_bypass) {
>>
>> This change looks obviously wrong - if bypass is false here then we definitely
>> want to enable the SMMU, so disable_bypass is irrelevant. It shouldn't even be
>> possible to get here with bypass==true under ACPI, since
>> arm_smmu_device_acpi_probe() cannot fail :/
> 
> Sorry, my understanding of the meaning of the disable_bypass module parameter
> and the process of setting GBPA_ABORT was insufficient.
> 
> I misunderstood that the disable_bypass module parameter is used to simply
> bypass (disable) SMMU (SMMU_CR0.SMMUEN == 0 and SMMU_GBPA.ABORT == 0).
> Forget about the fixes in this patch.
> 
> Although our understanding was lacking,
> we thought it would be a good idea to have a module parameter that simply disables SMMU,
> so we were considering a fix.

Right, disable_bypass is a security/robustness feature for when the 
driver *is* in use. If for some reason you want to disable the SMMU 
drivers completely, they are regular driver model drivers, so just don't 
load the module in the first place (or use initcall_blacklist if it's 
built-in).

Thanks,
Robin.

> 
> Best regards,
> Shuuichirou.
> 
>> -----Original Message-----
>> From: Robin Murphy <robin.murphy@arm.com>
>> Sent: Wednesday, August 3, 2022 6:26 PM
>> To: Ishii, Shuuichirou/石井 周一郎 <ishii.shuuichir@fujitsu.com>;
>> will@kernel.org; joro@8bytes.org; thunder.leizhen@huawei.com; jgg@ziepe.ca;
>> tglx@linutronix.de; chenxiang66@hisilicon.com; christophe.jaillet@wanadoo.fr;
>> john.garry@huawei.com; baolu.lu@linux.intel.com;
>> linux-arm-kernel@lists.infradead.org; iommu@lists.linux.dev;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] iommu/arm-smmu-v3: fixed check process for
>> disable_bypass module parameter
>>
>> On 2022-08-03 00:42, Shuuichirou Ishii wrote:
>>> The current process does not enable the bypass setting regardless of
>>> the value of the disable_bypass module parameter when ACPI is enabled,
>>> so the value of the disable_bypass module parameter has been corrected
>>> so that it is handled correctly.
>>>
>>> Signed-off-by: Shuuichirou Ishii <ishii.shuuichir@fujitsu.com>
>>> ---
>>>    drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> index 88817a3376ef..256d7b2a83a7 100644
>>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
>>> @@ -3396,7 +3396,7 @@ static int arm_smmu_device_reset(struct
>> arm_smmu_device *smmu, bool bypass)
>>>    		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);
>>>
>>>    	/* Enable the SMMU interface, or ensure bypass */
>>> -	if (!bypass || disable_bypass) {
>>> +	if (!bypass && disable_bypass) {
>>
>> This change looks obviously wrong - if bypass is false here then we definitely
>> want to enable the SMMU, so disable_bypass is irrelevant. It shouldn't even be
>> possible to get here with bypass==true under ACPI, since
>> arm_smmu_device_acpi_probe() cannot fail :/
>> Robin.
>>
>>>    		enables |= CR0_SMMUEN;
>>>    	} else {
>>>    		ret = arm_smmu_update_gbpa(smmu, 0, GBPA_ABORT);
