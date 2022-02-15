Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C16D4B60C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbiBOCHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:07:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbiBOCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:07:14 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EB125DC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644890825; x=1676426825;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dZS7EKMhjasWG4hFq6KS48/STYMyzi5srwau0lAF/g0=;
  b=HDNlmR1+Z+oeBQ76oopdVSqwnosQYhHmbJDQOX70lNnzqc22sDjMlakI
   F7iojjavi24KYCY13fFIHZew9xV7fYpLsdIwhwWp6BojC+ndGbIkMAHoG
   1vKX3P6M0S676q41uErvbTJO2SyDgHVxCFeNU5BO5RlikgkNquAdfx7ag
   coEYT44hgONuoDT14Iq4kvh6CW7Z3Bp4Czv82fSstPxje/kEa4t+L0NJi
   AklPjzYnxyPcNcaT6IFQzCy7akuC/GVUxSl2F74QMO6qNriuwS9DkT1GH
   kOAJlm11r1DpqsaMVH1AB9GZraCF48v0s91f5rZsKIY15I3l6EYksdtQK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250176826"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="250176826"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 18:07:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680795109"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 18:07:01 -0800
Message-ID: <1d817995-f89b-a1de-6aff-9a2bfe91367f@linux.intel.com>
Date:   Tue, 15 Feb 2022 10:05:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iommu cleanup and refactoring
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <YgpjzNtQlOdq+1AB@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpjzNtQlOdq+1AB@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2/14/22 10:14 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:28AM +0800, Lu Baolu wrote:
>> v3:
>>   - Remove ops check when dev_iommu_ops() is used.
>>   - This version of series is available on github:
>>     https://github.com/LuBaolu/intel-iommu/commits/iommu-domain-ops-v3
>>
>> Lu Baolu (10):
>>    iommu/vt-d: Remove guest pasid related callbacks
>>    iommu: Remove guest pasid related interfaces and definitions
>>    iommu/vt-d: Remove aux-domain related callbacks
>>    iommu: Remove aux-domain related interfaces and iommu_ops
>>    iommu: Remove apply_resv_region
>>    drm/nouveau/device: Get right pgsize_bitmap of iommu_domain
>>    iommu: Use right way to retrieve iommu_ops
>>    iommu: Remove unused argument in is_attach_deferred
>>    iommu: Use dev_iommu_ops() helper
>>    iommu: Split struct iommu_ops
> 
> Really cool, thanks for doing this, Baolu! I am currently running some
> tests on this series to make sure there are no build breakages. And I
> agree with Jason that:
> 
> 	iommu: Use right way to retrieve iommu_ops and
> 	iommu: Use dev_iommu_ops() helper
> 
> can be combined into one patch. Splitting iommu_ops was something I have
> been thinking about for some time, so thanks again for doing this.

You are welcome!

Do you want me to send a new version with below changes:

- Remove WARN_ON() in dev_iommu_ops();
- Merge above two patches.

Or, you can change above yourself?

> 
> Regards,
> 
> 	Joerg

Best regards,
baolu
