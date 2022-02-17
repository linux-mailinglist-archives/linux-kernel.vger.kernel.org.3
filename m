Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550A74BA31D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbiBQOez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:34:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235817AbiBQOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:34:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D88B0D3B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 06:34:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645108477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERM6i9VIQq6azPXhtpMNhdNd8kspcpizPgS+kFsLxJE=;
        b=Zmz8GZNQdBhbZqDH8RnZuUeOi4c/GIZYboYSO6BuqVLUIZFth0loR5Usr/o0S+/wcwVLmW
        oQmYLQerk+9EYh9qlQ8yWRpFPL4OVKTnSeD9IP6Xo4hpP1ATXlDoC3abN/4kDxOCb9AJGe
        Hl2E89RkrbtRrp4hPLCGnMIzfKPA8QQE6RCDBnTuIVMYxBmxrfwNSjZgzrwQUTgd0DreJg
        BbzoGFKTGSUOucyHViRLtfb7NQmyDe4ydA7TlXwppj1R5SsZfhCm9z7/wD0uiurZhBt1Vg
        4BalUAPBUooxhWAQvN4E7pObkgopPKjFvFxOiQI+5eSykM4Yy8Bwjic0SNUJgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645108477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ERM6i9VIQq6azPXhtpMNhdNd8kspcpizPgS+kFsLxJE=;
        b=08ADbwKvR95UMI8V01i23zgFMgh7K7wKEXii2YZDnneZuioZ+7xw/Y0NezskWgyVvKSO3B
        ArYeHc7FP85E2xDw==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH printk v1 01/13] printk: rename cpulock functions
In-Reply-To: <Ygtyb4WFVlv/earX@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-2-john.ogness@linutronix.de>
 <YgZaMkUU5Ve2GV9D@alley> <Ygn7ZFnFL4QiQHRg@google.com>
 <Ygtyb4WFVlv/earX@alley>
Date:   Thu, 17 Feb 2022 15:40:36 +0106
Message-ID: <87fsoh8sub.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-02-15, Petr Mladek <pmladek@suse.com> wrote:
> This patch is about how to make it more obvious that this
> API has to be used carefully. I see the following main risks when
> using this API:
>
>      + it might cause deadlocks, especially in panic
>
>      + it is supposed to be tail lock (no other locks allowed in this
>        context)
>
>      + it is re-entrant
>
>      + it does not prevent parallel (nested) access on the same CPU

I can add more information about the risks to the function documentation
(include/linux/printk.h).

> "get/put" are more acceptable for me. They create at lest some feeling
> that it tries to get something and it might take some time. Even
> thought many "get/put" APIs are not blocking.

OK. So I will keep the naming for the series v2.

> BTW: The API disables IRQ. So the nested access is limited to two
> levels: normal/IRQ and nested NMI contexts.

And there are reentrant call chains. For example, we already have:

nmi_cpu_backtrace()
    printk_cpu_sync_get_irqsave(flags);
    dump_stack();
        printk_cpu_sync_get_irqsave(flags);
        __dump_stack(log_lvl);
        printk_cpu_sync_put_irqrestore(flags);
    printk_cpu_sync_put_irqrestore(flags);

John
