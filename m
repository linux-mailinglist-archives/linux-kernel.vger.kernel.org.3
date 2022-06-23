Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D57557290
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 07:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiFWF0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 01:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 01:25:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7791F393F0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:25:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id x38so33914072ybd.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 22:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4HCbTmBoKxeGRCwHnS+t3tgkJ4Ac3lNIToRxpu9oR4c=;
        b=dukYNb8WvrCQWxO8z7FMWBNcF49V4rdFGap5R51SKkfmhDK6VYERT0NDA0r4AJea0S
         B+6ZeoMfZTfuhVGk1a7z0HmV2ja8DYp5WfpJG+T3YUAuLqaO/OU6QWJEUgqlV5SBxU+r
         0vVUP864nBkQsk41cePudMrJNqq627c0EHqv1ZGXqmNhLM/cJKBXtPy/OUzzb8IWv8uj
         fHuyrnbtGoTOYYlRXgN1n4KCGGu2MZZs87nfWA4Uc55Ke1wE2bSvU6zaT2cxIAhph3qH
         8xV3CVEPmd9m4R/5s6IInrgNuwVfgXUh39I9nNsWDEXhHYFIMuTqSgtWjbB4oqTJZFiZ
         RcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4HCbTmBoKxeGRCwHnS+t3tgkJ4Ac3lNIToRxpu9oR4c=;
        b=GmdZWgukQZOzCjiYQr46m9p9vL/TC0fl1gRZOIcNsBe1FWgA1oDjpArOTsb8IbIxHO
         D+a4nJVZDumvd0GkJ+xbsEW0ktLqIwTqxE3lW7qN9VzdeQPwdhOZO6Vr3jLX1gGI0hFD
         DUdxXqgat4sUUFQw2ILEoGjoTTfRkrFjFTkYLhNzJcDyxPtQ/zyNPnIqZ/OsOVvxoauQ
         B8uoHssI01kalT2LapJ89wx6VAAEp+sH8tLsrb9CfdEdDeTkZmc7OEeaLDpb+3cxOY00
         mJhkx433y06C0Xdy1X213vm4wQN44oAcofaoCiDtaiLIwRABdhd6TDGyg7JGXQdsIcm4
         eyVQ==
X-Gm-Message-State: AJIora8Qg4QhHcIYKzRvupzAd3X4rkqYHwFX2AopOpihooSQk5HHvGdh
        yT/Z2DMW/3Ai4XeTWgo8uF7UYa7C484G+BapPlEARQ==
X-Google-Smtp-Source: AGRyM1vDPunn8MVh0wxLeLFQUHslZWTtOsoe2zawtvHKiOOKl+IkPmfqgYruQgM2loAC366SxhDLLEO/4B9nQZrRsjk=
X-Received: by 2002:a25:5b44:0:b0:669:504c:e49f with SMTP id
 p65-20020a255b44000000b00669504ce49fmr7755403ybb.530.1655961947558; Wed, 22
 Jun 2022 22:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20130116164832.GP2668@htj.dyndns.org> <50F6DD4D.3070808@linux.intel.com>
 <CA+55aFyjrXzKMqmOuMo9z24OZj3kD4O4M4y_O-h=r6udCz2MyA@mail.gmail.com>
 <20130116213032.GS2668@htj.dyndns.org> <CA+55aFzdf44QOZn4KS6tT09COFsmCg80sTah1XpeoErJxAzbRQ@mail.gmail.com>
 <20130118012503.GH16568@mtj.dyndns.org> <CA+55aFyCihvZqOo=83UwWq3AgJEfVqpNjsY2iCFOEm8o6Un-YA@mail.gmail.com>
 <20130118025936.GJ16568@mtj.dyndns.org> <20130118030407.GK16568@mtj.dyndns.org>
 <CA+55aFwAwX_o6ocGhd1WwUwxfOnh+S6aKeZdEpeeHVAnBm4uVQ@mail.gmail.com> <20130118221227.GG24579@htj.dyndns.org>
In-Reply-To: <20130118221227.GG24579@htj.dyndns.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jun 2022 22:25:11 -0700
Message-ID: <CAGETcx8Hss0ddF5A1qBtrZ1zUtt_=YehAhmj5JpxUSdo2WrCbg@mail.gmail.com>
Subject: Re: [PATCH 5/5] async, kmod: warn on synchronous request_module()
 from async workers
To:     Tejun Heo <tj@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Ming Lei <ming.lei@canonical.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jens Axboe <axboe@kernel.dk>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2013 at 2:12 PM Tejun Heo <tj@kernel.org> wrote:
>
> >>From 4983f3b51e18d008956dd113e0ea2f252774cefc Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Fri, 18 Jan 2013 14:05:57 -0800
>
> Synchronous requet_module() from an async worker can lead to deadlock
> because module init path may invoke async_synchronize_full().  The
> async worker waits for request_module() to complete and the module
> loading waits for the async task to finish.  This bug happened in the
> block layer because of default elevator auto-loading.
>
> Block layer has been updated not to do default elevator auto-loading
> and it has been decided to disallow synchronous request_module() from
> async workers.
>
> Trigger WARN_ON_ONCE() on synchronous request_module() from async
> workers.
>
> For more details, please refer to the following thread.
>
>   http://thread.gmane.org/gmane.linux.kernel/1420814
>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Alex Riesen <raa.lkml@gmail.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  kernel/kmod.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/kmod.c b/kernel/kmod.c
> index 1c317e3..ecd42b4 100644
> --- a/kernel/kmod.c
> +++ b/kernel/kmod.c
> @@ -38,6 +38,7 @@
>  #include <linux/suspend.h>
>  #include <linux/rwsem.h>
>  #include <linux/ptrace.h>
> +#include <linux/async.h>
>  #include <asm/uaccess.h>
>
>  #include <trace/events/module.h>
> @@ -130,6 +131,14 @@ int __request_module(bool wait, const char *fmt, ...)
>  #define MAX_KMOD_CONCURRENT 50 /* Completely arbitrary value - KAO */
>         static int kmod_loop_msg;
>
> +       /*
> +        * We don't allow synchronous module loading from async.  Module
> +        * init may invoke async_synchronize_full() which will end up
> +        * waiting for this task which already is waiting for the module
> +        * loading to complete, leading to a deadlock.
> +        */
> +       WARN_ON_ONCE(wait && current_is_async());
> +

If a builtin driver does async probing even before we get to being
able to load modules, this causes a spurious warning splat.

Here's a report by Marek [1]. I tried taking a stab at not warning at
least for drivers that do async probing before the initcalls are done,
but then I got confused [2] trying to understand when is the earliest
point in the bootup that request_module() can succeed. If someone can
clarify my confusion, I can try avoiding this warning for calls to
request_module() before we can load any modules. Any other ideas for
either making this warning way less trigger happy about false
positives?

[1] - https://lore.kernel.org/lkml/d5796286-ec24-511a-5910-5673f8ea8b10@samsung.com/
[2] - https://lore.kernel.org/lkml/CAGETcx-MHwex8tHLB1d71MAP01-3OPDZSNCUBb3iT+BtrugJmQ@mail.gmail.com/

Another question (pardon my ignorance) is whether we need to
async_synchronize_full() at the end of do_init_module() or if we can
limit it to a smaller domain? Looking at this history, I see that this
call was added by Linus in this commit d6de2c80e9d7 ("async: Fix
module loading async-work regression"). Are we doing the blanket
async_synchronize_full() only because we are not keeping proper track
of the async domains? And if so, then what if we have a sync domain
per module and any uses of async_schedule*() triggered by that module
is tied to the module's async domain? Then we'd only need to sync that
module's domain and we won't hit any deadlock issues.

Grepping for async_schedule*() calls, I see only about 30 instances.
At a glance, it looks like most cases are:
1. Have a device/driver from which we can find the related module and
tie the async_scheduler() to that domain.
2. Just direct async_schedule*() calls from module_init() -- we can
just directly tie it to the module's domain.
3. Other?

Is this idea worth pursuing? Or am I going in a completely wrong direction?

Btw, I did see Linus's suggestion in one of the emails in this thread
(?) about just doing a synchronize full on device open. That'd seem
like it would work too, but I'm afraid to touch any file open code
path because I expect that to be a hot path.

-Saravana
