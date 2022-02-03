Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1514A88BC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 17:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352313AbiBCQle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 11:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352300AbiBCQlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 11:41:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E75C061714;
        Thu,  3 Feb 2022 08:41:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 52E40CE2015;
        Thu,  3 Feb 2022 16:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D565C340E8;
        Thu,  3 Feb 2022 16:41:28 +0000 (UTC)
Date:   Thu, 3 Feb 2022 11:41:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] rtla/osnoise_top: Fix segmentation fault when
 failing to enable -t
Message-ID: <20220203114126.3ec6b37d@gandalf.local.home>
In-Reply-To: <3ef9cb911e9b51be55a874cacc847d44bca9877e.1643033113.git.bristot@kernel.org>
References: <cover.1643033113.git.bristot@kernel.org>
        <3ef9cb911e9b51be55a874cacc847d44bca9877e.1643033113.git.bristot@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 15:24:06 +0100
Daniel Bristot de Oliveira <bristot@kernel.org> wrote:

> rtla osnoise top is causing a segmentation fault when running with
> the --trace option on a kernel that does not support multiple
> instances. For example:
> 
>     [root@f34 rtla]# rtla osnoise top -t
>     failed to enable the tracer osnoise
>     Could not enable osnoiser tracer for tracing
>     Failed to enable the trace instance
>     Segmentation fault (core dumped)
> 
> This error happens because the exit code of the tools is trying
> to destroy the trace instance that failed to be created.
> 
> Rearrange the order in which trace instances are destroyed to avoid
> this problem.
> 
> Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-trace-devel@vger.kernel.org
> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> ---
>  tools/tracing/rtla/src/osnoise_top.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> index 332b2ac205fc..546769bc7ff7 100644
> --- a/tools/tracing/rtla/src/osnoise_top.c
> +++ b/tools/tracing/rtla/src/osnoise_top.c
> @@ -546,7 +546,7 @@ int osnoise_top_main(int argc, char **argv)
>  						    trace);
>  		if (retval < 0) {
>  			err_msg("Error iterating on events\n");
> -			goto out_top;
> +			goto out_trace;
>  		}
>  
>  		if (!params->quiet)
> @@ -569,11 +569,12 @@ int osnoise_top_main(int argc, char **argv)
>  		}
>  	}
>  
> +out_trace:
> +	if (params->trace_output)
> +		osnoise_destroy_tool(record);
>  out_top:
>  	osnoise_free_top(tool->data);
>  	osnoise_destroy_tool(tool);
> -	if (params->trace_output)
> -		osnoise_destroy_tool(record);

Wouldn't these four patches be more robust if you just initialized record
(and tool) to NULL, and change osnoise_destroy_tool() to:

void osnoise_destroy_tool(struct osnoise_tool *top)
{
	if (!top)
		return;

        trace_instance_destroy(&top->trace);

        if (top->context)
                osnoise_put_context(top->context);

        free(top);
}

Then you don't need these extra labels and if statements in the main code.

-- Steve


>  out_exit:
>  	exit(return_value);
>  }

