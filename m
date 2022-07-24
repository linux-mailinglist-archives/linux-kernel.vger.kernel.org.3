Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541FB57F422
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 10:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiGXIjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 04:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXIja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 04:39:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A0514082
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 01:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658651968; x=1690187968;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ziLiSEQbzWjCi7B0eTZt1SCYgRe+J/hqHUnOduqyHUc=;
  b=feEi8R8a/CyYKdMJmPO8NqJU75K8CYcLCvrNFcnh/5B81F0xfWGLcWFr
   qPbIeYRXECyRc34iuqcJRHFjnTqFMVcVPoNIXFziyrqvreOhiY3vTMT+j
   I/ABpQkJHddcUl0ofArXB7bEJ8H7r6pNMNZcBoUR05NqGng8hJoAgFPoo
   HMaQuPMXK7M7gd3N/2CElFN2Imqb4RqMbevFuKa9P82IIaRyl9G+cEQdi
   o4rQfKE8F5VZMgvIlxMN5qiJCGwOxpkfNRvb4Zy8HDW8jk+UinUaczK4P
   kZjNKenDgMAdkxBnqxa8br5uMTnnldosCpk0cpquBnR4vCDhNN8QQJAWO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="288285000"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288285000"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:39:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="657758458"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 01:39:23 -0700
Message-ID: <b31ce6fd-4202-e7bb-61de-3120c1e06825@linux.intel.com>
Date:   Sun, 24 Jul 2022 16:39:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220723141118.GD79279@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/23 22:11, Jason Gunthorpe wrote:
>> +	xa_erase(&group->pasid_array, pasid);
> It is worth checking that the value returned from xa_erase is domain
> and WARN_ON if not, since we are passing domain in..

Yes, will do like this:

WARN_ON(xa_erase(&group->pasid_array, pasid) != domain);

Best regards,
baolu
