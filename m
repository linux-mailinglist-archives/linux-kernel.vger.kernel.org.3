Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0B057F2B9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 05:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiGXC7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 22:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiGXC7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 22:59:39 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0B13F8C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 19:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658631578; x=1690167578;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tu+rlCbzZUYmb39RdyQ4XYT1JbhjzZ6xE7dWDudpVkc=;
  b=hfng02PpR8htaOKrRSK8DOE/v9U6zJhPd/hzyrdXdKNC9Tubq9GnGq6a
   UqnEdX/RqCIwLduZ4h3FXD67vinos8Mhauk18ywm8yhwdWNwczYM6A35a
   ndJ321FC2pY+a8yY5UfMKCB7wlyiP7xC+AgYFNtMJWQ+hC29/kz37ZfIO
   gdBP3YvOvqKXZw3r2atBy641TWU78Uw4LutFgFip5PB4hDJSWa8JeibCy
   kx4py09/gagN2Srugfq4FGlKkvJITxAMufGciEpahzZNWYeIDATvTwhM4
   Nrx5gogtSOAKowo2vBw1m4jhn/vDkPgk1y0QE06yGGYVal4k68QXsyfnP
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10417"; a="270545561"
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="270545561"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 19:59:38 -0700
X-IronPort-AV: E=Sophos;i="5.93,189,1654585200"; 
   d="scan'208";a="657692682"
Received: from zjiang1-mobl.ccr.corp.intel.com (HELO [10.249.170.155]) ([10.249.170.155])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2022 19:59:36 -0700
Message-ID: <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
Date:   Sun, 24 Jul 2022 10:59:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/7/21 15:39, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, July 19, 2022 7:53 AM
>>
>> @@ -88,7 +89,8 @@ extern struct list_head dmar_drhd_units;
>>   static inline bool dmar_rcu_check(void)
>>   {
>>   	return rwsem_is_locked(&dmar_global_lock) ||
>> -	       system_state == SYSTEM_BOOTING;
>> +	       system_state == SYSTEM_BOOTING ||
>> +	       (IS_ENABLED(CONFIG_INTEL_IOMMU)
>> && !intel_iommu_enabled);
>>   }
> 
> intel_iommu_enabled is 0 if CONFIG_INTEL_IOMMU is not set.
> 
> same for other similar checks.

Sorry that I didn't get your point. If CONFIG_INTEL_IOMMU is not set,
IS_ENABLED(CONFIG_INTEL_IOMMU) is 0. The adding check has no effect. Did
I miss anything?

Best regards,
baolu

