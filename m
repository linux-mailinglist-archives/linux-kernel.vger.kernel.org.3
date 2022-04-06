Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD024F609C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiDFNid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiDFNh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:37:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D288D4F78C1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 03:38:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D55C21100;
        Wed,  6 Apr 2022 10:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649241121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMDGAmoV8QktX8IKltrIly445f2xIv5AMZSxxxqIcwQ=;
        b=DecQ10YcpW+8SnMPjyYeJuMQiKBj5stHvhKa5KRxfYwUpEc5PEDk273yXhBPNW3/cgZRdv
        0Rjp4dTIAU+jGaiKu/8NNDh79SQOmBngcYf7XtSqu3bFaMFSXrV+JFuPcZCPEtd7+k2q6l
        ACQfQ3QZC8yaBdMLQkUuOMwKGMGyzME=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DA53CA3B82;
        Wed,  6 Apr 2022 10:32:00 +0000 (UTC)
Date:   Wed, 6 Apr 2022 12:31:59 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/12] printk: add macro for console detail
 messages
Message-ID: <Yk1sH5huJa6dayqJ@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405132535.649171-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-04-05 15:31:28, John Ogness wrote:
> It is useful to generate log messages that include details about
> the related console. Rather than duplicate the logic to assemble
> the details, put that logic into a macro printk_console_msg().
> 
> Once console printers become threaded, this macro will find many
> users.

I really like this idea.

> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fb9a6eaf54fd..39ca9d758e52 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2993,6 +2993,10 @@ static void try_enable_default_console(struct console *newcon)
>  		newcon->flags |= CON_CONSDEV;
>  }
>  
> +#define printk_console_msg(c, lvl, msg) \
> +	printk(lvl pr_fmt("%sconsole [%s%d] " msg "\n"), \
> +	       (c->flags & CON_BOOT) ? "boot" : "", c->name, c->index)

This might be dangerous because "msg" is handled as printk format.
Any potential %<modifier> might cause unexpected memory access.

Honestly, I am not good at writing macros. I played with it and
the following worked for me:

#define printk_console_msg(c, lvl, fmt, ...)			\
	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),		\
	       (c->flags & CON_BOOT) ? "boot" : "",		\
	       c->name, c->index,				\
		##__VA_ARGS__)

Note that it requires adding "\n" back to the callers.

Also, please, call it "console_printk()" or so. It needs extra
arguments and this name will help to distinguish it from
the plain printk() wrappers. From my POV, it is something like,
for example, dev_printk(), snd_printk(), or xfs_printk_ratelimited().

Best Regards,
Petr
