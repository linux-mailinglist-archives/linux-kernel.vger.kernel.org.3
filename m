Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB46469343
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 11:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234597AbhLFKVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 05:21:18 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:28463 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhLFKVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 05:21:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638785869; x=1670321869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PVV29sV4We6F1jIZFYY+8jqv0ousRDeLGhpOB6Yv/TY=;
  b=upeC+o4aYGBDmvYCZSlS3S0fQI9Yh3w1C9AAUMYiS6NWyqWfIzClyWIi
   dNGPJzU/KBneXpcnR6Z6bqInI9cxWFM096Ukj3RaOSkwnDo/DpJ28T82i
   w84txLnFbNqAskW09FjEZ71N61YW24VSUPyvdP2TzKSaw4kFq5yONoLG5
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 02:17:49 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 02:17:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 02:14:31 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 02:13:54 -0800
Message-ID: <429d1354-f128-205a-ae27-3eadd8929209@quicinc.com>
Date:   Mon, 6 Dec 2021 15:43:50 +0530
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
