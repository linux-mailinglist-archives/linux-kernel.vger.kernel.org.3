Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566D55838B7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbiG1G1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiG1G1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:27:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D549753D26
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658989657; x=1690525657;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=jOlcrF54BgdoCTWPvBjjzQ5jHjfAyaaVLW7zTceQpag=;
  b=QSGNlIJhxqWdPd/EPOFlGepO3LCuK5PHP+9TeySwMf43M5lJR/bYmou+
   8GMV779rn8dz+N/FjUmbs2eu92pI8tLgKUf6pmER1mkVjhbVxXtAX+/9s
   PAS1Ita1X1D5BXIlNAcf2p0wFbi1U0f1SVKADR1JOGJYtWPLL08NMwGwP
   8cVshWR/ysMhf+sfEHhWmnAiZKTpzCB4+f1euU7ODgxfy+aCiPCo4MVHA
   hn3oYT3wl/m5WVcHA6tlZsBOYMB6KsitwOKXZLMQI45CQ6Nr6dV6+T9Ko
   KToyY2FYLb3IVZMt5UwNY3LfzOnxQ7fUyQBjxCIu6nL6Eq9ihTOma7tMy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10421"; a="268815018"
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="268815018"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:27:37 -0700
X-IronPort-AV: E=Sophos;i="5.93,196,1654585200"; 
   d="scan'208";a="928137045"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.213.160]) ([10.254.213.160])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 23:27:32 -0700
Message-ID: <ccba785d-9000-09f0-7ca8-b21834924ced@linux.intel.com>
Date:   Thu, 28 Jul 2022 14:27:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
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
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
 <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <cf370e4a-9391-4dd3-1e0a-3c7ea70d9ed2@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
In-Reply-To: <cf370e4a-9391-4dd3-1e0a-3c7ea70d9ed2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/28 10:44, Baolu Lu wrote:
>>
>> If the fabric routes PASID properly then groups are not an issue - all
>> agree on this?
> 
> I still think the singleton group is required, but it's not related to
> the PCI fabric routing discussed here.
> 
> We have a single array for PASIDs in the iommu group. All devices
> sitting in the group should share a single PASID namespace. However both
> the translation structures for IOMMU hardware or the device drivers can
> only adapt to per-device PASID namespace. Hence, it's reasonable to
> require the singleton group.

Further, conceptually, we cannot support pasid attach/detach on multi-
device groups. If multiple devices cannot be isolated, it is difficult
to ensure that their pasid spaces are isolated from each other.
Therefore, it is wrong to attach a domain to the pasid of a device. All
devices in the group must share a domain.

Best regards,
baolu
