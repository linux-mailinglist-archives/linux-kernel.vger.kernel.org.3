Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852374A8339
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350296AbiBCLdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:33:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350277AbiBCLdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:33:37 -0500
Date:   Thu, 3 Feb 2022 12:33:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643888016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9RA+sjK6L0bWBZ4ZVutfdgD2+sK4WumTVYUK7TAd3g=;
        b=2LleO+ldfeSnH3yEGe1Ng73jf0BrVJG+eYmBrA1TCb+z6WKpkJ4vqPbf2t/vI75TGTYXO6
        eX+/6QO0N/Dfy4nq8wI0rqt9sfpyua1obyjNpk3ajAaHSvPFsY8TVeRXJCM4PoW8xug/jB
        elMRyFo8brSXUk3sMCW9UfSLJl5X4ZbDpFH0XiaSRFibUry6qPT5eMbG2fYBuEqDDtZuAB
        ZHK1TQeXnBXuW87jUa++EahapMHZJ8VKFBHw3LL0H9N8GzIf7d6kdBmwDToj7F8kxE9BlO
        fWAjeNYmYwsy74l++kq+rS4aADgU7sGgWVu2RTbXg0Kgg2ThhBC2Ka/qGsTJCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643888016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b9RA+sjK6L0bWBZ4ZVutfdgD2+sK4WumTVYUK7TAd3g=;
        b=gRsw6dieqXCdQpM2ycgkki4UCm9bDEkIvkIXcUzwoA6MPVXWLwQcjYi14xl8FuzP7n4NPR
        QVJYR8wF1JNxFbBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: defer_console_output: do not assume interrupts
 disabled
Message-ID: <Yfu9j1VN/YP8cqza@linutronix.de>
References: <20220203112915.1350753-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220203112915.1350753-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-03 12:35:15 [+0106], John Ogness wrote:
> With commit 458df9fd4815 ("printk: remove separate printk_sched
> buffers and use printk buf instead") defer_console_output() was
> changed to no longer disable interrupts. However, it used the
> function __this_cpu_or(), which assumes interrupts disabled. That
> also should have been changed to this_cpu_or().
> 
> Although defer_console_output() is mostly used when interrupts are
> disabled, this is not always the case. One example is
> get_random_bytes(), which is often called with interrupts enabled.

It is okay for __this_cpu_or() to be invoked with disabled preemption if
that is true for all callers. Disabled interrupts or not is not
important as long as there are no callers in_irq(). I believe that there
are callers in_irq() and therefore this_cpu_or() is correct.

>   get_random_bytes()
>     warn_unseeded_randomness()
>       printk_deferred()
> 
> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Sebastian
