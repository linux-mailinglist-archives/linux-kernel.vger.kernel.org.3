Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1136C562935
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbiGACkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbiGACkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:40:11 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784313879A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656643210; x=1688179210;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=edwKdOeVps2DTKJzwrZSMgChaL5jo07778euBqV1TM8=;
  b=caRbIjGkd5t7pSm6fUCEoP7dQ6hFHn7wkIq5r0jVyoWcN6HwAERRgFTm
   H/lGt2uAIQdi+4xVl6w42MBjW0XD5UKv3ufQTvIkNGtCRzAqo7iy6Cf8Q
   ePkRcjIHlSMbj+EXize0F0TOVdMKoVJqpKOUcPCHfPTh+Bj4b7fngcMEw
   tO3rNlDwUvJD0L8GxtSkrIz74EEowf+bIsbaKqnZu9GderfcIKAkTVhWm
   0SL4gvFKaaIGQ0NNtbRbfzVuLPmXZfhbLbuS8q2J9Nn6uoWJgSS8P1RGE
   wCXS6Fkzo6BVjNuyR1eDSDTAYEZShzfm5l79SjGIrcGV+t/EN9gAhD1Dr
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="308044292"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="308044292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:40:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="589059098"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Jun 2022 19:40:07 -0700
Message-ID: <595c314b-2d16-aeef-d808-d1cb713ba175@linux.intel.com>
Date:   Fri, 1 Jul 2022 10:35:50 +0800
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
Subject: Re: [PATCH v1 3/6] iommu/vt-d: Refactor iommu information of each
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
 <20220625125204.2199437-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276A78546BD2B38068385E18CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276A78546BD2B38068385E18CBA9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/22 4:28 PM, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Saturday, June 25, 2022 8:52 PM
>>
>> +struct iommu_domain_info {
>> +	struct intel_iommu *iommu;
>> +	unsigned int refcnt;
>> +	u16 did;
>> +};
>> +
>>   struct dmar_domain {
>>   	int	nid;			/* node id */
>> -
>> -	unsigned int iommu_refcnt[DMAR_UNITS_SUPPORTED];
>> -					/* Refcount of devices per iommu */
>> -
>> -
>> -	u16		iommu_did[DMAR_UNITS_SUPPORTED];
>> -					/* Domain ids per IOMMU. Use u16
>> since
>> -					 * domain ids are 16 bit wide
>> according
>> -					 * to VT-d spec, section 9.3 */
> 
> It'd make sense to keep the comments when moving above fields.

Sure. Updated.

diff --git a/drivers/iommu/intel/iommu.h b/drivers/iommu/intel/iommu.h
index 56c3d1a9e155..fae45bbb0c7f 100644
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -527,8 +527,10 @@ struct context_entry {

  struct iommu_domain_info {
         struct intel_iommu *iommu;
-       unsigned int refcnt;
-       u16 did;
+       unsigned int refcnt;            /* Refcount of devices per iommu */
+       u16 did;                        /* Domain ids per IOMMU. Use u16 
since
+                                        * domain ids are 16 bit wide 
according
+                                        * to VT-d spec, section 9.3 */
  };


> 
>> +	spin_lock(&iommu->lock);
>> +	curr = xa_load(&domain->iommu_array, iommu->seq_id);
>> +	if (curr) {
>> +		curr->refcnt++;
>> +		kfree(info);
>> +		goto success;
> 
> Not a fan of adding a label for success. Just putting two lines (unlock+
> return) here is clearer.

Updated.

> 
>> +	ret = xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
>> +			      info, GFP_ATOMIC));
> 
> check xa_err in separate line.

Sure. Updated as below:

@@ -1778,13 +1780,14 @@ static int domain_attach_iommu(struct 
dmar_domain *domain,
         info->did       = num;
         info->iommu     = iommu;
         domain->nid     = iommu->node;
-       ret = xa_err(xa_store(&domain->iommu_array, iommu->seq_id,
-                             info, GFP_ATOMIC));
-       if (ret)
+       curr = xa_cmpxchg(&domain->iommu_array, iommu->seq_id,
+                         NULL, info, GFP_ATOMIC);
+       if (curr) {
+               ret = xa_err(curr) ? : -EBUSY;
                 goto err_clear;
+       }
         domain_update_iommu_cap(domain);

> 
>>
>>   static void domain_detach_iommu(struct dmar_domain *domain,
>>   				struct intel_iommu *iommu)
>>   {
>> -	int num;
>> +	struct iommu_domain_info *info;
>>
>>   	spin_lock(&iommu->lock);
>> -	domain->iommu_refcnt[iommu->seq_id] -= 1;
>> -	if (domain->iommu_refcnt[iommu->seq_id] == 0) {
>> -		num = domain->iommu_did[iommu->seq_id];
>> -		clear_bit(num, iommu->domain_ids);
>> +	info = xa_load(&domain->iommu_array, iommu->seq_id);
>> +	if (--info->refcnt == 0) {
>> +		clear_bit(info->did, iommu->domain_ids);
>> +		xa_erase(&domain->iommu_array, iommu->seq_id);
>>   		domain_update_iommu_cap(domain);
>> -		domain->iommu_did[iommu->seq_id] = 0;
>> +		kfree(info);
> 
> domain->nid may still point to the node of the removed iommu.

Good catch! I should assign it to NUMA_NO_NODE, so that it could be
updated in the next domain_update_iommu_cap(). Updated as below:

@@ -1806,6 +1809,7 @@ static void domain_detach_iommu(struct dmar_domain 
*domain,
         if (--info->refcnt == 0) {
                 clear_bit(info->did, iommu->domain_ids);
                 xa_erase(&domain->iommu_array, iommu->seq_id);
+               domain->nid = NUMA_NO_NODE;
                 domain_update_iommu_cap(domain);
                 kfree(info);
         }

Best regards,
baolu
