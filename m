Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 675D4544541
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbiFIIAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiFIIAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:00:43 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C88E10E5;
        Thu,  9 Jun 2022 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654761642; x=1686297642;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e1UGClnaUgzCb1brsqptliKGNl+O+10vLwIjpGp/hgo=;
  b=C0wY5RdWQkUhd97+S7rwxYVJEBHn6ZtUYQCzNUGJwP7LAaMd3O3w3Wxa
   +k2jcpEmzXjtX7tEpVndayCAbuB9Dqvf9gKZneW/efbd5gWSxOmuSiuvb
   XQESL8+f1/eFBo0smLSOp/Eh7Mt2qgwdpS6RZH3aZiMvBMyFGP6J19Ifc
   A=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Jun 2022 01:00:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 01:00:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 9 Jun 2022 01:00:12 -0700
Received: from [10.50.50.196] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 9 Jun 2022
 01:00:08 -0700
Message-ID: <231dd355-acf3-626f-3da0-350281c660f5@quicinc.com>
Date:   Thu, 9 Jun 2022 13:30:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv2] iommu/arm-smmu-qcom: Add debug support for TLB sync
 timeouts
Content-Language: en-US
To:     Vincent Knecht <vincent.knecht@mailoo.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
CC:     <iommu@lists.linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <quic_guptap@quicinc.com>, Rob Clark <robdclark@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220526041403.9984-1-quic_saipraka@quicinc.com>
 <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <78f1adee5c6e0c3547c116d0e78fe5b70f9c15e1.camel@mailoo.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On 6/9/2022 2:52 AM, Vincent Knecht wrote:
> Le jeudi 26 mai 2022 à 09:44 +0530, Sai Prakash Ranjan a écrit :
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
>>   * Use scm call consistently so that it works on older chipsets where
>>     some of these regs are secure registers.
>>   * Add device specific data to get the implementation defined register
>>     offsets.
>>
>> ---
>>   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 161 ++++++++++++++++++---
>>   drivers/iommu/arm/arm-smmu/arm-smmu.c      |   2 +
>>   drivers/iommu/arm/arm-smmu/arm-smmu.h      |   1 +
>>   3 files changed, 146 insertions(+), 18 deletions(-)
> Hi Sai, and thanks for this patch !
>
> I've encountered TLB sync timeouts with msm8939 SoC recently.
> What would be needed to add to this patch so this SoC is supported ?
> Like, where could one check the values to be used in an equivalent
> of qcom_smmu_impl0_reg_offset values for this SoC (if any change needed) ?
> Current values are not found by simply greping in downstream/vendor dtsi/dts files...

These are implementation defined registers and some might not be present on older SoCs
and sometimes they don't add this support in downstream kernels even if the registers
are present.

I looked up the IP doc for msm8939 and I could find only TBU_PWR_STATUS register and
you can use the same offset for it as given in this patch.

Thanks,
Sai
