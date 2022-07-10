Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2854156D132
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 22:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiGJUEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 16:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJUEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 16:04:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEE9E0CD;
        Sun, 10 Jul 2022 13:04:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657483486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ds58LBUy5xwQDAL9DgQJqTgqF3lxrJCRDfvC8rdCdZM=;
        b=p7FqFOHakGxx5lkNamELYCztliAvIsynUpv0H7MdXCQ+ttL3PGHkqvnM8uj3obQOC1Xbn2
        Q+1m34witYxl8cmJ6KGPYplxbvBqU/xITyW9Dazu9qTtbzEdsOTkQt4seHeyBGO3S7xaA7
        w1QW5o1cxwqBsfir8wfEx+NbwiNguD4jW1bQ+bO1SBQYdvyDcxfMWGcECcDvoWnryOGirE
        UHfQhCMc3EBEw0f9luTWgFjHl44sW4+vmYRN9FG2IyLHEtc5G2CaIWD++ZU8HTyNjLGBXr
        L0bnmqBJJ6FPawmnHZY460vOrglxSQlsRqjlw1hChpa0EAFRnUFTZIe2rmsM9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657483486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ds58LBUy5xwQDAL9DgQJqTgqF3lxrJCRDfvC8rdCdZM=;
        b=mzbP5FlUDUhYA+ylWPk4C2I4GY8EnxGMA41UCm5+zMfiqZ4qK/WcygXosu2lRdrq6wtWtq
        8mkCkUhZavz8QuBA==
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     todd.e.brandt@linux.intel.com, Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: PNP0501 serial driver takes almost 2 seconds to suspend/resume
 (printk issue)
In-Reply-To: <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
References: <12fb98fe27e23e3f74a139e5e8eb83a97a343372.camel@linux.intel.com>
 <51b9e2cc3baf61a604bd239b736ec2d12f1f6695.camel@linux.intel.com>
 <87czegxccb.fsf@jogness.linutronix.de>
 <045ebee30af2b80aaeace1dab18ecd113e3f17c7.camel@linux.intel.com>
 <87tu7qvx1q.fsf@jogness.linutronix.de>
 <CAHp75VfyzMNMO2NRwXwSjAmQqBbdRG3+SzyFDG+90dmvmg1xLQ@mail.gmail.com>
Date:   Sun, 10 Jul 2022 22:10:45 +0206
Message-ID: <87o7xwbuoy.fsf@jogness.linutronix.de>
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

On 2022-07-10, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>> Looking at freeze-5.19.0-rc1-bad.html, at 3431.221039 we see that
>> suspend_console() was called. The additional 1-second delay you are
>> referring to would be 3432.436187, where serial is
>> suspended. pr_flush() would have been satisfied when the message at
>> 3431.221039 was printed. So the question is, why is there still
>> printing going on?
>
> It might be no_console_suspend hack. Are you, btw, aware of this ugly
> hack in the kernel?

I am aware of it. There are some cases where it actually works. But it
is not being used here. The boot args are:

BOOT_IMAGE=/boot/vmlinuz-5.19.0-rc1+ root=UUID=1dfec046-baf6-4f38-8b5e-a8f438a48038 ro rw quiet console=ttyS0,115200 console=tty0 i915.enable_psr=1 initcall_debug log_buf_len=32M quiet splash console=tty0 console=ttyS0,115200n8 vt.handoff=7

I am curious if Todd sees this problem with 5.19-rc4 or later (the
kthread printers were removed).

John
