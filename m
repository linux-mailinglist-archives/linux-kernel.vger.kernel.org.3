Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF07352EA74
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348330AbiETLDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348312AbiETLDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:03:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A91498DC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653044588; x=1684580588;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=64uK/wIWiSqexpwgngQnIl6DO+Ru93LCQrKFKwJZoRk=;
  b=KfAhV/ZrgZDAepWxRu41zxNeMcsjIA80VnbBjm96VSh+17JBVnKcv38q
   7Vy2AKhfGIjc1SPPWiYac1Ay47tt+UosNnc7zJTeDYhjieKHSj6cHN/az
   4pU7QG7JU2QKuk6hdb29fsAumNHp6aMApg9lQkEqNWUZ0YDIxboTvMyM4
   Tw08WZkY9ctx+9h98Dqj14kQe5WGNLQ9H37BMSaVYb4paSCxLogoPgHPT
   0ueWSjMiR1ZfmfalU8HFiZoSKXEynQsCboTg1uSGMqYSxVC4ZdKwh1QBs
   8ywTS6cfrImYHCLbO6gttN5wzPDsmNbbCy86rNuLLERNnYSi9TzKib55K
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="260157077"
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="260157077"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 04:03:07 -0700
X-IronPort-AV: E=Sophos;i="5.91,239,1647327600"; 
   d="scan'208";a="599166968"
Received: from wangyu5-mobl.ccr.corp.intel.com (HELO [10.249.172.121]) ([10.249.172.121])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 04:03:04 -0700
Message-ID: <9e786a91-6239-1fa5-cad9-f319794b6055@linux.intel.com>
Date:   Fri, 20 May 2022 19:03:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] iommu: Add blocking_domain_ops field in iommu_ops
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220516015759.2952771-1-baolu.lu@linux.intel.com>
 <20220516015759.2952771-3-baolu.lu@linux.intel.com>
 <YodVJ7ervpIdWfg+@8bytes.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YodVJ7ervpIdWfg+@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/20 16:45, Joerg Roedel wrote:
> On Mon, May 16, 2022 at 09:57:56AM +0800, Lu Baolu wrote:
>>   	const struct iommu_domain_ops *default_domain_ops;
>> +	const struct iommu_domain_ops *blocking_domain_ops;
> 
> I don't understand why extra domain-ops are needed for this. I think it
> would be more straight-forward to implement allocation of
> IOMMU_DOMAIN_BLOCKED domains in each driver and let the details be
> handled in the set_dev() call-back. The IOMMU driver can make sure DMA
> is blocked for a device when it encounters a IOMMU_DOMAIN_BLOCKED
> domain.
> 
> For IOMMUs that have no explicit way to block DMA could just use an
> unmanaged domain with an empty page-table.

Yes, this is what will go.

Best regards,
baolu

