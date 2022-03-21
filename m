Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F354E2510
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:12:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346702AbiCULNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345241AbiCULNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:13:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BA39393E7;
        Mon, 21 Mar 2022 04:11:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF93C1042;
        Mon, 21 Mar 2022 04:11:48 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0783F766;
        Mon, 21 Mar 2022 04:11:46 -0700 (PDT)
Message-ID: <fd86c2cf-3068-1bea-2a6f-46cabb019062@arm.com>
Date:   Mon, 21 Mar 2022 11:11:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 2/2] thunderbolt: Make iommu_dma_protection more
 accurate
Content-Language: en-GB
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>
References: <cover.1647624084.git.robin.murphy@arm.com>
 <0dd14883930c9f55ace22162e23765a37d91a057.1647624084.git.robin.murphy@arm.com>
 <DM4PR12MB51683722CF9A553563D0C721E2139@DM4PR12MB5168.namprd12.prod.outlook.com>
 <YjhaViFzmEjBgmmu@lahna>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjhaViFzmEjBgmmu@lahna>
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

On 2022-03-21 10:58, mika.westerberg@linux.intel.com wrote:
> Hi Mario,
> 
> On Fri, Mar 18, 2022 at 10:29:59PM +0000, Limonciello, Mario wrote:
>> [Public]
>>
>>> Between me trying to get rid of iommu_present() and Mario wanting to
>>> support the AMD equivalent of DMAR_PLATFORM_OPT_IN, scrutiny has
>>> shown
>>> that the iommu_dma_protection attribute is being far too optimistic.
>>> Even if an IOMMU might be present for some PCI segment in the system,
>>> that doesn't necessarily mean it provides translation for the device(s)
>>> we care about. Furthermore, all that DMAR_PLATFORM_OPT_IN really does
>>> is tell us that memory was protected before the kernel was loaded, and
>>> prevent the user from disabling the intel-iommu driver entirely. While
>>> that lets us assume kernel integrity, what matters for actual runtime
>>> DMA protection is whether we trust individual devices, based on the
>>> "external facing" property that we expect firmware to describe for
>>> Thunderbolt ports.
>>>
>>> It's proven challenging to determine the appropriate ports accurately
>>> given the variety of possible topologies, so while still not getting a
>>> perfect answer, by putting enough faith in firmware we can at least get
>>> a good bit closer. If we can see that any device near a Thunderbolt NHI
>>> has all the requisites for Kernel DMA Protection, chances are that it
>>> *is* a relevant port, but moreover that implies that firmware is playing
>>> the game overall, so we'll use that to assume that all Thunderbolt ports
>>> should be correctly marked and thus will end up fully protected.
>>>
>>
>> This approach looks generally good to me.  I do worry a little bit about older
>> systems that didn't set ExternalFacingPort in the FW but were previously setting
>> iommu_dma_protection, but I think that those could be treated on a quirk
>> basis to set PCI IDs for those root ports as external facing if/when they come
>> up.
> 
> There are no such systems out there AFAICT.

And even if there are, as above they've never actually been fully 
protected and still won't be, so it's arguably a good thing for them to 
stop thinking so.

>> I'll send up a follow up patch that adds the AMD ACPI table check.
>> If it looks good can roll it into your series for v3, or if this series goes
>> as is for v2 it can come on its own.
>>
>>> CC: Mario Limonciello <mario.limonciello@amd.com>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> v2: Give up trying to look for specific devices, just look for evidence
>>>      that firmware cares at all.
>>
>> I still do think you could know exactly which devices to use if you're in
>> SW CM mode, but I guess the consensus is to not bifurcate the way this
>> can be checked.
> 
> Indeed.
> 
> The patch looks good to me now. I will give it a try on a couple of
> systems later today or tomorrow and let you guys know how it went. I
> don't expect any problems but let's see.
> 
> Thanks a lot Robin for working on this :)

Heh, let's just hope the other half-dozen or so subsystems I need to 
touch for this IOMMU cleanup aren't all quite as involved as this turned 
out to be :)

Cheers,
Robin.
