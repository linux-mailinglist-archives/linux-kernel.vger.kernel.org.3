Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEF455DE80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbiF1MjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344722AbiF1MjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:39:09 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852C2ED49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656419948; x=1687955948;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xH+zDbWm9NnK+jA1wnqDI01ZjKwfPCHuUTs1IQUIh5U=;
  b=SKsRqnCrxFPq9RextccGAYul1UbiUaA9qE9j3RTMa6n4pkH6R1E0haKY
   +qCWstF8WngQKspmDkMQP5t5Ieh92hfG+/u31gapG0abmJyrMvau8Ba70
   /zaNCS8+q8DBiaB2nJNnBK1pIlXa7LjvnrPWdUwJIQlUkrf9ZQU84Ct/c
   eKhmv1iup4pJBRSuzyA7t9xUjYch+3ZXt0CrfAjv5NERcwpasDjQy8aXg
   t4B9G0HyGxoIQzjeol0DdZHCUyyWCvPAshzU76iLkdUuakZRaNL5sh7t4
   Lk1etFyVJQJ/RBbZYn3P4xOmFGQyqtP+7EejZAa82JPbBrhB7h00X2CdD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="281766486"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="281766486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:39:08 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646897670"
Received: from ltang11-mobl1.ccr.corp.intel.com (HELO [10.249.169.64]) ([10.249.169.64])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 05:39:05 -0700
Message-ID: <e311ead5-776b-ad71-5ad9-98f9ab6e569a@linux.intel.com>
Date:   Tue, 28 Jun 2022 20:39:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, David Woodhouse <dwmw2@infradead.org>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Mike Travis <mike.travis@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>, iommu@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] iommu/vt-d: Reset DMAR_UNITS_SUPPORTED
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>, Steve Wahl <steve.wahl@hpe.com>,
        Kevin Tian <kevin.tian@intel.com>
References: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220625125204.2199437-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/25 20:51, Lu Baolu wrote:
> Hi folks,
> 
> This is a follow-up series of changes proposed by this patch:
> 
> https://lore.kernel.org/linux-iommu/20220615183650.32075-1-steve.wahl@hpe.com/
> 
> It removes several static arrays of size DMAR_UNITS_SUPPORTED and sets
> the DMAR_UNITS_SUPPORTED to 1024.
> 
> Please help review and suggest.

This series is also available on github:

https://github.com/LuBaolu/intel-iommu/commits/vtd-next-for-v5.20

Best regards,
baolu

> 
> Best regards,
> baolu
> 
> Lu Baolu (6):
>    iommu/vt-d: Remove unused domain_get_iommu()
>    iommu/vt-d: Use IDA interface to manage iommu sequence id
>    iommu/vt-d: Refactor iommu information of each domain
>    iommu/vt-d: Add VTD_FLAG_IOMMU_PROBED flag
>    iommu/vt-d: Remove global g_iommus array
>    iommu/vt-d: Make DMAR_UNITS_SUPPORTED default 1024
> 
>   include/linux/dmar.h        |   6 +-
>   drivers/iommu/intel/iommu.h |  29 ++++--
>   drivers/iommu/intel/dmar.c  |  33 ++-----
>   drivers/iommu/intel/iommu.c | 188 ++++++++++++++----------------------
>   drivers/iommu/intel/pasid.c |   2 +-
>   drivers/iommu/intel/svm.c   |   2 +-
>   6 files changed, 103 insertions(+), 157 deletions(-)
> 

