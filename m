Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07554CC38
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiFOPJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 11:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiFOPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 11:09:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA6372409C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 08:09:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D81C153B;
        Wed, 15 Jun 2022 08:09:27 -0700 (PDT)
Received: from [10.57.7.82] (unknown [10.57.7.82])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0DA3F7F5;
        Wed, 15 Jun 2022 08:09:26 -0700 (PDT)
Message-ID: <da9cca0a-ec5b-2e73-9de0-a930f7d947b2@arm.com>
Date:   Wed, 15 Jun 2022 16:09:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RESEND PATCH v8 01/11] iommu: Add DMA ownership management
 interfaces
Content-Language: en-GB
To:     Robin Murphy <robin.murphy@arm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220418005000.897664-1-baolu.lu@linux.intel.com>
 <20220418005000.897664-2-baolu.lu@linux.intel.com>
 <10eaa3b1-4cf7-a7b6-a7f6-111a486a343a@arm.com>
 <54159102-42f8-e5dc-5099-1d5d4dbbfc65@arm.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <54159102-42f8-e5dc-5099-1d5d4dbbfc65@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/2022 11:57, Robin Murphy wrote:
> On 2022-06-15 10:53, Steven Price wrote:
>> On 18/04/2022 01:49, Lu Baolu wrote:
>>> Multiple devices may be placed in the same IOMMU group because they
>>> cannot be isolated from each other. These devices must either be
>>> entirely under kernel control or userspace control, never a mixture.
>>>
>>> This adds dma ownership management in iommu core and exposes several
>>> interfaces for the device drivers and the device userspace assignment
>>> framework (i.e. VFIO), so that any conflict between user and kernel
>>> controlled dma could be detected at the beginning.
>>>
>>> The device driver oriented interfaces are,
>>>
>>>     int iommu_device_use_default_domain(struct device *dev);
>>>     void iommu_device_unuse_default_domain(struct device *dev);
>>>
>>> By calling iommu_device_use_default_domain(), the device driver tells
>>> the iommu layer that the device dma is handled through the kernel DMA
>>> APIs. The iommu layer will manage the IOVA and use the default domain
>>> for DMA address translation.
>>>
>>> The device user-space assignment framework oriented interfaces are,
>>>
>>>     int iommu_group_claim_dma_owner(struct iommu_group *group,
>>>                     void *owner);
>>>     void iommu_group_release_dma_owner(struct iommu_group *group);
>>>     bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>>>
>>> The device userspace assignment must be disallowed if the DMA owner
>>> claiming interface returns failure.
>>>
>>> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Signed-off-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>>
>> I'm seeing a regression that I've bisected to this commit on a Firefly
>> RK3288 board. The display driver fails to probe properly because
>> __iommu_attach_group() returns -EBUSY. This causes long hangs and splats
>> as the display flips timeout.
>>
>> The call stack to __iommu_attach_group() is:
>>
>>   __iommu_attach_group from iommu_attach_device+0x64/0xb4
>>   iommu_attach_device from rockchip_drm_dma_attach_device+0x20/0x50
>>   rockchip_drm_dma_attach_device from vop_crtc_atomic_enable+0x10c/0xa64
>>   vop_crtc_atomic_enable from
>> drm_atomic_helper_commit_modeset_enables+0xa8/0x290
>>   drm_atomic_helper_commit_modeset_enables from
>> drm_atomic_helper_commit_tail_rpm+0x44/0x8c
>>   drm_atomic_helper_commit_tail_rpm from commit_tail+0x9c/0x180
>>   commit_tail from drm_atomic_helper_commit+0x164/0x18c
>>   drm_atomic_helper_commit from drm_atomic_commit+0xac/0xe4
>>   drm_atomic_commit from drm_client_modeset_commit_atomic+0x23c/0x284
>>   drm_client_modeset_commit_atomic from
>> drm_client_modeset_commit_locked+0x60/0x1c8
>>   drm_client_modeset_commit_locked from
>> drm_client_modeset_commit+0x24/0x40
>>   drm_client_modeset_commit from drm_fb_helper_set_par+0xb8/0xf8
>>   drm_fb_helper_set_par from drm_fb_helper_hotplug_event.part.0+0xa8/0xc0
>>   drm_fb_helper_hotplug_event.part.0 from output_poll_execute+0xb8/0x224
>>
>>> @@ -2109,7 +2115,7 @@ static int __iommu_attach_group(struct
>>> iommu_domain *domain,
>>>   {
>>>       int ret;
>>>   -    if (group->default_domain && group->domain !=
>>> group->default_domain)
>>> +    if (group->domain && group->domain != group->default_domain)
>>>           return -EBUSY;
>>>         ret = __iommu_group_for_each_dev(group, domain,
>>
>> Reverting this 'fixes' the problem for me. The follow up 0286300e6045
>> ("iommu: iommu_group_claim_dma_owner() must always assign a domain")
>> doesn't help.
>>
>> Adding some debug printks I can see that domain is a valid pointer, but
>> both default_domain and blocking_domain are NULL.
>>
>> I'm using the DTB from the kernel tree (rk3288-firefly.dtb).
>>
>> Any ideas?
> 
> Hmm, TBH I'm not sure how that worked previously... it'll be complaining
> because the ARM DMA domain is still attached, but even when the attach
> goes ahead and replaces the ARM domain with the driver's new one, it's
> not using the special arm_iommu_detach_device() interface anywhere so
> the device would still be left with the wrong DMA ops :/
> 
> I guess the most pragmatic option is probably to give rockchip-drm a
> similar bodge to exynos and tegra, to explicitly remove the ARM domain
> before attaching its own.

A bodge like below indeed 'fixes' the problem:

---8<---
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
index 67d38f53d3e5..cbc6a5121296 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
@@ -23,6 +23,14 @@
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_vblank.h>
 
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_detach_device(...)	({ })
+#define arm_iommu_release_mapping(...)	({ })
+#define to_dma_iommu_mapping(dev) NULL
+#endif
+
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
 #include "rockchip_drm_gem.h"
@@ -49,6 +57,14 @@ int rockchip_drm_dma_attach_device(struct drm_device *drm_dev,
 	if (!private->domain)
 		return 0;
 
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+		if (mapping) {
+			arm_iommu_detach_device(dev);
+			arm_iommu_release_mapping(mapping);
+		}
+	}
+
 	ret = iommu_attach_device(private->domain, dev);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "Failed to attach iommu device\n");
---8<---

I'll type up a proper commit message and see what the DRM maintainers think.

Thanks,

Steve
