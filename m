Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCB9550DF9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 02:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237579AbiFTAfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 20:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbiFTAfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 20:35:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9171164D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 17:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655685337; x=1687221337;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xR5ggdMBlQy29n7xKM9geifq+2JbfrLe0YAM05RfwrY=;
  b=ZCESJQTSiRwmNRFXVBLGrFe95dzRlUNi41CzjzYz0eXe2r3/HTWCcc6d
   rT1Tfjj56pQ6F2OIzEXTXgBaTIaEGOtImk2giTmprK2f/i9stnURAhQ7S
   daBFr6YDKIbPAohUS3x0hwQ3b6zoNF3EWbYJN7rb0FQsrnU/fciT0FqHB
   cOT5ajofuoPSFqKSlIlcFXK/lZ0renxF8Z20gxjXDkt8zvuWjpr42wTjy
   AJVM1STAbTWzWwmMcBkKMURVFE9iMippIMTtc6iv9736sprA273ws7ekt
   J8abQ46ZsMuRxburRP03v1pldXEfydNO6Mn5XAQ9/0evKZHXDXaZV46Om
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="343765409"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="343765409"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:35:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="832865311"
Received: from lgao7-mobl2.ccr.corp.intel.com (HELO [10.255.31.74]) ([10.255.31.74])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 17:35:33 -0700
Message-ID: <3e806c40-f190-b688-4b60-6fbf3520ff3e@linux.intel.com>
Date:   Mon, 20 Jun 2022 08:35:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 05/11] iommu/vt-d: Add SVA domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-6-baolu.lu@linux.intel.com>
 <BN9PR11MB5276F6765461543CD9D2D0D98CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276F6765461543CD9D2D0D98CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/17 15:47, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 7, 2022 9:50 AM
>>
>> +
>> +static const struct iommu_domain_ops intel_svm_domain_ops = {
>> +	.set_dev_pasid		= intel_svm_attach_dev_pasid,
>> +	.block_dev_pasid	= intel_svm_detach_dev_pasid,
>> +	.free			= intel_svm_domain_free,
>> +};
>> +
> 
> It's clearer to use set/block for intel callbacks.

Yes. That reads clearer.

--
Best regards,
baolu
