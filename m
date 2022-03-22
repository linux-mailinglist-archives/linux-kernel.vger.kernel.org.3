Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91B04E3BF5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbiCVJzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiCVJzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:55:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94267387;
        Tue, 22 Mar 2022 02:53:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 531B3106F;
        Tue, 22 Mar 2022 02:53:35 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B62283F66F;
        Tue, 22 Mar 2022 02:53:33 -0700 (PDT)
Message-ID: <3e715fb9-7a0d-046a-c32c-bc6afbecf55e@arm.com>
Date:   Tue, 22 Mar 2022 09:53:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] iommu: Add capability for pre-boot DMA protection
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>
Cc:     michael.jamet@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, YehezkelShB@gmail.com,
        iommu@lists.linux-foundation.org, mario.limonciello@amd.com,
        andreas.noever@gmail.com, mika.westerberg@linux.intel.com
References: <cover.1647624084.git.robin.murphy@arm.com>
 <797c70d255f946c4d631f2ffc67f277cfe0cb97c.1647624084.git.robin.murphy@arm.com>
 <20220322091432.GA27069@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220322091432.GA27069@lst.de>
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

On 2022-03-22 09:14, Christoph Hellwig wrote:
> On Fri, Mar 18, 2022 at 05:42:57PM +0000, Robin Murphy wrote:
>> VT-d's dmar_platform_optin() actually represents a combination of
>> properties fairly well standardised by Microsoft as "Pre-boot DMA
>> Protection" and "Kernel DMA Protection"[1]. As such, we can provide
>> interested consumers with an abstracted capability rather than
>> driver-specific interfaces that won't scale. We name it for the former
>> aspect since that's what external callers are most likely to be
>> interested in; the latter is for the IOMMU layer to handle itself.
>>
>> Also use this as an opportunity to draw a line in the sand and add a
>> new interface so as not to introduce any more callers of iommu_capable()
>> which I also want to get rid of. For now it's a quick'n'dirty wrapper
>> function, but will evolve to subsume the internal interface in future.
>>
>> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
>>
>> Suggested-by: Christoph Hellwig <hch@lst.de>
>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> I can't really think of a way in which I suggested this, but it does
> looks like a good interface:

Well, you were the first to say it should be abstracted[1], and since my 
initial thought that it could be hidden completely didn't pan out, I 
felt I should give you credit for being right all along :)

> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks!

Robin.

[1] https://lore.kernel.org/linux-iommu/YjDDUUeZ%2FdvUZoDN@infradead.org/
