Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236ED56988A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiGGDBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbiGGDBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:01:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3768A2FFDC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657162909; x=1688698909;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nh9x4dao7rW+cOue8YAdxg9Nyj1lCalyV2yGX6Iu6Vs=;
  b=arb7XPX4zYjRkVJEK8V+X3OKf+6SqzeNyOsX1jHRJP/rkUNjPEa27Ppz
   t1sbFSCJ43JyCs2X/QxYikHFWTsaMr5AmomQYE9zQJqaJBuW+RqeVSEhk
   Tg2epz14DRpnY0KTfh2r8K7ZWTo+tFwenxmdwh06zP+4U/1Y8em7IXq3O
   wB43CMHxs9PF9BkKIJIM3uJ2c3brV2g8rKp89/oDlBXJKrcqMWvl+r85l
   GFmHVkXnX9fMkROzAVLc2fzrlmvl6r5tI/uW+DHZqPEBT+kXicm0s9GzP
   nyGv80ZSxr01DLQ5aTIDle0SfE8qneM0pqJ1hqOI+IaEDSkUoJWQv1mb1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="347900907"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="347900907"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:01:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650936196"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 20:01:44 -0700
Message-ID: <efe50b1b-f23d-987f-36b4-c6583cfcde6e@linux.intel.com>
Date:   Thu, 7 Jul 2022 11:01:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-6-baolu.lu@linux.intel.com>
 <BN9PR11MB527676D80CA7348890320BDE8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB527676D80CA7348890320BDE8C839@BN9PR11MB5276.namprd11.prod.outlook.com>
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

On 2022/7/7 09:52, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 5, 2022 1:07 PM
>>
>> + *	IOMMU_DOMAIN_SVA	- DMA addresses are shared process address
>> + *				  spaces represented by mm_struct's.
>>    */
> 
> s/address spaces/addresses/

Updated.

> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>

Best regards,
baolu
