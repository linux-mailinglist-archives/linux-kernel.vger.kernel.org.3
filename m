Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48757589282
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiHCS5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiHCS5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:57:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051DA33A0E
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:57:47 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id uj29so19920469ejc.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=/dqFZCHimKdfgJ5h2Hr/dgVrJv3glvLsMO7a64z+Kfw=;
        b=EVf6K6yS1s/uIkLCTDq/IPckjNF1FRgd+BEcICTHa2dhO1BuQMok9ES/sWfkORPWD9
         72cZfMHbz0woORa8syTupSGqbMlAQt16vp4Mjcz6+RL2EJNtdOfihZO7wX6ZryjGL/mV
         kwPnHvH3UEYHQZ7IBtgQmfGVkUXinWJgrYiKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/dqFZCHimKdfgJ5h2Hr/dgVrJv3glvLsMO7a64z+Kfw=;
        b=ht8Muhkb8uY6uOWAglO6LvrvHUUdUBAMYnPfcRkscRv5h1gqktL8OEMo2YwS8dSFyL
         JbnyqS7TmTcbHwxA2eyBZDk1zm03FIwbkKph/zcPqSFnjT8t0e1VfV1gksYu3c1SVey3
         BML4Gw7OW0OwaLbSLDYWfihWnKrjZrAf+1R5a83U9gm6FDXKWS9BYfq0AQuiqZs2riw6
         bn3pGUbWcHlvWTlABqcTKEVMv66OM/jY39Vi0/2wSsy4kfwNAOOFv942J5nnwWmzXDUA
         yuT/XqPKPpvZIXQi7DcETGAItChTnt19+1J0wjEV9zovxAIMxGRMY1nm6hqJOyUZOUm6
         bUbw==
X-Gm-Message-State: ACgBeo2PRjh4NwvUhc3rYM8cOlqufrwnOPShQfxV/XEWvaFrEsXSDq4o
        6N0qPodmpMOm4YJ6vJux2sndFIYLbK3GBUeI
X-Google-Smtp-Source: AA6agR6nrkmJfnba5eeQgEBaX3oYJT7jiVAsfBTS1OrKrcGWUbQ+OeuGKwKfq9Odx4mk/+AoVZSR5A==
X-Received: by 2002:a17:907:97c3:b0:730:978c:bfbe with SMTP id js3-20020a17090797c300b00730978cbfbemr10002927ejc.186.1659553065119;
        Wed, 03 Aug 2022 11:57:45 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id nb41-20020a1709071ca900b0072637b9c8c0sm849490ejc.219.2022.08.03.11.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 11:57:44 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id h13so3346303wrf.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:57:44 -0700 (PDT)
X-Received: by 2002:a5d:56cf:0:b0:21e:ce64:afe7 with SMTP id
 m15-20020a5d56cf000000b0021ece64afe7mr16553047wrw.281.1659553063979; Wed, 03
 Aug 2022 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV>
In-Reply-To: <YurA3aSb4GRr4wlW@ZenIV>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 11:57:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
Message-ID: <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 11:39 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Main part here is making parallel lookups safe for RT - making
> sure preemption is disabled in start_dir_add()/ end_dir_add() sections (on
> non-RT it's automatic, on RT it needs to to be done explicitly) and moving
> wakeups from __d_lookup_done() inside of such to the end of those sections.

Ugh.

I really dislike this pattern:

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_disable();
       ...
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_enable();

and while the new comment explains *why* it exists, it's still very ugly indeed.

We have it in a couple of other places, and we also end up having
another variation on the theme that is about "migrate_{dis,en}able()",
except it is written as

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                migrate_disable();
        else
                preempt_disable();

because on non-PREEMPT_RT obviously preempt_disable() is the better
and simpler thing.

Can we please just introduce helper functions?

At least that

        if (IS_ENABLED(CONFIG_PREEMPT_RT))
                preempt_disable();
        ...

pattern could be much more naturally expressed as

        preempt_disable_under_spinlock();
        ...

which would make the code really explain what is going on. I would
still encourage that *comment* about it, but I think we really should
strive for code that makes sense even without a comment.

The fact that then without PREEMPT_RT, the whole
"preempt_disable_under_spinlock()" becomes a no-op is then an
implementation detail - and not so different from how a regular
preempt_disable() becomes a no-op when on UP (or with PREEMPT_NONE).

And that "preempt_disable_under_spinlock()" really documents what is
going on, and I feel would make that code easier to understand? The
fact that PREEMPT_RT has different rules about preemption is not
something that the dentry code should care about.

The dentry code could just say "I want to disable preemption, and I
already hold a spinlock, so do what is best".

So then "preempt_disable_under_spinlock()" precisely documents what
the dentry code really wants.

No?

Anyway, I have pulled this, but I really would like fewer of these
random PREEMPT_RT turds around, and more "this code makes sense" code.

                Linus
