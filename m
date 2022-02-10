Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10FE84B02C4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 03:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbiBJCAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 21:00:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbiBJB7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 20:59:20 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8172BB0A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 17:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644457748; x=1675993748;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=A1arXDdvviAbJmFHB0JiZO8bM7BMFQsEYKo+h0boyLo=;
  b=FiYj4PBKlEb7PaQUxDrL13qDVvEbPRDti4Mzgsjkvy6w77u2q/KSbuoB
   s1ruyLif2giCPHdhWmqiQAxvri5x7dBDnWxbq7xMXvOiplESPv2ZfEa0V
   RZdz2BKJqE/K70EnUZAgHghX5C505nBpPZG4dywmLXhiAtiKYA4FubXYM
   4XgYXijLDJNTfkSQmOs3BuKac5uPgi4i/vla5BqjBPAwRHixvzonT/s36
   PAbf49HnmzjPR1hAPQbMet6J3lLtFTPWWtvMRRmoMDIXQES6xttUyuty2
   NxNYemmzAlYIyjYoP7aeJU7ykYin7fEDO3GJAVneRB5m2vF8RpUeDbnS5
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="249585930"
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="249585930"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 16:45:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,357,1635231600"; 
   d="scan'208";a="678966591"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2022 16:45:46 -0800
Message-ID: <b83e4324-6ef8-1cf0-b5e2-00d0802a6f75@linux.intel.com>
Date:   Thu, 10 Feb 2022 08:44:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 02/10] iommu: Remove guest pasid related interfaces and
 definitions
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-3-baolu.lu@linux.intel.com>
 <20220209132954.GT4160@nvidia.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <20220209132954.GT4160@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On 2/9/22 9:29 PM, Jason Gunthorpe wrote:
>> diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
>> index 59178fc229ca..65d8b0234f69 100644
>> --- a/include/uapi/linux/iommu.h
>> +++ b/include/uapi/linux/iommu.h
>> @@ -158,185 +158,4 @@ struct iommu_page_response {
>>   	__u32	code;
>>   };
> What is the plan for the rest of the dead code in this file?

The remaining code are IOMMU fault related. I can look into them in a
separated series where I plan to make the I/O page fault framework
generic.

Best regards,
baolu
