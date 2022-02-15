Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255894B6004
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 02:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbiBOBdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 20:33:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiBOBdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 20:33:06 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2911212E9FD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 17:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644888778; x=1676424778;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0ctRTJZZNVcCzZj/wNrnn1QyWEQDzBeLXyFmEOHK8r4=;
  b=X1si7ryfkt0jAnEGQ5VHy+Nbf0yzxaZMwR8yDmToOfdd91jpoCFyCWnE
   HADpdnaBCIwNpPF1lLKh1OtPma3kOQmmBfC6nhCuJ4KsJHVCAJvd2OBPN
   bj6Wn4enSzXvC3znlkpN0zs+QpKo14/o5q/VlJ0tYmENgkM3Yb+h+9Zhz
   uYXCO7jEI+C12meulyhgz0w/3q7Trx5EpuXJZ95veahyiGTNHvkqdWuX5
   OUSNN9i1mYWMTFr11Am6RT3oX8A9TENoDJimE9yw9BefZxJn/KImnIF5u
   ytbCH0cRU2aaXR4xasF9ZPAVE3lPZL4OnmH1oHAuuO+1JFzL6Vr4+Njqg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="336652559"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="336652559"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 17:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="680786710"
Received: from allen-box.sh.intel.com (HELO [10.239.159.118]) ([10.239.159.118])
  by fmsmga001.fm.intel.com with ESMTP; 14 Feb 2022 17:32:56 -0800
Message-ID: <30e45a7e-088d-7479-a284-68effadf3cbe@linux.intel.com>
Date:   Tue, 15 Feb 2022 09:31:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
 <YgpY1IIBkFIxxjbm@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
In-Reply-To: <YgpY1IIBkFIxxjbm@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/22 9:27 PM, Joerg Roedel wrote:
> On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
>> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
>> index 69230fd695ea..1036c1900b5c 100644
>> --- a/include/linux/intel-iommu.h
>> +++ b/include/linux/intel-iommu.h
>> @@ -813,6 +813,8 @@ bool context_present(struct context_entry *context);
>>   struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8 bus,
>>   					 u8 devfn, int alloc);
>>   
>> +extern const struct iommu_ops intel_iommu_ops;
>> +
> The intel_iommu_ops symbol is only used in drivers/iommu/intel, so I
> would prefer a header in that directory. But I leave that up to Baolu to
> decide.

Agreed. I also have a plan to split them out into a internal header.

Best regards,
baolu
