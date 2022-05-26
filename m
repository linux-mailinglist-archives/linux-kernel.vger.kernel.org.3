Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D90535273
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236667AbiEZRNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238640AbiEZRNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:13:51 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646B32DA91
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:13:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id u20so2577734edd.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vLmbrEy2PP3nbLOHrSgdn0TnCKQbA8uYZ/+AtNakFSw=;
        b=L4Ji3fiiRpXSJ3drcql+TyLsjhC+AM5jODVRmSW3i02WypkVR1aGjK7NuumtP34pu2
         UoHHRfaIxqiXnG3fF6Bm9rj8m0/Fsd/ptrDGVm+epy/qVjKoA/FttwIisrI8AK1Lt5ot
         uquKG1Hq+RQf64wxHXIb3OkWZYNRXE7vhtTJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vLmbrEy2PP3nbLOHrSgdn0TnCKQbA8uYZ/+AtNakFSw=;
        b=qap82FY637QxUU7P0e0JNJP4c7aAw69DYc133vwaGApOhQYmCS9U1WeLhPERqV+xxp
         aXy6bEKUFZqQYIGTDCpOCLpnwHX2eAed4RcK0bsw2Z8l/eFLv+ibjjwy+qFGiKnN1SwP
         2lYzS8ib9YHoRZEewuGD0Ru1XHK7udXGd5Hdu5i3VnBWcNnc0YwoYU+0Zw/4apKGSYdD
         wj0ehVGMIfSLwYhzH4cZz6kD1uMvAET7GlE1dZxcKxR+eHjYsFeGi0wwriBiT6bnvgqX
         D/IRkJhU+r9QnCPEuMNKPquO38fradruNC7+DmfGMJdoOBTK/3X05E+lLtoGzUX64/IL
         huAQ==
X-Gm-Message-State: AOAM531mqoysz+nmXy3mquP1Nm82McgqgrzBPPprTAAmVJJtU7c9hlEe
        zKIBv/IezaMq5aWHvn7WflDlYseBnyejuYgnGVs=
X-Google-Smtp-Source: ABdhPJwv4c4bPNQdZ8SwGXxfO2SERGOHL834H047ziShCbcDtio6SjSStrBnPOMDlwqWeeSTBEJezA==
X-Received: by 2002:a05:6402:354a:b0:42b:52ed:dde4 with SMTP id f10-20020a056402354a00b0042b52eddde4mr26445786edd.324.1653585228735;
        Thu, 26 May 2022 10:13:48 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id k25-20020a508ad9000000b0042bcc931c84sm981063edk.56.2022.05.26.10.13.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 10:13:47 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id x12so2941386wrg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:13:46 -0700 (PDT)
X-Received: by 2002:a5d:58c2:0:b0:210:1f7:bfa0 with SMTP id
 o2-20020a5d58c2000000b0021001f7bfa0mr6519550wrf.281.1653585225756; Thu, 26
 May 2022 10:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <YouKQw72H7y9EJQK@alley> <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
 <87pmk1tgmx.fsf@jogness.linutronix.de> <Yo9t9Vg/DpvMqCs7@alley>
In-Reply-To: <Yo9t9Vg/DpvMqCs7@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 10:13:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjny_OCPeBfr0uLzcMsAK2aa1TX3UPkp2V2scLD4g=7mw@mail.gmail.com>
Message-ID: <CAHk-=wjny_OCPeBfr0uLzcMsAK2aa1TX3UPkp2V2scLD4g=7mw@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.19
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 5:09 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Yeah, it is a shame. I have met code with exclusive waiters only once,
> 8 years ago and completely forgot about it.

Yeah, the exclusive waiters thing is quite unusual, and not a normal pattern.

It's basically only used for a very few performance-critical cases
where the "multiple readers, but only one writer should wake things
up" can happen.

And it's rare. It's things like "accept()" on a socket - where it's
common to have a lot of threads waiting for a new connection, but you
don't want to wake them all just because one new connection comes in,
because only one of them will successfully take it.

There are not very many patterns like that where you have that "many
people waiting for the same thing, only one will get it". It happens
for socket readers (kind of like accept, but for the "UDP packet with
command comes in"), or with things like pipes (which people use for
similar things and distribute work to potentially lots of threads
through a pipe).

So the common pattern tends to be "some event that gets a threaded
server using one thread to complete", but there just aren't that many
of those cases.

It _could_ also be used for things like locking (ie think "lock
release wakes up waiter"), but I think all our lock primitives end up
doing their wakeup routines at a lower level (ie using
"wake_up_process()" directly) so those don't actually use it.

End result: the exclusive waiters are an important case, but they are
rare - and thus the "all()" version of wakeup is also quite rare.

                        Linus
