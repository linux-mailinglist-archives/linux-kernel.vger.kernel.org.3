Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6A4DC7C6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbiCQNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 09:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiCQNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 09:44:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 85F5C1263C;
        Thu, 17 Mar 2022 06:43:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44A181576;
        Thu, 17 Mar 2022 06:43:06 -0700 (PDT)
Received: from [10.57.42.204] (unknown [10.57.42.204])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6DA83F766;
        Thu, 17 Mar 2022 06:43:04 -0700 (PDT)
Message-ID: <23f232a1-f511-d2fe-b1f8-5fd32b3a1a8f@arm.com>
Date:   Thu, 17 Mar 2022 13:42:56 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] thunderbolt: Stop using iommu_present()
Content-Language: en-GB
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "michael.jamet@intel.com" <michael.jamet@intel.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andreas.noever@gmail.com" <andreas.noever@gmail.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "YehezkelShB@gmail.com" <YehezkelShB@gmail.com>,
        "hch@lst.de" <hch@lst.de>
References: <YjHb1xCx4UAmUjrR@lahna>
 <16852eb2-98bb-6337-741f-8c2f06418b08@arm.com> <YjIb+XOGZbWKpQDa@lahna>
 <BL1PR12MB515762E68F3A48A97EB2DC89E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <YjIgQfmcw6fydkXd@lahna> <3bb6a2f8-005b-587a-7d7a-7a9a5391ec05@arm.com>
 <BL1PR12MB5157DA58C3BDAFB5736676F6E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <5ef1c30a-1740-00cc-ad16-4b1c1b02fca4@arm.com>
 <BL1PR12MB5157380CD6FD9EB83E76CBB0E2119@BL1PR12MB5157.namprd12.prod.outlook.com>
 <0709e994-1c8b-56fe-7743-8fdbf3ba748b@arm.com> <YjLsfhUmhjOiy6G8@lahna>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YjLsfhUmhjOiy6G8@lahna>
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

On 2022-03-17 08:08, Mika Westerberg wrote:
> Hi Robin,
> 
> On Wed, Mar 16, 2022 at 07:17:57PM +0000, Robin Murphy wrote:
>> The feeling I'm getting from all this is that if we've got as far as
>> iommu_dma_protection_show() then it's really too late to meaningfully
>> mitigate bad firmware.
> 
> Note, these are requirements from Microsoft in order for the system to
> use the "Kernel DMA protection". Because of this, likelyhood of "bad
> firmware" should be quite low since these systems ship with Windows
> installed so they should get at least some soft of validation that this
> actually works.
> 
>> We should be able to detect missing
>> untrusted/external-facing properties as early as nhi_probe(), and if we
>> could go into "continue at your own risk" mode right then *before* anything
>> else happens, it all becomes a lot easier to reason about.
> 
> I think what we want is that the DMAR opt-in bit is set in the ACPI
> tables and that we know the full IOMMU translation is happening for the
> devices behind "external facing ports". If that's not the case the
> iommu_dma_protection_show() should return 0 meaning the userspace can
> ask the user whether the connected device is allowed to use DMA (e.g
> PCIe is tunneled or not).

Ah, if it's safe to just say "no protection" in the case that we don't 
know for sure, that's even better. Clearly I hadn't quite grasped that 
aspect of the usage model, thanks for the nudge!

> We do check for the DMAR bit in the Intel IOMMU code and we also do
> check that there actually are PCIe ports marked external facing but we
> could issue warning there if that's not the case. Similarly if the user
> explicitly disabled the IOMMU translation. This can be done inside a new
> IOMMU API that does something like the below pseudo-code:
> 
> #if IOMMU_ENABLED
> bool iommu_dma_protected(struct device *dev)
> {
> 	if (dmar_platform_optin() /* or the AMD equivalent */) {
> 		if (!iommu_present(...)) /* whatever is needed to check that the full translation is enabled */
> 			dev_warn(dev, "IOMMU protection disabled!");
> 		/*
> 		 * Look for the external facing ports. Should be at
> 		 * least 1 or issue warning.
> 		 */
> 		 ...
> 
> 		return true;
> 	}
> 
> 	return false;
> }
> #else
> static inline bool iommu_dma_protected(struct device *dev)
> {
> 	return false;
> }
> #endif
> 
> Then we can make iommu_dma_protection_show() to call this function.

The problem that I've been trying to nail down here is that 
dmar_platform_optin() really doesn't mean much for us - I don't know how 
  Windows' IOMMU drivers work, but there's every chance it's not the 
same way as ours. The only material effect that dmar_platform_optin() 
has for us is to prevent the user from disabling the IOMMU driver 
altogether, and thus ensure that iommu_present() is true. Whether or not 
we can actually trust the IOMMU driver to provide reliable protection 
depends entirely on whether it knows the PCIe ports are external-facing. 
If not, we can only *definitely* know what the IOMMU driver will do for 
a given endpoint once that endpoint has appeared behind the port and 
iommu_probe_device() has decided what its default domain should be, and 
as far as I now understand, that's not an option for Thunderbolt since 
it can only happen *after* the tunnel has been authorised and created.

Much as I'm tempted to de-scope back to my IOMMU API cleanup and run 
away from the rest of the issue, I think I can crib enough from the 
existing code to attempt a reasonable complete fix, so let me give that 
a go...

Thanks,
Robin.
