Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A406255ADF1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 03:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiFZBPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 21:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbiFZBPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 21:15:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5BA12AF3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 18:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656206148; x=1687742148;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kWtrTWhVygy80koAHRds8cQZJGpxEZcR9U+1akiF+8M=;
  b=HDjpzqj6QANXn5GW+P1oUlevgdEiDrhRAhRSm5dCDGdPPIjm8ZyH3nb4
   prwJsmHmMBaA+Fs6mRXbtiGJiOmvDwEtkmocsZnK3CxolkSQdZOGJeJve
   cEC7cffuySqETMpNJEFJNw3rx9AAr3s3NJSqu/p98Ny+aECpJaSU7Bamc
   lu6cVWGtrTu5ouYziWsUK2gO6duM8F5EFgkUklTqU3PXuGjMCelrFBYMU
   6WR/kgxPewLbNMnii+dYhLZyQGYCqdFOQX7CxtFU/q3k5cmloyZ3TMHXd
   hry3iqLQ34vlnzqeDNsqoSOEb3UQsVFNTx7mYVHVkribnSchDWyTJ45f+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="261042498"
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="261042498"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:15:48 -0700
X-IronPort-AV: E=Sophos;i="5.92,223,1650956400"; 
   d="scan'208";a="645839129"
Received: from jzhu26-mobl1.ccr.corp.intel.com (HELO [10.249.168.26]) ([10.249.168.26])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 18:15:44 -0700
Message-ID: <068df2f5-1e14-8249-ac14-55864e6a4488@linux.intel.com>
Date:   Sun, 26 Jun 2022 09:15:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 00/11] iommu: SVA and IOPF refactoring
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220621144353.17547-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On 2022/6/21 22:43, Lu Baolu wrote:
> Hi folks,
> 
> The former part of this series refactors the IOMMU SVA code by assigning
> an SVA type of iommu_domain to a shared virtual address and replacing
> sva_bind/unbind iommu ops with set/block_dev_pasid domain ops.
> 
> The latter part changes the existing I/O page fault handling framework
> from only serving SVA to a generic one. Any driver or component could
> handle the I/O page faults for its domain in its own way by installing
> an I/O page fault handler.
> 
> This series has been functionally tested on an x86 machine and compile
> tested for all architectures.
> 
> This series is also available on github:
> [2]https://github.com/LuBaolu/intel-iommu/commits/iommu-sva-refactoring-v9
> 
> Please review and suggest.

Just a gentle ping on this series.

Do you have further inputs? I am trying to see if we can merge this
series for v5.20. The drivers also depend on it to enable their kernel
DMA with PASID.

Sorry to disturb you.

Best regards,
baolu
