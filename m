Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA3B52BE95
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239266AbiERPSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239260AbiERPSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:18:25 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AD2654F;
        Wed, 18 May 2022 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652887102; x=1684423102;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S+bP0S2XQ8gBknUNWWxauT1t7+ZYAfY6nISGcCKh9B4=;
  b=XJkSsgQKYhYohFR+/xFpuyt3ur72FWMyggaDsTVEg5RQVvCYbfd1oMRv
   X0UetSCUKhKz8MZ3jvmnlgrW3suDpqDq1tBUwrKl3I9+by1FbugSLZU8M
   nuHe+B6k2GDSQBvy6ww5osh5ZOJPzRHIoypJ4wCOxL/smZUUI7D9XWjvn
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 May 2022 08:18:22 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 08:18:21 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 08:18:21 -0700
Received: from [10.50.12.117] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 08:18:17 -0700
Message-ID: <c696ebfc-9a2a-7b12-7297-3be8a31a82d3@quicinc.com>
Date:   Wed, 18 May 2022 20:48:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv14 5/9] lib: Add register read/write tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <9827bae40f6f319f294d06859c9e3c7442f067f2.1651663123.git.quic_saipraka@quicinc.com>
 <20220518100721.18fb5876@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220518100721.18fb5876@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On 5/18/2022 7:37 PM, Steven Rostedt wrote:
> On Wed, 4 May 2022 16:58:24 +0530
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>
>> +#include <linux/tracepoint.h>
>> +
>> +DECLARE_EVENT_CLASS(rwmmio_rw_template,
>> +
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
>> +
>> +	TP_ARGS(caller, val, width, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, caller)
>> +		__field(unsigned long, addr)
>> +		__field(u64, val)
>> +		__field(u8, width)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->caller = caller;
>> +		__entry->val = val;
>> +		__entry->addr = (unsigned long)(void *)addr;
>> +		__entry->width = width;
>> +	),
>> +
>> +	TP_printk("%pS width=%d val=%#llx addr=%#lx",
>> +		(void *)(unsigned long)__entry->caller, __entry->width,
> __entry->caller is already defined as "unsigned long", why the extra
> typecast?

I remember seeing compilation errors without this change in early versions of
the series. Let me check this again.


>> +		__entry->val, __entry->addr)
>> +);
>> +
>> +DEFINE_EVENT(rwmmio_rw_template, rwmmio_write,
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
>> +	TP_ARGS(caller, val, width, addr)
>> +);
>> +
>> +DEFINE_EVENT(rwmmio_rw_template, rwmmio_post_write,
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
>> +	TP_ARGS(caller, val, width, addr)
>> +);
>> +
>> +TRACE_EVENT(rwmmio_read,
>> +
>> +	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
>> +
>> +	TP_ARGS(caller, width, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, caller)
>> +		__field(unsigned long, addr)
>> +		__field(u8, width)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->caller = caller;
>> +		__entry->addr = (unsigned long)(void *)addr;
>> +		__entry->width = width;
>> +	),
>> +
>> +	TP_printk("%pS width=%d addr=%#lx",
>> +		 (void *)(unsigned long)__entry->caller, __entry->width, __entry->addr)
>
> Same here.

Same as above.

>> +);
>> +
>> +TRACE_EVENT(rwmmio_post_read,
>> +
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
>> +
>> +	TP_ARGS(caller, val, width, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, caller)
>> +		__field(unsigned long, addr)
>> +		__field(u64, val)
>> +		__field(u8, width)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->caller = caller;
>> +		__entry->val = val;
>> +		__entry->addr = (unsigned long)(void *)addr;
>> +		__entry->width = width;
>> +	),
>> +
>> +	TP_printk("%pS width=%d val=%#llx addr=%#lx",
>> +		 (void *)(unsigned long)__entry->caller, __entry->width,
> And here.

Same as above.

>> +		 __entry->val, __entry->addr)
>> +);
>> +
>> +#endif /* _TRACE_RWMMIO_H */
>> +
>> +#include <trace/define_trace.h>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index 087e06b4cdfd..5e2fd075724f 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -118,6 +118,13 @@ config INDIRECT_IOMEM_FALLBACK
>>   	  mmio accesses when the IO memory address is not a registered
>>   	  emulated region.
>>   
>> +config TRACE_MMIO_ACCESS
>> +	bool "Register read/write tracing"
>> +	depends on TRACING && ARCH_HAVE_TRACE_MMIO_ACCESS
>> +	help
>> +	  Create tracepoints for MMIO read/write operations. These trace events
>> +	  can be used for logging all MMIO read/write operations.
>> +
>>   source "lib/crypto/Kconfig"
>>   
>>   config CRC_CCITT
>> diff --git a/lib/Makefile b/lib/Makefile
>> index 6b9ffc1bd1ee..3df7d24e65d2 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -151,6 +151,8 @@ lib-y += logic_pio.o
>>   
>>   lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
>>   
>> +obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
>> +
>>   obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
>>   
>>   obj-$(CONFIG_BTREE) += btree.o
>> diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
>> new file mode 100644
>> index 000000000000..88637038b30c
>> --- /dev/null
>> +++ b/lib/trace_readwrite.c
>> @@ -0,0 +1,47 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Register read and write tracepoints
>> + *
>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#include <linux/ftrace.h>
>> +#include <linux/module.h>
>> +#include <asm-generic/io.h>
>> +
>> +#define CREATE_TRACE_POINTS
>> +#include <trace/events/rwmmio.h>
>> +
>> +#ifdef CONFIG_TRACE_MMIO_ACCESS
>> +void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> Where's the header file that defines these functions? I would think it
> should be in this patch as well.

It is present in "include/asm-generic/io.h" which is already included above.

Thanks,
Sai

> -- Steve
>
>
>> +		    unsigned long caller_addr)
>> +{
>> +	trace_rwmmio_write(caller_addr, val, width, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(log_write_mmio);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
>> +
>> +void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
>> +			 unsigned long caller_addr)
>> +{
>> +	trace_rwmmio_post_write(caller_addr, val, width, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(log_post_write_mmio);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_write);
>> +
>> +void log_read_mmio(u8 width, const volatile void __iomem *addr,
>> +		   unsigned long caller_addr)
>> +{
>> +	trace_rwmmio_read(caller_addr, width, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(log_read_mmio);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
>> +
>> +void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
>> +			unsigned long caller_addr)
>> +{
>> +	trace_rwmmio_post_read(caller_addr, val, width, addr);
>> +}
>> +EXPORT_SYMBOL_GPL(log_post_read_mmio);
>> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_read);
>> +#endif /* CONFIG_TRACE_MMIO_ACCESS */

