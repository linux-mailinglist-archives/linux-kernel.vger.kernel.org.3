Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6D50AAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387461AbiDUVnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 17:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343498AbiDUVnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 17:43:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1432648E5E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 14:40:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650577224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYxzdD4XVgq6CKbbQ3EP31o4JbRYZewfaps5uRZG8Gs=;
        b=CxfDV2ehT2ndpG0Oo2rV7BA70XPvAY9l7pgAhYQCv0gtPjcq7BbcJWQDaDXUXDYT73jGYc
        0V4gNz7nZVCZBYyxCh4ZX5qUSlw067PbTcMT8f4BvE9JIPzDPeiR9ehPHU0iB08MA/VZCF
        USaEaFfCkGeOqeW94hBB6QD9iFTh6xMkdAQ4Ee8YNmnsdeSMWYYPt/MKRnfpl40M9CmJzX
        yW0BiOJcZ34Vg3jlZbsKyOopSJW01kbh6t8GJlEuvhCn0F2Uu1HGRxUhJL3Yrp4dsSW1KV
        9zeKovdIHHh+x5jJzrbeC4Q2b0hw4ao0W3uJ9oju5VnshaKdL4ZG6VqbbqWgeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650577224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pYxzdD4XVgq6CKbbQ3EP31o4JbRYZewfaps5uRZG8Gs=;
        b=VsmUOaA87jRVZjsNriBwh5H5KqcvUBJwer+E2z8pzth9ybMyNopSQYAIqef5ZtDvFejQe8
        YfhfcJ7MR3IvUAAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <20220421212250.565456-15-john.ogness@linutronix.de>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
Date:   Thu, 21 Apr 2022 23:46:24 +0206
Message-ID: <87wnfiyv1z.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

If v4 ends up being acceptable for linux-next, I would request you fold
a couple cosmetic changes into this patch.

On 2022-04-21, John Ogness <john.ogness@linutronix.de> wrote:
> +/*
> + * Since the kthread printers do not acquire the console_lock but do need to
> + * access @flags, they could experience races because other tasks
> + * (synchronizing using the console_lock) can modify @flags. These macros are
> + * available to at least provide atomic variable updates so that the kthread
> + * printers can see consistent values.

This last sentence is bad. It should not use the words "atomic" and
"updates". Please change it to:

    These macros are available to store the new value in a way that will
    provide consistent load values for kthread printers. Tasks using
    these macros must still do so under the console_lock.

[...]

>  EXPORT_SYMBOL(console_stop);
>  
> +

Please remove this accidental blank line.

>  void console_start(struct console *console)
>  {
>  	console_lock();
> -	console->flags |= CON_ENABLED;
> -	console_unlock();
>  
> -	/* Wake the newly enabled kthread printer. */
> -	wake_up_klogd();
> +	/* Can cause races for printk_kthread_func(). */
> +	console_flags_set(console->flags, CON_ENABLED);
>  
> +	console_unlock();
>  	__pr_flush(console, 1000, true);
>  }
>  EXPORT_SYMBOL(console_start);

John
