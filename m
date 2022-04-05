Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2794F520C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849352AbiDFCee (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349583AbiDEW0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 18:26:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E68E17A2F6;
        Tue,  5 Apr 2022 14:24:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649193852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJUFDru3qyRPcfEWEwWxICWATudSEIElFknJUgTQ0rI=;
        b=cCDrq+y4GV3ckhkx0flFd1XPyBIxnBgkMD4TFRB8m3nQ+HlLtjIpzgwvCremvc1EzQLtqu
        +qhehmh6PeprC5PqL3qAAvNxiyR6qkzBGhSLt+XyHvBZRr2mqTVsFgdEIsI+VXx8CkREUN
        Us+Vxoci2U4gstiAPEVAwUub7+pMdMUp80sA/LewDbfaVc6MMeqloUiNNONCciWCQKnoWj
        i1XvU0GDjhnAssqIAYLJHu9QBixaB1lMNWeQKl4SlIppYJUPWRi18M0u8SL1phBxGAUCao
        9cI2+xyzwHKD3uMCL/OrPB6gG+HnQv0M181JhYU1EOgOQ9RTUztrNwD2BnQcIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649193852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NJUFDru3qyRPcfEWEwWxICWATudSEIElFknJUgTQ0rI=;
        b=Gf60UpzSNAwZhbH/FbvMcoEFj+IASDOG+6UsBJsVK9yir1a5I2JZsB9eUzG8bzlbDdMrVV
        RJms7BQQG5P33ECw==
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Alexander Potapenko <glider@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Helge Deller <deller@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Phil Auld <pauld@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Wang Qing <wangqing@vivo.com>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v2 00/12] implement threaded console printing
In-Reply-To: <YkxaTy08ClcNj0P3@smile.fi.intel.com>
References: <20220405132535.649171-1-john.ogness@linutronix.de>
 <YkxaTy08ClcNj0P3@smile.fi.intel.com>
Date:   Tue, 05 Apr 2022 23:30:10 +0206
Message-ID: <87sfqrrzph.fsf@jogness.linutronix.de>
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

On 2022-04-05, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> From the list of patches and the only one I am Cc'ed to I can't find
> the answer to my question,

It seems lore is having trouble picking up the series. Until then, I've
pushed the series to github.com so you can see the code.

> i.e. does it take care about console_unregister() cases at run time?
> (We have some drivers to call ->exit() for console in that case,
> perhaps it should do something before calling it.)

Yes. In console_unregister(), the printing thread is shutdown before the
actual console unregistration takes place. The thread is shutdown here:

https://github.com/Linutronix/linux/blob/b27eb6c3d168d608b3a9d04578e030a3d79d889a/kernel/printk/printk.c#L3393

The console's exit() callback is below that:

https://github.com/Linutronix/linux/blob/b27eb6c3d168d608b3a9d04578e030a3d79d889a/kernel/printk/printk.c#L3429

> Would be nice to see some pointers where I can find the answer and
> maybe even describing in the cover-letter/commit
> message/documentation.

I suppose for the console thread patch [0] I could add a paragraph to
the commit message mentioning kernel thread shutdown for console
unregistration.

[0] https://github.com/Linutronix/linux/commit/e26ae677da2e339dd268c1f871b81e61e782393f

John
