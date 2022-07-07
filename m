Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79CFF5696D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234724AbiGGAUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiGGAUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:20:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0922B271;
        Wed,  6 Jul 2022 17:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657153238; x=1688689238;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kG5jotEa1Wd96n4KXqFgzVT3ccOLgmmy7vGKrfscZe0=;
  b=hJKjSKPFUwPpQdw+k8xgKh2cBWoSPWCzT88YtJks2p3MfilINCjNcFGX
   SzfKcv1f4O5vNN7aa6b1aX+CMpbemyWBzv9Oy+yjDgk8R1G6mUl1zwCJh
   od/oDI4GEL1Us3ev6QbRGR3IGNoE5Soxb+J5mlMJbVcdriwrJWYSH07H0
   mo1qUg2Wfqtd+qN+xTNQINFuA0d2/t6ZPosNJQsFBAsOWg2GH87VNNFtg
   4OYQORvAZVtWArMpuZnZICBxqSZdeeQ/JTbcrp3Bx8muC1e7rXqVXHdx+
   s4tRlRYwxrd7tdiMe6NMlNAV1wuGUjtXLB4P08ckTzA5w+M0FXmATzHep
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="263682628"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="263682628"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:20:37 -0700
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="650892999"
Received: from hualiu-mobl1.ccr.corp.intel.com (HELO [10.249.171.209]) ([10.249.171.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:20:34 -0700
Message-ID: <28a58a21-a866-b49c-9977-c8d05b320fbd@linux.intel.com>
Date:   Thu, 7 Jul 2022 08:20:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Cc:     baolu.lu@linux.intel.com, will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        suravee.suthikulpanit@amd.com, vasant.hegde@amd.com,
        mjrosato@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        schnelle@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/15] iommu: Always register bus notifiers
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
References: <cover.1657034827.git.robin.murphy@arm.com>
 <8c380309f264cd0dfc73ba2ec060adc9515af2f2.1657034828.git.robin.murphy@arm.com>
 <1fab4c8a-7bc5-9a50-d48a-0dc590cac7a6@linux.intel.com>
 <3d613192-f673-852e-9c52-b8a913d25616@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3d613192-f673-852e-9c52-b8a913d25616@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/6 21:43, Robin Murphy wrote:
> On 2022-07-06 02:53, Baolu Lu wrote:
>> On 2022/7/6 01:08, Robin Murphy wrote:
>>>   /*
>>>    * Use a function instead of an array here because the domain-type 
>>> is a
>>>    * bit-field, so an array would waste memory.
>>> @@ -152,6 +172,10 @@ static int __init iommu_subsys_init(void)
>>>               (iommu_cmd_line & IOMMU_CMD_LINE_STRICT) ?
>>>                   "(set via kernel command line)" : "");
>>> +    /* If the system is so broken that this fails, it will WARN 
>>> anyway */
>>
>> Can you please elaborate a bit on this? iommu_bus_init() still return
>> errors.
> 
> Indeed, it's commenting on the fact that we don't try to clean up or 
> propagate an error value further even if it did ever manage to return 
> one. I feared that if I strip the error handling out of iommu_bus_init() 
> itself on the same reasoning, we'll just get constant patches from the 
> static checker brigade trying to add it back, so it seemed like the 
> neatest compromise to keep that decision where it's obviously in an 
> early initcall, rather than in the helper function which can be viewed 
> out of context. However, I'm happy to either expand this comment or go 
> the whole way and make iommu_bus_init() return void if you think it's 
> worthwhile.

Thanks for the explanation. It would be helpful if the comment could be
expanded. In this case, after a long time, people will not consider it
an oversight. :-)

Best regards,
baolu

> 
> Cheers,
> Robin.
> 
>>
>>> +    for (int i = 0; i < ARRAY_SIZE(iommu_buses); i++)
>>> +        iommu_bus_init(iommu_buses[i]);
>>> +
>>>       return 0;
>>
>> Best regards,
>> baolu
> 

