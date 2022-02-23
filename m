Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078104C1D11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241035AbiBWUW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241097AbiBWUW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:22:57 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45E4D251
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:22:29 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u11so5771521lju.4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3H2+NYtTtjeGTQYVonE+hBzT55dUXsQnd/qXFVfW9U=;
        b=FJYeflWGBh0cbxz8hlGeGMD3+L4e4hFc/0jlzVwyFG+y4B4WF9+QCmtYl7JL34CB+2
         mXfO6w03DriGF514W5BCsF8o5mGA/NKs5uDMPQr+h6Wo6xHSlepZe0EdBcXyGBiW1XrG
         id6hqr0iWW0az6wyMpunwbHhqvhKopWPc3twU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3H2+NYtTtjeGTQYVonE+hBzT55dUXsQnd/qXFVfW9U=;
        b=C0jKOJzdwZzeHvZB4iYTi7AYzKZy9mvoqtYc/arSWhO6GloEF0bvFablpVejhNyPkU
         cOr44A3+Jb7o4RJsv7Sl7lGs6+DZ5dBhQFwg1m23MfTchauQpWO0JlKCIo+HTRum9SFr
         BLHIwMHRIynPuQs7VIg9uknVCP0gMYkY/N1Mm/V2BEYkTvpK4tB8IZ6oljZO+39zOMpQ
         WqtFjEirGo4JWI3qi1ZioRbALTkNeE1C98af9Gh5rEG7uB8U9EYU3olMZgXlT7RTwdTA
         S5JbC0EVbXFTgPg51hohQ47XrjKoPF8+d6VDHWkJ3Kxg4hodyC2xuzuxXiPuKVXd2sWs
         Hw2g==
X-Gm-Message-State: AOAM533ueU4c7FT9pRJswchNXDyGwYrwIEYDHeEpsc0nlWDjZvhddSyy
        F6bH8+lUwgZtcu4Z4UyF89jMtmcrW+KQulJbhsQ=
X-Google-Smtp-Source: ABdhPJzEihtyl5goPF0iEDTH0kVzIi8IDXPsGvSdziSV/l4L5S3Swf11TlmprQxi5pwld1WcclG4Cg==
X-Received: by 2002:a2e:91d4:0:b0:23f:2ae2:2898 with SMTP id u20-20020a2e91d4000000b0023f2ae22898mr743130ljg.429.1645647747499;
        Wed, 23 Feb 2022 12:22:27 -0800 (PST)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id w23sm43247lfu.96.2022.02.23.12.22.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:22:25 -0800 (PST)
Received: by mail-lj1-f170.google.com with SMTP id t14so26359356ljh.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:22:25 -0800 (PST)
X-Received: by 2002:a2e:b8cc:0:b0:246:4767:7a29 with SMTP id
 s12-20020a2eb8cc000000b0024647677a29mr803446ljp.152.1645647744896; Wed, 23
 Feb 2022 12:22:24 -0800 (PST)
MIME-Version: 1.0
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com> <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com> <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca> <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
 <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
In-Reply-To: <F9A66F89-66C2-4322-808B-275384C4CC9D@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:22:08 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
Message-ID: <CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com>
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
To:     Jakob <jakobkoschel@gmail.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
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

On Wed, Feb 23, 2022 at 12:15 PM Jakob <jakobkoschel@gmail.com> wrote:
>
> in such a case you would still have to set the iterator value to
> NULL when reaching the terminating condition or am I missing something?

No.

Make the rule be "you never use the iterator outside the loop".

IOW, the code sequence is

        some_struct *ptr, *iter;

        ptr = NULL;
        list_for_each_entry(iter, ...) {
                if (iter_matches_condition(iter)) {
                        ptr = iter;
                        break;
                }
        }

        .. never use 'iter' here - you use 'ptr' and check it for NULL ..

See? Same number of variables as using a separate 'bool found' flag,
but simpler code, and it matches the rule of 'don't use iter outside
the loop'.

This is how you'd have to do it anyway if we start using a C99 style
'declare iter _in_ the loop' model.

And as mentioned, it actually tends to lead to better code, since the
code outside the loop only has one variable live, not two.

Of course, compilers can do a lot of optimizations, so a 'found'
variable can be made to generate good code too - if the compiler just
tracks it and notices, and turns the 'break' into a 'goto found', and
the fallthrough into the 'goto not_found'.

So 'better code generation' is debatable, but even if the compiler can
do as good a job with a separate 'bool' variable and some cleverness,
I think we should strive for code where we make it easy for the
compiler to DTRT - and where the generated code is easier to match up
with what we wrote.

                  Linus
