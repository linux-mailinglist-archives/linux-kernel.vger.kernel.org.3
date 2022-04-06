Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BF74F61A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiDFOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234675AbiDFOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:23:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701714C0080;
        Wed,  6 Apr 2022 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649240901; x=1680776901;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ga3bmWpFRns3F8dX7fQDF54qJCQGZJAxmilcJLgTgi4=;
  b=ISovC0x0CfXM3aY0CZ4mpCnr/wxXR/JoE1bAp8n+//p5i2J7w+LyhBtJ
   awsNfUz1Z14lcSIMy9T/BE9+nrsjZtH+pnKtK8PDtZDURFHZDnmpwIYpc
   be/JUg/FxVvJQ6iT0eKmUmMXz+oQxQZZz97cwB1x/tNkei1jRr8mmWLB1
   LpP+ZGBQEMHY2iUFl89+YXXp6/HCu2kNVIJXARd91FKY91YgwLDXRdeYm
   EwVpfze661J/AWur2yr4NZmlaZ3zklwt8dEEUuftRwB3Nc5QtqZx8lZHC
   cMGCTwUT3Yy6DQ31yaGN5/0W2gVAHDwiqU43uqJMxCLk54mu0ma8vRd1e
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240942576"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="240942576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:28:08 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570453045"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.82]) ([10.254.215.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:28:04 -0700
Message-ID: <b2bcd37a-08aa-0c49-8181-063beb43fc41@linux.intel.com>
Date:   Wed, 6 Apr 2022 18:28:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        mario.limonciello@amd.com, hch@lst.de
Subject: Re: [PATCH v3 2/4] iommu: Add capability for pre-boot DMA protection
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        andreas.noever@gmail.com, michael.jamet@intel.com,
        mika.westerberg@linux.intel.com, YehezkelShB@gmail.com
References: <cover.1649089693.git.robin.murphy@arm.com>
 <2b5dc62a6325075cb5bd1ceec31ebad1833acf83.1649089693.git.robin.murphy@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <2b5dc62a6325075cb5bd1ceec31ebad1833acf83.1649089693.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/5 18:41, Robin Murphy wrote:
> VT-d's dmar_platform_optin() actually represents a combination of
> properties fairly well standardised by Microsoft as "Pre-boot DMA
> Protection" and "Kernel DMA Protection"[1]. As such, we can provide
> interested consumers with an abstracted capability rather than
> driver-specific interfaces that won't scale. We name it for the former
> aspect since that's what external callers are most likely to be
> interested in; the latter is for the IOMMU layer to handle itself.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/oem-kernel-dma-protection
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/iommu.c | 2 ++
>   include/linux/iommu.h       | 2 ++
>   2 files changed, 4 insertions(+)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 255304eb3b1f..49d552a96098 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4550,6 +4550,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
>   		return domain_update_iommu_snooping(NULL);
>   	if (cap == IOMMU_CAP_INTR_REMAP)
>   		return irq_remapping_enabled == 1;
> +	if (cap == IOMMU_CAP_PRE_BOOT_PROTECTION)
> +		return dmar_platform_optin();
>   
>   	return false;
>   }
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1fa927e6f1c6..64c02f472f7b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -107,6 +107,8 @@ enum iommu_cap {
>   					   transactions */
>   	IOMMU_CAP_INTR_REMAP,		/* IOMMU supports interrupt isolation */
>   	IOMMU_CAP_NOEXEC,		/* IOMMU_NOEXEC flag */
> +	IOMMU_CAP_PRE_BOOT_PROTECTION,	/* Firmware says it used the IOMMU for
> +					   DMA protection and we should too */
>   };
>   
>   /* These are the possible reserved region types */
