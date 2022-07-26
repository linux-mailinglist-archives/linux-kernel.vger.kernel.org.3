Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 877CF580E51
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232442AbiGZH5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGZH5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:57:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE041ADBD
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 00:57:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658822260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUxOHR9ruyvarDL+n99COropQfzZw5hQeHs+l5NpGBA=;
        b=ICsMZJtBquGqNUAbBt1NkCf4RuWUtK8WKuw+rCOhsAtXtGgDVT+d7Ghnpwe7l6ggssrxKg
        QpXketqEDg76S7bDm16R54St8NhitP7NhDpBs5v8xjt1+05SCMDgdTQ8a44lw6qTcTeZ13
        NVwfdz+FvK3vwWcLEkbc4MRlnx42K6hJvmUI4/EFDBzRk0KK2G2WDj7crSy65sOQFDdr6T
        /AW9VGkYH9lQNNqgRzjJ7FJZImLe521z/KrSYfbaRjzsEPYA79Ou1ddFETZcA2ZMatoedy
        OzUw3zhsqsLYsMsRyjeMuNgLlC3a6niDwTM7fyWP39on3nAgCohAJeabasR3iQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658822260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uUxOHR9ruyvarDL+n99COropQfzZw5hQeHs+l5NpGBA=;
        b=Qc0wgGxaT9mjo4CZ1wpwJnnFqbZ6q/m3RiaTniZS67QmsmAo9I6VF3TpC8+x28Me8gbkm+
        S2M7S7qUFoIVegDw==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v3] printk: Skip console drivers on PREEMPT_RT.
In-Reply-To: <Yt6zwP9xSdUhsoQ9@linutronix.de>
References: <YtgjtfjYVMQrzFTK@linutronix.de>
 <87y1wn3g3g.fsf@jogness.linutronix.de> <Ytgu17hATM8iqdGC@linutronix.de>
 <87ilnrn06u.fsf@jogness.linutronix.de> <Ytj3PisFjOfS9L0Y@linutronix.de>
 <YtqakGJAQzw/IPul@alley> <YtrYdXWGb0NQLKNA@linutronix.de>
 <Yt6MzEEFfpyTBIIj@alley> <Yt6gxxRxDZ/wFHrA@linutronix.de>
 <Yt6nlaSrfZ+fn80x@alley> <Yt6zwP9xSdUhsoQ9@linutronix.de>
Date:   Tue, 26 Jul 2022 10:03:39 +0206
Message-ID: <871qu8i9vw.fsf@jogness.linutronix.de>
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

On 2022-07-25, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> printk might be invoked in a context with disabled interrupts and or
> preemption and additionally disables interrupts before it invokes the
> console drivers. This behaviour is not desired on PREEMPT_RT:
> - The console driver are using spinlock_t based locking which become sleeping
>   locks on PREEMPT_RT and must not be acquired with disabled interrupts (or
>   preemption).
>
> - The locks within the console drivers must remain sleeping locks and they must
>   not disable interrupts. Printing (and polling for its completion) at 115200
>   baud on an UART takes too long for PREEMPT_RT in general and so raises the
>   latency of the IRQ-off time of the system beyond acceptable levels.
>
> Skip printing to the console as temporary workaround until the printing threads
> and atomic consoles have been introduced or another solution which is
> compatible with the PREEMPT_RT approach.
> With this change, the user will not see any kernel message printed to the
> console but can retrieve the printk buffer from userland (via the dmesg
> command). This allows enable PREEMPT_RT as a whole without disabling printk and
> loosing all kernel output.

Note that "the dmesg command" is not the only userspace tool to access
the kernel logs. Logging daemons (using /proc/kmsg or /dev/kmsg) also
have full access.

> Disable console printing on PREEMPT_RT.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Reviewed-by: John Ogness <john.ogness@linutronix.de>
