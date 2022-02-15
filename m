Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389924B6021
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiBOBsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:48:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiBOBsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:48:50 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE68B0C6E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644889720; x=1676425720;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nV7806JD+BvncEFIlyRfAtuzlBcLLqH1yrxrTkQsvYc=;
  b=eRMmXZdK0w1RGSEPjc0F3/u2rDLKxL7t8GO1Y2W/eTpZzxx1ujnNgSxt
   YdYD9iQp2MyO+LmSd73l0xqs2QSVZjVAKcl7s5gC0SFZTNFFQkswh1l6G
   pBGCwN8QvMUIMoMylIVWq8m1kuf9zkBLrZ/72/CyVJderNZONjNEx4FFV
   zEswiC0b1WQa5huAsla4Dm6/HYocVv3d44oz31NTSD50UxkrKTqpodSDJ
   KgVDcyOhptzZvpNbRi22Ni1XhS0KZyIrJed6RiZjV+Qi5vPk4F2hKUNzv
   HyORzVvRrc4tGU68qlHpZqcKue7vsqqZIen8evSagj/qaZ/v+paOYx3SS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="313501115"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="313501115"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:48:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680789537"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:48:14 -0800
Message-ID: <0dd0f4c9-37a6-0418-3f19-22c40ccc8265@linux.intel.com>
Date:   Tue, 15 Feb 2022 09:46:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
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
Subject: Re: [PATCH v3 07/10] iommu: Use right way to retrieve iommu_ops
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220214015538.2828933-1-baolu.lu@linux.intel.com>
 <20220214015538.2828933-8-baolu.lu@linux.intel.com>
 <YgpP7AhY5hd/DX/C@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpP7AhY5hd/DX/C@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 8:49 PM, Joerg Roedel wrote:
> On Mon, Feb 14, 2022 at 09:55:35AM +0800, Lu Baolu wrote:
>> +static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
>> +{
>> +	/*
>> +	 * Assume that valid ops must be installed if iommu_probe_device()
>> +	 * has succeeded. The device ops are essentially for internal use
>> +	 * within the IOMMU subsystem itself, so we should be able to trust
>> +	 * ourselves not to misuse the helper.
>> +	 */
>> +	WARN_ON(!dev || !dev->iommu || !dev->iommu->iommu_dev ||
>> +		!dev->iommu->iommu_dev->ops);
> 
> There is no need for this WARN_ON, the code will oops anyway when one of
> the pointers checked here is NULL.
> 

We really don't need to WARN_ON intermediate null pointers. But I would
argue that we could add a WARN() on null dev->iommu->iommu_dev->ops, so
that callers have no need to check the returned ops.

Best regards,
baolu
