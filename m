Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C0528279
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiEPKpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 06:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239787AbiEPKow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 06:44:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3849C24947;
        Mon, 16 May 2022 03:44:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC6CC1063;
        Mon, 16 May 2022 03:44:48 -0700 (PDT)
Received: from [10.57.82.175] (unknown [10.57.82.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849D83F66F;
        Mon, 16 May 2022 03:44:46 -0700 (PDT)
Message-ID: <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
Date:   Mon, 16 May 2022 11:44:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device
 bus
Content-Language: en-GB
To:     Mikko Perttunen <cyndis@kapsi.fi>, Will Deacon <will@kernel.org>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-6-cyndis@kapsi.fi>
 <20220516100721.GA1927@willie-the-truck>
 <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <4a170997-c893-1788-dcaa-8ed2193146ae@kapsi.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-16 11:13, Mikko Perttunen wrote:
> On 5/16/22 13:07, Will Deacon wrote:
>> On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>
>>> Set itself as the IOMMU for the host1x context device bus, containing
>>> "dummy" devices used for Host1x context isolation.
>>>
>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>> ---
>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> index 568cce590ccc..9ff54eaecf81 100644
>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>> @@ -39,6 +39,7 @@
>>>   #include <linux/amba/bus.h>
>>>   #include <linux/fsl/mc.h>
>>> +#include <linux/host1x_context_bus.h>
>>>   #include "arm-smmu.h"
>>> @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct iommu_ops 
>>> *ops)
>>>               goto err_reset_pci_ops;
>>>       }
>>>   #endif
>>> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>>> +    if (!iommu_present(&host1x_context_device_bus_type)) {
>>> +        err = bus_set_iommu(&host1x_context_device_bus_type, ops);
>>> +        if (err)
>>> +            goto err_reset_fsl_mc_ops;
>>> +    }
>>> +#endif
>>> +
>>>       return 0;
>>> +err_reset_fsl_mc_ops: __maybe_unused;
>>> +#ifdef CONFIG_FSL_MC_BUS
>>> +    bus_set_iommu(&fsl_mc_bus_type, NULL);
>>> +#endif
>>
>> bus_set_iommu() is going away:
>>
>> https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com
>>
>> Will
> 
> Thanks for the heads-up. Robin had pointed out that this work was 
> ongoing but I hadn't seen the patches yet. I'll look into it.

Although that *is* currently blocked on the mystery intel-iommu problem 
that I can't reproduce... If this series is ready to land right now for 
5.19 then in principle that might be the easiest option overall. 
Hopefully at least patch #2 could sneak in so that the compile-time 
dependencies are ready for me to roll up host1x into the next rebase of 
"iommu: Always register bus notifiers".

Cheers,
Robin.
