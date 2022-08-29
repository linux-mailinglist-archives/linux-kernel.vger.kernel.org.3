Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAC45A4196
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiH2Dtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiH2Dt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:49:29 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD322A955
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661744968; x=1693280968;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tRZaEf/QcV5YJ/s+KDdgO4oBY9RNOxhvC0Wp20UFThk=;
  b=EvKxgTBQxCOygXSm6K+0b9tNrDZa/WnOURH6EPxLU5I2RQf4dgK6iJiF
   RgY4VriDv17SBmstZEc8qOzSAENTladdKYPD+tGmFlMxz4XRQq805cgQS
   2JZZZeMKbbHNC1nkcniiZvTZsXz3fSinptGe0f70FirCKizJOENRDYnXw
   Yk8A3FSrtKV0D+ZnVHL2QqCs6Y4WGeLMqNbieRY9wzIPunEzSlVqycsbR
   96glROQRheN/tzwrg2WCtlMPar+tndXTsWycRsW6oUl+nY2DWGMnrZ+jO
   zQHVphq1yJMiaBfcIna8CBohjLJbjQeTAwFns6bWtURwhl2bvInHd0atl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10453"; a="292382135"
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="292382135"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:49:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,271,1654585200"; 
   d="scan'208";a="644277480"
Received: from lizhipe2-mobl.ccr.corp.intel.com (HELO [10.254.210.26]) ([10.254.210.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2022 20:49:25 -0700
Message-ID: <5cf7247a-0fa4-8dbb-d11f-8b6ef6e76ecd@linux.intel.com>
Date:   Mon, 29 Aug 2022 11:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iommu: Replace detach_dev with real blocking
 domains
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20220826123014.52709-1-baolu.lu@linux.intel.com>
 <20220826123014.52709-2-baolu.lu@linux.intel.com>
 <YwjoFXLFIGo8s2YH@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YwjoFXLFIGo8s2YH@nvidia.com>
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

On 2022/8/26 23:34, Jason Gunthorpe wrote:
> On Fri, Aug 26, 2022 at 08:30:12PM +0800, Lu Baolu wrote:
>>  From iommu core's point of view, detaching a domain from a device is
>> equal to attaching the group's blocking domain to the device. This
>> repalces all detach_dev callbacks in the IOMMU drivers with a real
>> blocking domain and handles detaching domain through it.
> 
> There is a subtly here, where detach_dev() is not *always* going to a
> blocking domain. Recall we made this mistaken when building the owner
> series and it is why the blocking domain was introduced.
> 
> The challenge with this work is to be sure that the code you assigned
> to the blocking domain doesn't actually set an identity domain or
> set things to use the platform DMA ops.

This looks like a defect in the current IOMMU subsystem.

> 
>> +static int blocking_domain_attach_dev(struct iommu_domain *_domain,
>> +				      struct device *dev)
>> +{
>> +	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>> +
>> +	s390_iommu_detach_device(domain, dev);
>> +
>> +	return 0;
>> +}
> 
> For instance, I know that this is returning the group back to the
> platform DMA ops.
> 
> To really make progress on this I would suggest
> 
> 1) Remove detach_dev from drivers that don't use it. This is any
>     driver that provides a default domain, if a default domain is set
>     then we always use attach_dev(default_domain) and never detach_dev
> 
> 2) Of those drivers in #1 audit and try to determine if their
>     detach_dev is doing blocking domain behavior and if yes give them a
>     real blocking domain. Otherwise just delete the code.
> 
> 3) The remaining drivers are not using default_domain. Rename
>     'detach_dev' to iommu_ops->set_platform_dma(dev) to make it clear
>     that what it is doing is returning control back to the platform DMA
>     ops.
> 
> I would do one patch per driver on the blocking domain conversions and
> get acks from the driver owners. Do as many as can be acked, delete
> the rest.
> 
> Make it clear to driver owners checking that blocking domain must halt
> all DMA, and it must not be a passthrough or identity behavior.
> 
> When last I looked several of the drivers looked like they were
> setting an identity domain on the detach_dev - eg back to a boot time
> behavior where the iommu is bypassed. It is really important these not
> be converted to blocking :) Arguably if they can be found they should
> be converted to identity domains instead.

Above makes sense to me. Thanks! I will spend some time looking into
each IOMMU driver and back here after I work through all of them.

Best regards,
baolu

