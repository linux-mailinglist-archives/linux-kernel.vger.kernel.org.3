Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE75566299
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 07:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiGEFGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 01:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiGEFGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 01:06:03 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2712A8F;
        Mon,  4 Jul 2022 22:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1656997559; x=1688533559;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=PAfrv6obJNhFhvY8AejIU454yGvN0bvGjWO9B1hF+c8=;
  b=Cil7wMvDnh5pjvoJLMmdDfigetrS64EcL6tr5Vl4uQaScpdpkgZuJ/VM
   MFZhthTLgP0lm5ElZ2Cy0UljZKmcNLZppEllnRjUqXonkqDEP3moT3dLr
   /+xjl3SIOsEBWGeO/sA1BkBWheWBk+m0dzm8ZRSFYXwP9pludBGfSytyi
   g=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jul 2022 22:05:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 22:05:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Jul 2022 22:05:58 -0700
Received: from [10.50.56.53] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 4 Jul 2022
 22:05:54 -0700
Message-ID: <00e8622a-915b-b5e0-12cd-78bb6a2758c9@quicinc.com>
Date:   Tue, 5 Jul 2022 10:35:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_guptap@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
 <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
In-Reply-To: <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

On 6/23/2022 11:32 AM, Sai Prakash Ranjan wrote:
> On 5/26/2022 9:44 AM, Sai Prakash Ranjan wrote:
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
>>   * Use scm call consistently so that it works on older chipsets where
>>     some of these regs are secure registers.
>>   * Add device specific data to get the implementation defined register
>>     offsets.
>>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>>   3 files changed, 146 insertions(+), 18 deletions(-)
>
> Any comments on this patch?

Gentle Ping !!

Thanks,
Sai
