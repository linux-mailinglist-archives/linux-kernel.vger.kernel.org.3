Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9C5A4166
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 05:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbiH2DPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 23:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiH2DPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 23:15:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C068C60DF
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:14:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id y3so13146158ejc.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=czsEz3uMSDGtuN3iX+1gBJ3GgnTp4SI1Njv08bLGbUU=;
        b=cPVVHSrIrAu2fehaiXFO0NP7AV/D8IKrlaMiQe+6eE9t8kVdLLqit3Ns43ao5yryMU
         bM3fOL+yiO5KsBC9cVh11Rmxm0oDVgV9e8FV3PDtt1F3rBjNB5Hi9jvvZ95lMWPmJgHo
         BzpLC+c2RDhxf774/fKbqWzoqlAZzsnK+vWK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=czsEz3uMSDGtuN3iX+1gBJ3GgnTp4SI1Njv08bLGbUU=;
        b=maR2v60X1gJaDH57Bk0FbZT2AMgnBNtEl71yvuW3Tesol1eju+5dGWYuyafOzS7ALq
         IJzR7oZwfyEiO3b37yhhCGkeu7dTACnFJXks824SDdraG8YdoddEAvLsuGTGZ63HggJS
         mMMSQAUjdtq7l9xoKel6VjRu5D+d8ng4M6JZf8fZxCNlX3y3GgzNEOI6NMXcceivl66u
         wxzQGKt71rIOwbpzurRE7QcUUis8NZWg6BcNA2UuGYhW3t2l8kkoLsN2XOdAZIbzHhT0
         Uvgvgc9Ih1eUx1J482lC3IcveQ6xt79DREPh/cOpDd4Mk8tIHD8dsRx/Gzg4R873FEHl
         xkOA==
X-Gm-Message-State: ACgBeo09jhDa99Tq9tEVC3ADierte06JNmx9MrVbySnmlQvT1UEuVDuE
        ZLWHd6r8URQmI0J0VcEcA3N+HMeAIdLma+Zg
X-Google-Smtp-Source: AA6agR7WCpZwUOM6oX3Kp9NLDW/LGhbW4btFDKyE4oW3uBRZbL+FYq4a3FjnY1A3oJ9AwjgLjK/2cA==
X-Received: by 2002:a17:907:2e19:b0:730:acf0:4921 with SMTP id ig25-20020a1709072e1900b00730acf04921mr11505230ejc.416.1661742895071;
        Sun, 28 Aug 2022 20:14:55 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id s14-20020a1709067b8e00b0073dc60271b2sm3957678ejo.32.2022.08.28.20.14.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Aug 2022 20:14:54 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id v7-20020a1cac07000000b003a6062a4f81so7467780wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 20:14:54 -0700 (PDT)
X-Received: by 2002:a7b:c399:0:b0:3a5:f3fb:85e0 with SMTP id
 s25-20020a7bc399000000b003a5f3fb85e0mr5607006wmj.38.1661742495614; Sun, 28
 Aug 2022 20:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220824163100.224449-1-david@redhat.com> <20220824163100.224449-2-david@redhat.com>
 <0db131cf-013e-6f0e-c90b-5c1e840d869c@nvidia.com> <ea380cf0-acda-aaba-fb63-2834da91b66b@redhat.com>
 <CALu+AoThhou7z+JCyv44AxGWDLDt2b7h0W6wcKRsJyLvSR1iQA@mail.gmail.com>
 <fe7aee66-d9f7-e472-a13f-e4c5aa176cca@redhat.com> <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
In-Reply-To: <CALu+AoRwVfr=9KabOLUQigWwCtP5RLQ1YaKbG75ZVM9E-bW2ZQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Aug 2022 20:07:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Message-ID: <CAHk-=wit-DmhMfQErY29JSPjFgebx_Ld+pnerc4J2Ag990WwAA@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] coding-style.rst: document BUG() and WARN() rules
 ("do not crash the kernel")
To:     Dave Young <dyoung@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, kexec@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Stephen Johnston <sjohnsto@redhat.com>,
        Prarit Bhargava <prarit@redhat.com>
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

On Sun, Aug 28, 2022 at 6:56 PM Dave Young <dyoung@redhat.com> wrote:
>
> > John mentioned PANIC_ON().
>
> I would vote for PANIC_ON(), it sounds like a good idea, because
> BUG_ON() is not obvious and, PANIC_ON() can alert the code author that
> this will cause a kernel panic and one will be more careful before
> using it.

People, NO.

We're trying to get rid of BUG_ON() because it kills the machine.

Not replace it with another bogus thing that kills a machine.

So no PANIC_ON(). We used to have "panic()" many many years ago, we
got rid of it. We're not re-introducing it.

People who want to panic on warnings can do so. WARN_ON() _becomes_
PANIC for those people. But those people are the "we have a million
machines, we want to just fail things on any sign of trouble, and we
have MIS people who can look at the logs".

And it's not like we need to get rid of _all_ BUG_ON() cases. If you
have a "this is major internal corruption, there's no way we can
continue", then BUG_ON() is appropriate. It will try to kill that
process and try to keep the machine running, and again, the kind of
people who don't care about one machine (because - again - they have
millions of them) can just turn that into a panic-and-reboot
situation.

But the kind of people for whom the machine they are on IS THEIR ONLY
MACHINE - whether it be a workstation, a laptop, or a cellphone -
there is absolutely zero situation where "let's just kill the machine"
is *EVER* approproate. Even a BUG_ON() will try to continue as well as
it can after killing the current thread, but it's going to be iffy,
because locking etc.

So WARN_ON_ONCE() is the thing to aim for. BUG_ON() is the thing for
"oops, I really don't know what to do, and I physically *cannot*
continue" (and that is *not* "I'm too lazy to do error handling").

There is no room for PANIC. None. Ever.

The only thing there is are "I don't care about this machine because
I've got 999,999 other machines, so I'd rather take one machine
offline for analysis".

Understand? The "should I panic and reboot" is fundamentally not about
the code, and it's not a choice that the kernel code gets to make.
It's purely about the choice of the person maintaining the machine.

As a kernel developer, you do not EVER get to say "panic" or "kill the machine".

End of story.

                 Linus
