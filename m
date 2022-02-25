Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCBF4C3CC6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 04:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiBYD4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 22:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237170AbiBYD4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 22:56:14 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BBEE338C;
        Thu, 24 Feb 2022 19:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645761343; x=1677297343;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7bNqhz0mQyZAE8fDoMqXVFB3mxjRItk/hMbBOLGdooE=;
  b=CdqyAOlFATjoWyCG1brZhW5cgPP+GQeOGgTjGQ7/lXMVyYBcNDtEhghY
   oDMYc4kRclnHjSq9rnsdFYt4N09AODvOqZpZ+X8p5pquwbhWUABnzOjNT
   YUr6OJon+8MvS5fCOPcz6uwCKB8E631VdES6yAWXGFmyrNt3sIvmJWivX
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 24 Feb 2022 19:55:43 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 19:55:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Thu, 24 Feb 2022 19:55:42 -0800
Received: from [10.50.41.45] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Thu, 24 Feb
 2022 19:55:37 -0800
Message-ID: <8ab2db1c-ba63-e184-e27b-aaf17843bceb@quicinc.com>
Date:   Fri, 25 Feb 2022 09:25:33 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCHv10 5/6] lib: Add register read/write tracing support
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, gregkh <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Prasad Sodagudi" <psodagud@codeaurora.org>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
 <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
 <20220224085718.2e0b8b46@gandalf.local.home>
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
In-Reply-To: <20220224085718.2e0b8b46@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

On 2/24/2022 7:27 PM, Steven Rostedt wrote:
> On Thu, 24 Feb 2022 11:37:07 +0530
> Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:
>
>
>> --- /dev/null
>> +++ b/include/trace/events/rwmmio.h
>> @@ -0,0 +1,97 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM rwmmio
>> +
>> +#if !defined(_TRACE_RWMMIO_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_RWMMIO_H
>> +
>> +#include <linux/tracepoint.h>
>> +
>> +DECLARE_EVENT_CLASS(rwmmio_rw_template,
>> +
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
>> +
>> +	TP_ARGS(caller, val, width, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u64, caller)
>> +		__field(u64, val)
>> +		__field(u64, addr)
> So caller and addr are both pointers. Why not define them as unsigned long?
> That will save 8 bytes on 32 bit machines.
>
> 		__field(unsigned long, caller)
> 		__field(unsigned long, addr)
> 		__feild(u64, val)
>
> to keep the longs together as on 32 bit, it will be better aligned.
>
> The tracing tools can handle the difference from user space. Even when
> reading trace files from 32 bit architectures on 64 bit machines, and vise
> versa.

Sure, I'll change them to unsigned long. Thanks for the suggestion.

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
>> +	TP_printk("%pS width=%d val=%#llx addr=%#llx",
>> +		(void *)(unsigned long)__entry->caller, __entry->width,
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
>> +		__field(u64, caller)
>> +		__field(u64, addr)
> Same here.
>
> -- Steve

Sure.

Thanks,
Sai

>
>> +		__field(u8, width)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->caller = caller;
>> +		__entry->addr = (unsigned long)(void *)addr;
>> +		__entry->width = width;
>> +	),
>> +
>> +	TP_printk("%pS width=%d addr=%#llx",
>> +		 (void *)(unsigned long)__entry->caller, __entry->width, __entry->addr)
>> +);
>> +
>> +TRACE_EVENT(rwmmio_post_read,
>> +
>> +	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
>> +
>> +	TP_ARGS(caller, val, width, addr),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(u64, caller)
>> +		__field(u64, val)
>> +		__field(u64, addr)
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
>> +	TP_printk("%pS width=%d val=%#llx addr=%#llx",
>> +		 (void *)(unsigned long)__entry->caller, __entry->width,
>> +		 __entry->val, __entry->addr)
>> +);
>> +
>> +#endif /* _TRACE_RWMMIO_H */
>> +
>> +#include <trace/define_trace.h>
>> diff --git a/lib/Kconfig b/lib/Kconfig
>> index c80fde816a7e..ea520c315c0f 100644
>> --- a/lib/Kconfig
>> +++ b/lib/Kconfig
>> @@ -119,6 +119,13 @@ config INDIRECT_IOMEM_FALLBACK
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
>> index 300f569c626b..43813b0061cd 100644
>> --- a/lib/Makefile
>> +++ b/lib/Makefile
>> @@ -152,6 +152,8 @@ lib-y += logic_pio.o
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


