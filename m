Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89310569A62
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbiGGGUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiGGGUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:20:23 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088071EAFD;
        Wed,  6 Jul 2022 23:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657174823; x=1688710823;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0GncP1lP/UKCHyowwfddoOYDjFybJCdgKqH6YR5zIuI=;
  b=Q+ArQEtCBFAQYWZtsi+IYgAm2JhhOXiflzsfGxA2sOy9kq4ruiU2Grfw
   YdcAslJGUAaG9Cefxlb3zix+crkt0DEnxTA+bRemPxlxXo0AlwaR/95pM
   S/dkiueasYaMi8qpzRYOCoUJ5sFr/M1IyNIbiiV56cXFi+z1BC4+xRL6H
   U=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jul 2022 23:20:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:20:22 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 6 Jul 2022 23:20:21 -0700
Received: from [10.50.36.54] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 6 Jul 2022
 23:20:18 -0700
Message-ID: <32306c0d-58cf-b1df-2794-5b1f17e3d062@quicinc.com>
Date:   Thu, 7 Jul 2022 11:50:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_guptap@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
 <20220706115638.GD2403@willie-the-truck>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220706115638.GD2403@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/2022 5:26 PM, Will Deacon wrote:
> On Thu, May 26, 2022 at 09:44:03AM +0530, Sai Prakash Ranjan wrote:
>> TLB sync timeouts can be due to various reasons such as TBU power down
>> or pending TCU/TBU invalidation/sync and so on. Debugging these often
>> require dumping of some implementation defined registers to know the
>> status of TBU/TCU operations and some of these registers are not
>> accessible in non-secure world such as from kernel and requires SMC
>> calls to read them in the secure world. So, add this debug support
>> to dump implementation defined registers for TLB sync timeout issues.
>>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
>> ---
>>
>> Changes in v2:
>>   * Use scm call consistently so that it works on older chipsets where
>>     some of these regs are secure registers.
>>   * Add device specific data to get the implementation defined register
>>     offsets.
>>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>>   3 files changed, 146 insertions(+), 18 deletions(-)
> If this is useful to you, then I suppose it's something we could support,
> however I'm pretty worried about our ability to maintain/scale this stuff
> as it is extended to support additional SoCs and other custom debugging
> features.
>
> Perhaps you could stick it all in arm-smmu-qcom-debug.c and have a new
> config option for that, so at least it's even further out of the way?
>
> Will

Sounds good to me, will do that.

Thanks,
Sai
