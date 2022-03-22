Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F924E3832
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 06:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbiCVFEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 01:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiCVFEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 01:04:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5B167E3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 22:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647925405; x=1679461405;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=9uqPM+FOjSZGcrtq3DsRrRPnxlYdv1cSjJxdC+pFnns=;
  b=frr4OiR9KcVGxYtDeg5f3GJ70a1K6xZ8s/bhqoi4DEPSDE2U8V1FP7Xq
   52G7HYLwG9IP+8qxbXnEJxC7350bGZCunTN38Ejx3jRZxDLlUntBZ/3qP
   TNiMQc0KIKjZZMD0f+6LPLr707LZY9UgzKoVkVNXDZgofg5Vq/IQxiP/9
   XvvQI9Ty6Gc20Dr7jQ6AWPnPt53ZAZW5Yh8hLp9dv8VAs86E9FlRF1E2O
   vIvQ+JLK0qCDW14jGqCJrh4QpTo2fDhGiNFSwchhix0094RFfua54dW5Z
   JQOKpzxv7oW6o+cWGUjz7bEiuzwWddO9O10sy4HJ4ioUaXB+VN730crz3
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="238328222"
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="238328222"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:03:22 -0700
X-IronPort-AV: E=Sophos;i="5.90,200,1643702400"; 
   d="scan'208";a="518728164"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.186]) ([10.254.209.186])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 22:03:17 -0700
Message-ID: <64fa931b-ea2d-f425-5baa-654216bac779@linux.intel.com>
Date:   Tue, 22 Mar 2022 13:03:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica> <20220321124346.GP11336@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
In-Reply-To: <20220321124346.GP11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/21 20:43, Jason Gunthorpe wrote:
> On Mon, Mar 21, 2022 at 11:42:16AM +0000, Jean-Philippe Brucker wrote:
> 
>> I tend to disagree with that last part. The fault is caused by a specific
>> device accessing shared page tables. We should keep that device
>> information throughout the fault handling, so that we can report it to the
>> driver when things go wrong.
> SVA faults should never be reported to drivers??
> 

When things go wrong, the corresponding response code will be responded
to the device through iommu_page_response(). The hardware should then
report the failure to the device driver and the device driver will
handle it in the device-specific way. There's no need to propagate the
I/O page faults to the device driver in any case. Do I understand it
right?

Best regards,
baolu
