Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0918359EDE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 23:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiHWVCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 17:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiHWVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 17:02:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3F46C7F0A3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 14:02:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67B94113E;
        Tue, 23 Aug 2022 14:02:08 -0700 (PDT)
Received: from [10.57.15.101] (unknown [10.57.15.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8BA3F67D;
        Tue, 23 Aug 2022 14:02:03 -0700 (PDT)
Message-ID: <478c4aba-897f-7e08-1df7-4e296538db9c@arm.com>
Date:   Tue, 23 Aug 2022 22:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [REGRESSION 5.19.x] AMD HD-audio devices missing on 5.19
Content-Language: en-GB
To:     Jason Gunthorpe <jgg@nvidia.com>, Takashi Iwai <tiwai@suse.de>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Eric Auger <eric.auger@redhat.com>,
        regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <874jy4cqok.wl-tiwai@suse.de> <20220823010021.GA5967@nvidia.com>
 <87h723sdde.wl-tiwai@suse.de> <87ilmjqj1f.wl-tiwai@suse.de>
 <20220823202824.GA4516@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20220823202824.GA4516@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-23 21:28, Jason Gunthorpe wrote:
> On Tue, Aug 23, 2022 at 01:46:36PM +0200, Takashi Iwai wrote:
>> It was tested now and confirmed that the call path is via AMDGPU, as
>> expected:
>>    amdgpu_pci_probe ->
>>    amdgpu_driver_load_kms ->
>>    amdgpu_device_init ->
>>    amdgpu_amdkfd_device_init ->
>>    kgd2kfd_device_init ->
>>    kgd2kfd_resume_iommu ->
>>    kfd_iommu_resume ->
>>    amd_iommu_init_device ->
>>    iommu_attach_group ->
>>    __iommu_attach_group
> 
> Oh, when you said sound intel I thought this was an Intel CPU..
> 
> Yes, there is this hacky private path from the amdgpu to
> the amd iommu driver that makes a mess of it here. We discussed it in
> this thread:
> 
> https://lore.kernel.org/linux-iommu/YgtuJQhY8SNlv9%2F6@8bytes.org/
> 
> But nobody put it together that it would be a problem with this.
> 
> Something like this, perhaps, but I didn't check if overriding the
> type would cause other problems.
> 
> diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
> index 696d5555be5794..6a1f02c62dffcc 100644
> --- a/drivers/iommu/amd/iommu_v2.c
> +++ b/drivers/iommu/amd/iommu_v2.c
> @@ -777,6 +777,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
>   	if (dev_state->domain == NULL)
>   		goto out_free_states;
>   
> +	/* See iommu_is_default_domain() */
> +	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
>   	amd_iommu_domain_direct_map(dev_state->domain);

Same question as 6 months ago, apparently: allocating an unmanaged 
domain with a pagetable then sucking out the pagetable is silly enough, 
but if we're going to then also call it a proper identity domain, we 
should really just allocate an identity domain directly; but then why 
not just enable_v2 on the identity domain that we know is already there 
courtesy of def_domain_type?

Robin.


Intentional whitespace-damaged patch based on wrong kernel version to 
stress how much it is for illustration purposes only:
----->8-----
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index fb61bdca4c2c..2925103cd71a 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -135,9 +135,6 @@ static void free_device_state(struct device_state 
*dev_state)

         iommu_group_put(group);

-       /* Everything is down now, free the IOMMUv2 domain */
-       iommu_domain_free(dev_state->domain);
-
         /* Finally get rid of the device-state */
         kfree(dev_state);
  }
@@ -730,7 +727,6 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
  int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
  {
         struct device_state *dev_state;
-       struct iommu_group *group;
         unsigned long flags;
         int ret, tmp;
         u16 devid;
@@ -773,34 +769,20 @@ int amd_iommu_init_device(struct pci_dev *pdev, 
int pasids)
         if (dev_state->states == NULL)
                 goto out_free_dev_state;

-       dev_state->domain = iommu_domain_alloc(&pci_bus_type);
-       if (dev_state->domain == NULL)
+       dev_state->domain = iommu_get_domain_for_dev(&pdev->dev);
+       if (dev_state->domain->type != IOMMU_DOMAIN_IDENTITY)
                 goto out_free_states;

-       amd_iommu_domain_direct_map(dev_state->domain);
-
         ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
         if (ret)
-               goto out_free_domain;
-
-       group = iommu_group_get(&pdev->dev);
-       if (!group) {
-               ret = -EINVAL;
-               goto out_free_domain;
-       }
-
-       ret = iommu_attach_group(dev_state->domain, group);
-       if (ret != 0)
-               goto out_drop_group;
-
-       iommu_group_put(group);
+               goto out_free_states;

         spin_lock_irqsave(&state_lock, flags);

         if (__get_device_state(devid) != NULL) {
                 spin_unlock_irqrestore(&state_lock, flags);
                 ret = -EBUSY;
-               goto out_free_domain;
+               goto out_free_states;
         }

         list_add_tail(&dev_state->list, &state_list);
@@ -809,12 +791,6 @@ int amd_iommu_init_device(struct pci_dev *pdev, int 
pasids)

         return 0;

-out_drop_group:
-       iommu_group_put(group);
-
-out_free_domain:
-       iommu_domain_free(dev_state->domain);
-
  out_free_states:
         free_page((unsigned long)dev_state->states);

