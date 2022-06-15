Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A3154BF1C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbiFOBP4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Jun 2022 21:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:15:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9791837D;
        Tue, 14 Jun 2022 18:15:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC74B6195E;
        Wed, 15 Jun 2022 01:15:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EF2C3411B;
        Wed, 15 Jun 2022 01:15:52 +0000 (UTC)
Date:   Tue, 14 Jun 2022 21:15:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     alison.schofield@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] trace, cxl: Introduce a TRACE_EVENT for CXL Poison
 Records
Message-ID: <20220614211550.335dde60@gandalf.local.home>
In-Reply-To: <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022 17:10:26 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add a trace event for CXL Poison List Media Error Records that
> includes the starting DPA of the poison, the length, and the
> the source of the poison.
> 
> This trace event will be used by the CXL_MEM driver to log the
> Media Errors returned by the GET_POISON_LIST Mailbox command.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  include/trace/events/cxl.h | 60 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 include/trace/events/cxl.h
> 
> diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
> new file mode 100644
> index 000000000000..17e707c3817e
> --- /dev/null
> +++ b/include/trace/events/cxl.h
> @@ -0,0 +1,60 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cxl
> +
> +#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
> +#define _CXL_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_UNKNOWN);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INTERNAL);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_EXTERNAL);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INJECTED);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_VENDOR);
> +TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INVALID);
> +
> +#define show_poison_source(source)					\
> +	__print_symbolic(source,					\
> +			{CXL_POISON_SOURCE_UNKNOWN,  "UNKNOWN"},	\
> +			{CXL_POISON_SOURCE_EXTERNAL, "EXTERNAL"},	\
> +			{CXL_POISON_SOURCE_INTERNAL, "INTERNAL"},	\
> +			{CXL_POISON_SOURCE_INJECTED, "INJECTED"},	\
> +			{CXL_POISON_SOURCE_VENDOR,   "VENDOR"},		\
> +			{CXL_POISON_SOURCE_INVALID,  "INVALID"})
> +
> +TRACE_EVENT(cxl_poison_list,
> +
> +	    TP_PROTO(struct device *dev,
> +		     int source,
> +		     unsigned long start,
> +		     unsigned int length),
> +
> +	    TP_ARGS(dev, source, start, length),
> +
> +	    TP_STRUCT__entry(
> +		__string(name, dev_name(dev))
> +		__field(int, source)
> +		__field(u64, start)
> +		__field(u32, length)

OK, the above order should be fine, without adding any holes. The
__string() is 4 bytes as well as the "int". Which keeps it aligned with the
u64 (8 bytes), followed by a u32, which is 4 bytes.

From a tracing perspective:

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve


> +	    ),
> +
> +	    TP_fast_assign(
> +		__assign_str(name, dev_name(dev));
> +		__entry->source = source;
> +		__entry->start = start;
> +		__entry->length = length;
> +	    ),
> +
> +	    TP_printk("dev %s source %s start %llu length %u",
> +		__get_str(name),
> +		show_poison_source(__entry->source),
> +		__entry->start,
> +		__entry->length)
> +);
> +#endif /* _CXL_TRACE_H */
> +
> +/* This part must be outside protection */
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cxl
> +#include <trace/define_trace.h>

