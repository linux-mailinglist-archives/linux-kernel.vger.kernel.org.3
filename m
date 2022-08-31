Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2AA5A7321
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiHaBDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbiHaBDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:03:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CD6AF499
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661907769; x=1693443769;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4g2unoSDN1ukBbO1EGZvQu17z9pHdUQ6vWbPZmoPISc=;
  b=eSxiGgIfpsRk/Q90oXLeo5gCViRQ2ixb2jwZoIfwtD2So79+Jgr0cIor
   1BmHmJiIF3hQ2YxE7RsPSoRFhq8wjZtZ1y7EYkZSjUdpPbccBSJzALr28
   gM1JPwdO5P6pHuFZluC4lHtvt7jCa5tmzUv/OVV6081HNf4Bh/2LiHhgI
   wzUK0L3jUQG4HLTVDz5fbDPqxuX5pC5wkJAe+WT9NneYvPlBJh+nUxrwq
   0EQODSGKHIYZo4Y2960yq4axjaZHxNdo7pKwIjhuR2Ghahgzg1mojWBFo
   VDiggp4tRAvPBOGSpaY2+GZ/OkDkhjrGrgskIYu/qjJ2Hzew8jMGIxKrH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="275744292"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="275744292"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:02:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="608040973"
Received: from allen-box.sh.intel.com (HELO [10.239.159.48]) ([10.239.159.48])
  by orsmga007.jf.intel.com with ESMTP; 30 Aug 2022 18:02:35 -0700
Message-ID: <3aa28716-9d91-321a-0e52-58ae425ac598@linux.intel.com>
Date:   Wed, 31 Aug 2022 08:57:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Cc:     baolu.lu@linux.intel.com, Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 2/2] iommu: Use the user PGD for SVA if PTI is enabled
Content-Language: en-US
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
 <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220822201213.352289-3-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 4:12 AM, Jacob Pan wrote:
> With page table isolation, the kernel manages two sets of page tables
> for each process: one for user one for kernel. When enabling SVA, the
> current x86 IOMMU drivers bind device and PASID with the kernel copy
> of the process page table.
> 
> While there is no known "Meltdown" type of DMA attack, exposing
> kernel mapping to DMA intended for userspace makes the system vulnerable
> unnecessarily. It also breaks the intention of PTI.
> 
> This patch replaces kernel page table PGD with the user counterpart,
> thus fulfill the promise of PTI on the DMA side.
> 
> Signed-off-by: Jacob Pan<jacob.jun.pan@linux.intel.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
