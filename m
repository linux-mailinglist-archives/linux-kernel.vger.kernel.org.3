Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C9F5703B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiGKNAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGKM77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:59:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4F30AD70;
        Mon, 11 Jul 2022 05:59:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75B5F1576;
        Mon, 11 Jul 2022 05:59:36 -0700 (PDT)
Received: from [10.57.85.194] (unknown [10.57.85.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 049213F70D;
        Mon, 11 Jul 2022 05:59:33 -0700 (PDT)
Message-ID: <638d1d19-dc8a-c5f0-4c91-8ed95de8fe27@arm.com>
Date:   Mon, 11 Jul 2022 13:59:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] iommu/exynos: Set correct dma mask for SysMMU v5+
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sam Protsenko <semen.protsenko@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Janghyuck Kim <janghyuck.kim@samsung.com>,
        Cho KyongHo <pullip.cho@samsung.com>,
        Daniel Mentz <danielmentz@google.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220702213724.3949-1-semen.protsenko@linaro.org>
 <20220702213724.3949-2-semen.protsenko@linaro.org>
 <9afb1e98-706f-ed61-892c-e3cc321364b4@linaro.org>
 <CAPLW+4kfrHOb8utzynhB=2KLDQu-NC08UYpAVjpg__NQSeSQyg@mail.gmail.com>
 <c2c3c37e-0f63-9b89-ed49-78193c46d7bd@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <c2c3c37e-0f63-9b89-ed49-78193c46d7bd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-11 13:27, Krzysztof Kozlowski wrote:
> On 08/07/2022 15:18, Sam Protsenko wrote:
>> On Sun, 3 Jul 2022 at 21:50, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 02/07/2022 23:37, Sam Protsenko wrote:
>>>> SysMMU v5+ supports 36 bit physical address space. Set corresponding DMA
>>>> mask to avoid falling back to SWTLBIO usage in dma_map_single() because
>>>> of failed dma_capable() check.
>>>>
>>>> The original code for this fix was suggested by Marek.
>>>>
>>>> Originally-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>>
>>> This is some tip specific tag, I don't think checkpatch allows it.
>>> Either use suggesgted-by or co-developed-by + SoB.
>>>
>>
>> Yes, checkpatch is swearing at that line, though I encountered that
>> tag mentioning somewhere in Documentation. Will rework it in v2.
> 
> Yes, in tip. It did not go outside of tip.
> 
>>
>>>> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
>>>> ---
>>>>   drivers/iommu/exynos-iommu.c | 8 ++++++++
>>>>   1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>>>> index 71f2018e23fe..28f8c8d93aa3 100644
>>>> --- a/drivers/iommu/exynos-iommu.c
>>>> +++ b/drivers/iommu/exynos-iommu.c
>>>> @@ -647,6 +647,14 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
>>>>                }
>>>>        }
>>>>
>>>> +     if (MMU_MAJ_VER(data->version) >= 5) {
>>>> +             ret = dma_set_mask(dev, DMA_BIT_MASK(36));
>>>> +             if (ret) {
>>>> +                     dev_err(dev, "Unable to set DMA mask: %d\n", ret);
>>>
>>> Missing cleanup: iommu_device_unregister
>>> and probably also: iommu_device_sysfs_remove
>>>
>>
>> Right. Also the correct cleanup should be added for failing
>> iommu_device_register() case, above of the quoted code. Will do that
>> in v2, thanks.
>>
>> Another thing is that "remove" method is missing. But guess I'll get
>> to it later, when adding modularization support for this driver.
> 
> remove is independent of modules, so it should be here already.

.suppress_bind_attrs is set in the driver, so a .remove method on its 
own would be dead code, since there's no way for it to be called. We can 
permit module unloading since the module itself can be reference counted 
(which in practice usually means that unloading will be denied). However 
that's not the case for driver binding itself, so it's better not to 
even pretend that removing an IOMMU's driver while other drivers are 
using it (usually via DMA ops without even realising) is going to have 
anything other than catastrophic results.

Thanks,
Robin.
