Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02DC353548E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345922AbiEZUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345528AbiEZUhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:37:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33438496A6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:37:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C34BEB820CB
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:37:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84A5C385A9;
        Thu, 26 May 2022 20:37:11 +0000 (UTC)
Date:   Thu, 26 May 2022 16:37:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "printk: wake up all waiters"
Message-ID: <20220526163710.0a2cd6f4@gandalf.local.home>
In-Reply-To: <20220526203056.81123-1-john.ogness@linutronix.de>
References: <20220526203056.81123-1-john.ogness@linutronix.de>
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

On Thu, 26 May 2022 22:36:56 +0206
John Ogness <john.ogness@linutronix.de> wrote:

> This reverts commit 938ba4084abcf6fdd21d9078513c52f8fb9b00d0.
> 
> The wait queue @log_wait never has exclusive waiters, so there
> is no need to use wake_up_interruptible_all(). Using
> wake_up_interruptible() was the correct function to wake all
> waiters.
> 
> Since there are no exclusive waiters, erroneously changing
> wake_up_interruptible() to wake_up_interruptible_all() did not
> result in any behavior change. However, using
> wake_up_interruptible_all() on a wait queue without exclusive
> waiters is fundamentally wrong.
> 
> Go back to using wake_up_interruptible() to wake all waiters.

(Just to show that I have been paying attention ;-)

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index a3e1035929b0..ea3dd55709e7 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3904,7 +3904,7 @@ static void wake_up_klogd_work_func(struct irq_work *irq_work)
>  	}
>  
>  	if (pending & PRINTK_PENDING_WAKEUP)
> -		wake_up_interruptible_all(&log_wait);
> +		wake_up_interruptible(&log_wait);
>  }
>  
>  static DEFINE_PER_CPU(struct irq_work, wake_up_klogd_work) =

