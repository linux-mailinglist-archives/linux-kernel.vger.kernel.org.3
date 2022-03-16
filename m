Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248814DB874
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 20:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348804AbiCPTTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 15:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239247AbiCPTTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 15:19:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E535C1D0DB;
        Wed, 16 Mar 2022 12:18:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BB11476;
        Wed, 16 Mar 2022 12:18:03 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46CE03F7F5;
        Wed, 16 Mar 2022 12:18:02 -0700 (PDT)
Message-ID: <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com>
Date:   Wed, 16 Mar 2022 19:17:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "hch@lst.de" <hch@lst.de>
References: <b4356b228db9cb88d12db6559e28714ce26e022e.1647429348.git.robin.murphy@arm.com>
 <YjHb1xCx4UAmUjrR@lahna> <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com>
 <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
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

On 2022-03-16 18:34, Limonciello, Mario wrote:
> [Public]
> 
>>> Can the USB4 CM make the device links in the DVSEC case perhaps too?  I
>> would
>>> think we want that anyway to control device suspend ordering.
>>>
>>> If I had something discrete to try I'd dust off the DVSEC patch I wrote
>> before to
>>> try it, but alas all I have is integrated stuff on my hand.
>>>
>>>>>> Mika, you might not have seen it yet, but I sent a follow up diff in this
>>>> thread
>>>>>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy
>> to
>>>> do
>>>>>> so as well as I confirmed it helps my original intent too).
>>>>>
>>>>> I saw it now and I'm thinking are we making this unnecessary complex? I
>>>>> mean Microsoft solely depends on the DMAR platform opt-in flag:
>>>>>
>>>>>
>>>>
>>>
>>> I think Microsoft doesn't allow you to turn off the IOMMU though or put it
>> in
>>> passthrough through on the kernel command line.
>>>
>>>>> We also do turn on full IOMMU mappings in that case for devices that
>> are
>>>>> marked as external facing by the same firmware that provided the
>> DMAR
>>>>> bit. If the user decides to disable IOMMU from command line for
>> instance
>>>>> then we expect she knows what she is doing.
>>>>
>>>> Yeah, if external_facing is set correctly then we can safely expect the
>>>> the IOMMU layer to do the right thing, so in that case it probably is OK
>>>> to infer that if an IOMMU is present for the NHI then it'll be managing
>>>> that whole bus hierarchy. What I'm really thinking about here is whether
>>>> we can defend against a case when external_facing *isn't* set, so we
>>>> treat the tunnelled ports as normal PCI buses, assume it's OK since
>>>> we've got an IOMMU and everything else is getting translation domains
>> by
>>>> default, but then a Thunderbolt device shows up masquerading the
>> VID:DID
>>>> of something that gets a passthrough quirk, and thus tricks its way
>>>> through the perceived protection.
>>>>
>>>> Robin.
>>>
>>> Unless it happened after 5.17-rc8 looking at the code I think that's Intel
>>> specific behavior though at the moment (has_external_pci).  I don't see it
>>> in a generic layer.
>>
>> Ah, it's not necessarily the most obvious thing -
>> pci_dev->external_facing gets propagated through to pci_dev->untrusted
>> by set_pcie_untrusted(), and it's that that's then checked by
>> iommu_get_def_domain_type() to enforce a translation domain regardless
>> of default passthrough or quirks. It's then further checked by
>> iommu-dma's dev_is_untrusted() to enforce bounce-buffering to avoid data
>> leakage in sub-page mappings too.
>>
> 
> Ah thanks for explaining it, that was immediately obvious to me.
> 
>>> In addition to the point Robin said about firmware not setting external
>> facing
>>> if the IOMMU was disabled on command line then iommu_dma_protection
>>> would be showing the wrong values meaning userspace may choose to
>>> authorize the device automatically in a potentially unsafe scenario.
>>>
>>> Even if the user "knew what they were doing", I would expect that we still
>>> do our best to protect them from themselves and not advertise something
>>> that will cause automatic authorization.
>>
>> Might it be reasonable for the Thunderbolt core to check early on if any
>> tunnelled ports are not marked as external facing, and if so just tell
>> the user that iommu_dma_protection is off the table and anything they
>> authorise is at their own risk?
>>
>> Robin.
> 
> How about in iommu_dma_protection_show to just check that all the device
> links to the NHI are marked as untrusted?
> 
> Then if there are device links missing we solve that separately (discrete USB4
> DVSEC case we just need to make those device links).

The feeling I'm getting from all this is that if we've got as far as 
iommu_dma_protection_show() then it's really too late to meaningfully 
mitigate bad firmware. We should be able to detect missing 
untrusted/external-facing properties as early as nhi_probe(), and if we 
could go into "continue at your own risk" mode right then *before* 
anything else happens, it all becomes a lot easier to reason about. If 
there's a strong enough impetus from Microsoft for system vendors to get 
their firmware right, hopefully we can get away with not trying too hard 
to cope with systems that haven't.

I'm inclined to send v2 of this patch effectively going back to my 
original (even simpler) cleanup, just now with much more reasoning about 
why it isn't doing more :)

Cheers,
Robin.
