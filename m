Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ABC7585F20
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiGaNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiGaNda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 09:33:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD88B874
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 06:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659274409; x=1690810409;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L128BTCkAu3V8yEsnQdkBwexWdo++stpksb66pAAfVo=;
  b=cMJ0kZYoZw3Zq0Ji1ZF2L5Fn7EamdcDv+M+NQ/ynnCeb2NYJ6Ih2v1yR
   z58NrYTwe21NZPDCxTPnqguVFhGYImDOfoUo8L/NkBA+OnCnvXPZ7vKf+
   h7rKkEVpQaJcA6qwF/yw7VPE1TXoUQ2E397u1dw+D44KrNgtzwOazp7dy
   CfWc9Kc+NjiAIaaaSrTXvfTFb28RbsKcQFCArfEjO/dCZ1e/x/2jnQd8K
   k+2wmqDF8vqlhr3tgmO19sM1T+t2TotH+WhQDDt706ppGjrkBqQOTogle
   m145x+JLZJKzmgHzi7MbQPKxtZva6zd0LORzceR3tUaQdQjy/gtVxmFfv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10425"; a="269377763"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="269377763"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:33:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="629930609"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.191]) ([10.254.208.191])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 06:33:24 -0700
Message-ID: <31134c57-8f2c-d5a9-20d3-1c089a6ff58f@linux.intel.com>
Date:   Sun, 31 Jul 2022 21:33:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 01/12] iommu: Add max_pasids field in struct
 iommu_device
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
 <20220705050710.2887204-2-baolu.lu@linux.intel.com>
 <a837d035-1897-99f1-03e5-0d02ab9f2b4f@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <a837d035-1897-99f1-03e5-0d02ab9f2b4f@intel.com>
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

Hi Yi,

Thanks for reviewing my series.

On 2022/7/31 19:54, Yi Liu wrote:
> On 2022/7/5 13:06, Lu Baolu wrote:
>> Use this field to keep the number of supported PASIDs that an IOMMU
>> hardware is able to support. This is a generic attribute of an IOMMU
> 
> a nit. it should be the max pasid value an IOMMU hardware can support
> instead of number of PASIDs. right?

More accurately, it's maximum number of PASIDs supported by IOMMU
hardware".

Best regards,
baolu
