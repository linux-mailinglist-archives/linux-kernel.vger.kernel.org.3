Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38ABE46D055
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhLHJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbhLHJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:53:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9142C061746;
        Wed,  8 Dec 2021 01:50:09 -0800 (PST)
Received: from [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3] (unknown [IPv6:2a00:c281:1230:3700:51d0:7039:5913:64d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 82E431F45AE2;
        Wed,  8 Dec 2021 09:50:07 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638957008; bh=zVGIFxck9x5IerNsAjYPgRm4rJR70g1v7ksESCraX18=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=V5hPMueCR58aL9EvrTkfycXGs2uCkQW0aCd1isf4imL37WS5U6egHSqJA/YN+UmA8
         0Fnrrw0TV/G6La/R95ym9R8T3DXYfRVd810lEnfl3D4xAS4fCc8kuG63dAuYQqog6s
         PCqlnD3dOJ9LTOp00QsxPPgmRwxPPV2mdH+gLzVoQ+MYMvsg4T2kRcrxJUjF2B9bEQ
         GkAHy8CT1Mga5F1Yd+Fm0PnB88P6QbQ1diA9Vqh7RCOhwZgv/FRoyxGBCeOwg3ueaz
         hkLYhmZkmclvIxJZy9xNycIr2gVinoFmR4dVN2+/6nyYo5kG21wVLSo5iQ56aJVCbM
         ilmnunYbGysGg==
Subject: Re: [PATCH 1/2] iommu/mediatek: Always tlb_flush_all when each PM
 resume
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     kernel@collabora.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com,
        iommu@lists.linux-foundation.org
References: <20211122104400.4160-1-dafna.hirschfeld@collabora.com>
 <20211122104400.4160-2-dafna.hirschfeld@collabora.com>
 <6abef78f6447c626b737fd35688f421c29871f43.camel@mediatek.com>
 <d30438bf-9add-7904-bad0-0764e3602263@collabora.com>
Message-ID: <35d53ea0-68db-a516-9e9c-272e8f0ed082@collabora.com>
Date:   Wed, 8 Dec 2021 11:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <d30438bf-9add-7904-bad0-0764e3602263@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07.12.21 10:31, Dafna Hirschfeld wrote:
> 
> 
> On 27.11.21 04:46, Yong Wu wrote:
>> Hi Dafna,
>>
>> Sorry for reply late.
>>
>> On Mon, 2021-11-22 at 12:43 +0200, Dafna Hirschfeld wrote:
>>> From: Yong Wu <yong.wu@mediatek.com>
>>>
>>> Prepare for 2 HWs that sharing pgtable in different power-domains.
>>>
>>> When there are 2 M4U HWs, it may has problem in the flush_range in
>>> which
>>> we get the pm_status via the m4u dev, BUT that function don't reflect
>>> the
>>> real power-domain status of the HW since there may be other HW also
>>> use
>>> that power-domain.
>>>
>>> The function dma_alloc_attrs help allocate the iommu buffer which
>>> need the corresponding power domain since tlb flush is needed when
>>> preparing iova. BUT this function only is for allocating buffer,
>>> we have no good reason to request the user always call pm_runtime_get
>>> before calling dma_alloc_xxx. Therefore, we add a tlb_flush_all
>>> in the pm_runtime_resume to make sure the tlb always is clean.
>>>
>>> Another solution is always call pm_runtime_get in the
>>> tlb_flush_range.
>>> This will trigger pm runtime resume/backup so often when the iommu
>>> power is not active at some time(means user don't call pm_runtime_get
>>> before calling dma_alloc_xxx), This may cause the performance drop.
>>> thus we don't use this.
>>>
>>> In other case, the iommu's power should always be active via device
>>> link with smi.
>>>
>>> The previous SoC don't have PM except mt8192. the mt8192 IOMMU is
>>> display's
>>> power-domain which nearly always is enabled. thus no need fix tags
>>> here.
>>> Prepare for mt8195.
>>
>> In this patchset, this message should be not proper. I think you could
>> add the comment why this patch is needed in mt8173.
>>
>>>
>>> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
>>> [imporvie inline doc]
>>> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
>>> ---
>>>   drivers/iommu/mtk_iommu.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
>>> index 25b834104790..28dc4b95b6d9 100644
>>> --- a/drivers/iommu/mtk_iommu.c
>>> +++ b/drivers/iommu/mtk_iommu.c
>>> @@ -964,6 +964,13 @@ static int __maybe_unused
>>> mtk_iommu_runtime_resume(struct device *dev)
>>>           return ret;
>>>       }
>>> +    /*
>>> +     * Users may allocate dma buffer before they call
>>> pm_runtime_get,
>>> +     * in which case it will lack the necessary tlb flush.
>>> +     * Thus, make sure to update the tlb after each PM resume.
>>> +     */
>>> +    mtk_iommu_tlb_flush_all(data);
>>
>> This should not work. since current the *_tlb_flush_all call
>> pm_runtime_get_if_in_use which will always return 0 when it called from
>> this runtime_cb in my test. thus, It won't do the tlb_flush_all
>> actually.

He, indeed, my mistake, although the encoder works more or less fine even
without the full flush so I didn't catch that.

>>
>> I guess this also depend on these two patches of mt8195 v3.
>> [PATCH v3 09/33] iommu/mediatek: Remove for_each_m4u in tlb_sync_all
>> [PATCH v3 10/33] iommu/mediatek: Add tlb_lock in tlb_flush_all

I'll add those two

>>
>> like in [10/33], I added a mtk_iommu_tlb_do_flush_all which don't have
>> the pm operation.

yes, I need to remove the pm_runtime_get_if_in_use call in the 'flush_all' func
I see there is also a patch for that in the mt8195 v3 series "[PATCH v3 13/33] iommu/mediatek: Remove the power status checking in tlb flush all"

So I'll send v2, adding all those 3 patches, but I think adding mtk_iommu_tlb_do_flush_all
on patch 9 and removing it again on patch 13 is confusing so I'll avoid that.

Thanks,
Dafna



>>
>> This looks has a dependence. Let me know if I can help this.
> 
> It did work for me, testing on elm device. I'll check that again.
> 
> 
>>
>>> +
>>>       /*
>>>        * Uppon first resume, only enable the clk and return, since
>>> the values of the
>>>        * registers are not yet set.
> 
