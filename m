Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6852C54C971
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242888AbiFONKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiFONKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:10:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F9F24084
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655298628; x=1686834628;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=49iVnIBH2iZUFVwoFe1umaO203mLoJXO8qFijdhPPbM=;
  b=F2iVngdVStwwwRWa87iUVrCMrnbpBCKyjJ1/hxAlxenfW/GEJ93wU/Z2
   JzNdiW+60mSwc0YW8cJXUAOLkiMYLtEyNvRlgDrUqshbZqzrRjzz3c71t
   qU9hC4dMEx42Emd9SPHewL3uHbp7UQ9DHxUI4u0kpDg9Y2DB3Ce4p3YUq
   YFwQMlOCdbgBcSfuGRBXl39zkA7Bm0yRC1NIHzuN9+PVUJcIAdSKvHeUF
   NDi8tTzRZHGffVvvQYe8IIVQ5bQXYjvR+a7LMCCbWyTDHhDjCd0mVJi4d
   Umn8vobZMOwfWZsdFpgy+BTK19UO3wR0l5RKVp+rXcmrofNotyEnU0RJY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="279672546"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="279672546"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:10:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="589105904"
Received: from leitan-mobl.ccr.corp.intel.com (HELO [10.255.31.142]) ([10.255.31.142])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 06:10:21 -0700
Message-ID: <b11b7cca-9e39-ac60-57a9-4e7049579221@linux.intel.com>
Date:   Wed, 15 Jun 2022 21:10:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 03/12] iommu/vt-d: Remove clearing translation data in
 disable_dmar_iommu()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-4-baolu.lu@linux.intel.com>
 <BN9PR11MB52762E7602FFF7EE4B52AC888CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <28161d94-6f2d-700f-853d-53b42f4d00d0@linux.intel.com>
 <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A9FB934BC5F6FA55D4958CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/15 14:22, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 3:21 PM
>>
>> On 2022/6/14 14:49, Tian, Kevin wrote:
>>>> From: Lu Baolu<baolu.lu@linux.intel.com>
>>>> Sent: Tuesday, June 14, 2022 10:51 AM
>>>>
>>>> The disable_dmar_iommu() is called when IOMMU initialization fails or
>>>> the IOMMU is hot-removed from the system. In both cases, there is no
>>>> need to clear the IOMMU translation data structures for devices.
>>>>
>>>> On the initialization path, the device probing only happens after the
>>>> IOMMU is initialized successfully, hence there're no translation data
>>>> structures.
>>> Out of curiosity. With kexec the IOMMU may contain stale mappings
>>> from the old kernel. Then is it meaningful to disable IOMMU after the
>>> new kernel fails to initialize it properly?
>>
>> For kexec kernel, if the IOMMU is detected to be pre-enabled, the IOMMU
>> driver will try to copy tables from the old kernel. If copying table
>> fails, the IOMMU driver will disable IOMMU and do the normal
>> initialization.
>>
> 
> What about an error occurred after copying table in the initialization
> path? The new kernel will be in a state assuming iommu is disabled
> but it is still enabled using an old mapping for certain devices...
>   

If copying table failed, the translation will be disabled and a clean
root table will be used.

if (translation_pre_enabled(iommu)) {
         pr_info("Translation already enabled - trying to copy 
translation structures\n");

         ret = copy_translation_tables(iommu);
         if (ret) {
                 /*
                  * We found the IOMMU with translation
                  * enabled - but failed to copy over the
                  * old root-entry table. Try to proceed
                  * by disabling translation now and
                  * allocating a clean root-entry table.
                  * This might cause DMAR faults, but
                  * probably the dump will still succeed.
                  */
                 pr_err("Failed to copy translation tables from previous 
kernel for %s\n",
                        iommu->name);
                 iommu_disable_translation(iommu);
                 clear_translation_pre_enabled(iommu);
         } else {
                 pr_info("Copied translation tables from previous kernel 
for %s\n",
                         iommu->name);
         }
}

Best regards,
baolu
