Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCAE4F9E1A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 22:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239455AbiDHUT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 16:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiDHUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 16:19:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5C9396ACD
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 13:17:17 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649449035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGg8/jzR3j1pSFzQLp7EyCYOhVTf4KBViZSPhpRv2hk=;
        b=gTY3S4WlnWga9zg0uZUcqdJT344QnlycpzWQOaoqi8xPLUHCcEfCrDmeixI6gDBEN/mPkh
        /7a649Sqq7itQJzSKTOQeo0V9aCImWsCizGcojZg3ZsN812XzWVVPnYJi2a0YpVMDA4FjQ
        /qDhtdDktzj4C80eE+oQyytm8OH7nNYrHBYWw4GZc/zhEJ5jVq4BdCpRq7dQ5Hx4414N0O
        fqjQZ/Nbtt2r0S0MgDxjNzCYWsTkEbgOCKAluEj83XgySKkErzUtyqlQttqnoY9arlilsi
        cQbYuOwu/9C2/KQOln1pUJO4x0cgMp7qz763Tkyn6o3PclkYiYnm+O5y/hswXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649449035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JGg8/jzR3j1pSFzQLp7EyCYOhVTf4KBViZSPhpRv2hk=;
        b=Y7KfsHDfSOYGjKiqDueArCa+bc9iMpwP6E4HpSv9LIPEbW/56ouENzOxv6E/a5r7TmZA1Z
        qWl4bZMKtwpaTAAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: guarantee forward progress: was: Re: [PATCH printk v2 11/12]
 printk: extend console_lock for proper kthread support
In-Reply-To: <YlA8jpuziDrD27A2@alley>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <20220405132535.649171-12-john.ogness@linutronix.de>
 <YlA8jpuziDrD27A2@alley>
Date:   Fri, 08 Apr 2022 22:23:15 +0206
Message-ID: <87v8vjnxdg.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-04-08, Petr Mladek <pmladek@suse.com> wrote:
> I played a lot with it and it is really hard because:
>
>    + new messages can appear anytime
>    + direct mode might get requested anytime
>    + only the direct mode knows whether all messages were flushed
>      on all consoles

Yes, and this is why v1 dramatically simplified the picture by making
kthreads not care about direct mode. In v1 the kthread logic is very
simple: If there are messages to print, try to print them no matter
what. We didn't need to worry if someone was printing, because we knew
that at least the kthread was always printing.

This meant that there would be times when direct mode is active but the
kthreads are doing the printing. But in my experimenting, that tends to
be the case anyway, even with this more complex v2 approach. The reason
is that if some code does:

printk_prefer_direct_enter();
(100 lines of printk calls)
printk_prefer_direct_exit();

And directly before that printk_prefer_direct_enter() _any_ kthread was
already inside call_console_driver(), then _all_ the console_trylock()
calls of the above 100 printk's will fail. Inserting messages into the
ringbuffer is fast and any active printer will not have finished
printing its message before the above code snippet is done.

In fact, the above snippet will only do direct printing if there were
previously no unflushed messages. That is true for v1 (by design) and v2
(by misfortune, because ringbuffer insertion is much faster than a
single call_console_driver() call).

This new idea (v2) of trying to stop kthreads in order to "step aside"
for direct printing is really just adding a lot of complexity, a lot of
irqwork calls, and a lot of races. And with my experimenting I am not
seeing any gain, except for new risks of nobody printing.

I understand that when we say printk_prefer_direct_enter() that we
_really_ want to do direct printing. But we cannot force it if any
printer is already inside call_console_driver(). In that case, direct
printing simply will not and cannot happen.

For v3 I recommend going back to the v1 model, where kthreads do not
care if direct mode is preferred. I claim that v2 does yield any more
actual direct printing than v1 did.

However, I would keep the v2 change that kthreads go into their
wait_event check after every message. That at least provides earlier
responses for kthreads to stop themselves if they are disabled.

Once we have atomic consoles, things will look different. Then we
perform true synchronous direct printing. But without them, the "prefer"
in printk_prefer_direct_enter() is only a preference that can only be
satisfied under ideal situations (i.e. no kthread is inside
call_console_driver()).

John
