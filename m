Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76BC6487B44
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 18:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240730AbiAGRSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 12:18:46 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57464 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiAGRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 12:18:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 589AC611E0
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 17:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B019C36AE0;
        Fri,  7 Jan 2022 17:18:44 +0000 (UTC)
Date:   Fri, 7 Jan 2022 12:18:42 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 1/3] tracing/filter: degrade addr in
 filter_pred_string() from double pointer to pointer
Message-ID: <20220107121842.70c7651b@gandalf.local.home>
In-Reply-To: <20220107044951.22080-2-kernelfans@gmail.com>
References: <20220107044951.22080-1-kernelfans@gmail.com>
        <20220107044951.22080-2-kernelfans@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  7 Jan 2022 12:49:49 +0800
Pingfan Liu <kernelfans@gmail.com> wrote:

> Since FILTER_PTR_STRING has the type of "char *", it is meaningless to
> convert it to "char **". Hence degrading addr from double pointer to
> single.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> To: linux-kernel@vger.kernel.org
> ---
>  kernel/trace/trace_events_filter.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index c9124038b140..264456e1698f 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -670,11 +670,11 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
>  /* Filter predicate for char * pointers */
>  static int filter_pred_pchar(struct filter_pred *pred, void *event)
>  {
> -	char **addr = (char **)(event + pred->offset);
> +	char *addr = (char *)(event + pred->offset);

This doesn't look right. The address of the pointer should be in the event.
"event" is an address to the content of the event in the kernel ring buffer.

	event + pred->offset

Is then the address of position of the event.

Let's say we have an event record at 0xffff8000, and the pred->offset is at
0x10. And the pointer to the string (in user space) is at 0x70008000.

0xffff8000:  <heade>
0xffff8010: 0x70008000

0x70008000: "user space sting"

event + pred->offset gives us 0xffff8010

If we now have that as char *addr, then addr is 0xffff8010


>  	int cmp, match;
> -	int len = strlen(*addr) + 1;	/* including tailing '\0' */
> +	int len = strlen(addr) + 1;	/* including tailing '\0' */

This would give us the addr = 0xffff8010, which is not where the string
exists.

How would this work?

-- Steve


>  
> -	cmp = pred->regex.match(*addr, &pred->regex, len);
> +	cmp = pred->regex.match(addr, &pred->regex, len);
>  
>  	match = cmp ^ pred->not;
>  

