Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D76587E76
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237356AbiHBO45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbiHBO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:56:55 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0141CB16
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 07:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86371CE1FE3
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF90C433C1;
        Tue,  2 Aug 2022 14:56:47 +0000 (UTC)
Date:   Tue, 2 Aug 2022 10:56:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Tom Zanussi <zanussi@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Add .percent suffix option to histogram
 values
Message-ID: <20220802105646.50819088@gandalf.local.home>
In-Reply-To: <202208021438.2r5RXlo9-lkp@intel.com>
References: <165932284978.2881436.13536997915615710506.stgit@devnote2>
        <202208021438.2r5RXlo9-lkp@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Aug 2022 14:49:36 +0800
kernel test robot <lkp@intel.com> wrote:

> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: __udivdi3  

This is due to this:

> @@ -5190,18 +5202,34 @@ static void hist_trigger_print_key(struct seq_file *m,
>  	seq_puts(m, "}");
>  }
>  
> +/* Get the 100 times of the percentage of @val in @total */
> +static inline unsigned int __get_percentage(u64 val, u64 total)
> +{
> +	if (val < (U64_MAX / 10000))
> +		return (unsigned int)(val * 10000 / total);
> +	else
> +		return val / (total / 10000);
> +}
> +

You can't use '/' on u64 values. You have to use div64*(). Otherwise 32 bit
architectures may use floating point operations or glibc helpers.

See the other divisions in trace_events_hist.c that do so too.

-- Steve


>    >>> referenced by trace_events_hist.c:5211 (kernel/trace/trace_events_hist.c:5211)
>    >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
>    >>> referenced by trace_events_hist.c:0 (kernel/trace/trace_events_hist.c:0)
>    >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
>    >>> referenced by trace_events_hist.c:5211 (kernel/trace/trace_events_hist.c:5211)
>    >>>               trace/trace_events_hist.o:(hist_show) in archive kernel/built-in.a
>    >>> referenced 1 more times  

