Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3F355F257
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 02:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiF2AY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 20:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiF2AY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 20:24:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8412240BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656462295; x=1687998295;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gNrBHCQAvCRcX09U/UlWMcKB1+tzLb4/Y4Z/doplvUA=;
  b=Y8j0msbdnRGFAmkuT6oyjcdrspjZ0+Lg0bLAwJ+zkhGhmMKXf1UaWXB+
   8tbQbwt0emA0XEo9DSlw+xs4SlWHBoH0FncszWdz92kALaGaiZV5vPSgO
   tmUC24Dt9BFYDBfavNerva/X6GHGxXZBhb7qAd3/bttpMaszqoGWhS3Zo
   UD/4LMlAobOASsdSWN0/Yq+fzD7SVTbACegAnTwxi+mzgBcLJbucJShSI
   fM/kLjHvgjP2HoM4Zu2b0lbnBI2EzNN2b/r3PvLZGXE71oosqxFdy0hth
   Ba87X4O+/l8eBctNSPdBZ3yJQw8dq04mBIEvp9iaCWOOvfLH/xbNwhAVK
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="282976581"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="282976581"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="647142607"
Received: from xuepengx-mobl1.ccr.corp.intel.com (HELO [10.255.29.216]) ([10.255.29.216])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 17:24:51 -0700
Message-ID: <bf2ae213-b938-2550-b367-f548fc755e99@linux.intel.com>
Date:   Wed, 29 Jun 2022 08:24:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com,
        Ethan Zhao <haifeng.zhao@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
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

On 2022/6/28 22:20, Jean-Philippe Brucker wrote:
> On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
>>>>> Once the iopf_handle_single() is removed, the name of
>>>>> iopf_handle_group() looks a little weired
>>>>>
>>>>> and confused, does this group mean the iommu group (domain) ?
>>>>> while I take some minutes to
>>>>
>>>> No. This is not the iommu group. It's page request group defined by the
>>>> PCI SIG spec. Multiple page requests could be put in a group with a
>>>> same group id. All page requests in a group could be responded to device
>>>> in one shot.
>>>
>>> Thanks your explaination, understand the concept of PCIe PRG.  I meant
>>>
>>> do we still have the necessity to mention the "group" here in the name
>>>
>>> iopf_handle_group(),  which one is better ? iopf_handle_prg() or
>>>
>>> iopf_handler(),  perhaps none of them ? :)
>>
>> Oh! Sorry for the misunderstanding.
>>
>> I have no strong feeling to change this naming. :-) All the names
>> express what the helper does. Jean is the author of this framework. If
>> he has the same idea as you, I don't mind renaming it in this patch.
> 
> I'm not attached to the name, and I see how it could be confusing. Given
> that io-pgfault is not only for PCIe, 'prg' is not the best here either.
> iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Okay, so I will rename it to iopf_handle_faults() in this patch.

Best regards,
baolu
