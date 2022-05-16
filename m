Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52E52830C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiEPLUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiEPLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:20:36 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F2534BBE;
        Mon, 16 May 2022 04:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LUKhFyWGsJws4jt1m41drcAy5kgxr8adnAp720eLM7Y=; b=KlbgSdflonmdW6hPspTw/oFJYR
        yLr4OzBTS5jTqa88i7yjnmsG6GpnO3VrGHQvwpaLGB2sica6hBO1nPPepUxvCjDJ/qMSWv2bqHO+b
        ZmAAhzszkvaGdABMHDNLbFKBA/0X2cZLpA26IbwG1J+/WKn3BSeYHWPzAy1E2IXsArxpSxY1jKaNf
        G7qksyN1vqqi7dVGF3f0eawRTnGOVi0UUGB2fOyVmQ+Pmj57atz5AZx29cjIHEp8OKaSWq9LTUTaz
        ANu8h4V4ZNvvD3woDjGX8sWZqSmMJ69f3GKZYxGyFvG3KOEc3VaTNtMLpx3ov/1arKmls2ipz2Eax
        IJtGDvbg==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=[192.168.1.10])
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqYlv-0001Dw-4J; Mon, 16 May 2022 14:20:19 +0300
Message-ID: <020a8244-760e-fe7c-594a-1d85e5645dbe@kapsi.fi>
Date:   Mon, 16 May 2022 14:20:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v5 5/9] iommu/arm-smmu: Attach to host1x context device
 bus
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
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
 <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
In-Reply-To: <099cf0f9-5c27-0247-7c5e-6704a9527b11@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 13:44, Robin Murphy wrote:
> On 2022-05-16 11:13, Mikko Perttunen wrote:
>> On 5/16/22 13:07, Will Deacon wrote:
>>> On Mon, May 16, 2022 at 11:52:54AM +0300, cyndis@kapsi.fi wrote:
>>>> From: Mikko Perttunen <mperttunen@nvidia.com>
>>>>
>>>> Set itself as the IOMMU for the host1x context device bus, containing
>>>> "dummy" devices used for Host1x context isolation.
>>>>
>>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>>> ---
>>>>   drivers/iommu/arm/arm-smmu/arm-smmu.c | 13 +++++++++++++
>>>>   1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c 
>>>> b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> index 568cce590ccc..9ff54eaecf81 100644
>>>> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
>>>> @@ -39,6 +39,7 @@
>>>>   #include <linux/amba/bus.h>
>>>>   #include <linux/fsl/mc.h>
>>>> +#include <linux/host1x_context_bus.h>
>>>>   #include "arm-smmu.h"
>>>> @@ -2053,8 +2054,20 @@ static int arm_smmu_bus_init(struct iommu_ops 
>>>> *ops)
>>>>               goto err_reset_pci_ops;
>>>>       }
>>>>   #endif
>>>> +#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
>>>> +    if (!iommu_present(&host1x_context_device_bus_type)) {
>>>> +        err = bus_set_iommu(&host1x_context_device_bus_type, ops);
>>>> +        if (err)
>>>> +            goto err_reset_fsl_mc_ops;
>>>> +    }
>>>> +#endif
>>>> +
>>>>       return 0;
>>>> +err_reset_fsl_mc_ops: __maybe_unused;
>>>> +#ifdef CONFIG_FSL_MC_BUS
>>>> +    bus_set_iommu(&fsl_mc_bus_type, NULL);
>>>> +#endif
>>>
>>> bus_set_iommu() is going away:
>>>
>>> https://lore.kernel.org/r/cover.1650890638.git.robin.murphy@arm.com
>>>
>>> Will
>>
>> Thanks for the heads-up. Robin had pointed out that this work was 
>> ongoing but I hadn't seen the patches yet. I'll look into it.
> 
> Although that *is* currently blocked on the mystery intel-iommu problem 
> that I can't reproduce... If this series is ready to land right now for 
> 5.19 then in principle that might be the easiest option overall. 
> Hopefully at least patch #2 could sneak in so that the compile-time 
> dependencies are ready for me to roll up host1x into the next rebase of 
> "iommu: Always register bus notifiers".
> 
> Cheers,
> Robin.

My guess is that the series as a whole is not ready to land in the 5.19 
timeframe, but #2 could be possible.

Thierry, any opinion?

Thanks,
Mikko
