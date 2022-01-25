Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0519E49A8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320542AbiAYDNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:13:16 -0500
Received: from mga04.intel.com ([192.55.52.120]:38508 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1381285AbiAYDAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643079644; x=1674615644;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=hcjXanRyyzUabhBOjDATgrq+wFYZUEv0LZVR5v+RCiM=;
  b=WMt64R1HH3cQvA1FW2Xnmp6sdqYJxAwyImTvxQS3lNi+SabtULNESSDQ
   2PT7IAF8NOP93DbdVKOvNcA+B3Epuy+Huh0UKeb3vI0P64zPIKFiFdKG0
   8LCexSdDqS9Z7EFznoSF6t7xRmbHhOMDaJYuNTl2/o5O+6ud87/af+hg3
   DXT8IGM5RCf3r7AZlYvOLKNiIIgoTBtKJlyESbwqPHRXPKyh2pce8nK0r
   I0239VzXjhODGQrX9ZevfhDGffM9c7niaOKwkWfNOrRClPByGImXDc0zg
   Pr2DaAEpcbvfIRMyc8tZZap2+VkdHnsVSIYrLovujBKANTquVGB3XoDps
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="245039202"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="245039202"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534530804"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:00:34 -0800
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] drm/nouveau/device: Get right pgsize_bitmap of
 iommu_domain
To:     Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-6-baolu.lu@linux.intel.com>
 <Ye5xlSbwAw5JJ8k2@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5977c231-fbd3-ac26-ff13-94ed7a08f347@linux.intel.com>
Date:   Tue, 25 Jan 2022 10:59:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5xlSbwAw5JJ8k2@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 5:29 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:00PM +0800, Lu Baolu wrote:
>> The supported page sizes of an iommu_domain are saved in the pgsize_bitmap
>> field. Retrieve the value from the right place.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
>> Link: https://lore.kernel.org/r/20211218074546.1772553-1-baolu.lu@linux.intel.com
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Wouldn't it mke sense to remove the pgsize_bitmap in struct iommu_ops
> and initialize the domain field in the domain_alloc methods?  Or am I
> missing something?
> 

It looks reasonable to me. The pgsize_bitmap is an attribute of a domain
that provides the map/unmap interfaces. It could be moved out of the
iommu_ops structure.

Best regards,
baolu
