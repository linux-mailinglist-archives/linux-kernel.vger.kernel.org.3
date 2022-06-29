Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E94755F65C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 08:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbiF2GPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 02:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2GPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 02:15:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982EF1CB23
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 23:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656483342; x=1688019342;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=MIRJXsI3AGI9TOUBaCXQFdgFRZepMITCdgAbqxVUet0=;
  b=QCk5r9h/pK4C4kCmjHV5rismWnZnPTim+wofHC0kv1DpOIlr47lS4k+T
   2c+tmOfyBcZiw0756E0xd5NJ69PfssPCcbk4jc7E4CtJKwTAn2K/5iy2G
   eFS4yh0LgapJmRlVlwETxF89SQLqgvNVAKDNivUm+UNI2JTrkAO2/8iRN
   EYTT+At1ld7PWxsnlNO1v7Nng0T9M/vrbMuO+LQ/NVphp8zCDMoUxf1uI
   XPaMVqfAhxrU633hdpdA9VLSPWLYqoL/0He8Qz89djcWIJjg0uDSmUy4M
   boeDEwu/gPBgoImTvKz+Ipy6ceXvHx9hUcfvKGqXM26bElQdvUke24c3l
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264975499"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="264975499"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 23:15:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="595103334"
Received: from zhaohaif-mobl1.ccr.corp.intel.com (HELO [10.254.214.131]) ([10.254.214.131])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 23:15:30 -0700
Message-ID: <2e99710b-becc-1e03-fa10-ad5f2dd06802@linux.intel.com>
Date:   Wed, 29 Jun 2022 14:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v9 10/11] iommu: Per-domain I/O page fault handling
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Baolu Lu <baolu.lu@linux.intel.com>
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
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-11-baolu.lu@linux.intel.com>
 <faacb997-0c0a-04e1-903d-53857f463214@linux.intel.com>
 <693a3604-d70b-e08c-2621-7f0cb9bdb6ca@linux.intel.com>
 <75b17c70-1658-91ea-0992-1be769550943@linux.intel.com>
 <935ca9e3-28c9-99af-5609-41bb1500b2b3@linux.intel.com>
 <YrsOO9E+j+CMgKMA@myrica>
From:   Ethan Zhao <haifeng.zhao@linux.intel.com>
In-Reply-To: <YrsOO9E+j+CMgKMA@myrica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/28 22:20, Jean-Philippe Brucker 写道:
> On Tue, Jun 28, 2022 at 07:53:39PM +0800, Baolu Lu wrote:
>>>>> Once the iopf_handle_single() is removed, the name of
>>>>> iopf_handle_group() looks a little weired
>>>>>
>>>>> and confused, does this group mean the iommu group (domain) ?
>>>>> while I take some minutes to
>>>> No. This is not the iommu group. It's page request group defined by the
>>>> PCI SIG spec. Multiple page requests could be put in a group with a
>>>> same group id. All page requests in a group could be responded to device
>>>> in one shot.
>>> Thanks your explaination, understand the concept of PCIe PRG.  I meant
>>>
>>> do we still have the necessity to mention the "group" here in the name
>>>
>>> iopf_handle_group(),  which one is better ? iopf_handle_prg() or
>>>
>>> iopf_handler(),  perhaps none of them ? :)
>> Oh! Sorry for the misunderstanding.
>>
>> I have no strong feeling to change this naming. :-) All the names
>> express what the helper does. Jean is the author of this framework. If
>> he has the same idea as you, I don't mind renaming it in this patch.
> I'm not attached to the name, and I see how it could be confusing. Given
> that io-pgfault is not only for PCIe, 'prg' is not the best here either.
> iopf_handle_faults(), or just iopf_handler(), seem more suitable.

Both iopf_handle_faults() and iopf_handler() looks straight, iopf_handler()

saves one word 'faults', iopf already has the meaning 'io page fault' , so

iopf_handler() is clear enough I think.


Thanks,

Ethan

>
> Thanks,
> Jean

-- 
"firm, enduring, strong, and long-lived"

