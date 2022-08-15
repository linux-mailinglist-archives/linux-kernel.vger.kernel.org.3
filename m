Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99473593423
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiHORnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiHORnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:43:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AEA167D6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:43:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 593E46122A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 17:43:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B478C433C1;
        Mon, 15 Aug 2022 17:43:08 +0000 (UTC)
Date:   Mon, 15 Aug 2022 13:43:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 07/11] tracing: trace_events_synth: Convert to printbuf
Message-ID: <20220815134314.32f3d3fc@gandalf.local.home>
In-Reply-To: <20220815172613.621627-8-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
        <20220815172613.621627-8-kent.overstreet@linux.dev>
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

On Mon, 15 Aug 2022 13:26:09 -0400
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> From: Kent Overstreet <kent.overstreet@gmail.com>
> 
> This converts from seq_buf to printbuf.
> 
> This code was using seq_buf for building up dynamically allocated
> strings; the conversion uses printbuf's heap allocation functionality to
> simplify things (no longer need to calculate size of the output string).

As I stated before. I'll look into converting the seq_bufs to printbuf for
tracing at a later date. That includes this file.

Please remove this patch from the series.

> 
> Also, alphabetize the #includes.
> 

And although the #includes are not in the order the tracing directory
prefers, that order is upside-down x-mas tree, not alphabetical.

Thanks,

-- Steve


> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/trace/trace_events_synth.c | 51 ++++++++++---------------------
>  1 file changed, 16 insertions(+), 35 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index 5e8c07aef0..720c75429c 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -5,13 +5,14 @@
>   * Copyright (C) 2015, 2020 Tom Zanussi <tom.zanussi@linux.intel.com>
>   */
>  
> -#include <linux/module.h>
>  #include <linux/kallsyms.h>
> -#include <linux/security.h>
> +#include <linux/module.h>
>  #include <linux/mutex.h>
> +#include <linux/printbuf.h>
> +#include <linux/rculist.h>
> +#include <linux/security.h>
>  #include <linux/slab.h>
>  #include <linux/stacktrace.h>
> -#include <linux/rculist.h>
>  #include <linux/tracefs.h>
>  
>  /* for gfp flag names */
> @@ -611,7 +612,7 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  	const char *prefix = NULL, *field_type = argv[0], *field_name, *array;
>  	struct synth_field *field;
>  	int len, ret = -ENOMEM;
> -	struct seq_buf s;
> +	struct printbuf buf;
>  	ssize_t size;
>  
>  	if (!strcmp(field_type, "unsigned")) {
> @@ -654,28 +655,16 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  		goto free;
>  	}
>  
> -	len = strlen(field_type) + 1;
> -
> -	if (array)
> -		len += strlen(array);
> -
> -	if (prefix)
> -		len += strlen(prefix);
> -
> -	field->type = kzalloc(len, GFP_KERNEL);
> -	if (!field->type)
> -		goto free;
> -
> -	seq_buf_init(&s, field->type, len);
> +	buf = PRINTBUF;
>  	if (prefix)
> -		seq_buf_puts(&s, prefix);
> -	seq_buf_puts(&s, field_type);
> +		prt_str(&buf, prefix);
> +	prt_str(&buf, field_type);
>  	if (array)
> -		seq_buf_puts(&s, array);
> -	if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
> +		prt_str(&buf, array);
> +	if (buf.allocation_failure)
>  		goto free;
>  
> -	s.buffer[s.len] = '\0';
> +	field->type = buf.buf;
>  
>  	size = synth_field_size(field->type);
>  	if (size < 0) {
> @@ -687,23 +676,15 @@ static struct synth_field *parse_synth_field(int argc, char **argv,
>  		goto free;
>  	} else if (size == 0) {
>  		if (synth_field_is_string(field->type)) {
> -			char *type;
> -
> -			len = sizeof("__data_loc ") + strlen(field->type) + 1;
> -			type = kzalloc(len, GFP_KERNEL);
> -			if (!type)
> -				goto free;
> -
> -			seq_buf_init(&s, type, len);
> -			seq_buf_puts(&s, "__data_loc ");
> -			seq_buf_puts(&s, field->type);
> +			buf = PRINTBUF;
> +			prt_str(&buf, "__data_loc ");
> +			prt_str(&buf, field->type);
>  
> -			if (WARN_ON_ONCE(!seq_buf_buffer_left(&s)))
> +			if (buf.allocation_failure)
>  				goto free;
> -			s.buffer[s.len] = '\0';
>  
>  			kfree(field->type);
> -			field->type = type;
> +			field->type = buf.buf;
>  
>  			field->is_dynamic = true;
>  			size = sizeof(u64);

