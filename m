Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1873D59B609
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 20:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiHUSfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 14:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHUSfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 14:35:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7CF14085
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:35:48 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so11321912edi.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=YSSHJ+VsaJUg1r/a/+35lQH0g0L8gJK0fSZvr/ocZNM=;
        b=Pb8fZGy+qw0Jsf9P+rTvRUjSYIPbCrofsuhXOwLEr8uQbDYYGaxir8wRIXl6VzXQT9
         n106cXF4z3b4dLyvBjy4B68ijIfEE/wSbCAxQnNPKOJeMh6romfST0T2kKS4UhyWHR4o
         wkpvvYjz65wgaqr9KFZT2/XO7RORFwr5FsSk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=YSSHJ+VsaJUg1r/a/+35lQH0g0L8gJK0fSZvr/ocZNM=;
        b=owrF+7pC6oNEXcJzHDmLfLMAVpbf0LJckqmTRAtnvIO5/n1Ci9zzLwB+W3S5wpVSzj
         sAMoA8JxpSh9RNDfy+10umr5wQIfv9WqO9znRv45cZvyFDFLtZHoWaUd5X8w7+2xy8ky
         rxijqRCT4QQ5ZnjWr8zBx1JdMcNmG4HtJhHdzn7r5mF1rvMykcou9Ryoe2UqLtAXi+WC
         CD3hqJlkzcJlxahKYYQd5UqbA0vgRRV8/gilOtuTaE7elSgGlXll8BB9KZezDZQhkyuB
         hY8IfBI6xL+HDt1vUY4/ifXPa7u6l6FJTym5LKptouRDVPjx3sVHa5avJIqqYQMEvqMw
         I6Tw==
X-Gm-Message-State: ACgBeo0qBzqwGKcIBHgAAxsJCVvJmTZTJxNVwB1weN0Eg/N9ZRfjeknc
        RRFY5G29r7TMu6bAEFqcw/jUO5/3HYtz/3JY
X-Google-Smtp-Source: AA6agR6FJDFp+6F2oSghhBO4D8vuzEut4EGvt9o1v8U5xd5UNSAlEWhUQbRgRyOaOeMqD+wvupTqug==
X-Received: by 2002:a05:6402:1cab:b0:445:d67f:5323 with SMTP id cz11-20020a0564021cab00b00445d67f5323mr13717005edb.100.1661106947023;
        Sun, 21 Aug 2022 11:35:47 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 27-20020a170906329b00b0073c0b87ba34sm4821427ejw.198.2022.08.21.11.35.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Aug 2022 11:35:46 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id d16so5465714wrr.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 11:35:46 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:222:ca41:dc26 with SMTP id
 a8-20020a056000188800b00222ca41dc26mr8553970wri.442.1661106945788; Sun, 21
 Aug 2022 11:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220821000737.328590235@goodmis.org> <20220821000844.510643400@goodmis.org>
In-Reply-To: <20220821000844.510643400@goodmis.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 21 Aug 2022 11:35:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
Message-ID: <CAHk-=wjsxu782N0P+oMu35N7rJAOeh3buQFWJaZHZTNmVSB=3Q@mail.gmail.com>
Subject: Re: [for-linus][PATCH 01/10] tracing: Suppress sparse warnings
 triggered by is_signed_type()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
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

On Sat, Aug 20, 2022 at 5:08 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Since there is no known way of checking signedness of a bitwise type
> without triggering sparse warnings, disable signedness checking when
> verifying code with sparse.

What, what, what?

The last I saw of this discussion, the fix was just to make sparse not
warn about these cases. Why did this bogus fix make it into a pull
request that I will now ignore?

If we want to just shut up the sparse warning, then afaik the simple
one-liner fix would have been

-#define is_signed_type(type)   (((type)(-1)) < (type)1)
+#define is_signed_type(type)   (((__force type)(-1)) < (__force type)1)

and at least then sparse checks the same source as is compiled,
instead of passing a "this is not a signed type" to places.

So that "no known way" was always bogus, the real question was whether
there was a way to make sparse not need the "ignore bitwise" hack.

Btw, that patch is entirely broken for *another* reason.

Even if you were to say "ok, sparse just gets a different argument",
the fact that the trace_events file re-defined that is_signed_type()
macro means that you added that

+#undef is_signed_type

to make the compiler happy about how you only modified one of them.

But that then means that if <linux/trace_events.h> gets included
*before* <linux/overflow.h>, you'll just get the warning *there*
instead.

Now, that warning would only happen for a __CHECKER__ build - but
that's the only build this patch is relevant for anyway.

And maybe that ordering doesn't exist, or maybe it only exists on some
very random config. Regardless, it's broken.

Of course, the real fix should be to just not re-define that macro at
all, and just have it in *one* place.

                  Linus
