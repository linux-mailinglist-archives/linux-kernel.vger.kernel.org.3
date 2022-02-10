Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3044B0754
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiBJHgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:36:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbiBJHgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:36:48 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653C1270;
        Wed,  9 Feb 2022 23:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644478609; x=1676014609;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UYTGULdMGV9sc8yVw9KMVk2PqW+apnNq019VLoB/ZZk=;
  b=q7kMGTpjd+72o9eQnepw0Tz+QBgzOvlQSxmpIu4Z6gfuRAl3CDEyl6ne
   EufX15Pmjxq3mMSKzFIQM33tMDYad5OVIcLKNeuV+ss9CUiZbYC62X4d3
   OL662ug3w9wujKtPxTrxuc+IrLMEj+XYqqO4AbpYZE2LL2a4AsbYktK1q
   U=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 09 Feb 2022 23:36:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:36:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 23:36:48 -0800
Received: from [10.50.12.153] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Wed, 9 Feb 2022
 23:36:44 -0800
Message-ID: <a64cefd2-7dfa-c86c-f1aa-461699253b62@quicinc.com>
Date:   Thu, 10 Feb 2022 13:06:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv9 1/5] arm64: io: Use asm-generic high level MMIO
 accessors
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        gregkh <gregkh@linuxfoundation.org>, <quic_psodagud@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>
References: <cover.1642482334.git.quic_saipraka@quicinc.com>
 <87926437f2f9e72dd94f0b30c8784c2da5508644.1642482334.git.quic_saipraka@quicinc.com>
 <YgQNiXsh4hC+5+O5@arm.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <YgQNiXsh4hC+5+O5@arm.com>
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

On 2/10/2022 12:22 AM, Catalin Marinas wrote:
> On Mon, Jan 24, 2022 at 12:03:30PM +0530, Sai Prakash Ranjan wrote:
>> Remove custom arm64 MMIO accessors read{b,w,l,q} and their relaxed
>> versions in support to use asm-generic defined accessors. Also define
>> one set of IO barriers (ar/bw version) used by asm-generic code to
>> override the arm64 specific variants.
>>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
> I'm fine with this patch:
>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

>> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
>> index 7fd836bea7eb..1b436810d779 100644
>> --- a/arch/arm64/include/asm/io.h
>> +++ b/arch/arm64/include/asm/io.h
> [...]
>> +/* arm64-specific, don't use in portable drivers */
>> +#define __iormb(v)		__io_ar(v)
>> +#define __iowmb()		__io_bw()
>> +#define __iomb()		dma_mb()
> However, I'd like to see a few subsequent patches that get rid of the
> __io*mb() uses in drivers/ (there don't seem to be that many).
>

Sure, I will do these in next version of this series. Hoping to get 
reviews on other patches
as well so I can include all the changes in the next version.

Thanks,
Sai
