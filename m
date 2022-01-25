Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98BA049B64E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243242AbiAYOcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:32:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:46264 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578140AbiAYOZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:25:56 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5178421127;
        Tue, 25 Jan 2022 14:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643120753; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1oi05nJVTpmax0XEzzHo6/1zPl+3C8kP4fs5h/613xY=;
        b=SnjLKHeN30YEpkobUUiYRMnnS+j3DA8NsdXLwryHgr6wxASDFmmR4doZ2wZrLoJd1nYcfV
        lHsaNPh9pZ8M4O+WNF8uYTqVK/wTigmHG2j+GZr+IwFadeIvgUB1aKiKkOieeLPyjdSibv
        9TsGP2h57K1zp2RD2CxVZ+cDgUeqCZM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1117EA3B97;
        Tue, 25 Jan 2022 14:25:53 +0000 (UTC)
Date:   Tue, 25 Jan 2022 15:25:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] printk: Avoid livelock with heavy printk during panic
Message-ID: <YfAIbRqfFMwqsrKV@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-4-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121190222.572694-4-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-01-21 11:02:21, Stephen Brennan wrote:
> During a panic(), if another CPU is writing heavily the kernel log (e.g.
> via /dev/kmsg), then the panic CPU may livelock writing out its messages
> to the console. Note when too many messages are dropped during panic and
> suppress further printk, except from the panic CPU.

I would add something like:

"It might cause that some useful messages are lost. But messages are
being lost anyway and this at least avoids the possible livelock."

> ---
>  kernel/printk/printk.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 20b4b71a1a07..ca253ac07615 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2667,6 +2678,8 @@ void console_unlock(void)
>  		if (console_seq != r.info->seq) {
>  			console_dropped += r.info->seq - console_seq;
>  			console_seq = r.info->seq;
> +			if (panic_in_progress() && panic_console_dropped++ > 10)
> +				suppress_panic_printk = 1;

It would be great to let the user know, something like:

				pr_warn("Too many dropped messages. Supress messages on non-panic CPUs to prevent livelock.\n");



>  		}
>  
>  		if (suppress_message_printing(r.info->level)) {

Otherwise, it looks good to me.

Best Regards,
Petr
