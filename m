Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B284B5A22
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 19:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239750AbiBNSnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 13:43:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238772AbiBNSnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 13:43:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF6B6AA6C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 10:42:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3660360F45
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33092C340E9;
        Mon, 14 Feb 2022 18:42:40 +0000 (UTC)
Date:   Mon, 14 Feb 2022 13:42:38 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: ensure trace buffer is at least 4096 bytes
 large
Message-ID: <20220214134238.20255872@gandalf.local.home>
In-Reply-To: <20220214134456.1751749-1-svens@linux.ibm.com>
References: <20220214134456.1751749-1-svens@linux.ibm.com>
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

On Mon, 14 Feb 2022 14:44:56 +0100
Sven Schnelle <svens@linux.ibm.com> wrote:

> Booting the kernel with 'trace_buf_size=1' give a warning at
> boot during the ftrace selftests:
> 
> [    0.892809] Running postponed tracer tests:
> [    0.892893] Testing tracer function:
> [    0.901899] Callback from call_rcu_tasks_trace() invoked.
> [    0.983829] Callback from call_rcu_tasks_rude() invoked.
> [    1.072003] .. bad ring buffer .. corrupted trace buffer ..
> [    1.091944] Callback from call_rcu_tasks() invoked.
> [    1.097695] PASSED
> [    1.097701] Testing dynamic ftrace: .. filter failed count=0 ..FAILED!
> [    1.353474] ------------[ cut here ]------------
> [    1.353478] WARNING: CPU: 0 PID: 1 at kernel/trace/trace.c:1951 run_tracer_selftest+0x13c/0x1b0
> 
> Therefore enforce a minimum of 4096 bytes to make the selftest pass.
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Thanks,

I'll queue this up for the next merge window.

-- Steve

> ---
>  kernel/trace/trace.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 7c2578efde26..3050892d1812 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -1474,10 +1474,12 @@ static int __init set_buf_size(char *str)
>  	if (!str)
>  		return 0;
>  	buf_size = memparse(str, &str);
> -	/* nr_entries can not be zero */
> -	if (buf_size == 0)
> -		return 0;
> -	trace_buf_size = buf_size;
> +	/*
> +	 * nr_entries can not be zero and the startup
> +	 * tests require some buffer space. Therefore
> +	 * ensure we have at least 4096 bytes of buffer.
> +	 */
> +	trace_buf_size = max(4096UL, buf_size);
>  	return 1;
>  }
>  __setup("trace_buf_size=", set_buf_size);

