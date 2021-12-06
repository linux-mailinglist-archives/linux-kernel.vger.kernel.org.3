Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A2469302
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241561AbhLFJ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:56:36 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:19403 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241535AbhLFJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:56:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638784386; x=1670320386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TfUheKrOCFb8cBYCHV4oO6MJPLAM3m4daldd6IgL5qw=;
  b=YXk2G0ExtYv01clYrmxr+Gi9dZ8MIsQQrA8fMziJjHAOg3Lz/qBvs+sI
   FMgkEvyndwV4frywttDoK3gSfjPX8UgZyzsie5Rk2/f+7u9y3f7UlXeLI
   rv4zjwQv6jBW2svtp5XqDF+C39Q0UtrM0O0X7SSvN80SUT5PhDyIV4AKW
   Y=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Dec 2021 01:53:06 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 01:53:01 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 6 Dec 2021 01:53:00 -0800
Received: from [10.50.43.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Mon, 6 Dec 2021
 01:52:56 -0800
Message-ID: <0cd0bc8c-e3db-b3fb-5be4-c619d1d5d633@quicinc.com>
Date:   Mon, 6 Dec 2021 15:22:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv5 4/4] asm-generic/io: Add logging support for MMIO
 accessors
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
        <quic_psodagud@quicinc.com>
References: <cover.1638275062.git.quic_saipraka@quicinc.com>
 <99ecc64c6da3abb3ea2930082c40f1820655664c.1638275062.git.quic_saipraka@quicinc.com>
 <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <CAK8P3a1k-1_m7r-u0uO1nW1m43bt_hR9u+UeW=SqK40+Ltb+iA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/2021 2:39 PM, Arnd Bergmann wrote:
> On Mon, Dec 6, 2021 at 9:28 AM Sai Prakash Ranjan
> <quic_saipraka@quicinc.com> wrote:
>> +#if IS_ENABLED(CONFIG_TRACE_MMIO_ACCESS) && !(defined(__DISABLE_TRACE_MMIO__))
>> +#include <linux/tracepoint-defs.h>
>> +
>> +DECLARE_TRACEPOINT(rwmmio_write);
>> +DECLARE_TRACEPOINT(rwmmio_read);
>> +
>> +#define rwmmio_tracepoint_active(t) tracepoint_enabled(t)
>> +void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr);
>> +void log_read_mmio(u8 width, const volatile void __iomem *addr);
>> +
>> +#else
>> +
>> +#define rwmmio_tracepoint_active(t) false
>> +static inline void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr) {}
>> +static inline void log_read_mmio(u8 width, const volatile void __iomem *addr) {}
>> +
>> +#endif /* CONFIG_TRACE_MMIO_ACCESS */
>>
>>   /*
>>    * __raw_{read,write}{b,w,l,q}() access memory in native endianness.
>> @@ -149,6 +166,8 @@ static inline u8 readb(const volatile void __iomem *addr)
>>   {
>>          u8 val;
>>
>> +       if (rwmmio_tracepoint_active(rwmmio_read))
>> +               log_read_mmio(8, addr);
>>          __io_br();
>>          val = __raw_readb(addr);
>>          __io_ar(val);
> For readability, it may be nicer to fold the two lines you add for each
> helper into one, such as
>
> void __log_write_mmio(u64 val, u8 width, volatile void __iomem *addr);
> #define log_write_mmio(val, widtg, addr) do { \
>       if (tracepoint_enabled(rwmmio_read)) \
>                 __log_write_mmio((val), (width), (addr)); \
> } while (0)
>
> I wonder if it may even be better to not check for tracepoint_active() in the
> inline function at all but always enter the external function when built-in.
> This means we do run into the branch, but it also reduces the i-cache footprint.

Right, we don't need the tracepoint active check as we declare the 
tracepoint only when the config is
enabled so I can just call log_{read,write}_mmio directly.

> For general functionality, I think it would be better to trace the returned
> value from the read, but I don't know if that defeats the purpose you
> are interested in, since it requires the tracing to come after the __raw_read.
>
>         

Yes just the trace after read/write won't serve our usecase where we 
expect crashes/hangs on accessing
these registers but internally we did have a log_post_read_mmio() as 
well, if it is useful then I can add it.

Thanks,
Sai
