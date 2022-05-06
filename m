Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB851D8EF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 15:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392424AbiEFN0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 09:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392440AbiEFN0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 09:26:46 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CFD6830B;
        Fri,  6 May 2022 06:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651843382; x=1683379382;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YQat1rkbwME50is2lwrsUzhjqH7wUUl1ZMLcbuIXkx8=;
  b=zgVZ5SwgQrQJohv4cumKrXn6JnJb0sOR4JnGl2RAF/G8OHucCJhHjLqN
   86inPMp+0gq43gpEMMVZkACqXAJQ9TkJwSNz+3JCPGf0hcDRDV1mZVUCg
   AX/QsEYi79CEn8V9+9m8sDAyJqmc5R0uX0wTqSw2KD8p5SWV5iRQJhprL
   4=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 May 2022 06:23:02 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 06:23:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 06:23:01 -0700
Received: from [10.50.57.95] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 6 May 2022
 06:22:56 -0700
Message-ID: <f41e8177-dbda-a03a-299e-d18ee5a5f459@quicinc.com>
Date:   Fri, 6 May 2022 18:52:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv14 2/9] coresight: etm4x: Use asm-generic IO memory
 barriers
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>, <arnd@arndb.de>,
        <catalin.marinas@arm.com>, <rostedt@goodmis.org>
CC:     <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <0d76de0ecc0aa7cb01fd8b8863a8e567abd4410b.1651663123.git.quic_saipraka@quicinc.com>
 <483bb401-13e6-8c52-4b5f-f3c635b9ad46@arm.com>
 <b44a0e0b-ee86-3b08-0103-3ccee94e3270@quicinc.com>
 <687b78b5-5671-5317-ce9e-98720bb533fa@arm.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <687b78b5-5671-5317-ce9e-98720bb533fa@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/2022 2:51 PM, Suzuki K Poulose wrote:
> On 06/05/2022 04:02, Sai Prakash Ranjan wrote:
>> Hi Suzuki,
>>
>> On 5/6/2022 5:14 AM, Suzuki K Poulose wrote:
>>> Hi,
>>>
>>> On 04/05/2022 12:28, Sai Prakash Ranjan wrote:
>>>> Per discussion in [1], it was decided to move to using architecture
>>>> independent/asm-generic IO memory barriers to have just one set of
>>>> them and deprecate use of arm64 specific IO memory barriers in driver
>>>> code. So replace current usage of __io_rmb()/__iowmb() in drivers to
>>>> __io_ar()/__io_bw().
>>>>
>>>> [1] https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/
>>>>
>>>
>>> Looking at the dis-assembly it looks like in effect they are slightly
>>> different for arm64.
>>>
>>> i.e., before this patch we had
>>>
>>> "dmb osh{ld/st}"
>>>
>>> and after the patch we have :
>>>
>>> "dsb {ld/st}"
>>>
>>> Is this really what we want ? I don't think this is desirable.
>>>
>>> Suzuki
>>>
>>
>> No, this is not supposed to happen and I do not see how it could happen.
>> __io_ar() is defined as __iormb() and __io_bw() is __iowmb().
>>
>> I checked the disassembly in both case with MMIO trace off/on with __etm4_cpu_save()
>> as below and saw the same number of "dmb"s.
>>
>> aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" vmlinux-without-mmio
>> aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" vmlinux-with-mmio
>>
>> Can you tell me how are you validating if I am missing something?
>
> Apologies, I was missing the patch in this series, which adds
> the arm64 definition for __io_ar/__io_bw. (hint: Please Cc
> the affected subsystem in the Cover letter for the series, so
> we know what the intention of the changes are).
>

Sure, I will keep this in mind, apologies for the confusion.

> With the patch1, yes this makes sense to me. Otherwise, __io_ar()
> is default to rmb() which implies dsb ld.
>
> With that said,
>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks,
Sai
