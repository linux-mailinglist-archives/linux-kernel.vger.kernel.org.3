Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFADE524D27
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353892AbiELMjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347397AbiELMjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:39:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3F462136
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652359162; x=1683895162;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ylfevFr8DAKKlnOWSQ7Fkq7Eg5B5wM7FmiEl79rW8r0=;
  b=TlovMbEELLo704acggZyaGg5gKM1b0Cxno8mmr5dmO5xauAjEDbuQ5a6
   Cp+sZt3+oQtqMO3sJdsBiEa6iEggcQt/UZz/URyAoCvVFvjO0jS7XoBrQ
   KtCaqg19enT38srfFJaKiB+qZRlOUTyiz26fu4kkfW9xQkaSwUuVawsNb
   QyLOsolhJrgLV7iDNY/xcbVZ5LDFO4z221xK5oD1IYQuUGKJl9l4Sm96+
   glNaUkEKtJA61CV9iFXLVygPj/lM9bfsdpiowlV4Z8CiozRh6jMWqSTYD
   0X4P1c+/Un1GQE5mk4GVDpd+t+t/4QszJJTm5yEJ/hnc9MVDYOHU8m+oJ
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249886272"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="249886272"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 05:39:22 -0700
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594647779"
Received: from hezhu1-mobl1.ccr.corp.intel.com (HELO [10.255.29.168]) ([10.255.29.168])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 05:39:18 -0700
Message-ID: <bf79924a-2501-c835-6bf8-ab2810df8e92@linux.intel.com>
Date:   Thu, 12 May 2022 20:39:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
 <20220510152330.GG49344@nvidia.com>
 <749a7d62-3e6c-ef5c-beaf-6b7add495740@linux.intel.com>
 <20220511145319.GZ49344@nvidia.com>
 <05a68e1e-8e18-5914-ebe7-d7b1a4aaa2ec@linux.intel.com>
 <20220512115136.GV49344@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220512115136.GV49344@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 19:51, Jason Gunthorpe wrote:
> On Thu, May 12, 2022 at 11:02:39AM +0800, Baolu Lu wrote:
>>>> +       mutex_lock(&group->mutex);
>>>> +       domain = xa_load(&group->pasid_array, pasid);
>>>> +       if (domain && domain->type != type)
>>>> +               domain = NULL;
>>>> +       mutex_unlock(&group->mutex);
>>>> +       iommu_group_put(group);
>>>> +
>>>> +       return domain;
>>> This is bad locking, group->pasid_array values cannot be taken outside
>>> the lock.
>>
>> It's not iommu core, but SVA (or other feature components) that manage
>> the life cycle of a domain. The iommu core only provides a place to
>> store the domain pointer. The feature components are free to fetch their
>> domain pointers from iommu core as long as they are sure that the domain
>> is alive during use.
> 
> I'm not convinced.

I'm sorry, I may not have explained it clearly. :-)

This helper is safe for uses inside the IOMMU subsystem. We could trust
ourselves that nobody will abuse this helper to obtain domains belonging
to others as the pasid has been allocated for SVA code. No other code
should be able to setup another type of domain for this pasid. The SVA
code has its own lock mechanism to avoid using after free.

Please correct me if I missed anything. :-) By the way, I can see some
similar helpers in current IOMMU core. For example,

struct iommu_domain *iommu_get_domain_for_dev(struct device *dev)
{
         struct iommu_domain *domain;
         struct iommu_group *group;

         group = iommu_group_get(dev);
         if (!group)
                 return NULL;

         domain = group->domain;

         iommu_group_put(group);

         return domain;
}
EXPORT_SYMBOL_GPL(iommu_get_domain_for_dev);

Best regards,
baolu
