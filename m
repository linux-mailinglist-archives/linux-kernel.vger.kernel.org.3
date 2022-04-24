Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FC850CF71
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiDXEkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiDXEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:40:47 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4CABE04
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650775068; x=1682311068;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HAFqm/cKTB4j4+tV4YQ9J7Ui8jD83jhADG6UUK2gF68=;
  b=U8WlFTvF8czbZEyPF8M3gX6I1ti8+UJJjwQUSBDlrNSp5yHufABAEfY2
   8Jc3LyRSRgl0Cwgk7rIUGvt8gBByGwToe3ysS79V4EfTzbZxomUc4o53z
   eU5Zi29+Z4bycOv3nCZ8OT1pA4JOIoa6FLra8mSA944Jcrlz4cp1r5lFX
   pdjC4rJ352BnFAfIzf03MCzHKJSFYJ3w4MqZiz1TJepuZaHNJ7ebtaY5O
   w/r130Vxvi3issudIsDYCQxLmV+J5ges5DT4HZQEl+ihSDZ8emlBpAL2/
   hIFmULDKAIR78IXaAzSf+tm3l6gMRUcFZouOilhs5x5bHu7TEORfQcacu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="244922575"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="244922575"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:37:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="578658846"
Received: from yzhou56-mobl2.ccr.corp.intel.com (HELO [10.249.173.202]) ([10.249.173.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 21:37:46 -0700
Message-ID: <4b2cd2a7-d715-882c-9cce-533dcff8bc79@linux.intel.com>
Date:   Sun, 24 Apr 2022 12:37:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/4] iommu/vt-d: Check before setting PGSNP bit in
 pasid table entry
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52767A16DC6BB80838C876068CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
 <503795b0-282c-2a8a-b669-5e7a0fc4a696@linux.intel.com>
 <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52766E90CF544C2B00F364008CF99@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/24 11:37, Tian, Kevin wrote:
>>> This should be rebased on top of Jason's enforce coherency series
>>> instead of blindly setting it. No matter whether it's legacy mode
>>> where we set SNP in PTE or scalable mode where we set PGSNP
>>> in PASID entry for entire page table, the trigger point should be
>>> same i.e. when someone calls enforce_cache_coherency().
>> With Jason's enforce coherency series merged, we even don't need to set
>> PGSNP bit of a pasid entry for second level translation. 2nd level
>> always supports SNP in PTEs, so set PGSNP in pasid table entry is
>> unnecessary.
>>
> Yes, this sounds correct for 2nd-level.
> 
> but setting PGSNP of 1st level translation is also relevant to that
> change when talking about enforcing coherency in the guest. In
> this case PASID_FLAG_PAGE_SNOOP should be set also after
> enforce_cache_coherency() is called.

Yes. Agreed.

> Currently it's always set for unmanaged domain in
> domain_setup_first_level():
> 
> 	if (domain->domain.type == IOMMU_DOMAIN_UNMANAGED)
> 		flags |= PASID_FLAG_PAGE_SNOOP;
> 
> Suppose we need a separate interface to update PGSNP after pasid
> entry is set up.

Currently enforcing coherency is only used in VFIO. In the VFIO use
case, it's safe to always set PGSNP when an UNMANAGED domain is attached
on the first level pasid translation. We could add support of updating
PGSNP after pasid entry setup once there's a real need.

Best regards,
baolu
