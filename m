Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B453A2D3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 12:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbiFAKiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 06:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347833AbiFAKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 06:38:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0493B7CDE5
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 03:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654079929; x=1685615929;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mtwSjzvzSsj5uNAepvv6xKBLP1QaTB74LPqp4GVeXMY=;
  b=bAazwDlJkPeVWRv/vU2J95vqCcuhiv050I09U1BUruODAUhYi6ig7qXb
   ZfTldbcTDbLrr51OUZu3Ra/B3matimcfdwwA6EJ25f1oDvZg0Cu7FE5ko
   15Jma6ZlBpOzj6f37wvJ+15wk+VSRAZfYwtB4ttNkTLyTORbUZmXxGaV2
   wPVsIEFrEaN5MPH2XLuNoIIK+XR/mho2iIV/ItOy+HxtAUlI77bA4T9lu
   hwtbFyKvz/WIG5j0mNN3vvfNXg4ikVeb06dZg/zHLx5Bc28tr4IZHBxN0
   kSoYNwVHs5qDcLdqg4B80Lu/+d22RGGEnECoQqWiRBP/co8soyGcK4jP0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="300896418"
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="300896418"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:38:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,268,1647327600"; 
   d="scan'208";a="707001500"
Received: from hej1-mobl.ccr.corp.intel.com (HELO [10.255.28.123]) ([10.255.28.123])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 03:38:46 -0700
Message-ID: <369bf961-d5e5-998f-542d-f90bc4c6cb28@linux.intel.com>
Date:   Wed, 1 Jun 2022 18:38:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/12] iommu/vt-d: Acquiring lock in domain ID allocation
 helpers
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220527063019.3112905-1-baolu.lu@linux.intel.com>
 <20220527063019.3112905-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52760F17D3B9359EB4BB2B7B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB52760F17D3B9359EB4BB2B7B8CDF9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

Thank you for the comments.

On 2022/6/1 17:09, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Friday, May 27, 2022 2:30 PM
>>
>> The iommu->lock is used to protect the per-IOMMU domain ID resource.
>> Move the spinlock acquisition/release into the helpers where domain
>> IDs are allocated and freed. The device_domain_lock is irrelevant to
>> domain ID resources, remove its assertion as well.
> while moving the lock you also replace spin_lock_irqsave() with spin_lock().
> It'd be cleaner to just do movement here and then replace all _irqsave()
> in patch 8.

Yeah, that will be clearer.

Best regards,
baolu
