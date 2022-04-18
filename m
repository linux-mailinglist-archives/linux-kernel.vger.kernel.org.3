Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE57A504F83
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 13:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236845AbiDRLr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 07:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbiDRLr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 07:47:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906B8263C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 04:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650282288; x=1681818288;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ed9XtiWvuduH3tePyFDVZz4+lZ73C5IN2pEFYdP+YKI=;
  b=aw2Mjak+93FclCcIlf9i+OqhUpfmbIf6LjOV46n7HlmdtYKeBgR7Fr9r
   60LN4nRizwPhYgbSBZgwSq+bx2m/aVs6VmxVAMsTWxP5h9GGNxNbpz5ks
   3nitAuArXAwhmituSAobqgS1Q/2rtdlcMEwe2Yfql+5AU9w965a4QP0/M
   BJtb5N1HExkEUgpFt40pOFrtME4VQen4oO/A4/Qx1R/1Mt5AyuPwt7zTe
   Gwmec3B0+fU8CIlrVNjfVNdliPD7LDHkI1X4pyVgQYBxBibvx8t1hHqO9
   o+0Vf2c1obq9oipg7KwiwS+c+uzVtDgWxC0l/1TwFttXA2TI3eF8I625v
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="262962853"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="262962853"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="575541874"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.208.231]) ([10.254.208.231])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 04:44:46 -0700
Message-ID: <46f51f30-28e9-4b91-acd5-1df43c1428d6@linux.intel.com>
Date:   Mon, 18 Apr 2022 19:44:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Language: en-US
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
References: <20220416123049.879969-1-baolu.lu@linux.intel.com>
 <20220416123049.879969-4-baolu.lu@linux.intel.com>
 <BN9PR11MB5276BC4D5F9B133C84630CBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 3/3] iommu/vt-d: Size Page Request Queue to avoid overflow
 condition
In-Reply-To: <BN9PR11MB5276BC4D5F9B133C84630CBA8CF39@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/18 15:00, Tian, Kevin wrote:
>> From: Lu Baolu<baolu.lu@linux.intel.com>
>> Sent: Saturday, April 16, 2022 8:31 PM
>>
>> PRQ overflow may cause I/O throughput congestion, resulting in unnecessary
>> degradation of IO performance. Appropriately increasing the length of PRQ
>> can greatly reduce the occurrence of PRQ overflow. The count of maximum
>> page requests that can be generated in parallel by a PCIe device is
>> statically defined in the Outstanding Page Request Capacity field of the
>> PCIe ATS configure space.
>>
>> The new lenght of PRQ is calculated by summing up the value of Outstanding
>> Page Request Capacity register across all devices where Page Requests are
>> supported on the real PR-capable platfrom (Intel Sapphire Rapids). The
>> result is round to the nearest higher power of 2.
> The actual requirement is usage and platform specific. What about
> doubling the default size and also provide an option for admin to
> tune?

I also have this in my list to provide an opt-in interface for user. But
I don't want to include it in this series as this is only for small
tuning. The opt-in interface looks more like a new feature. :-)

Best regards,
baolu
