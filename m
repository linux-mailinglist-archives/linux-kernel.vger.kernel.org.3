Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B551B7F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244297AbiEEG3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbiEEG3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:29:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF4F1A049
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651731973; x=1683267973;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XCojLW+9ezVCq192dbkCy99WssFI1eBwqcSpomU98EU=;
  b=ZZx/90lBDjVSJiDDpwk8wCIgoayK/P0pjtwjtC3sXh8nDpbtcAxCTMqS
   aGCaBNDr3tfAsW8dmOcXLoBewd/1BUraEdLC9+2vRKfnmpbtSQ14l9IRK
   Li1wsQtX5d1fiuBZSQWTRNydmsO2FDIVkBRFcQYrXSIOmBLCCn+jDBvUA
   8NlhE2G+JC8sIKBTVqzHsufkB2aNH0FdIvs5pHe+5jpjLoPW0oRhXeLHp
   JevYMhUtkH5M32nHn9Yea7v3O2JKj5KZ76lw7pUujRsloIEKEb8vHsjTi
   z9qumrTOGrym4XzZsmDBPERLjrSb3P1vPUSdb/iX8fB9U2nzlMxHjjfT7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10337"; a="331001055"
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="331001055"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:25:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,200,1647327600"; 
   d="scan'208";a="563092452"
Received: from minhaowa-mobl.ccr.corp.intel.com (HELO [10.255.30.75]) ([10.255.30.75])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2022 23:25:45 -0700
Message-ID: <ab40853f-3a44-6bb8-21d4-c1f5464b030e@linux.intel.com>
Date:   Thu, 5 May 2022 14:25:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 02/12] iommu: Add pasid_bits field in struct dev_iommu
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20220502014842.991097-1-baolu.lu@linux.intel.com>
 <20220502014842.991097-3-baolu.lu@linux.intel.com> <YnFuLsvWcjjKBWNy@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YnFuLsvWcjjKBWNy@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/4 02:02, Jean-Philippe Brucker wrote:
> On Mon, May 02, 2022 at 09:48:32AM +0800, Lu Baolu wrote:
>> Use this field to save the pasid/ssid bits that a device is able to
>> support with its IOMMU hardware. It is a generic attribute of a device
>> and lifting it into the per-device dev_iommu struct makes it possible
>> to allocate a PASID for device without calls into the IOMMU drivers.
>> Any iommu driver which suports PASID related features should set this
>> field before features are enabled on the devices.
>>
>> For initialization of this field in the VT-d driver, the
>> info->pasid_supported is only set for PCI devices. So the status is
>> that non-PCI SVA hasn't been supported yet. Setting this field only for
>> PCI devices has no functional change.
>>
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker<jean-philippe@linaro.org>

Thank you! Very appreciated for reviewing my patches.

Best regards,
baolu

