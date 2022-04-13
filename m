Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 344BC4FFC1F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbiDMRNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiDMRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:12:26 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C6B2495A;
        Wed, 13 Apr 2022 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649869804; x=1681405804;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JOB+UVW8zbUV4QffJ7mmyRMUwWjpWnIftd5tTRSyqN4=;
  b=sHlZEVDJ0KWdkEMGCDf+bt+xWUQstW5YWVXX6b1odHB6uW2ynk9339nC
   NwmXGU1ncTLc6brFRXRtd/H6KvRMDWebfS8cZI1fz0Fh40VOLSYU1elhe
   U5zviLVLe4Fqu5/tPyF4B5PCnVvH6fhvrq7Tl5t8KftIr97aXiix87CPm
   U=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Apr 2022 10:10:03 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 10:10:03 -0700
Received: from [10.134.65.5] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 13 Apr
 2022 10:10:02 -0700
Message-ID: <fd8c702b-f433-0526-6945-3339a8de2f0a@quicinc.com>
Date:   Wed, 13 Apr 2022 10:09:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH 03/11] arm64: gunyah: Add Gunyah hypercalls ABI
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>
References: <20220223233729.1571114-1-quic_eberman@quicinc.com>
 <20220223233729.1571114-4-quic_eberman@quicinc.com>
 <YhdZen7MwdAIJMsu@lakrids> <874k4o4l39.wl-maz@kernel.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <874k4o4l39.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/2022 2:26 AM, Marc Zyngier wrote:
> Thanks Mark for roping me in.
> 
> On Thu, 24 Feb 2022 10:10:02 +0000,
> Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Hi,
>>
>> As a general thing, this is the *only* patch from this series which has
>> been Cc'd to linux-arm-kernel, which makes it practically impossible to
>> understand the context for this, which is somewhat frustrating.
>>
>> Looking on lore.kernel.org I see that the entire series was Cc'd to
>> linux-arm-msm, but most people don't subscribe to that list. If you send
>> one patch in a series to a list, please send the *entire* series there. >>>> On Wed, Feb 23, 2022 at 03:37:21PM -0800, Elliot Berman wrote:
>>> Add initial support to perform Gunyah hypercalls. The arm64 ABI for
>>> Gunyah hypercalls generally follows the AAPCS64, and can be summarized:
>>>   - Function identifier is passed through the imm operand
>>>   - [r0,r7] are parameter and result registers
>>>   - [r8-r18] are temporary and saved by the caller (VM)
>>>   - [r19-r31] are preserved and saved by the hypervisor
>>>
>>> The preprocessor macors for creating the necessary HVC instruction
>>> roughly follows the SMCCC 1.1 implementation in
>>> include/linux/arm-smccc.h.
>>
>> I've added the SMCCC maintainers (myself, Lorenzo, and SUdeep) to Cc,
>> and also Marc who was involvedi n prior discussions in this area. Please
>> Cc us on any future patches adding HVC or SMCC interfaces (SMCCC or
>> otherwise).
> 
> In general, please Cc all the interested parties with the whole
> series. Random patches randomly cc'd out of context are pretty useless
> and only lead to them being ignored.
> 

I'll do this in the future, thanks for the recommendation here.

>>
>> We've previously said NO to any new hypercall mechanisms which do not
>> follow SMCCC. There is no reason to fragment this space further; please
>> use SMCCC (which your hypervisor must already implement in part if it
>> exposes PSCI to a guest).
>>
>> NAK to this non-SMCCC interface.
> 
> Agreed. We pushed back on that for Hyper-V, and I don't see a reason
> for changing tack on that.
> 
> The calling convention exists for a reason: portability. If this
> hypervisor is to be "independent of any high-level OS kernel" (as it
> is being advertised), then it must already implement SMCCC.
> 
> What is the issue with properly supporting SMCCC for all interactions
> with the hypervisor and not reinventing a square wheel? >

We had discussion on this and will implement SMCCC calls for Gunyah's 
hypercalls. I'll share updated patches soon once we have update the 
hypervisor.

> Thanks,
> 
> 	M.
> 
