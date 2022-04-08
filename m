Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E953F4FA00D
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbiDHXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbiDHXU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:20:59 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A044A377C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:18:52 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d40so9901132lfv.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 16:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+0RZpqf3KzwJPURLDOzp5VeHv5/Is97npE43jIV+BQ=;
        b=AOYCq50jR9qrc2EYro6XeQOFteBCb6c/hMcxBF1TZRtQb+TjlrxF/sPevQuCKcPp05
         ddxaU/W2cU2INMOoSXaI0NT9nzuctbV/PvuD0jKHkqSYJs/5c2sBxed2QYr3e/qGzaqP
         iIpPCS3xfEKYE7pRLBQqzqOJt8HCOpRSyXBXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+0RZpqf3KzwJPURLDOzp5VeHv5/Is97npE43jIV+BQ=;
        b=rtajv73t5nAI+kiKnS/8EWelliVnLDC284Tk/jE7QWYs4aH/gvD1CLLbfQsbL5Um71
         pCgEclbHDFgN6bD8XsgXYW2M80NVJPgqYhOWLZk52HjtUr1OCi0BsNXvazBlEzJsDrO5
         UV2HPlEqmgmABY8uApVvVn87lRP77+zRQW8d4ZwCx+kkSHHS4+Tnw2f5m6umIG3zIC3u
         Z4f213SenutD4Hn9l9/W0iDxa4bJ8mVqEnwYgmMuUOilauNMkjWd5p+j7AQZ0y5M3Way
         Zg3MjxMLoE4nGxXI252Nlgt4YgGJ3FxB9zUQ3rt/Mh4Gf9suzT7QBX5rhXn+2KEEtejf
         zg9g==
X-Gm-Message-State: AOAM531Iy97EvegvStE9aWBWBpDpRLC495RwTa4jDejd6eUwZ2tryN8N
        r/wkdzhpUsFFeFtNO5+oD6aIozaX+foLM+nc
X-Google-Smtp-Source: ABdhPJxdFCzuZXm2N9M0h/Yj6U3+eWFdluZQy5rvtcveaiSIUroKL9KmOuCuocYJrD+5CBcUFGXLzg==
X-Received: by 2002:ac2:4290:0:b0:464:f225:1a37 with SMTP id m16-20020ac24290000000b00464f2251a37mr7146946lfh.140.1649459930672;
        Fri, 08 Apr 2022 16:18:50 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c3-20020a2e9d83000000b0024b5382fef9sm220648ljj.71.2022.04.08.16.18.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 16:18:49 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id q14so13245264ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 16:18:48 -0700 (PDT)
X-Received: by 2002:a2e:9041:0:b0:24a:ce83:dcb4 with SMTP id
 n1-20020a2e9041000000b0024ace83dcb4mr13349107ljg.291.1649459928561; Fri, 08
 Apr 2022 16:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220407161745.7d6754b3@gandalf.local.home> <87pmlrkgi3.ffs@tglx>
 <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com> <20220408161025.5842a663@gandalf.local.home>
In-Reply-To: <20220408161025.5842a663@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Apr 2022 13:18:27 -1000
X-Gmail-Original-Message-ID: <CAHk-=whPMLcdy0P6WGP4nbrn-e1ksr35sBM+k=kziWikzmQ31A@mail.gmail.com>
Message-ID: <CAHk-=whPMLcdy0P6WGP4nbrn-e1ksr35sBM+k=kziWikzmQ31A@mail.gmail.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 10:10 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We have that already, it's called "del_timer_sync()". And that's not used
> when it should be, and does not catch the case of the timer being rearmed.

THAT'S MY POINT.

It doesn't do the "no rearming".

So my point is that people who actually use "del_timer_sync()"
generally *want* that "no re-arming", and right now they go to extra
work to do so.

Because calling del_timer_sync() while the timer can get re-armed is
almost always a bug _anyway_.

So :

 - don't use the name "free" - because that's not what people always are about

 - aim to *replace* the current del_timer_sync() with the new functionality

A new name is good. But "free" is wrong. The function doesn't free
anything, and it's not necessarily even the case that all users would
want to free it.

I do like the "timer_shutdown()" naming that Thomas suggested.

Imagine having something that just guarantees that the timer isn't
running, and you have to explicitly restart it.

No, del_timer_sync() doesn't do that. It only guarantees that any
previously started timer has been finished.

And no, currently we don't actually have a "timer_restart()". You have
to re-init it completely with timer_setup(), and then do a
"mod_timer()". But that's because we haven't had that
"timer_shutdown()" functionality in the past.

Now, most timers don't necessarily re-arm themselves at all, so those
people don't care, and del_timer_sync() works for them as-is.

 But even if you don't have a self-rearming timer, maybe you want to
make sure nobody else restarts it either.

As mentioned, right now people actually do things like this manually
using some flag of their own.

               Linus
