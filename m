Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E1A57FC77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbiGYJdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiGYJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:33:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B8A165A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658741591; x=1690277591;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LG94wmYcqwulOfN8bOk9Um30V8TQnDcAdYhfJN1cJTQ=;
  b=IUr7EOuQFqfT1yewFrhzvymbnZ8L1wi5STR60PYljZNVPlK4F+BKlBfv
   l7kNp50DnIesWPgiaCLp/OaS0synwWleDHti7He19Uvtm69TdT39RxPE/
   bfdMCLpkMBGXpYotXF6gbz0BTVCP+mRgYM6Y8+Dwgj/Dyi0kDMbLCcGpZ
   Huzk37ipcdHcsk1NVVhyevsH9NZmgWLTqATLQBQQ9LGdTv/AoNOuh9IbJ
   8XUfDZeK2PnPYjE9Ul/Nb8JUgy4QNF+Zbbt2HnCBOQoNLIBZvHskvtu3v
   P1aqDB8LhkvwHsfe5kl5UmOeyHytyUsjjkoVGHwR8QWvMif07s1/z4F1n
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288414901"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="288414901"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:33:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="658110042"
Received: from liangk-mobl.ccr.corp.intel.com (HELO [10.255.30.67]) ([10.255.30.67])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 02:33:05 -0700
Message-ID: <7862ed6f-b834-5dc7-8677-31ff52fec76d@linux.intel.com>
Date:   Mon, 25 Jul 2022 17:33:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <20220723142650.GH79279@nvidia.com>
 <bffb6e2d-d310-49b9-0725-37ab4263c22d@linux.intel.com>
 <Yt5IqyZw/Sa6Ck5t@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <Yt5IqyZw/Sa6Ck5t@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On 2022/7/25 15:39, Jean-Philippe Brucker wrote:
> On Sun, Jul 24, 2022 at 09:48:15PM +0800, Baolu Lu wrote:
>> /*
>>   * iommu_detach_device_pasid() - Detach the domain from pasid of device
>>   * @domain: the iommu domain.
>>   * @dev: the attached device.
>>   * @pasid: the pasid of the device.
>>   *
>>   * The @domain must have been attached to @pasid of the @dev with
>>   * iommu_detach_device_pasid().
>>   */
>> void iommu_detach_device_pasid(struct iommu_domain *domain, struct device
>> *dev,
>> 			       ioasid_t pasid)
>> {
>> 	struct iommu_group *group = iommu_group_get(dev);
>> 	struct group_pasid *param;
>>
>> 	mutex_lock(&group->mutex);
>> 	domain->ops->set_dev_pasid(group->blocking_domain, dev, pasid);
> Please also pass the old domain to this detach() function, so that the
> IOMMU driver doesn't have to keep track of them internally.

The iommu core provides the interface to retrieve attached domain with a
{device, pasid} pair. Therefore in the smmuv3 driver, the set_dev_pasid
could do like this:

+static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
+                                     struct device *dev, ioasid_t id)
+{
+       int ret = 0;
+       struct mm_struct *mm;
+       struct iommu_sva *handle;
+
+       /*
+        * Detach the domain if a blocking domain is set. Check the
+        * right domain type once the IOMMU driver supports a real
+        * blocking domain.
+        */
+       if (!domain || domain->type == IOMMU_DOMAIN_UNMANAGED) {
+               struct pasid_iommu *param;
+
+               param = iommu_device_pasid_param(dev, id);
+               if (!param || !param->domain)
+                       return -EINVAL;
+               arm_smmu_sva_block_dev_pasid(param->domain, dev, id);
+
+               return 0;
+       }
+
+       mm = domain->mm;
+       mutex_lock(&sva_lock);
+       handle = __arm_smmu_sva_bind(dev, mm);
+       if (IS_ERR(handle))
+               ret = PTR_ERR(handle);
+       mutex_unlock(&sva_lock);
+
+       return ret;
+}

The check of "(!domain || domain->type == IOMMU_DOMAIN_UNMANAGED)" looks
odd, but could get cleaned up after a real blocking domain is added.
Then, we can simply check "domain->type == IOMMU_DOMAIN_BLOCKING".

> In addition to clearing contexts, detach() also needs to invalidate TLBs,
> and for that the SMMU driver needs to know the old ASID (!= PASID) that
> was used by the context descriptor.

Best regards,
baolu
