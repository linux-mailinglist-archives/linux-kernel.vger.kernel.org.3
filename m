Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2607B4EC321
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbiC3MV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345624AbiC3MEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:04:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364D631926
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648641484; x=1680177484;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=i6d3OM34X008YLrBdwkzSuCTCJAwJAXcn3nAL1SIlvQ=;
  b=ZY8wP35zCgRuGkvMJqgM7D1h4b1tLvKI72IlqXeX+huQ96qu99prfav0
   BrSE0dE66fvvQg5zWEWggtKhLayk8dRxDKE3sHzGtdN4/pe/NkyVWYP3u
   IfCpkHHo5x0tENSFWQ8K7oJgO17kkCBr4IvGJ8wrAm5BQ92NohRzMdwhY
   SCCFvQFmeMgYKntsGcvU+Cf09SEt6l1lEVm4lMrA0pwAVWPhcmKuVVnlH
   bkjLP31gYoIC9tqDHxS4TJb5lyaxOUfvSo4Ya3U3pzegHYRh28PPniV8r
   9VuTMfk61EIqtxdx5YYalRy7xCCmmZYJWekpizH6AUiYNq2o2hkFrcTxT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239453975"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="239453975"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:58:03 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565505227"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.120]) ([10.254.215.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:57:59 -0700
Message-ID: <f52d0412-a88c-6c07-1b40-ff866b288641@linux.intel.com>
Date:   Wed, 30 Mar 2022 19:57:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
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
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-3-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F455B3319789BAB1E0E8C1E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220329114259.GB1716663@nvidia.com>
 <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH RFC v2 02/11] iommu: Add iommu_group_singleton_lockdown()
In-Reply-To: <BN9PR11MB5276239993592FF808726EF68C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On 2022/3/30 14:50, Tian, Kevin wrote:
>> ie if we have a singleton group that doesn't have ACS and someone
>> hotplugs in another device on a bridge, then our SVA is completely
>> broken and we get data corruption.
> Can we capture that in iommu_probe_device() when identifying
> the group which the probed device will be added to has already been
> locked down for SVA? i.e. make iommu_group_singleton_lockdown()
> in this patch to lock down the fact of singleton group instead of
> the fact of singleton driver...
> 

The iommu_probe_device() is called in the bus notifier callback. It has
no way to stop the probe of the device. Unless we could add a direct
call in the device probe path of the driver core?

Best regards,
baolu
