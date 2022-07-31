Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BA5585F28
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiGaNpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiGaNpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:45:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6E06151
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659275116; x=1690811116;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xNdwAlr0T5czk0DQzyHKqrvhr3p3s9DnZNkOQ3z8kb0=;
  b=GSHmNnKDOfQBw63ROq31HdZ1dATgWMfJvx4f2+QbtInAsk4s9I7gPVNA
   LcX4z4V4zaobZ/IE2Tffl2Yy2J8i5ihYhNZfHlKWlKFeUcwQttuwizxxa
   +aBzK1n9X8GTdbdlMzr667j+Impoii36QZnXQpuObc3oh5Y1ldca+yNsJ
   dOJpiG8eR/1ICYiVG60IZG4DTRAtX7asOr4ffmZIovS5cfjVi20uAkEkN
   ZFwJuzbhaab4I8tAqZjyaP8yPEXjovCsrw60YXNpaGGalskk5H0NUu8PC
   2t3pa09RLVrz9tnZhRzjYjFXXS4gWOf8lsDZTmXJow6TfZjuPe/ywkpy+
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="290203998"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="290203998"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:45:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629932115"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.191]) ([10.254.208.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:45:11 -0700
Message-ID: <f6f58760-d352-37e1-beac-b1213e4500b0@linux.intel.com>
Date:   Sun, 31 Jul 2022 21:45:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Yi Liu <yi.l.liu@intel.com>, Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
 <7e9e61e0-bc8a-a757-a666-0a7828b7fde8@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <7e9e61e0-bc8a-a757-a666-0a7828b7fde8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/31 20:36, Yi Liu wrote:
> On 2022/7/5 13:07, Lu Baolu wrote:
>> The existing iommu SVA interfaces are implemented by calling the SVA
>> specific iommu ops provided by the IOMMU drivers. There's no need for
>> any SVA specific ops in iommu_ops vector anymore as we can achieve
>> this through the generic attach/detach_dev_pasid domain ops.
> 
> s/"attach/detach_dev_pasid"/"set/block_pasid_dev"/

Updated. By the way, as discussed, block_pasid_dev will be dropped since
the next version. It's actually setting group's blocking domain.

Best regards,
baolu
