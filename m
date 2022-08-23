Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4658959D145
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 08:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbiHWG01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 02:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240579AbiHWG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 02:26:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D949C60690
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661235984; x=1692771984;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mFPEXWqVfNGpmhdTzE8CaxKEhae+4dG8ZW90cX5pwwk=;
  b=XSNbStbyEsOQdhw2hqwumuhkbOX9HW9Npl1brffJjrRSBArm4f88eEj/
   fHjqesX9hVTfANQFC4ClMwmsmSlM0VNwEZXDh6luTO5GCI8VRHjRttEZb
   +S54OmUFfGXIDfE45TJo+obsvvWfu2QccnluVHyXsKfcogf8Yhrx/RQe7
   7+PgiCK0cpyEksENN3Kwv1JTuzvwep+X6hgHUlIq8Z1SbVp3GAs+zUj5/
   N9ZRFDuTraNGbJ3JZNhpH+LSMdfGlDxxhK5uQiunlk3bHD9P/tFGvYZ/Y
   9QTL7u/mmcsOK59D/0tCgA/YwvIY6ErCEWWimv7FNZFQC5rOqRI6F9TYn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="293602748"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="293602748"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:26:24 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="642324549"
Received: from xujinlon-mobl.ccr.corp.intel.com (HELO [10.254.211.102]) ([10.254.211.102])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 23:26:22 -0700
Message-ID: <c69320f8-c906-549f-0fbd-ef4c9b665f25@linux.intel.com>
Date:   Tue, 23 Aug 2022 14:26:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, yi.l.liu@intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible recursive lock in
 iommu_flush_dev_iotlb()
Content-Language: en-US
To:     iommu@lists.linux.dev
References: <20220817025650.3253959-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220817025650.3253959-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/17 10:56, Lu Baolu wrote:
> The per domain spinlock is acquired in iommu_flush_dev_iotlb(), which
> is possbile to be called in the interrupt context. For instance,
> 
>    <IRQ>
>    iommu_flush_dev_iotlb
>    iommu_flush_iotlb_psi
>    intel_iommu_tlb_sync
>    iommu_iotlb_sync
>    __iommu_dma_unmap
>    ? nvme_unmap_data
>    nvme_unmap_data
>    nvme_pci_complete_rq
>    nvme_irq
>    __handle_irq_event_percpu
>    handle_irq_event_percpu
>    handle_irq_event
>    handle_edge_irq
>    __common_interrupt
>    common_interrupt
> 
> This coverts the spin_lock/unlock() into the irq save/restore varieties
> to avoid the possible recursive locking issues.
> 
> Fixes: ffd5869d93530 ("iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()")
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

This patch has been queued:

https://lore.kernel.org/linux-iommu/20220823061557.1631056-1-baolu.lu@linux.intel.com/

Best regards,
baolu
