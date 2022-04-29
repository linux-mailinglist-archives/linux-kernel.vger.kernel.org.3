Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E76951426C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354578AbiD2GjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiD2Gi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:38:59 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A2A81199
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651214142; x=1682750142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=73uaYpqAPQn+8U/LuREycvqXt3Sws/vKsehS795EZBw=;
  b=i6sr6lWcYEJH+55IyX+dFV5fWFsBuhSNF2bcnbhQNivfYnnqYQSyNwxf
   jsvOYRug62qq/YL31uQddm55oFv+ERVHsNIzEHO7Ost9KeFC4l0coeJiB
   TY5HBrGda5IeHwewcVOZvo8K9x5R272yGZ8thK4xCoR8IPB67OLrcJiJP
   zKaN9yLOI/yXroGrXFrvFUNJgOH4JDfUXJtT3Rat6hAm9m4B0wWH+3S2c
   gv+PnYbMfarw1jTuLxl3Rhxk8WW+8MhlbMTEDtjxEfjz7yIM9vWVfUmTK
   AsirKV1fqsoFcbFU3o1YFsQ3zUbP51Uv28Ev34U1chY7SPNoV1rKwkv1y
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="248479529"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="248479529"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:35:42 -0700
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="581924572"
Received: from lye4-mobl.ccr.corp.intel.com (HELO [10.249.170.95]) ([10.249.170.95])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 23:35:39 -0700
Message-ID: <d8682159-508b-501b-3642-54c8155a356d@linux.intel.com>
Date:   Fri, 29 Apr 2022 14:35:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 11/12] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220421052121.3464100-1-baolu.lu@linux.intel.com>
 <20220421052121.3464100-12-baolu.lu@linux.intel.com>
 <YmqrTGcHotvhhaT2@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YmqrTGcHotvhhaT2@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/28 22:57, Jean-Philippe Brucker wrote:
> On Thu, Apr 21, 2022 at 01:21:20PM +0800, Lu Baolu wrote:
>>   static void iopf_handle_group(struct work_struct *work)
>>   {
>>   	struct iopf_group *group;
>> @@ -134,12 +78,23 @@ static void iopf_handle_group(struct work_struct *work)
>>   	group = container_of(work, struct iopf_group, work);
>>   
>>   	list_for_each_entry_safe(iopf, next, &group->faults, list) {
>> +		struct iommu_domain *domain;
>> +
>> +		domain = iommu_get_domain_for_dev_pasid_async(group->dev,
>> +				iopf->fault.prm.pasid);
> Reading the PCIe spec again (v6.0 10.4.1.1 PASID Usage), all faults within
> the group have the same PASID so we could move the domain fetch out of the
> loop. It does deviate from the old behavior, though, so we could change
> it later.

Perhaps we can add a pasid member in the struct iopf_group and do a
sanity check when a new iopf is added to the group? Here, we just fetch
the domain with group->pasid.

Best regards,
baolu
