Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8E49A8CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320873AbiAYDPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:15:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:63761 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1318491AbiAYDGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:06:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643079962; x=1674615962;
  h=cc:subject:to:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=by9ZO+ZTDaK468UmSn4Yi/q3n6O9rPWIIHQ/Z6V2Pus=;
  b=V1sZsfiyN8T4D944xM4WGXhYmpEpZDUx1MqHjV+E8/dhd55TXlVZnezd
   IaWQA+xtkppwDTeO2pcMY+va2psU4czhhIk5WwyLELn4KoVy/u9s7c92h
   I6IHjDsNboQq8SfJ5jiWUV0JLRgNopb8jZ+0urexY1eRu+3b36iVKmsgc
   Ku5idTD8/91QNevRrQvGrnrf2Hs3/QG74B0tce8sZmNUOsei+e7ANeZRY
   LyyEIPj6/wpy/w3eyYf8gFEJduryPxBDTkhdyKExBwtiiLJKDwpo7Mf4F
   Qjm6fhxHOv74kjHDHEE9iWKV9BswPxVO7T85ezbJWOW33E6GFgvtxITzN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="270647151"
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="270647151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 19:02:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,313,1635231600"; 
   d="scan'208";a="534531392"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2022 19:02:03 -0800
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
Subject: Re: [PATCH 6/7] iommu: Use right way to retrieve iommu_ops
To:     Christoph Hellwig <hch@infradead.org>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <20220124071103.2097118-7-baolu.lu@linux.intel.com>
 <Ye5yHejpaAnJQYeR@infradead.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f59b5cf7-0275-b979-1d57-a629fd81450a@linux.intel.com>
Date:   Tue, 25 Jan 2022 11:01:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ye5yHejpaAnJQYeR@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/22 5:32 PM, Christoph Hellwig wrote:
> On Mon, Jan 24, 2022 at 03:11:01PM +0800, Lu Baolu wrote:
>> The common iommu_ops is hooked to both device and domain. When a helper
>> has both device and domain pointer, the way to get the iommu_ops looks
>> messy in iommu core. This sorts out the way to get iommu_ops. The device
>> related helpers go through device pointer, while the domain related ones
>> go through domain pointer.
> 
> Ugg. This really sounds like we should have a different structures for
> each set of ops?
>

Yes. Do this in the following patch.

Best regards,
baolu
