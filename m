Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25CEB589095
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236472AbiHCQel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiHCQei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:34:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2AC0D9A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:34:37 -0700 (PDT)
Date:   Wed, 3 Aug 2022 18:34:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659544475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpDkpo8s29Gszm9Hq6Uy2LMdLL57dgXly+kYCi9noFM=;
        b=P46e5v7JxZ6idFzt6aHASVJfzECETzvylAmQZZ6N8qO1QBFIYduTiKY71vOkyZU3V5Uk5J
        O9PylRbnAJhW/J6lJDijoOtek3XuTnwK4JsyX6003XMR8FDYTdmWJJqPdYapJmWMKz9ksL
        zI58mIyL2qUuoBkV9N/eC7DsNS1Y+lS25tLQGBVrJhwkFQcohELcBWqu2sc+Hg7GW3qDsJ
        tX5Tg9HZLQs2Uum+TPyHBfD+pBU6YDliSR/1W63ht4lWfGOzylz/ZCFb87hNkhJSpt5bsg
        foVdw1xEQV9fNO1zh8ALiH/4Sh3Zn+BElMJPb08KrXtgHcxD9RcJlIOElDpgwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659544475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NpDkpo8s29Gszm9Hq6Uy2LMdLL57dgXly+kYCi9noFM=;
        b=12EBYwt/F4Z1Qhyr351M+TqYK4stALcrOSautThdQH+BAq90CmfeUpMoxdeCH00FdWZ9C7
        nDG/Uwo+Ktcmb/Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] printk for 5.20
Message-ID: <YuqjloJDmXl7YQkI@linutronix.de>
References: <YufsTLpighCI7qSf@alley>
 <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
 <YuqXkCZEfsSKoIX6@alley>
 <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-03 09:08:07 [-0700], Linus Torvalds wrote:
> But thinking some more about it, even the "serious RT" people almost
> certainly don't really want some kind of static "disable it all". Not
> even if it was a separate Kconfig question like I suggested.
> 
> You'd most likely want it to be dynamic, because things like "log to
> console" is different at bootup when the system hasn't started yet -
> you can't really have realtime response when your hardware hasn't even
> initialized yet - and when things are actually running.
> 
> So I think even then you really just want a "turn off console logging"
> dynamic flag, not a Kconfig option.

Having such a flag would mean we have to set it starting with
SYSTEM_SCHEDULING because otherwise we risk a deadlock once the console
driver tries to acquire its lock. The printk code invokes the console
drivers with disabled interrupts and the console driver use spinlock_t
locking which become sleeping locks on PREEMPT_RT and must not be
acquired with disabled interrupts.
The long term solution is to have a printing thread for the console
driver and the atomic console support to print directly in an emergency
case.

> Which I think we already have, in the form of log levels. No?
> 
>           Linus

Sebastian
