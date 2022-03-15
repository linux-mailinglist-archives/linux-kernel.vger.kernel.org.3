Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6E94DA4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 23:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352087AbiCOWFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 18:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbiCOWFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 18:05:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D3B236334;
        Tue, 15 Mar 2022 15:04:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAAB51474;
        Tue, 15 Mar 2022 15:04:27 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F51D3F66F;
        Tue, 15 Mar 2022 15:04:26 -0700 (PDT)
Message-ID: <ffc67380-afc7-559e-c0f0-a5d446725f75@arm.com>
Date:   Tue, 15 Mar 2022 22:04:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Content-Language: en-GB
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Christoph Hellwig <hch@infradead.org>, christian@kellner.me,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Michael Jamet <michael.jamet@intel.com>,
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
 <21d33a75-8c0e-7734-b3d1-dbe33cfe0ab0@arm.com>
 <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <7d588dfa-aa57-7be1-9cbb-61897f81bf99@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-15 18:36, Limonciello, Mario wrote:
> + Christian Kellner (Bolt userspace maintainer)
> 
> On 3/15/2022 13:07, Robin Murphy wrote:
>> On 2022-03-15 16:54, Limonciello, Mario via iommu wrote:
>>> [Public]
>>>
>>>
>>>> On Tue, Mar 15, 2022 at 11:24:55AM -0500, Mario Limonciello wrote:
>>>>> -     * handled natively using IOMMU. It is enabled when IOMMU is
>>>>> -     * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
>>>>> +     * handled natively using IOMMU. It is enabled when the IOMMU is
>>>>> +     * enabled and either:
>>>>> +     * ACPI DMAR table has DMAR_PLATFORM_OPT_IN set
>>>>> +     * or
>>>>> +     * ACPI IVRS table has DMA_REMAP bitset
>>>>>        */
>>>>>       return sprintf(buf, "%d\n",
>>>>> -               iommu_present(&pci_bus_type) &&
>>>> dmar_platform_optin());
>>>>> +               iommu_present(&pci_bus_type) &&
>>>>> +               (dmar_platform_optin() || amd_ivrs_remap_support()));
>>>>
>>>> Yikes.  No, the thunderbot code does not have any business poking into
>>>> either dmar_platform_optin or amd_ivrs_remap_support.  This needs
>>>> a proper abstration from the IOMMU code.
>>>
>>> To make sure I follow your ask - it's to make a new generic iommu 
>>> function
>>> That would check dmar/ivrs, and switch out thunderbolt domain.c to 
>>> use the
>>> symbol?
>>>
>>> I'm happy to rework that if that is what you want.
>>> Do you have a preferred proposed function name for that?
>>
>> But why? Either IOMMU translation is enabled or it isn't, and if it 
>> is, what's to gain from guessing at *why* it might have been? And even 
>> if the IOMMU's firmware table did tell the IOMMU driver to enable the 
>> IOMMU, why should that be Thunderbolt's business?
> A lot of this comes from baggage from early Thunderbolt 3 implementation 
> on systems with ICM (Intel's FW CM). On those systems there was a 
> concept of "Security Levels".  This meant that downstream PCIe devices 
> were not automatically authorized when a TBT3 device was plugged in.  In 
> those cases there was no guarantee that the IOMMU was in use and so the 
> security was passed on to the user to make a decision.
> 
> In Linux this was accomplished using the 'authorized' attribute in 
> /sys/bus/thunderbolt/devices/$NUM/authorized.  When this was set to 1 
> then the TBT3 device and PCIe topology behind it would be enumerated.
> 
> Further documentation explaining how this works is available here:
> https://www.kernel.org/doc/html/latest/admin-guide/thunderbolt.html#security-levels-and-how-to-use-them 
> 
> 
> (Intel based) Platforms from 2018+ w/ TBT3 started to use the IOMMU 
> consistently at runtime but had this existing implementation of security 
> levels to worry about.  Furthermore tunnels could be created pre-boot, 
> and so the thunderbolt driver may or may not re-create them based on 
> policy.
> 
> So a new attribute was created "iommu_dma_protection" that userspace 
> could use as part of a policy decision to automatically authorize 
> devices.  Exporting this attribute is very similar to what Microsoft 
> does to let the user see the security of the system.
> 
> https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection 
> 
> 
> In Linux today some userspace software "bolt" has a policy included by
> default that will automatically authorize TBT3 and USB4 (w/ PCIe) 
> devices when iommu_dma_protection is set to 1.
> 
>>
>> Furthermore, looking at patch #1 I can only conclude that this is 
>> entirely meaningless anyway. AFAICS it's literally reporting whether 
>> the firmware flag was set or not. Not whether it's actually been 
>> honoured and the IOMMU is enforcing any kind of DMA protection at all. 
>> Even on Intel where the flag does at least have some effect on the 
>> IOMMU driver, that can still be overridden.
> 
> Take a look at the Microsoft link I shared above.  They also make policy
> decisions based on the information in these tables.
> 
>>
>> I already have a patch refactoring this to get rid of iommu_present(), 
>> but at the time I wasn't looking to closely at what it's trying to 
>> *do* with the information. If it's supposed to accurately reflect 
>> whether the Thunderbolt device is subject to IOMMU translation and not 
>> bypassed, I can fix that too (and unexport dmar_platform_optin() in 
>> the process...)
>>
>> Robin.
> 
> This patch series stems from that history.  To give the best experience 
> to end users you want hotplugged devices to be automatically authorized 
> when software says it's safe to do so.
> 
> To summarize the flow:
> * User plugs in device
> * USB4 CM will query supported tunnels
> * USB4 CM will create devices in /sys/bus/thunderbolt/devices for new 
> plugged in TBT3/USB4 device
> * "authorized" attribute will default to "0" and PCIe tunnels are not 
> created
> * Userspace gets a uevent that the device was added
> * Userspace (bolt) reacts by reading 
> /sys/bus/thunderbolt/devices/domainX/iommu_dma_protection
> * If that is set to "1", bolt will write "1" to "authorized"  and USB4 
> CM will create PCIe tunnels
> * If that is set to "0", bolt will send an event to GUI to show a popup 
> asking to authorize the device
> * After user acks the authorization then it will write "1" to 
> "authorized" and USB4 CM will create PCIe tunnels
> 
> 
> Mika,
> 
> I wonder if maybe what we really want is to only use that flow for the 
> authorized attribute when using TBT3 + ICM (or IOMMU disabled at 
> runtime).  If we're using a USB4 host, check IOMMU translation layer 
> active like Robin suggested and then automatically authorize from the CM.

Thanks for the explanation. I don't think there's anything wrong with 
that flow per se - fundamentally, whether it's relayed through userspace 
or done automagically inside the kernel doesn't change the end result - 
but it does seem to confirm my suspicion that even now it's not actually 
working as intended and may end up letting devices be authorised in 
circumstances that they probably shouldn't be.

It's absolutely fine for Thunderbolt to care about whether a device 
currently has IOMMU translation enabled (and to expose that to userspace 
in its own way if it wants to), but that's generic IOMMU API stuff, no 
firmware-poking required :)

Tomorrow I'll rework the patch out of my iommu_present() cleanup stack 
to do the right thing, and share it.

Cheers,
Robin.
