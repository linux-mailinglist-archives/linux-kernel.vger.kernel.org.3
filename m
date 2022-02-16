Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0A4B8E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236741AbiBPQzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:55:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234355AbiBPQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:55:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AE329410F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:55:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A38D6B81F94
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 16:55:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10833C004E1;
        Wed, 16 Feb 2022 16:55:07 +0000 (UTC)
Date:   Wed, 16 Feb 2022 11:55:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Oscar Shiang <oscar0225@livemail.tw>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix inconsistent style of mini-HOWTO
Message-ID: <20220216115506.790ee23e@gandalf.local.home>
In-Reply-To: <TYCP286MB19130AA4A9C6FC5A8793DED2A1359@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB19130AA4A9C6FC5A8793DED2A1359@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
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

On Thu, 17 Feb 2022 00:50:06 +0800
Oscar Shiang <oscar0225@livemail.tw> wrote:

> Each description should start with a hyphen and a space. Insert
> spaces to fix it.
> 

I can take this, but there's a possibility that it will be reverted. The
output of the README in the tracefs file is an API. That is, the content of
the text is used to determine what version and what options of tracing is
enabled.

If something is scanning for the trace_clock or timestamp_mode lines, doing
an exact match of the entire context, this could break that code. If
there's any report of that happening (and we should look for anything that
might do that), then this will need to be reverted.

-- Steve


> Signed-off-by: Oscar Shiang <oscar0225@livemail.tw>
> ---
>  kernel/trace/trace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7c2578efd..a0d10e949 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5458,7 +5458,7 @@ static const char readme_msg[] =
>         "  error_log\t- error log for failed commands (that support it)\n"
>         "  buffer_size_kb\t- view and modify size of per cpu buffer\n"
>         "  buffer_total_size_kb  - view total size of all cpu buffers\n\n"
> -       "  trace_clock\t\t-change the clock used to order events\n"
> +       "  trace_clock\t\t- change the clock used to order events\n"
>         "       local:   Per cpu clock but may not be synced across CPUs\n"
>         "      global:   Synced across CPUs but slows tracing down.\n"
>         "     counter:   Not a clock, but just an increment\n"
> @@ -5467,7 +5467,7 @@ static const char readme_msg[] =
>  #ifdef CONFIG_X86_64
>         "     x86-tsc:   TSC cycle counter\n"
>  #endif
> -       "\n  timestamp_mode\t-view the mode used to timestamp events\n"
> +       "\n  timestamp_mode\t- view the mode used to timestamp events\n"
>         "       delta:   Delta difference against a buffer-wide timestamp\n"
>         "    absolute:   Absolute (standalone) timestamp\n"
>         "\n  trace_marker\t\t- Writes into this file writes into the kernel buffer\n"
> --
> 2.25.1

