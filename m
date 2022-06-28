Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263EC55D1E8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245173AbiF1FrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245183AbiF1FrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:47:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922F6275EB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 22:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656395206; x=1687931206;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TGG80vJaDllAevuk4S1BcXyz1JoWpznRrkuX2d/Mvkc=;
  b=VCp6/A/FmmlQzKWNDek3uEExQgk51zPV7NNqDNvBmF/TKSVxMlxnq0Tb
   nspmgEciRSvabzWzQp1QbAsWRcDmy2m2EA65rmOx3t9rUkLDr3J4oMQxw
   q01MUaw9rPPC9sc43Ui5mSGvVCUSY3WvRTalj/NPdvcJpF47rgdc8xLm5
   CYCul0rNylFd/WeUV5zNpTZhKsVSA3bGqNZoWC+3ApXXsYh2mcB+KVbqn
   zsh4r5HY77z4FUgbnBiUd/yahQqidbn5ALuf129Y7kOLpOMwgEiANkD4R
   9jEpkrYz6utOYiZxi++r8urcPFLnMD+XjqlI8EPfj0VWu5cQzJ+SQqRUm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367952872"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367952872"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:46:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646759897"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 22:46:34 -0700
Message-ID: <14fa06b8-e361-db68-8fe4-490aeb0242da@linux.intel.com>
Date:   Tue, 28 Jun 2022 13:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Jacob jun Pan <jacob.jun.pan@intel.com>
Subject: Re: [PATCH v9 06/11] arm-smmu-v3/sva: Add SVA domain support
Content-Language: en-US
To:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-7-baolu.lu@linux.intel.com>
 <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <9266198d-33fd-4cc5-fdaa-3ba5571543b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/27 19:50, Zhangfei Gao wrote:
> 
> On 2022/6/21 下午10:43, Lu Baolu wrote:
>> Add support for SVA domain allocation and provide an SVA-specific
>> iommu_domain_ops.
>>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Have tested the series on aarch64.

Thank you very much! Very appreciated for your help!

Best regards,
baolu
