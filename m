Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765E4F6119
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 16:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbiDFONa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 10:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234765AbiDFOMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:12:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB6E638186
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649239850; x=1680775850;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=F1zju/9kmX6n6dT8p0E7zyZ2nCVHgfYrynN7MVqmilQ=;
  b=K4ImYtrsD9+VcJzk8gE709/onLqqkjzpLpVUntp/Ipf0JK5nUe8A82AU
   OsVrhFEm5zFmPx4VoVj/OQJk0pEisIPTu/Lgt1SfkwsoMG8A5VxdAV34I
   TxIqPl7B8/dILjyNIawQzc69N3gEhXkMjYHm3AHYqOAqHApWc/Qvu8X5u
   P3Cz4Z7zCFTe3fUB6fBL5n8j2oP89nJ9tsZT7pWosE+3lybfkV0ldNHKr
   6yxP4YCpMd2JeojsWhUEiheNkyN9hQxW0T7b6SJI8P14Z2U9SmAkoyGlT
   SFGT8ip4A65mb2M8tsX6BNbKBxfkKfnJrAyAg4LFe9tfnKVB8NSnw7bKW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260996160"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="260996160"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:02:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="570442421"
Received: from huipengt-mobl1.ccr.corp.intel.com (HELO [10.254.215.82]) ([10.254.215.82])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:02:19 -0700
Message-ID: <821dc298-47fb-6d06-ba75-de5d62a97b7a@linux.intel.com>
Date:   Wed, 6 Apr 2022 18:02:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com,
        "Alex Williamson (alex.williamson@redhat.com)" 
        <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330115820.GE1716663@nvidia.com>
 <BN9PR11MB527691E38BAC4F89FB17BDB98C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220330143008.GB2111031@nvidia.com>
 <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <BL1PR11MB52718E663EF48C45D97FEEF38CE39@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/4/2 15:12, Tian, Kevin wrote:
>>>> Add a flag to the group that positively indicates the group can never
>>>> have more than one member, even after hot plug. eg because it is
>>>> impossible due to ACS, or lack of bridges, and so on.
>>> OK, I see your point. It essentially refers to a singleton group which
>>> is immutable to hotplug.
>> Yes, known at creation time, not retroactively enforced because
>> someone used SVA
>>
> We may check following conditions to set the immutable flag when
> a new group is created for a device in pci_device_group():
> 
> 1) ACS is enabled in the upstream path of the device;
> 2) the device is single function or ACS is enabled on a multi-function device;
> 3) the device type is PCI_EXP_TYPE_ENDPOINT (thus no hotplug);
> 4) no 'dma aliasing' on this device;
> 
> The last one is a bit conservative as it also precludes a device which aliasing
> dma due to quirks from being treated as a singleton group. But doing so
> saves the effort on trying to separate different aliasing scenarios as defined
> in pci_for_each_dma_alias(). Probably we can go this way as the first step.
> 
> Once the flag is set on a group no other event can change it. If a new
> identified device hits an existing singleton group in pci_device_group()
> then it's a bug.

How about below implementation?

/* callback for pci_for_each_dma_alias() */
static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
{
	return -EEXIST;
}

static bool pci_dev_is_immutably_isolated(struct pci_dev *pdev)
{
	/* Skip bridges. */
	if (pci_is_bridge(pdev))
		return false;

	/* Either connect to root bridge or the ACS-enabled bridge. */
	if (!pci_is_root_bus(pdev->bus) &&
	    !pci_acs_enabled(pdev->bus->self, REQ_ACS_FLAGS))
		return false;

	/* ACS is required for MFD. */
	if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
		return false;

	/* Make sure no PCI alias. */
	if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
		return false;

	return true;
}

I didn't get why do we need to check the PCI_EXP_TYPE_ENDPOINT device
type. Can you please elaborate a bit more?

Best regards,
baolu
