Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B588C52BC65
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 16:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbiEROHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 10:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiEROH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 10:07:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC66A072;
        Wed, 18 May 2022 07:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16105618D8;
        Wed, 18 May 2022 14:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A89C385A9;
        Wed, 18 May 2022 14:07:23 +0000 (UTC)
Date:   Wed, 18 May 2022 10:07:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Cc:     <arnd@arndb.de>, <catalin.marinas@arm.com>,
        <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <maz@kernel.org>, <quic_psodagud@quicinc.com>,
        <quic_tsoni@quicinc.com>, <will@kernel.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>
Subject: Re: [PATCHv14 5/9] lib: Add register read/write tracing support
Message-ID: <20220518100721.18fb5876@gandalf.local.home>
In-Reply-To: <9827bae40f6f319f294d06859c9e3c7442f067f2.1651663123.git.quic_saipraka@quicinc.com>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
        <9827bae40f6f319f294d06859c9e3c7442f067f2.1651663123.git.quic_saipraka@quicinc.com>
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

On Wed, 4 May 2022 16:58:24 +0530
Sai Prakash Ranjan <quic_saipraka@quicinc.com> wrote:

> +#include <linux/tracepoint.h>
> +
> +DECLARE_EVENT_CLASS(rwmmio_rw_template,
> +
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, volatile void __iomem *addr),
> +
> +	TP_ARGS(caller, val, width, addr),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, caller)
> +		__field(unsigned long, addr)
> +		__field(u64, val)
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
> +	TP_printk("%pS width=%d val=%#llx addr=%#lx",
> +		(void *)(unsigned long)__entry->caller, __entry->width,

__entry->caller is already defined as "unsigned long", why the extra
typecast?

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
> +		__field(unsigned long, caller)
> +		__field(unsigned long, addr)
> +		__field(u8, width)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->caller = caller;
> +		__entry->addr = (unsigned long)(void *)addr;
> +		__entry->width = width;
> +	),
> +
> +	TP_printk("%pS width=%d addr=%#lx",
> +		 (void *)(unsigned long)__entry->caller, __entry->width, __entry->addr)


Same here.

> +);
> +
> +TRACE_EVENT(rwmmio_post_read,
> +
> +	TP_PROTO(unsigned long caller, u64 val, u8 width, const volatile void __iomem *addr),
> +
> +	TP_ARGS(caller, val, width, addr),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, caller)
> +		__field(unsigned long, addr)
> +		__field(u64, val)
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
> +	TP_printk("%pS width=%d val=%#llx addr=%#lx",
> +		 (void *)(unsigned long)__entry->caller, __entry->width,

And here.

> +		 __entry->val, __entry->addr)
> +);
> +
> +#endif /* _TRACE_RWMMIO_H */
> +
> +#include <trace/define_trace.h>
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 087e06b4cdfd..5e2fd075724f 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -118,6 +118,13 @@ config INDIRECT_IOMEM_FALLBACK
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
> index 6b9ffc1bd1ee..3df7d24e65d2 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -151,6 +151,8 @@ lib-y += logic_pio.o
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

Where's the header file that defines these functions? I would think it
should be in this patch as well.

-- Steve


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

