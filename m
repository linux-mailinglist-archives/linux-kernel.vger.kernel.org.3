Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B66587588
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235546AbiHBCYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiHBCYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:24:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65291ADB1
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659407046; x=1690943046;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=X0+Fo5Zyxytk3rUKtAqS0oOOSdZ/wsYHzGBuKKmFi5Y=;
  b=B8KlaAsSna+49FWKEgmGl++Ao92FRjNoenCT0EllmY6gfeAqv2rGZ45g
   +vkgXXeS4M5cBEFE0lHs2gP/yNoYOqaIcww66y/o2WMx6XJv9VIus5brG
   brO5z3PZkya5Js5Yd+LBVkq24AfHwV+UfQLLhPiaNI0geVxnjwjB4GtV5
   hXWt5RhWoLLFFGQIrCMbDlYy+2J9nBidU5kvF2erA7aSwuzTtabW/DpBG
   oRewh9cp90HF3BUiZ8j7UTXqqU48mBUBZN1g2UOwYkqF9WZShL6IRIYyR
   p5uWDsg4h6asSU3SteoHDBiw/fxq5OAbTYC2xTJorqLpjoB+/N5kfrnUY
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="269070383"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="269070383"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661426081"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 19:24:02 -0700
Message-ID: <806b1437-441b-253b-7f52-ee7a7a9053e9@linux.intel.com>
Date:   Tue, 2 Aug 2022 10:19:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220726135722.GC4438@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 7/26/22 9:57 PM, Jason Gunthorpe wrote:
>> +	/*
>> +	 * Block PASID attachment in all cases where the PCI fabric is
>> +	 * routing based on address. ACS disables it.
>> +	 */
>> +	if (dev_is_pci(dev) &&
>> +	    !pci_acs_path_enabled(to_pci_dev(dev), NULL, REQ_ACS_FLAGS))
>> +		return -ENODEV;
> I would probably still put this in a function just to be clear, and
> probably even a PCI layer funcion 'pci_is_pasid_supported' that
> clearly indicates that the fabric path can route a PASID packet
> without mis-routing it.

I am fine with putting above in a function to make it clear. But I am
hesitant to move this part of logic into the PCI layer.

 From the perspective of IOMMU, TLPs with PASID prefix form distinct
address spaces, so it's reasonable to require ACS protection on the
upstream path.

But PCI spec doesn't require this. The interfaces defined in drivers/pci
/ats.c should work as well even the IOMMU is disabled.

> If the fabric routes PASID properly then groups are not an issue - all
> agree on this?

Yes, agreed. The iommu groups are not an issue any more. But just like
iommu_attach_device(), if multiple devices share a group, there must be
some mechanism to make sure that device drivers are aware of this fact
and only attach a shared domain to any PASID of those devices.'
Otherwise, the iommu_attach/detach_dev_pasid() might be misused.

Considering that all existing PASID use cases are singleton group case,
probably we can start our support from the simple singleton group case?

Best regards,
baolu
