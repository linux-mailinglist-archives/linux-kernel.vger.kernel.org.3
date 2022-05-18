Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C616A52B2B2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 08:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiERGnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiERGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:43:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FE41DA68
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652856218; x=1684392218;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9qTYvzKhlcHrIU1CsQee+xTk+1GmejCy5sboiPMyNu8=;
  b=c6jXV0MqROdKfTJOZIhttS3fCFSBh9k245kPGHsV/Vr+H3X5JOIMTc5R
   AuLny34tlYLrWtLWc66Lboa2g79bQXk3TxaLNogkMnPc8lfXzIpWL5l6T
   Y0sd7l+pe0lziQSo1M1RAEGLqSzyV2I6MWwCzUFdojnlq/mhgTtj1g1l4
   uaxLehzV4H+IACPXZRymzvEky9UuQeL+yA1US0AP/zEge+qxaxrRRo+Gc
   rCqFhBxdTBpq+0c+0dgSAyNP4dO0gXicyL3Slmi97Y0WgBbXPWfsgWZ7/
   796raycPwX8XhVQ/JyQzBByyEZy9befvG9SOelKSNtSZ6jfKFY64FtSm0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="252028337"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="252028337"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:43:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="545283301"
Received: from lenawanx-mobl.ccr.corp.intel.com (HELO [10.255.28.87]) ([10.255.28.87])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 23:43:35 -0700
Message-ID: <7fcd6f05-2a05-7dd3-3668-c1f45ee5e024@linux.intel.com>
Date:   Wed, 18 May 2022 14:43:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <8a0fc6cf-f46e-f17e-2b76-099ada1683c3@arm.com>
 <20220516135741.GV1343366@nvidia.com>
 <c8492b29-bc27-ae12-d5c4-9fbbc797e310@linux.intel.com>
 <f971aea9-8ae1-95f8-b10a-cd77e9704dc0@arm.com>
 <20220517131324.GU1343366@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220517131324.GU1343366@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/17 21:13, Jason Gunthorpe wrote:
> On Tue, May 17, 2022 at 01:43:03PM +0100, Robin Murphy wrote:
> 
>> FWIW from my point of view I'm happy with having a .detach_dev_pasid op
>> meaning implicitly-blocked access for now.
> 
> If this is the path then lets not call it attach/detach
> please. 'set_dev_pasid' and 'set_dev_blocking_pasid' are clearer
> names.

Sure. And with the blocking domain implemented, the
set_dev_blocking_pasid could be deprecated.

> 
>> On SMMUv3, PASIDs don't mix with our current notion of
>> IOMMU_DOMAIN_IDENTITY (nor the potential one for
>> IOMMU_DOMAIN_BLOCKED), so giving PASIDs functional symmetry with
>> devices would need significantly more work anyway.
> 
> There is no extra work in the driver, beyond SMMU having to implement
> a blocking domain. The blocking domain's set_dev_pasid op simply is
> whatever set_dev_blocking_pasid would have done on the unmanaged
> domain.
> 
> identity doesn't come into this, identity domains should have a NULL
> set_dev_pasid op if the driver can't support using it on a PASID.
> 
> IMHO blocking_domain->ops->set_dev_pasid() is just a more logical name
> than domain->ops->set_dev_blocking_pasid() - especially since VFIO
> would like drivers to implement blocking domain anyhow.

Perhaps implementing blocking domains for intel and smmuv3 iommu drivers
seem to be a more practical start.

Best regards,
baolu
