Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1943C562815
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 03:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiGABV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGABVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 21:21:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E920E5A2DA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 18:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656638512; x=1688174512;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H4ENz9j9WZZPAItQz3miCy+CRrDXsBwHO08vdhTePe4=;
  b=lMBbdCzbw2kizWQDpva+gC5VatwkDHmjCaNo8YDAZCVG3MPLzdOCyvfA
   t722sLw4nO3p23W+Wf7YGYKX5wuVKk3+hvOx6ot7yXQ6YmxT7aE10LOZV
   uBkx5nFHi+zFOTUACIh/nxm+4gBdifxQ++R7pIM+sk2BaHwwgfZEIpqa0
   4l/3Dk7GpPxvG3jJpdwcTpe9H29PzfBvREv8ZfUjxiSAOmvmy4BFZkV+n
   GGZ/6kp19nKO+VQlXNSgSIQ4xga+a7CDybUdewjiBf98ObNs3fGlbXcbG
   6XHTp5NhNuyP3w/q/HUMIofqmZkOlmUHUVtw9YO1wcWmANEvO2lHrP2Wg
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271287726"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271287726"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 18:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="589038477"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 18:21:49 -0700
Message-ID: <617e5bc8-aaef-c6b9-c50b-8fadb8ea8efb@linux.intel.com>
Date:   Fri, 1 Jul 2022 09:17:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        "Anderson, Russ" <russ.anderson@hpe.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/6] iommu/vt-d: Use IDA interface to manage iommu
 sequence id
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-3-baolu.lu@linux.intel.com>
 <BL1PR11MB5271C0143C8EA440BDAF45828CBA9@BL1PR11MB5271.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BL1PR11MB5271C0143C8EA440BDAF45828CBA9@BL1PR11MB5271.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 4:21 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> @@ -1062,11 +1040,14 @@ static int alloc_iommu(struct dmar_drhd_unit
>> *drhd)
>>   	if (!iommu)
>>   		return -ENOMEM;
>>
>> -	if (dmar_alloc_seq_id(iommu) < 0) {
>> +	iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
>> +					DMAR_UNITS_SUPPORTED,
> 
> should be "DMAR_UNITS_SUPPORTED - 1"

Yes, according to "@max: Highest ID to allocate.". Updated.

>> GFP_KERNEL);
>> +	if (iommu->seq_id < 0) {
>>   		pr_err("Failed to allocate seq_id\n");
>>   		err = -ENOSPC;
>>   		goto error;
>>   	}
> 
> ida_alloc_range() returns error code already. No need to change it.
> 

Agreed. Updated as below:

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index bf43889b9d2a..6327b34f5aa7 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1041,10 +1041,10 @@ static int alloc_iommu(struct dmar_drhd_unit *drhd)
                 return -ENOMEM;

         iommu->seq_id = ida_alloc_range(&dmar_seq_ids, 0,
-                                       DMAR_UNITS_SUPPORTED, GFP_KERNEL);
+                                       DMAR_UNITS_SUPPORTED - 1, 
GFP_KERNEL);
         if (iommu->seq_id < 0) {
                 pr_err("Failed to allocate seq_id\n");
-               err = -ENOSPC;
+               err = iommu->seq_id;
                 goto error;
         }
         sprintf(iommu->name, "dmar%d", iommu->seq_id);

Best regards,
baolu
