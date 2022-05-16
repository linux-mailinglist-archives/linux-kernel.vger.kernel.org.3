Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C485F5285B4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 15:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbiEPNnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 09:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiEPNnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 09:43:51 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5AA35DC1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652708630; x=1684244630;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t+/pLuhuUkhIgbEA+oiikj8Gc7z+OKs/HfsGEDeb13g=;
  b=RZeqL5nWzwLX/FavyEB+aBQWaPLi0xV0p11x6oyhpY8/WQBRIO6jX4J9
   aR1eypOXXLlz7j+EMUZ+mLhphQWfE6noZ1lGShJrZaghj0a76tEKueIo4
   A1lCeuoBtJKL9a7yT2mMHjna7dEuDemTHlbuTr2r3Sux14+UAMx1LoF8L
   pIXcAw2SiXDJwxeYYSjGVA0T+YZMvoW0sKhXjdEINfeAAT/mTh4KwX/AQ
   HyZD86XorFM0fEezwq5SV2NE7g+kQGB/6+9vLHbxZ2p+2dagDbtYVMJNJ
   /HWiBPH/FpQ9W2inyPzwtCkz7HnGM1hzjcMuE3b3BxtQCOt7p/rNfSdpR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10348"; a="270783626"
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="270783626"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 06:43:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,229,1647327600"; 
   d="scan'208";a="522451951"
Received: from yanjiepa-mobl.ccr.corp.intel.com (HELO [10.249.192.19]) ([10.249.192.19])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 06:43:45 -0700
Message-ID: <64f49746-1ae7-7516-8e92-06ffb4d5f8e5@linux.intel.com>
Date:   Mon, 16 May 2022 21:43:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 2022/5/16 19:22, Robin Murphy wrote:
> On 2022-05-16 02:57, Lu Baolu wrote:
>> Each IOMMU driver must provide a blocking domain ops. If the hardware
>> supports detaching domain from device, setting blocking domain equals
>> detaching the existing domain from the deivce. Otherwise, an UNMANAGED
>> domain without any mapping will be used instead.
> 
> Unfortunately that's backwards - most of the implementations of 
> .detach_dev are disabling translation entirely, meaning the device ends 
> up effectively in passthrough rather than blocked. Conversely, at least 
> arm-smmu and arm-smmu-v3 could implement IOMMU_DOMAIN_BLOCKED properly 
> with fault-type S2CRs and STEs respectively, it just needs a bit of 
> wiring up.

Thank you for letting me know this.

This means that we need to add an additional UNMANAGED domain for each
iommu group, although it is not used most of the time. If most IOMMU
drivers could implement real dumb blocking domains, this burden may be
reduced.

Best regards,
baolu
