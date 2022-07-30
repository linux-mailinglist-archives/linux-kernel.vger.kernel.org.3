Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC735858D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 08:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbiG3GXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 02:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiG3GXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 02:23:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B20343E45
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659162201; x=1690698201;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jJgGhh4GtN+6tyytNQDWb6gnYAcLWIHEmVqW7XXkpeQ=;
  b=ma+U2lzsaG2U04yvroMTSdTUrLVsjsBcQoXTe1XhOJQREAfqITqAox4X
   CkSfKKDU0OsPTQRG2XxmKW88oVBxaT0zRPb3kc/uv93qQNPNDeVVxkCA/
   Dhl98+hYFO4iMZFSaeb5+OTk42EKcxBtU4UbBZeUuYSIuNDK2IR8VU98s
   Wtzbg8iUTRWH2Odc/cLE1dwQwUQFxgoyZVxecK+oXOysTrEtVGfT/N5uk
   z0MF83S/V3uzX41PB5jbLNf72r2vrNWYYFl7G2UZBET7/z05V+/gcesya
   090w+6PqddpQQgxeYDHxopJN/bejAC183DT/b5DzyC7W0ctaIi8Y4xRuc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="289664853"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="289664853"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:23:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="660517319"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.210.174]) ([10.254.210.174])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 23:23:16 -0700
Message-ID: <f1908476-8f83-5467-9172-ec0b7838e67a@linux.intel.com>
Date:   Sat, 30 Jul 2022 14:23:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        "Zhu, Tony" <tony.zhu@intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
References: <20220723141118.GD79279@nvidia.com>
 <686b137f-232a-2a78-beb0-e4373bd20959@linux.intel.com>
 <20220725144005.GE3747@nvidia.com>
 <6da27a6b-b580-4ba4-24c8-ebdfb2d9345d@linux.intel.com>
 <20220726135722.GC4438@nvidia.com>
 <BN9PR11MB5276974ABA5981A7361953708C979@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220727115339.GM4438@nvidia.com>
 <BN9PR11MB52766C3D37FA985DEBDC30C78C969@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuJ6MXoNTj0RKCb8@nvidia.com>
 <BN9PR11MB52764B2B1B429ECDA0410D558C999@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YuPQ6om0gELPqoiu@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YuPQ6om0gELPqoiu@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/29 20:22, Jason Gunthorpe wrote:
> The RID issue is that we can't reliably tell the source apart in a
> group - so all the RIDs in a group have to be considered as the same
> RID, and mapped to the same PASID table.
> 
> But that is the only restriction of a group we have left, because the
> 'iommu doesn't isolate all traffic' restriction is defined not to
> exist if PASID is supported.

Get you. Thank you for the guide.

> 
>> So yes, from this angle leaving one table per group is a simpler
>> thing to do, especially when it's unclear whether there is real
>> demand to enable PASID for multi-device group. 😊
> Except it is confusing, complicated and unnecessary. Treating PASID of
> multi-device groups the same as everything else is logically simple.

Yes. Considering that current PASID use cases occur only on singleton
groups, to make things simple, let's start our PASID attachment support
simply from singleton groups.

Best regards,
baolu
