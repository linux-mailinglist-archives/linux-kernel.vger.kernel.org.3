Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6710B4DA213
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 19:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350981AbiCOSJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 14:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350970AbiCOSJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 14:09:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94A0F6373;
        Tue, 15 Mar 2022 11:07:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A3A41474;
        Tue, 15 Mar 2022 11:07:54 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B68B3F73D;
        Tue, 15 Mar 2022 11:07:52 -0700 (PDT)
Message-ID: <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
Date:   Tue, 15 Mar 2022 18:07:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Content-Language: en-GB
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Will Deacon <will@kernel.org>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
 <20220315162455.5190-2-mario.limonciello@amd.com>
 <YjDDUUeZ/dvUZoDN@infradead.org>
 <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BL1PR12MB5157D7B7734122684D47923AE2109@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On 2022-03-15 16:54, Limonciello, Mario via iommu wrote:
> [Public]
> 
> 
>> On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
>>> -	 * handled natively using IOMMU. It is enabled when IOMMU is
>>> -	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
>>> +	 * handled natively using IOMMU. It is enabled when the IOMMU is
>>> +	 * enabled and either:
>>> +	 * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
>>> +	 * or
>>> +	 * ACPI IVRS table has DMA_REMAP bitset
>>>   	 */
>>>   	return sprintf(buf, "%d\n",
>>> -		       iommu_present(&pci_bus_type) &&
>> dmar_platform_optin());
>>> +		       iommu_present(&pci_bus_type) &&
>>> +		       (dmar_platform_optin() || amd_ivrs_remap_support()));
>>
>> Yikes.  No, the thunderbot code does not have any business poking into
>> either dmar_platform_optin or amd_ivrs_remap_support.  This needs
>> a proper abstration from the IOMMU code.
> 
> To make sure I follow your ask - it's to make a new generic iommu function
> That would check dmar/ivrs, and switch out thunderbolt domain.c to use the
> symbol?
> 
> I'm happy to rework that if that is what you want.
> Do you have a preferred proposed function name for that?

But why? Either IOMMU translation is enabled or it isn't, and if it is, 
what's to gain from guessing at *why* it might have been? And even if 
the IOMMU's firmware table did tell the IOMMU driver to enable the 
IOMMU, why should that be Thunderbolt's business?

Furthermore, looking at patch #1 I can only conclude that this is 
entirely meaningless anyway. AFAICS it's literally reporting whether the 
firmware flag was set or not. Not whether it's actually been honoured 
and the IOMMU is enforcing any kind of DMA protection at all. Even on 
Intel where the flag does at least have some effect on the IOMMU driver, 
that can still be overridden.

I already have a patch refactoring this to get rid of iommu_present(), 
but at the time I wasn't looking to closely at what it's trying to *do* 
with the information. If it's supposed to accurately reflect whether the 
Thunderbolt device is subject to IOMMU translation and not bypassed, I 
can fix that too (and unexport dmar_platform_optin() in the process...)

Robin.
