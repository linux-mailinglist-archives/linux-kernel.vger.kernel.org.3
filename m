Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2401B54A84F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 06:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiFNEsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 00:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbiFNEsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 00:48:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D831534
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 21:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655182090; x=1686718090;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WNnlhhRpKdqwqyAN58id52IIA5QPWLuUwmueWv7fjlE=;
  b=lgMWPtyZKLhRwsEPlgzgbimrlL/lFXA52aJveyWkYTnFrgCjYhd4DDDQ
   dbWIpZVSo8FWG1IxDA1kQKXnSrtMQ0c+9oG55SFJAWBCWEsX8ykQFG3TV
   H8NVyMF2wfEvR4amEqyGjwokAy1NKkpYqcePEofSj84LSNuIfrTROMvji
   0497HBLnqD15do7EFzq9Ws8i+SLZ7lTYdCO3KJZjmSdAZMdlfiTWv/9mm
   4C97/VG6Kr17+WMpf5FjjxCxArso5DoVi7zR1IDh1bvACgD3ULls/Z+Vh
   fc+rL5sZkBuJfbdy7Q72FLtnv7DqjF7ddpoLe+RcT9kVC551J6vNGSCRV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="261537115"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="261537115"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:48:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="910765884"
Received: from gren5-mobl1.ccr.corp.intel.com (HELO [10.255.29.39]) ([10.255.29.39])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 21:48:08 -0700
Message-ID: <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
Date:   Tue, 14 Jun 2022 12:48:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/14 12:02, Tian, Kevin wrote:
>> From: Lu Baolu <baolu.lu@linux.intel.com>
>> Sent: Tuesday, June 14, 2022 11:44 AM
>>
>> This allows the upper layers to set a domain to a PASID of a device
>> if the PASID feature is supported by the IOMMU hardware. The typical
>> use cases are, for example, kernel DMA with PASID and hardware
>> assisted mediated device drivers.
>>
> 
> why is it not part of the series for those use cases? There is no consumer
> of added callbacks in this patch...

It could be. I just wanted to maintain the integrity of Intel IOMMU
driver implementation.

> 
>> +/* PCI domain-subdevice relationship */
>> +struct subdev_domain_info {
>> +	struct list_head link_domain;	/* link to domain siblings */
>> +	struct device *dev;		/* physical device derived from */
>> +	ioasid_t pasid;			/* PASID on physical device */
>> +};
>> +
> 
> It's not subdev. Just dev+pasid in iommu's context.

How about struct device_pasid_info?

Best regards,
baolu

