Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875FE54EA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiFPTqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 15:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiFPTqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 15:46:03 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998EF58E47;
        Thu, 16 Jun 2022 12:46:01 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BCDED6C1EAE;
        Thu, 16 Jun 2022 19:46:00 +0000 (UTC)
Received: from pdx1-sub0-mail-a312.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id AF7996C18FE;
        Thu, 16 Jun 2022 19:45:59 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1655408760; a=rsa-sha256;
        cv=none;
        b=LFI3oZzhp8nI4A9FAFyoAVY/uUhPvSCavYPFVjobzGzqLm68jeez/zMAGnfg53+3NWyXKd
        l5CSBpeSb5V6Dl5pTZYi1dmC21CElt6JlT/eP8vYy8uVGFrV3Prs2iEl81e/cpKbJ/9xus
        HvHBn2PoOmHLUQNt7Dba18HdIBywOZ88YTkC24vrEUcGHtdFBoQ4JZlIMGQvI29Uqo9e9G
        HhewtdjHO6gtsG8tPFRT7fY4i3+x4HdnwuIYLa5LhnrlOmn8IA1CZx7KOzQnhRnxy5an2X
        jy420Zya1i/Dr8D0SftYZyCwsfYUFOtc0jqpW3N2V0lxM4IhhN4BfSVhFSIZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1655408760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=LtgRJbay2NJBh9NnnRVdPmX1G1OKRq+xJ0Jn94eAvOo=;
        b=d6Fg37MmGo5c4qVumnPN+3sfwdD5cY7ofaAQBbT1IGr8l0j54Mc49SO2ct0g+1LP8uTbWF
        +nEIYvGtjUWQjSasb3SgpDzyabdc6rIGLLrsOxNkjxVEtJHey0O5rpJ9nWP30B3Btfkqkf
        E7ZYnYN8nFJwpTkdf2XbzRRyS+zyZvb5r8cmEI5DNGeWu3jZadaRIzpIC4FiFCGmi3FYrD
        GilEy4cFqxjwKMosHrbFNi5M1WhZkwXYXhchM83/VNcVwYyg2hMW0z0tJXqFsYZdgyjgvt
        EM6gpZ1ieDBFqvlaNGy1TipB912QsBY/nbTjxAN34FJmwXZCEpn/0JA/65Tuew==
ARC-Authentication-Results: i=1;
        rspamd-786f5898df-g7jcn;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Fumbling-Industry: 243f44d20affeaab_1655408760299_3844997658
X-MC-Loop-Signature: 1655408760299:2357453851
X-MC-Ingress-Time: 1655408760299
Received: from pdx1-sub0-mail-a312.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.179 (trex/6.7.1);
        Thu, 16 Jun 2022 19:46:00 +0000
Received: from offworld (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a312.dreamhost.com (Postfix) with ESMTPSA id 4LPCMp3VjlzCd;
        Thu, 16 Jun 2022 12:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1655408759;
        bh=LtgRJbay2NJBh9NnnRVdPmX1G1OKRq+xJ0Jn94eAvOo=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=LAyVgVF+kNrFORxl+qJMPbk7y37I6M1Aay9bVKptc23dhb+aJLW4qRWnqWsGCIr/F
         y5D1fON3vKZ0Ip/LDLaElrM3yKPJ4Ng5Ph6409mM+cxcmtf7YppNSURcVw7NnhiuJg
         xhQmfA4EZNANXXlmBV0EMuOKDKESk+N89WheJE3rwV/Lun/lmlH5SZNEfYrjhfK4zf
         6VRzeB9EPYHtEsYKWHJ4I+7CG/4to3vPSQzQ95v606VVhBaOy4yBjVo9QDfOVUpnXS
         TphsXVBP3L9hPSFvWsZVHaGu+U85jfjxqybzVCrci5FnaHboE2iTFmIziddskfl77Y
         v1wS2+k7oa9UQ==
Date:   Thu, 16 Jun 2022 12:45:55 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "alison.schofield@intel.com" <alison.schofield@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, a.manzanares@samsung.com
Subject: Re: [PATCH 1/3] trace, cxl: Introduce a TRACE_EVENT for CXL Poison
 Records
Message-ID: <20220616194555.ps5ur2plizreqzwh@offworld>
References: <cover.1655250669.git.alison.schofield@intel.com>
 <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <32a761fe7046680a4d50762fc43988def24a4bcd.1655250669.git.alison.schofield@intel.com>
User-Agent: NeoMutt/20220429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jun 2022, alison.schofield@intel.com wrote:

>From: Alison Schofield <alison.schofield@intel.com>
>
>Add a trace event for CXL Poison List Media Error Records that
>includes the starting DPA of the poison, the length, and the
>the source of the poison.
>
>This trace event will be used by the CXL_MEM driver to log the
>Media Errors returned by the GET_POISON_LIST Mailbox command.
>
>Signed-off-by: Alison Schofield <alison.schofield@intel.com>
>Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
> include/trace/events/cxl.h | 60 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 60 insertions(+)
> create mode 100644 include/trace/events/cxl.h
>
>diff --git a/include/trace/events/cxl.h b/include/trace/events/cxl.h
>new file mode 100644
>index 000000000000..17e707c3817e
>--- /dev/null
>+++ b/include/trace/events/cxl.h
>@@ -0,0 +1,60 @@
>+/* SPDX-License-Identifier: GPL-2.0 */
>+#undef TRACE_SYSTEM
>+#define TRACE_SYSTEM cxl
>+
>+#if !defined(_CXL_TRACE_H) ||  defined(TRACE_HEADER_MULTI_READ)
>+#define _CXL_TRACE_H
>+
>+#include <linux/tracepoint.h>
>+
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_UNKNOWN);
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INTERNAL);
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_EXTERNAL);
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INJECTED);
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_VENDOR);
>+TRACE_DEFINE_ENUM(CXL_POISON_SOURCE_INVALID);
>+
>+#define show_poison_source(source)					\
>+	__print_symbolic(source,					\
>+			{CXL_POISON_SOURCE_UNKNOWN,  "UNKNOWN"},	\
>+			{CXL_POISON_SOURCE_EXTERNAL, "EXTERNAL"},	\
>+			{CXL_POISON_SOURCE_INTERNAL, "INTERNAL"},	\
>+			{CXL_POISON_SOURCE_INJECTED, "INJECTED"},	\
>+			{CXL_POISON_SOURCE_VENDOR,   "VENDOR"},		\
>+			{CXL_POISON_SOURCE_INVALID,  "INVALID"})
>+
>+TRACE_EVENT(cxl_poison_list,
>+
>+	    TP_PROTO(struct device *dev,
>+		     int source,
>+		     unsigned long start,
>+		     unsigned int length),
>+
>+	    TP_ARGS(dev, source, start, length),
>+
>+	    TP_STRUCT__entry(
>+		__string(name, dev_name(dev))
>+		__field(int, source)
>+		__field(u64, start)
>+		__field(u32, length)
>+	    ),
>+
>+	    TP_fast_assign(
>+		__assign_str(name, dev_name(dev));
>+		__entry->source = source;
>+		__entry->start = start;
>+		__entry->length = length;
>+	    ),
>+
>+	    TP_printk("dev %s source %s start %llu length %u",
>+		__get_str(name),
>+		show_poison_source(__entry->source),
>+		__entry->start,
>+		__entry->length)
>+);
>+#endif /* _CXL_TRACE_H */
>+
>+/* This part must be outside protection */
>+#undef TRACE_INCLUDE_FILE
>+#define TRACE_INCLUDE_FILE cxl
>+#include <trace/define_trace.h>
>
>--
>2.31.1
>
