Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63139533541
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 04:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243544AbiEYCS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 22:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbiEYCSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 22:18:24 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8775F4CD71
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 19:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653445103; x=1684981103;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=h3XPzqnp3vKIn+De9Ti6cInP3d6FFD+A7MOLgnLxZgU=;
  b=SOXIv67oxWRLebaX/GB48Ahb1llebu6ZePh1bb7/kNiDZQZMTM6Zz5VD
   jitFE05L9AGrpr4ImaQ7PCL/jByJoaPbHBAbvn5ogwbjlo6eBKkvKP1Yl
   TmuO3sHBHB4hWFQKsH0gWhY5ldn/l6xE02mT+PS7VBN/oxTecWG5dd6EC
   fDZqUMtFhpnpmbv+gEb35f8S/xh2Z5b0drIUGehUvMGgM5zI4DDSLJ7I+
   icZ8vIIA1dgP0W1ONQ+sSLOFTgmko74yqyuDixGhgd2yvuF4ID/uB9/Lc
   4+sTvLKyvHJzxjcImrJIaQhnNFMQPNWP+GMF5r3+vudHbLuwERHG4d5KE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336749397"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336749397"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:18:23 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601605960"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 19:18:17 -0700
Message-ID: <8b4b22d7-3d56-d9b7-cfef-3479001c7cf4@linux.intel.com>
Date:   Wed, 25 May 2022 10:18:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v7 03/10] iommu/sva: Add iommu_sva_domain support
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-4-baolu.lu@linux.intel.com>
 <316981d6-6b40-9e2a-09d3-b0d6f8687247@linux.intel.com>
 <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D2DFFBFB4C57FA3854798CD79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/24 17:44, Tian, Kevin wrote:
>> From: Baolu Lu <baolu.lu@linux.intel.com>
>> Sent: Monday, May 23, 2022 3:13 PM
>>> @@ -254,6 +259,7 @@ struct iommu_ops {
>>>    	int (*def_domain_type)(struct device *dev);
>>>
>>>    	const struct iommu_domain_ops *default_domain_ops;
>>> +	const struct iommu_domain_ops *sva_domain_ops;
>>
>> Per Joerg's comment in anther thread,
>>
>> https://lore.kernel.org/linux-iommu/YodVJ7ervpIdWfg+@8bytes.org/
>>
>> adding a sva_domain_ops here is not the right way to go.
>>
>> If no objection, I will make the sva domain go through the
>> generic domain_alloc/free() callbacks in the next version.
>>
> 
> suppose it's just back to what v1-v6 did which all registered the ops
> in domain_alloc() callback?

Yes.

Best regards,
baolu
