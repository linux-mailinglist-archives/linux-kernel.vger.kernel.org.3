Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521BF4B5032
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:33:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346211AbiBNMcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:32:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiBNMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:32:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B76274A3C5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 04:32:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6694C1396;
        Mon, 14 Feb 2022 04:32:27 -0800 (PST)
Received: from [10.57.70.89] (unknown [10.57.70.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 572EB3F718;
        Mon, 14 Feb 2022 04:32:26 -0800 (PST)
Message-ID: <c95e5d3a-d2b4-dcc1-b6ba-2e4e9ebc5bb0@arm.com>
Date:   Mon, 14 Feb 2022 12:32:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Check for error num after setting mask
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
References: <20220106024302.2574180-1-jiasheng@iscas.ac.cn>
 <YgpAfVVhkNljJhJY@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YgpAfVVhkNljJhJY@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-14 11:43, Joerg Roedel wrote:
> Adding more potential reviewers.
> 
> On Thu, Jan 06, 2022 at 10:43:02AM +0800, Jiasheng Jiang wrote:
>> Because of the possible failure of the dma_supported(), the
>> dma_set_mask_and_coherent() may return error num.
>> Therefore, it should be better to check it and return the error if
>> fails.

In this particular case it cannot fail on any system the driver actually 
runs on - it's a platform device so the dma_mask pointer is always 
initialised, then dma_direct_supported() on arm64 will always return 
true for any mask wider than 32 bits, while arm_dma_supported() will 
also always pass since a 32-bit system cannot have memory above 40 bits 
either.

There's no great harm in adding the check for the sake of consistency, I 
guess, but it's purely cosmetic and not fixing anything.

Thanks,
Robin.

>> Fixes: 1c894225bf5b ("iommu/ipmmu-vmsa: IPMMU device is 40-bit bus master")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>   drivers/iommu/ipmmu-vmsa.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
>> index aaa6a4d59057..7df5da44a004 100644
>> --- a/drivers/iommu/ipmmu-vmsa.c
>> +++ b/drivers/iommu/ipmmu-vmsa.c
>> @@ -1003,7 +1003,9 @@ static int ipmmu_probe(struct platform_device *pdev)
>>   	bitmap_zero(mmu->ctx, IPMMU_CTX_MAX);
>>   	mmu->features = of_device_get_match_data(&pdev->dev);
>>   	memset(mmu->utlb_ctx, IPMMU_CTX_INVALID, mmu->features->num_utlbs);
>> -	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(40));
>> +	if (ret)
>> +		return ret;
>>   
>>   	/* Map I/O memory and request IRQ. */
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -- 
>> 2.25.1
