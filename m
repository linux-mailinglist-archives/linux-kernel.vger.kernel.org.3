Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5584E49E2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiA0Mnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiA0Mns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:43:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A193C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 04:43:47 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643287424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSHHDT/Ul5pdE8P6t8ktZ9Ch92LKxsTFGQCx9xs50Ts=;
        b=LYymgM7gSvAe12Kl0R+39pP7HTY/Uxe4k/fIaFhilZ7BMilRUQ1dVAl/6qkc03kPf/esZL
        GlTVjVtX1RaD7OkB9LM7QHRe+e+QBtapPUzs4vOcytGj9CWsQwI0iXaPrSUFxrLLYfnq9N
        sm9QEksAmz4l1vpWZmOJU6Pxx0q6I4y6ELMupPefWEBHWYzbGbavSMqIFDZMyPrHlg78dc
        ho4KmZDEC+eJQaCer/kGKjyoWLRUd3/HSxTBlRAZm4s8t7yWgkUXAFRIgcjokuD5aV0TV8
        /aZE43XZ2JxrfpqI8qnxS/h/lwLPPloZYDd2ZqyZS7P3p5437r0GFleeI2QlwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643287424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qSHHDT/Ul5pdE8P6t8ktZ9Ch92LKxsTFGQCx9xs50Ts=;
        b=1mjwPP3APj9JnPBTx4fhkY/v7JblGGEk2mjg8PXe7hcZHnDDrmFM4i5A8iDOcb8kfBGY4H
        SH2VcKslMiHM7wAQ==
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
In-Reply-To: <YfKEGg0zQqXBVqGG@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com> <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com> <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
 <YfJFjHdg/khNXiRd@google.com> <YfKEGg0zQqXBVqGG@alley>
Date:   Thu, 27 Jan 2022 13:49:44 +0106
Message-ID: <877dalpcvz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27, Petr Mladek <pmladek@suse.com> wrote:
> I mean that chance of dealock caused by the internal semaohore spin
> lock is super small. In compare, a lot of tricky code is guarded
> by console_sem. It looks like a big risk to ignore the semaphore
> early in panic().

Agreed.

> A better solution would be to use raw_spin_trylock_irqsave() in
> down_trylock().

down_trylock() is attempting to decrement a semaphore. It should not
fail just because another CPU is also in the process of
decrementing/incrementing the semaphore.

Maybe a down_trylock_cond() could be introduced where the trylock could
fail if a given condition is not met. The function would need to
implement its own internal trylock spin loop to check the condition. But
then we could pass in a condition for it to abort. For example, when in
panic and we are not the panic CPU.

John
