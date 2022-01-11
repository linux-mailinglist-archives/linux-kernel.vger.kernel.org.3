Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B885B48B73A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiAKTUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350494AbiAKTT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:19:56 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B24C034003
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:18:37 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o6so342260edc.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B44bvcGMR7HJrF8RjjxVk6yTIMoiYipBLak96y+Vc5U=;
        b=b2vOkvqM6CrU97KTnO6tCUMPeqtx4Tb9raQiqg+DsCBvIm5TjoldAmKmEfiOSjOJi8
         Q2wHU19wTfiKrO4kFP5KoxmIJN/5uCNBtFVo+DFeoT5q8s6S7/g7wbRMshY/F57KQpZc
         HByWVJ89WRq9xPL/+lWSfsSWUMQUEeyGZRwaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B44bvcGMR7HJrF8RjjxVk6yTIMoiYipBLak96y+Vc5U=;
        b=U2OPd/2rEOH//LI8o2lm3vfGGmtf2ISFjEW77J6PjCS73IRr3nZEaYsLzn2gTQLTJc
         QcOsqAuy1fypNORC5ipVr2iJ9+pTAQonwDaRzbRU9eQr/kpQ8w/35XfpJ22oJwL05dDO
         lMG4e9XzI7IZOgP3hoBbG/SsT7YSxcOq+vw5bvB5yFVAFyTiehpVd53dxsQmeFBHDkuc
         1yUJ5pGc4VnORr7jLzkUnm13Ieg5OfM+Lj9Tl5If5nczj78fzD40q7hLMBWxfVdvjJ+s
         9ejeLWsSJWUhCk4yYqJCSl783Oyv7egZMrrOjCOj0O3WqzUscPhWb0Sxu+DgDSPvy8Yq
         sI9w==
X-Gm-Message-State: AOAM531LkFygLspuayM5rqEv5k4zblCKIXUwK5X6oqG38zbexlcANU/6
        50u1psaG9YQvnIp04xf7mv9aIIgHMSiEsik2yu4=
X-Google-Smtp-Source: ABdhPJzGDNILMyQ4jD/kvTT92RH9yKNPSTBfIIt7cDxB/U1s2d0F5yYRtTQG5YJiahGkqZ0nbNJbXg==
X-Received: by 2002:a17:907:9616:: with SMTP id gb22mr4571095ejc.412.1641928716164;
        Tue, 11 Jan 2022 11:18:36 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id gz11sm3885602ejc.223.2022.01.11.11.18.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 11:18:36 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id c71so307038edf.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 11:18:35 -0800 (PST)
X-Received: by 2002:a5d:6083:: with SMTP id w3mr1539236wrt.281.1641928308184;
 Tue, 11 Jan 2022 11:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20220111071212.1210124-1-surenb@google.com> <Yd3RClhoz24rrU04@sol.localdomain>
In-Reply-To: <Yd3RClhoz24rrU04@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 11:11:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
Message-ID: <CAHk-=wgwb6pJjvHYmOMT-yp5RYvw0pbv810Wcxdm5S7dWc-s0g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] psi: Fix uaf issue when psi trigger is destroyed
 while being polled
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 10:48 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> The write here needs to use smp_store_release(), since it is paired with the
> concurrent READ_ONCE() in psi_trigger_poll().

A smp_store_release() doesn't make sense pairing with a READ_ONCE().

Any memory ordering that the smp_store_release() does on the writing
side is entirely irrelevant, since the READ_ONCE() doesn't imply any
ordering on the reading side. Ordering one but not the other is
nonsensical.

So the proper pattern is to use a WRITE_ONCE() to pair with a
READ_ONCE() (when you don't care about memory ordering, or you handle
it explicitly), or a smp_load_acquire() with a smp_store_release() (in
which case writes before the smp_store_release() on the writing side
will be ordered wrt accesses after smp_load_acquire() on the reading
side).

Of course, in practice, for pointers, the whole "dereference off a
pointer" on the read side *does* imply a barrier in all relevant
situations. So yes, a smp_store_release() -> READ_ONCE() does work in
practice, although it's technically wrong (in particular, it's wrong
on alpha, because of the completely broken memory ordering that alpha
has that doesn't even honor data dependencies as read-side orderings)

But in this case, I do think that since there's some setup involved
with the trigger pointer, the proper serialization is to use
smp_store_release() to set the pointer, and then smp_load_acquire() on
the reading side.

Or just use the RCU primitives - they are even better optimized, and
handle exactly that case, and can be more efficient on some
architectures if release->acquire isn't already cheap.

That said, we've pretty much always accepted that normal word writes
are not going to tear, so we *have* also accepted just

 - do any normal store of a value on the write side

 - do a READ_ONCE() on the reading side

where the reading side doesn't actually care *what* value it gets, it
only cares that the value it gets is *stable* (ie no compiler reloads
that might show up as two different values on the reading side).

Of course, that has the same issue as WRITE_ONCE/READ_ONCE - you need
to worry about memory ordering separately.

> > +     seq->private = new;
>
> Likewise here.

Yeah, same deal, except here you can't even use the RCU ones, because
'seq->private' isn't annotated for RCU.

Or you'd do the casting, of course.

              Linus
