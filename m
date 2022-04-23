Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF15F50C80B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232601AbiDWHfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiDWHfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:35:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9351A860E
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650699144; x=1682235144;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x/c3raDa5wSKoz1iB1BvOoz+NWGUFUCKRADdevodsx0=;
  b=DtmmQn6E56qKMFadp/gljhrBPAo9DcEu9F06Lc12BtQeDO3XwZCvXeOK
   esSas+66PPSmrdHM1xIGFLZ8LQw7xRyxPCeBWuuSFwrk/L3LJfNfd4k8c
   IXtrGb/TOKI6n7XMUk8zLM1KQ8ad7KB8pAoTqoSRjL0pd8WbWBx4MP0H7
   jOz1+e07L1XWV+LHUDGEQJw14xmvdLk1APQdK3JoSoxUIqTScqcyyCMCn
   MATu3WUpPHk8K01AIKLR2o05OW2DxVlDvQ/6Gy5slq2zMLPtpQAKWr9t+
   xIpMPBbR/0u3g5KEFfUnJEPTVRSkxyfsU1vQcXzOYh+90H0kVk4VBmz2A
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263713083"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="263713083"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:32:24 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="578307252"
Received: from yjsun1-mobl.ccr.corp.intel.com (HELO [10.255.31.217]) ([10.255.31.217])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 00:32:22 -0700
Message-ID: <936ce4a6-4574-9fc4-ad4a-2e93adca3c16@linux.intel.com>
Date:   Sat, 23 Apr 2022 15:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 3/4] iommu/vt-d: Drop stop marker messages
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
References: <20220421113558.3504874-1-baolu.lu@linux.intel.com>
 <20220421113558.3504874-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276D83DF086871587743E378CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <BN9PR11MB5276D83DF086871587743E378CF79@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/22 11:05, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Thursday, April 21, 2022 7:36 PM
>>
>> The page fault handling framework in the IOMMU core explicitly states
>> that it doesn't handle PCI PASID Stop Marker and the IOMMU drivers must
>> discard them before reporting faults. This handles Stop Marker messages
>> in prq_event_thread() before reporting events to the core.
>>
>> The VT-d driver explicitly drains the pending page requests when a CPU
>> page table (represented by a mm struct) is unbound from a PASID according
>> to the procedures defined in the VT-d spec. The Stop Marker messages do
>> not need a response. Hence, it is safe to drop the Stop Marker messages
>> silently if any of them is found in the page request queue.
>>
>> Fixes: d5b9e4bfe0d88 ("iommu/vt-d: Report prq to io-pgfault framework")
>> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
>> Reviewed-by: Jacob Pan<jacob.jun.pan@linux.intel.com>
> Reviewed-by: Kevin Tian<kevin.tian@intel.com>
> 

Thank you, Kevin. I will queue this patch to Joerg as a fix for v5.18.

Best regards,
baolu
