Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680E5572C9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiFWGC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWGC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:02:28 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE2B44771;
        Wed, 22 Jun 2022 23:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655964147; x=1687500147;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kQy3/S0oY9NNHYhqGTErgRO6snEJoyWavRF1Xgt/bO4=;
  b=kZ5c/na3nC8k0n6fhaSJO1xXgo/T27o4xs0q++2EkBCr46Jnm/bL876P
   4vUrbDL9N1QsXseoAhVBxWkBPpUxzYMP8qk2TzPbV5lj06vqzzvGsBGF7
   cCtfezwySAu+T7D9p1iL7IsvJF2Zp8yKLmXhT9W4PvCW3LvbvvN+SrEhT
   Q=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 22 Jun 2022 23:02:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 23:02:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 23:02:26 -0700
Received: from [10.50.26.56] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 22 Jun
 2022 23:02:22 -0700
Message-ID: <21d5fc44-4870-02bb-70b4-d9e1188c9cc1@quicinc.com>
Date:   Thu, 23 Jun 2022 11:32:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel" <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_guptap@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220526041403.9984-1-quic_saipraka@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 5/26/2022 9:44 AM, Sai Prakash Ranjan wrote:
> TLB sync timeouts can be due to various reasons such as TBU power down
> or pending TCU/TBU invalidation/sync and so on. Debugging these often
> require dumping of some implementation defined registers to know the
> status of TBU/TCU operations and some of these registers are not
> accessible in non-secure world such as from kernel and requires SMC
> calls to read them in the secure world. So, add this debug support
> to dump implementation defined registers for TLB sync timeout issues.
>
> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> ---
>
> Changes in v2:
>   * Use scm call consistently so that it works on older chipsets where
>     some of these regs are secure registers.
>   * Add device specific data to get the implementation defined register
>     offsets.
>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>   3 files changed, 146 insertions(+), 18 deletions(-)

Any comments on this patch?

Thanks,
Sai
