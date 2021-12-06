Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E759469345
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbhLFKVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:21:22 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28463 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhLFKVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638785873; x=1670321873;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PVV29sV4We6F1jIZFYY+8jqv0ousRDeLGhpOB6Yv/TY=;
  b=yLtslN6/a0eEDaS4+3/+9Hu433XGnpvG0Kdfc4TD/Q7memr1SVtlMKLs
   SsN/Q9VUsNtEgSJSv5xkBNfMFIemMvUmLZrLjU7HCBuA+3JJ8HFA3HQMe
   WsCOJ/Y2hzpLtOl3durBMhlrwrklO4HnKryBUwB9mGIsezRUk0h0sxw8B
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 02:17:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 02:17:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 02:17:48 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 02:12:42 -0800
Message-ID: <09a477b7-4219-756d-ed72-96fcdeb6a77b@quicinc.com>
Date:   Mon, 6 Dec 2021 15:41:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 3/4] tracing: Add register read/write tracing support
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marc Zyngier <maz@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        <quic_psodagud@quicinc.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <e088f4b4021f2e56093c7f73e77f556059e114b7.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a1wOEkoteJRu+qpE0k3gJ0fRnwfn1Zrtcnmgn5wT4yQdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 2:29 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
>> index 420ff4bc67fd..9f55bcc51de1 100644
>> --- a/kernel/trace/Kconfig
>> +++ b/kernel/trace/Kconfig
>> @@ -95,6 +95,13 @@ config RING_BUFFER_ALLOW_SWAP
>>           Allow the use of ring_buffer_swap_cpu.
>>           Adds a very slight overhead to tracing when enabled.
>>
>> +config TRACE_MMIO_ACCESS
>> +       bool "Register read/write tracing"
>> +       depends on TRACING
>> +       help
>> +         Create tracepoints for MMIO read/write operations. These trace events
>> +         can be used for logging all MMIO read/write operations.
> I think this needs a 'depends on ARCH_HAVE_TRACE_MMIO_ACCESS'
> or similar.

Sure, will add it.

>> +void log_read_mmio(u8 width, const volatile void __iomem *addr)
>> +{
>> +       trace_rwmmio_read(CALLER_ADDR0, CALLER_ADDR1, width, addr);
>> +}
> Here, it may be better to pass the caller address as an argument, I think
> CALLER_ADDR1 is not always reliable, though it's possible that it is
> in the configurations when this file gets enabled.
>
>

Do you mean that we use __builtin_return_address(0,1) directly here or 
that I pass
__func__ as the argument to log_read/write_mmio or is there some other 
way to
pass the caller address?

Thanks,
Sai
