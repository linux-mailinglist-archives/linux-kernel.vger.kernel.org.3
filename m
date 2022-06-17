Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8B154FAF0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383223AbiFQQRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383009AbiFQQRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:17:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346423178;
        Fri, 17 Jun 2022 09:17:14 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LPkc658G4z67NJj;
        Sat, 18 Jun 2022 00:13:26 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 17 Jun 2022 18:17:12 +0200
Received: from localhost (10.81.209.131) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Fri, 17 Jun
 2022 17:17:11 +0100
Date:   Fri, 17 Jun 2022 17:17:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] trace, cxl: Introduce a TRACE_EVENT for CXL Poison
 Records
Message-ID: <20220617171707.00001c84@Huawei.com>
In-Reply-To: <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
References: <cover.1655250669.git.alison.schofield@intel.com>
        <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.131]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Some comments on how this is used than the actual trace point for which

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The patch set currently just pushes through the length as provided
in the CXL record.  That is in units of 64 byte cachelines so I'd suggest
the result will be more readable if we multiply it up to be in bytes.

Also the address should be masked to the same length, but I mentioned that
at the caller.

Jonathan


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

