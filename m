Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581884DB794
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357625AbiCPRuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbiCPRum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:50:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD3F86AA6E;
        Wed, 16 Mar 2022 10:49:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 687391476;
        Wed, 16 Mar 2022 10:49:27 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1AE3F66F;
        Wed, 16 Mar 2022 10:49:25 -0700 (PDT)
Message-ID: <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
Date:   Wed, 16 Mar 2022 17:49:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
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
 <YjIgQfmcw6fydkXd@lahna>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjIgQfmcw6fydkXd@lahna>
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

On 2022-03-16 17:37, Mika Westerberg wrote:
> Hi Mario,
> 
> On Wed, Mar 16, 2022 at 05:24:38PM +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>> On Wed, Mar 16, 2022 at 02:49:09PM +0000, Robin Murphy wrote:
>>>>> What we want is to make sure the Tunneled PCIe ports get the full
>>> IOMMU
>>>>> protection. In case of the discrete above it is also fine if all the
>>>>> devices behind the PCIe root port get the full IOMMU protection. Note in
>>>>> the integrated all the devices are "siblings".
>>>>
>>>> Ah, OK, I wasn't aware that the NHI isn't even the right thing in the first
>>>> place :(
>>>>
>>>> Is there an easy way to get from the struct tb to a PCI device representing
>>>> the end of its relevant tunnel, or do we have a circular dependency
>>> problem
>>>> where the latter won't appear until we've authorised it (and thus the
>>> IOMMU
>>>> layer won't know about it yet either)?
>>>
>>> The PCIe root ports (and the PCIe downstream ports) are there already
>>> even without "authorization".
>>>
>>> There is a way to figure out the "tunneled" PCIe ports by looking at
>>> certain properties and we do that already actually. The BIOS has the
>>> following under these ports:
>>>
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs
>>> .microsoft.com%2Fen-us%2Fwindows-hardware%2Fdrivers%2Fpci%2Fdsd-
>>> for-pcie-root-ports%23identifying-externally-exposed-pcie-root-
>>> ports&amp;data=04%7C01%7Cmario.limonciello%40amd.com%7C0465d319a
>>> 6684335d9c208da07710e7c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
>>> C0%7C637830479402895833%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
>>> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am
>>> p;sdata=z6hpYGpj%2B%2BVvz9d6MXiO4N66PUm4zwhOdI%2Br6l3PjhQ%3D
>>> &amp;reserved=0
>>>
>>> and the ports will have dev->external_facing set to 1. Perhaps looking
>>> at that field helps here?
>>
>> External facing isn't a guarantee from the firmware though.  It's something we
>> all expect in practice, but I think it's better to look at the ones that are from
>> the _DSD usb4-host-interface to be safer.
> 
> Right but then we have the discrete ones with the DVSEC that exposes the
> tunneled ports :(
> 
>> Mika, you might not have seen it yet, but I sent a follow up diff in this thread
>> to Robin's patch.  If that looks good Robin can submit a v2 (or I'm happy to do
>> so as well as I confirmed it helps my original intent too).
> 
> I saw it now and I'm thinking are we making this unnecessary complex? I
> mean Microsoft solely depends on the DMAR platform opt-in flag:
> 
>    https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt
> 
> We also do turn on full IOMMU mappings in that case for devices that are
> marked as external facing by the same firmware that provided the DMAR
> bit. If the user decides to disable IOMMU from command line for instance
> then we expect she knows what she is doing.

Yeah, if external_facing is set correctly then we can safely expect the 
the IOMMU layer to do the right thing, so in that case it probably is OK 
to infer that if an IOMMU is present for the NHI then it'll be managing 
that whole bus hierarchy. What I'm really thinking about here is whether 
we can defend against a case when external_facing *isn't* set, so we 
treat the tunnelled ports as normal PCI buses, assume it's OK since 
we've got an IOMMU and everything else is getting translation domains by 
default, but then a Thunderbolt device shows up masquerading the VID:DID 
of something that gets a passthrough quirk, and thus tricks its way 
through the perceived protection.

Robin.
