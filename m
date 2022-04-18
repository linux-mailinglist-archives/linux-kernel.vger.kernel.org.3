Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA32B50604F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 01:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbiDRXks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 19:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiDRXkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 19:40:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1521A286CF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650325085; x=1681861085;
  h=message-id:date:mime-version:cc:to:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=460hG8CIIcm3gtmEox+OkQvY/ODX0b4z0I02OexvBno=;
  b=KYEfJhc0Rs5ZkE7ubb2Gz1Cw3zGSMQp1ezHiNqAMmE29R3UoqPFc/HfV
   W/gak8I5K/gK0rJfmemIV2EyoLwfLByoNfEDoyaRd47FnL2Xq9mxAHG2O
   0kg0Be1aBg+J1ECM9z2PFHOeZWC28UmWaJNnGDC4gP2K/TCDXoIkcUd/u
   v+7DCyrEnIr6aEi+U/8p/i/v5smtyzm4mWB7LZ+df7bKS4Ox44zcVDdfG
   3vHyUaXhQoJdsTgzMcX2Fou1kH47+Y9em6DpmKK4Dwi6sn/NtOwA29szb
   BeeDqmbJhWakhX56aKDCVmhhbHXuMYwFmGtiVZ+3oVbKXh4cA2uHJszEm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261236733"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="261236733"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:38:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="575804958"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.214.32]) ([10.254.214.32])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 16:38:00 -0700
Message-ID: <d928d256-b1bc-2d45-a9c3-382edfe67b80@linux.intel.com>
Date:   Tue, 19 Apr 2022 07:37:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        sven@svenpeter.dev, robdclark@gmail.com, m.szyprowski@samsung.com,
        yong.wu@mediatek.com, mjrosato@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, zhang.lyra@gmail.com,
        thierry.reding@gmail.com, vdumpa@nvidia.com,
        jean-philippe@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1649935679.git.robin.murphy@arm.com>
 <e607a32be8e84c56d65160902f4bd3fb434ee9d3.1649935679.git.robin.murphy@arm.com>
 <d838c7f8-2d31-2327-9b4d-c05b06a516bb@linux.intel.com>
 <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH 02/13] iommu: Move bus setup to IOMMU device registration
In-Reply-To: <1d9a2146-9e48-ba97-d049-5d2332ebbd3a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/19 6:09, Robin Murphy wrote:
> On 2022-04-16 01:04, Lu Baolu wrote:
>> On 2022/4/14 20:42, Robin Murphy wrote:
>>> @@ -1883,27 +1900,12 @@ static int iommu_bus_init(struct bus_type *bus)
>>>    */
>>>   int bus_set_iommu(struct bus_type *bus, const struct iommu_ops *ops)
>>>   {
>>> -    int err;
>>> -
>>> -    if (ops == NULL) {
>>> -        bus->iommu_ops = NULL;
>>> -        return 0;
>>> -    }
>>> -
>>> -    if (bus->iommu_ops != NULL)
>>> +    if (bus->iommu_ops && ops && bus->iommu_ops != ops)
>>>           return -EBUSY;
>>>       bus->iommu_ops = ops;
>>
>> Do we still need to keep above lines in bus_set_iommu()?
> 
> It preserves the existing behaviour until each callsite and its 
> associated error handling are removed later on, which seems like as good 
> a thing to do as any. Since I'm already relaxing iommu_device_register() 
> to a warn-but-continue behaviour while it keeps the bus ops on 
> life-support internally, I figured not changing too much at once would 
> make it easier to bisect any potential issues arising from this first step.

Fair enough. Thank you for the explanation.

Do you have a public tree that I could pull these patches and try them
on an Intel hardware? Or perhaps you have done this? I like the whole
idea of this series, but it's better to try it with a real hardware.

Best regards,
baolu


