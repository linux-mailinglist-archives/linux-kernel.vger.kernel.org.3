Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4582749C621
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbiAZJSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:18:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238967AbiAZJSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:18:43 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84801C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:18:43 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id d5so20266465pjk.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 01:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FlnS56+1MxbZe9hQnYpQ8SQZNU4W9RAQS10TV8kjkEw=;
        b=NyvgzEE8RSe5mzMrOCc4WZdqLa+2iPKcTZpafoJwkRzKeARVLmyTtYMhSlu3O8hi1u
         IUelXOP0G1odem15va3fwR+HDt7nY8gFForEMehYv4r33c6xF5Qpt2uEybQkTSsiArN1
         Xe9NcLIhp9dFZdgnEj9/5G0HPvjVv/YHU078o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FlnS56+1MxbZe9hQnYpQ8SQZNU4W9RAQS10TV8kjkEw=;
        b=llMeKI6iW+Hl0639VrzXk6ZFZvjGFY/Z9eqYunYAaMlSek7OgzIJIetbSfunx4bA26
         wnyrsoIFBteDZKdHmMFFnpeHtHcazpomrTir2cc2cO78hYgiqj0/cRyfjYMPEJDB3SWu
         khQo7Mck4fQ4B3r8EHP3L7WB7HMLzdg32XY8TW5oRNUbs61ZHzGvnXJeROZzQlfqwjhs
         HEEcgCJroheySy1UvhrC1YUgFDi4XjBy/5iPYKJt6OtzE7gy0Fm3wA7s2f8OHyJgKumg
         X9RusuM1fif2ABKoDELv/+hkOVS/AqP7OtaFTrPHK4u1JeZ7t7eVm77CHUp4AIBvoCQE
         Q8Fw==
X-Gm-Message-State: AOAM533DDwRjLp0CJDED/4G2Srz1eh+5MX6i8I3jaRIGqyPZaVBwFyAE
        pU0FsgF9MFrcuIGfXPrVHa7HKS9/pM5GEw==
X-Google-Smtp-Source: ABdhPJzbxVlpH/gzgQ/xcJhMt9g+LWJRyOhaGapXsJEAcq03k9j8XDSKnX96xaq1BKLTgZyS0dm8/A==
X-Received: by 2002:a17:90b:4f44:: with SMTP id pj4mr7800103pjb.167.1643188723110;
        Wed, 26 Jan 2022 01:18:43 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7bbc:f635:b767:2a8a])
        by smtp.gmail.com with ESMTPSA id y128sm1563335pfb.75.2022.01.26.01.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 01:18:42 -0800 (PST)
Date:   Wed, 26 Jan 2022 18:18:38 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <YfER7tlXZZpX94c9@google.com>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121190222.572694-3-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/01/21 11:02), Stephen Brennan wrote:
> A CPU executing with console lock spinning enabled might be halted
> during a panic. Before the panicking CPU calls console_flush_on_panic(),
> it may call console_trylock(), which attempts to optimistically spin,
> deadlocking the panic CPU:
> 
> CPU 0 (panic CPU)             CPU 1
> -----------------             ------
>                               printk() {
>                                 vprintk_func() {
>                                   vprintk_default() {
>                                     vprintk_emit() {
>                                       console_unlock() {
>                                         console_lock_spinning_enable();
>                                         ... printing to console ...
> panic() {
>   crash_smp_send_stop() {
>     NMI  -------------------> HALT
>   }
>   atomic_notifier_call_chain() {
>     printk() {
>       ...
>       console_trylock_spinnning() {
>         // optimistic spin infinitely

[..]

> +++ b/kernel/printk/printk.c
> @@ -1843,6 +1843,16 @@ static int console_trylock_spinning(void)
>  	if (console_trylock())
>  		return 1;
>  
> +	/*
> +	 * It's unsafe to spin once a panic has begun. If we are the
> +	 * panic CPU, we may have already halted the owner of the
> +	 * console_sem. If we are not the panic CPU, then we should
> +	 * avoid taking console_sem, so the panic CPU has a better
> +	 * chance of cleanly acquiring it later.
> +	 */
> +	if (panic_in_progress())
> +		return 0;

Is there something that prevents panic CPU from NMI hlt CPU which is
in console_trylock() under raw_spin_lock_irqsave()?

 CPU0				CPU1
				console_trylock_spinnning()
				 console_trylock()
				  down_trylock()
				   raw_spin_lock_irqsave(&sem->lock)

 panic()
  crash_smp_send_stop()
   NMI 			-> 		HALT
