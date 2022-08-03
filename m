Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1A589004
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiHCQIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiHCQI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:08:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B921EAFB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:08:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id f22so11077263edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=xyUh09AlPzLX3J7tBRjrcHuU0ktE1LHzV+qFDFqyRNU=;
        b=gVXf52XWMaxBvWtCj7zNqZZaHLyEq+am9sa1BecCKpaJJth2oKrBKTZKEuy/lrgyel
         BFVOGo+0KGV+gozB2wf858p5PlrjGu7O41KHCmrTbSqf2LsolYNINmrBU1Ih72qe+ahT
         1KLeRnPSslaBPljatc716TjeOPC+O8/Av5c+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=xyUh09AlPzLX3J7tBRjrcHuU0ktE1LHzV+qFDFqyRNU=;
        b=BaxRFtCp1lVV/69QryD/IQ31Ct3R8c3kVfNZ1Pbtw2otEHbL76mCpW3H7J9RQRVnp6
         bkIdJ0FZQyKNQwvKfhuL9+gr3ua2F9FQbnOlmm+Vry9Vm2Fh3hgPBRN9j7+If73VgVe8
         U+Ax9EAxTOEVGbcEFp5GjZVmaI9pfyqyxZmECLQgmJQC/Kro3LxqT+krIrXpP1J19Dj7
         itMln8GyuCfIOiw87D4HGr7dJ97CKvXVOOw+ApiQ0E7eyBwVtv73ZG9kbQsj1Z1AWMhP
         CONpauHzrQd8BwszT/s4kRcOy/DrvdfwNTcgnlPsK1o5dR0tBiuyxHCYk2bK6jppNJdX
         1A7w==
X-Gm-Message-State: AJIora9qvRUppXqnrGByrEsrTakCmIyz5GpxvQE1m8Rh6na8QMry3TnY
        v4tJMhI7tA8ADtqAzqP4eHKyOxbBKjO7AIOn
X-Google-Smtp-Source: AGRyM1s1IwTNckkGezJB6XHnH0LhNd6tTcScwl9TEzYTr6iJwecbCbbdKv5FYbd5qCwLiP03aS9N9A==
X-Received: by 2002:a50:ee85:0:b0:43d:3e0:6157 with SMTP id f5-20020a50ee85000000b0043d03e06157mr26750637edr.19.1659542905412;
        Wed, 03 Aug 2022 09:08:25 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id p16-20020a17090653d000b007309b35b335sm2316631ejo.104.2022.08.03.09.08.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 09:08:24 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so1089533wmm.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:08:23 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr3424259wmf.38.1659542903592; Wed, 03 Aug
 2022 09:08:23 -0700 (PDT)
MIME-Version: 1.0
References: <YufsTLpighCI7qSf@alley> <CAHk-=wie+VC-R5=Hm=Vrg5PLrJxb1XiV67Efx-9Cr1fBKCWHTQ@mail.gmail.com>
 <YuqXkCZEfsSKoIX6@alley>
In-Reply-To: <YuqXkCZEfsSKoIX6@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 09:08:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
Message-ID: <CAHk-=wj0umHOtL1TB_7Tvinoqhxz6BnL-jEC0eQfVihHOmbWjw@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.20
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 8:43 AM Petr Mladek <pmladek@suse.com> wrote:
>
> On Tue 2022-08-02 20:19:34, Linus Torvalds wrote:
> > And printing messages to a console is not some "oh, we'll just stop
> > doing that because you asked for PREEMPT_RT".
>
> My thinking was that PREEMPT_RT was used only by some rather small
> community that was very well aware of the upstream status. I kind of
> though that this was their choice.

Oh, I agree that it probably is a pretty small community.

And I also think that people who are really into RT are basically
always going to have extra patches anyway - I think the bulk of the
core stuff has made it upstream, but not *all* has made it.

And the "real RT" people tend to also have long lead times - it's not
just about "we need guaranteed latency", it also tends to be about
"our hardware is special and stays around for years" too - and likely
wouldn't ever really use upstream kernels directly anyway.

In fact, I don't think anybody can currently even enable PREEMPT_RT in
an upstream kernel anyway without extra patches. Much of the RT
infrastructure has been merged, but some of the grottier parts are
literally just "to make it easier to maintain the real external
patch".

So I agree with you that in reality it probably wouldn't really affect
very many people, if any.

I suspect the most immediate effect would literally be people who want
to experiment with it, "just because".

Not the serious RT users who probably have special hardware anyway and
are likely to also have special debug interfaces (exactly _because_
they have special latency concerns).

So that's why I'd suspect that the actual effect would be on people
who just want to tinker with it, and download the necessary RT patches
and set up some data acquisition station for their own use or
whatever.

But thinking some more about it, even the "serious RT" people almost
certainly don't really want some kind of static "disable it all". Not
even if it was a separate Kconfig question like I suggested.

You'd most likely want it to be dynamic, because things like "log to
console" is different at bootup when the system hasn't started yet -
you can't really have realtime response when your hardware hasn't even
initialized yet - and when things are actually running.

So I think even then you really just want a "turn off console logging"
dynamic flag, not a Kconfig option.

Which I think we already have, in the form of log levels. No?

          Linus
