Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3083F4C2DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235273AbiBXN57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiBXN5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:57:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C3B23BD;
        Thu, 24 Feb 2022 05:57:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41C74B825F5;
        Thu, 24 Feb 2022 13:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EDDAC340EC;
        Thu, 24 Feb 2022 13:57:20 +0000 (UTC)
Date:   Thu, 24 Feb 2022 08:57:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, "Marc Zyngier" <maz@kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, gregkh <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Prasad Sodagudi" <psodagud@codeaurora.org>
Subject: Re: [PATCHv10 5/6] lib: Add register read/write tracing support
Message-ID: <20220224085718.2e0b8b46@gandalf.local.home>
In-Reply-To: <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
References: <cover.1644824638.git.quic_saipraka@quicinc.com>
        <8cf9304d9941c25d920c4835cbc624ff5c2ac2cb.1644824638.git.quic_saipraka@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 11:37:07 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:


> --- /dev/null
> +++ b/include/trace/events/rwmmio.h
> @@ -0,0 +1,97 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM rwmmio
> +
> +#if !defined(_TRACE_RWMMIO_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_RWMMIO_H
> +
> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(rwmmio_rw_template,
> +
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
> +
> +	TP_ARGS(caller, val, width, addr),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, caller)
> +		__field(u64, val)
> +		__field(u64, addr)

So caller and addr are both pointers. Why not define them as unsigned long?
That will save 8 bytes on 32 bit machines.

		__field(unsigned long, caller)
		__field(unsigned long, addr)
		__feild(u64, val)

to keep the longs together as on 32 bit, it will be better aligned.

The tracing tools can handle the difference from user space. Even when
reading trace files from 32 bit architectures on 64 bit machines, and vise
versa.

> +		__field(u8, width)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->caller = caller;
> +		__entry->val = val;
> +		__entry->addr = (unsigned long)(void *)addr;
> +		__entry->width = width;
> +	),
> +
> +	TP_printk("%pS width=%d val=%#llx addr=%#llx",
> +		(void *)(unsigned long)__entry->caller, __entry->width,
> +		__entry->val, __entry->addr)
> +);
> +
> +DEFINE_EVENT(rwmmio_rw_template, rwmmio_write,
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
> +	TP_ARGS(caller, val, width, addr)
> +);
> +
> +DEFINE_EVENT(rwmmio_rw_template, rwmmio_post_write,
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
> +	TP_ARGS(caller, val, width, addr)
> +);
> +
> +TRACE_EVENT(rwmmio_read,
> +
> +	TP_PROTO(unsigned long caller, u8 width, const volatile void __iomem *addr),
> +
> +	TP_ARGS(caller, width, addr),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, caller)
> +		__field(u64, addr)

Same here.

-- Steve

> +		__field(u8, width)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->caller = caller;
> +		__entry->addr = (unsigned long)(void *)addr;
> +		__entry->width = width;
> +	),
> +
> +	TP_printk("%pS width=%d addr=%#llx",
> +		 (void *)(unsigned long)__entry->caller, __entry->width, __entry->addr)
> +);
> +
> +TRACE_EVENT(rwmmio_post_read,
> +
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
> +
> +	TP_ARGS(caller, val, width, addr),
> +
> +	TP_STRUCT__entry(
> +		__field(u64, caller)
> +		__field(u64, val)
> +		__field(u64, addr)
> +		__field(u8, width)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->caller = caller;
> +		__entry->val = val;
> +		__entry->addr = (unsigned long)(void *)addr;
> +		__entry->width = width;
> +	),
> +
> +	TP_printk("%pS width=%d val=%#llx addr=%#llx",
> +		 (void *)(unsigned long)__entry->caller, __entry->width,
> +		 __entry->val, __entry->addr)
> +);
> +
> +#endif /* _TRACE_RWMMIO_H */
> +
> +#include <trace/define_trace.h>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index c80fde816a7e..ea520c315c0f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -119,6 +119,13 @@ config INDIRECT_IOMEM_FALLBACK
>  	  mmio accesses when the IO memory address is not a registered
>  	  emulated region.
>  
> +config TRACE_MMIO_ACCESS
> +	bool "Register read/write tracing"
> +	depends on TRACING && ARCH_HAVE_TRACE_MMIO_ACCESS
> +	help
> +	  Create tracepoints for MMIO read/write operations. These trace events
> +	  can be used for logging all MMIO read/write operations.
> +
>  source "lib/crypto/Kconfig"
>  
>  config CRC_CCITT
> diff --git a/lib/Makefile b/lib/Makefile
> index 300f569c626b..43813b0061cd 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -152,6 +152,8 @@ lib-y += logic_pio.o
>  
>  lib-$(CONFIG_INDIRECT_IOMEM) += logic_iomem.o
>  
> +obj-$(CONFIG_TRACE_MMIO_ACCESS) += trace_readwrite.o
> +
>  obj-$(CONFIG_GENERIC_HWEIGHT) += hweight.o
>  
>  obj-$(CONFIG_BTREE) += btree.o
> diff --git a/lib/trace_readwrite.c b/lib/trace_readwrite.c
> new file mode 100644
> index 000000000000..88637038b30c
> --- /dev/null
> +++ b/lib/trace_readwrite.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Register read and write tracepoints
> + *
> + * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/ftrace.h>
> +#include <linux/module.h>
> +#include <asm-generic/io.h>
> +
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/rwmmio.h>
> +
> +#ifdef CONFIG_TRACE_MMIO_ACCESS
> +void log_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +		    unsigned long caller_addr)
> +{
> +	trace_rwmmio_write(caller_addr, val, width, addr);
> +}
> +EXPORT_SYMBOL_GPL(log_write_mmio);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_write);
> +
> +void log_post_write_mmio(u64 val, u8 width, volatile void __iomem *addr,
> +			 unsigned long caller_addr)
> +{
> +	trace_rwmmio_post_write(caller_addr, val, width, addr);
> +}
> +EXPORT_SYMBOL_GPL(log_post_write_mmio);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_write);
> +
> +void log_read_mmio(u8 width, const volatile void __iomem *addr,
> +		   unsigned long caller_addr)
> +{
> +	trace_rwmmio_read(caller_addr, width, addr);
> +}
> +EXPORT_SYMBOL_GPL(log_read_mmio);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_read);
> +
> +void log_post_read_mmio(u64 val, u8 width, const volatile void __iomem *addr,
> +			unsigned long caller_addr)
> +{
> +	trace_rwmmio_post_read(caller_addr, val, width, addr);
> +}
> +EXPORT_SYMBOL_GPL(log_post_read_mmio);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(rwmmio_post_read);
> +#endif /* CONFIG_TRACE_MMIO_ACCESS */

