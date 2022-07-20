Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C652A57BB64
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 18:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237773AbiGTQ0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 12:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiGTQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 12:26:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C816186F8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 09:26:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658334404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4leS/OzPg367ECXwYMnkpYl32ug6Wj+K9VKgkcusHe4=;
        b=1BFfPKBkMv2/TTXrAQH++IcMA8eDm9Gyfvmot9J3Np+yuectOGHvqUVURel/y3K9RAnOuF
        SF62GcFiVZGoOs6BUvtCWeToY78wIDaTsIrMAJlqP8WJCxKHyTbvNSQOVFHf+ynOgifi+1
        67n9aWq1AeA6eqhDRDhFsKDvJPg39hQdOOGGZM6N4jgRUVoWZkehZsGqe8Ac3i9lI60hpB
        TC/gmCWRGluxNIeYDAMTHHW8QN9rpyINie6MZ62kli10ekPVPwyH/WP/uiTE4oedb8SaWa
        R2qqex/Wewdlr2yJsr+TvBKe5QBR8St8g4dy7dtBQd2xo9T4xiH476RiR73sWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658334404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4leS/OzPg367ECXwYMnkpYl32ug6Wj+K9VKgkcusHe4=;
        b=aCTJaUthsSyqt7NcMPk1l8USpV/cEXRcrHJZaLLFUVDi1XBXRIFlQbezuUSFRi6S8dj2hW
        yx8/nRfP6AzqEjAA==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] printk: Skip console drivers on PREEMPT_RT.
In-Reply-To: <YtgjtfjYVMQrzFTK@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
Date:   Wed, 20 Jul 2022 18:32:43 +0206
Message-ID: <87y1wn3g3g.fsf@jogness.linutronix.de>
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

Hi Sebastian,

On 2022-07-20, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> printk might be invoked in a context with disabled interrupts and or
> preemption and additionally disables interrupts before it invokes the
> console drivers. This is behaviour is not compatible with PREEMPT_RT.
>
> Disable console printing until the return of atomic consoles and the
> printing thread. This allows to retrieve the log buffer from user space
> which is not possible by disable printk.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/printk/printk.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2843,6 +2843,16 @@ void console_unlock(void)
>  	}
>  
>  	/*
> +	 * On PREEMPT_RT it is not possible to invoke console drivers with
> +	 * disabled interrupts and or preemption. Therefore all drivers are
> +	 * skipped and the output can be retrieved from the buffer.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +		up_console_sem();

This should be:

                __console_unlock();

> +		return;
> +	}

Note that if @console_may_schedule is 1, then we are in a sleepable
context and could print. But since that is not very often, it is
probably better to just have it off all the time as you propose.

John Ogness
