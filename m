Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29534E7B32
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiCYRkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 13:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiCYRkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 13:40:03 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D821103D92
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:38:18 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id t25so14524051lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ePGjuXY8EO300BC/e4D5JyF5EaxATMuVc7TnpwwcYEU=;
        b=YHCnXa72ZLr6yRIhfmI5bNfAobivYRAXL+moD2gJKv7xdzD5CC/WAujsbz5zmuUUzx
         QSSJh5ML9/Hjxx4wKvOFGKe1v7BxnrSscY6WTke84lCG+ydB5YIkE4TZAfxH4KSrdad7
         qD3kLbi+RRATiEZ01j6SRznufrg8san05uhLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ePGjuXY8EO300BC/e4D5JyF5EaxATMuVc7TnpwwcYEU=;
        b=yDm2V+ZAtrijQlrDhcjoKune7zN8188b9yIQjoO10rEUrsACLTo8CcEbo3mUM95xDl
         EmAmHLOcvpGZcUfJ5hO9eH/rl8RZKBMo167kgNJajtgzjx26wtSwoMvwqoDmELwgIeui
         UFeTNBcAtFgF5bFZx6oMIDXqXaQfr0Yx8uxiVHPMUqdrm1R28ZA7tbWzAlgz9pmfkHIw
         4tn2RXcpDeRRv32obR/qeJnl3HgBAOdP0C3rW3YzxcRqpQ9XTcXiQP9XPMjnuzeImd7K
         9dwk1pgjsjQoe7uX9yesqfwQRtKoIQkQWnmZS8Yuc2QgzPzXLEk534xgjemo+8KojyPR
         lCpQ==
X-Gm-Message-State: AOAM5336+aTA4x7v5yPjwJizlLe97q9e3XljXnQxOZ+zOVKHj+LqtZWK
        16LRvhaEgytvBl1Lb2vYl7QnDUNNscwOG6Mmxbs=
X-Google-Smtp-Source: ABdhPJwUMpwJ8CddZQ82fRHQjmCf6RekXUr2DU0apImXbk1CMjTa07whYiy3ICqG4JeNQ1MAhjJGMQ==
X-Received: by 2002:a19:f24e:0:b0:449:f431:e774 with SMTP id d14-20020a19f24e000000b00449f431e774mr8643520lfk.189.1648229382486;
        Fri, 25 Mar 2022 10:29:42 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id m22-20020a197116000000b0044a0dbba162sm770854lfc.235.2022.03.25.10.29.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 10:29:39 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id z12so722569lfu.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 10:29:38 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr5516914lfu.531.1648229378049; Fri, 25
 Mar 2022 10:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <YjhdcJB4FaLfsoyO@gmail.com> <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <YjpLiKRUIB4TGJm0@zn.tnic> <CAHk-=wifoM9VOp-55OZCRcO9MnqQ109UTuCiXeZ-eyX_JcNVGg@mail.gmail.com>
 <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
In-Reply-To: <Yj2qZT6gdRYpkSIR@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 10:29:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaxDHAhxBkU_mVE5uw5po+qvzy4jgK8Q82rgi7XqZfiA@mail.gmail.com>
Message-ID: <CAHk-=wgaxDHAhxBkU_mVE5uw5po+qvzy4jgK8Q82rgi7XqZfiA@mail.gmail.com>
Subject: Re: [GIT PULL] locking changes for v5.18
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 4:42 AM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> What about old one? I have already complained in the early discussion that
> `make W=1 ...` is broken by this change.

So that is REALLY D*MN EASY TO FIX.

If you use W=1, and don't want WERROR, then don't *do* that then.

End of story.

But that's on _you_. Not on the build system. If you use W=1 and
WERROR together, you get exactly what you asked for. It might even be
what you wanted, if you want to go through the warnings/errors as you
encounter them, instead of building everything.

And that's why I refuse to take the completely broken "strip out one
or the other automatically" change.

It's a perfectly valid combination to enable both.

But more importantly, -Werror is more important than W=1. So if
anything should be disabled, it's W=1.

Side note: that would be trivial to just have in the Kconfig files if
W=1 was just a config option.

Do something like

     config EXTRA_ERRORS
         int "Add extra compiler errors" if EXPERT
         depends on !WERROR
         range 0-2
         default 0

but note again: WERROR should be the thing that controls this and
should be on by default, not the other way around.

If you want EXTRA_ERRORS, you should not only be CONFIG_EXPERT, you
should also have to manually disable WERROR that *normal* people
should have on by default.

              Linus
