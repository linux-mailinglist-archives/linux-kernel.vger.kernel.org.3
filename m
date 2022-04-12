Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA54FE085
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353543AbiDLMlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354846AbiDLMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:38:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35286339D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649764740; x=1681300740;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9DfAarcfAzo6JBBqkE0A2OGiOBZ6hr7tyCRuLN5rWe8=;
  b=kvUW1AwUJZzeDp3U2OLKg10Lz9mhwNtGJJCF1lTJmgyFVsNcFxYOIXPU
   xFINdZJyr965e+vlR+gK+nukz8F+w8UZa2U1nxKWBEZ8Wt/X1NmwpoH5l
   DU1+gH7xERU1Afu+xHDkwM5sEOfc7azLB5nZHiI1QGQVMBM5c5133jYpx
   uzOK5JHoa7QKzGhJO7l+GkZvDTzaTa71lvcY2bE4cokwkydvPMM5dHaUo
   TfczEKpFtKCmb8oyGOjlkqVVe7l5DQBHgIsUaiRAqoeZttWIxDu30fAoV
   dA66rYzIQZgdtiTzCQBwp/cEN0xlNniN4OohMn+CiVuYGgHeBbfkz6w+k
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261206240"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261206240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:58:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572730762"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 04:58:48 -0700
Message-ID: <84441673-4cd5-864c-38b5-3c2ce08d438f@linux.intel.com>
Date:   Tue, 12 Apr 2022 19:58:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v3 04/12] iommu/sva: Basic data structures for SVA
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-5-baolu.lu@linux.intel.com>
 <BN9PR11MB52766016D2FAD092A892E2A58CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766016D2FAD092A892E2A58CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 14:49, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Sunday, April 10, 2022 6:25 PM
>>
>> Use below data structures for SVA implementation in the IOMMU core:
>>
>> - struct iommu_sva_ioas
>>    Represent the I/O address space shared with an application CPU address
>>    space. This structure has a 1:1 relationship with an mm_struct. It
>>    graps a "mm->mm_count" refcount during creation and drop it on release.
>>
>> - struct iommu_domain (IOMMU_DOMAIN_SVA type)
>>    Represent a hardware pagetable that the IOMMU hardware could use for
>>    SVA translation. Multiple iommu domains could be bound with an SVA ioas
>>    and each graps a refcount from ioas in order to make sure ioas could
>>    only be freed after all domains have been unbound.
>>
>> - struct iommu_sva
>>    Represent a bond relationship between an SVA ioas and an iommu domain.
>>    If a bond already exists, it's reused and a reference is taken.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> 
> This should be patch07. None of following patches touch those structures
> until hitting patch08.

The iommu_sva_domain_mm() helper will be used in the following patches.

Best regards,
baolu
