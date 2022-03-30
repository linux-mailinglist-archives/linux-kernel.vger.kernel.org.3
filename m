Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54CF4EC351
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243034AbiC3MUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbiC3MEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:04:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386833B54D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648641546; x=1680177546;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tANUoNzHzK67sN+dxAnpjoWCep2qpLxGxl27vY7/z0A=;
  b=XiQGN43yrNKks5dmQ8+Nv3hKXPJ4cdq1I7GOnUNSK2IT37HRX5xzvYAt
   TeEEBwN9h7qECDEe6QKyQJHt8IB0v1LIyCIZc8332NMl03bteEryeMNY3
   vUvwfpkc1sf5QCgGg19J1F4hKyI/h6J/FpUgpA+Lgg7bcp9eMv/RgCJve
   K39bIKT5gK46XjvoXwcnK5HS776Tp1f8z46CYinRkZcanM1+IPijO9vFU
   IIhVWEza0a7jvsqZu2ipKF5hMhM/8IW4Uuo4azOJaztQcYlUuAEz14jH0
   qSgIosbSFgIXylJjdzP/GdlPWofZVOUDOna76LwDmMyUp7rBH5oKwCzI7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="259239359"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="259239359"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:59:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565505459"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.215.120]) ([10.254.215.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 04:58:59 -0700
Message-ID: <d2cdd06b-bd66-a422-125c-b1b389c195de@linux.intel.com>
Date:   Wed, 30 Mar 2022 19:58:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC v2 01/11] iommu: Add pasid_bits field in struct
 dev_iommu
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
References: <20220329053800.3049561-1-baolu.lu@linux.intel.com>
 <20220329053800.3049561-2-baolu.lu@linux.intel.com>
 <BN9PR11MB52763DAEC605FD1B21EE4EAF8C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52763DAEC605FD1B21EE4EAF8C1F9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/30 15:05, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Tuesday, March 29, 2022 1:38 PM
>>
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
> Miss a clarification for non-PCI SVA as discussed here:
> 
> https://lore.kernel.org/all/85d61ad6-0cf0-ac65-3312-32d0cdeb1b27@linux.intel.com/

Yes. Thanks for the reminding.

Best regards,
baolu
