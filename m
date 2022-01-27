Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C76349E48E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbiA0OZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:25:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39276 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiA0OZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:25:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 36B651F3AB;
        Thu, 27 Jan 2022 14:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643293557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbSBDUBhM1VKVepUEI40R+PoPjZ1FBHKtQVTPFDsqko=;
        b=rFhS1eDvIlJ4RlzwqI6YDiT+s0/bb1RTP/fMzY7Nby8A8t3eMv/+fjCpQB3GosK6tZEYhJ
        n+p/eZ8SXzJenUyhVtKyOYeRXRkInTFaSQbyp8xWfFpTLZrE5EbaXcw1QhSNSZg5IWAGRF
        LDRP1phCDX5Dgt4hUs5GeIfzJ+1F5RA=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C2E13A3B84;
        Thu, 27 Jan 2022 14:25:56 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:25:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <YfKrcQwtXjR87E3q@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com>
 <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com>
 <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
 <YfJFjHdg/khNXiRd@google.com>
 <YfKEGg0zQqXBVqGG@alley>
 <877dalpcvz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dalpcvz.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 13:49:44, John Ogness wrote:
> On 2022-01-27, Petr Mladek <pmladek@suse.com> wrote:
> > I mean that chance of dealock caused by the internal semaohore spin
> > lock is super small. In compare, a lot of tricky code is guarded
> > by console_sem. It looks like a big risk to ignore the semaphore
> > early in panic().
> 
> Agreed.
> 
> > A better solution would be to use raw_spin_trylock_irqsave() in
> > down_trylock().
> 
> down_trylock() is attempting to decrement a semaphore. It should not
> fail just because another CPU is also in the process of
> decrementing/incrementing the semaphore.

IMHO, it does not matter. As you say, raw_spin_trylock_irqsave() fails
only when another process is about to release or take the semaphore.
The semaphore is usually taken for a long time. The tiny window when
the counter is manipulated is negligible.

I mean, if down_trylock() fails because of raw_spin_trylock_irqsave()
failure then it is few instructions from failing even with the lock.

> Maybe a down_trylock_cond() could be introduced where the trylock could
> fail if a given condition is not met. The function would need to
> implement its own internal trylock spin loop to check the condition. But
> then we could pass in a condition for it to abort. For example, when in
> panic and we are not the panic CPU.

This looks too complicated.

Another solution would be to introduce panic_down_trylock() variant
of down_trylock() that will use raw_spin_trylock_irqsave(). The normal
down_trylock() might still use the raw_spin_lock_irqsave().

Well, this should get discussed with the locking people.

Best Regards,
Petr
