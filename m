Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBD15353E3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 21:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345150AbiEZTZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 15:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345661AbiEZTZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 15:25:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C42DFF5E
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:25:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rs12so4718501ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBGAM8ryyHsLa1iHEdpEDPOuYUzM/w4WcP0+IKIl0to=;
        b=FpexxPFk6evFtmZePpp/pK5/5YvsIKeU3kuxpcbYGEPOLilZ1GMUSx6/yXBfsG5I4C
         kgHAp+KYicclMZQXM00SIOqqQqUhLuQw9/ED5Aa14fN9EYrQMMprD8xpZTE9viVygmg8
         1zv0Mi3o2BGPy/h/mVjjaWchquMhV9J5iJp8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBGAM8ryyHsLa1iHEdpEDPOuYUzM/w4WcP0+IKIl0to=;
        b=tzw//F+21Th0zR0kIhj3uPFb0+yYayxhwEDSU240XYjGxkARHGe5LOFBwQOdResBi8
         XcnLitH5USU1DUhFnQUgLYyXZt5bljCmASJuVtvW/KG7YWz+v325z/8xoPmLjzv3Q0s2
         WfC0jzQRoZQxbAILqMBVgaQYRstIp6KOlUKETY+mQprinyFGNj5aad8cOjvBVU0Gfxoi
         cUL3hr6ot8KHDEgYaPGllT/OkcxLvha7FBm+I/YXuG0ErjhzBYOZZFrXXYxIEpnvOgBt
         reQb0HXExKDoR0mDiE6JgZG1Q8uB4iqI00NyuiKtQrG00nejAjXiMYAkgHBSpVDLh9LQ
         mp5A==
X-Gm-Message-State: AOAM5308nLsLxwj6qVQv+KatruSSdLXYMNyes2GTeIlIfMkE42Y0qHLM
        7f29xhaTe0CkCIkMjWIX6LrTHJ4TOHbfLEPVdug=
X-Google-Smtp-Source: ABdhPJxaJtfuKWKqCyNiw1XLcB6iv/eS5xCkFeDpkSJqVNarCsY5l3U/9zESk9WrVgqYsNxyIfdUJA==
X-Received: by 2002:a17:906:4fd1:b0:6f3:be23:7ad5 with SMTP id i17-20020a1709064fd100b006f3be237ad5mr35204533ejw.264.1653593125347;
        Thu, 26 May 2022 12:25:25 -0700 (PDT)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id f22-20020a50d556000000b0042617ba63a9sm1137972edj.51.2022.05.26.12.25.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 May 2022 12:25:24 -0700 (PDT)
Received: by mail-wm1-f54.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso1613977wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 12:25:23 -0700 (PDT)
X-Received: by 2002:a1c:7207:0:b0:397:66ee:9d71 with SMTP id
 n7-20020a1c7207000000b0039766ee9d71mr3653949wmc.8.1653593123526; Thu, 26 May
 2022 12:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <13e61c61-0d4b-5f48-6373-f056bf8b603f@redhat.com>
 <CAHk-=wgV8zqiLi5p-SNZ2zSi95CkkFXqPZJjtneVXeobgAohJg@mail.gmail.com>
 <f39aa9c0-b4e6-1f5d-f556-643442fcbcc5@redhat.com> <CAHk-=wgNP+Dziv=4MDEf-wAW-U_0ZNNsL0gMDs7A46+CACgD4w@mail.gmail.com>
 <e5ff5023-c3e7-769b-33b0-2c4b376bc4d2@redhat.com>
In-Reply-To: <e5ff5023-c3e7-769b-33b0-2c4b376bc4d2@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 May 2022 12:25:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTRT6nQeJpVCKb+m=So6bLzUZQYcY6+RH5W0gZfsp+Fg@mail.gmail.com>
Message-ID: <CAHk-=wgTRT6nQeJpVCKb+m=So6bLzUZQYcY6+RH5W0gZfsp+Fg@mail.gmail.com>
Subject: Re: [GIT PULL] platform-drivers-x86 for 5.19-1
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Mark Gross <mark.gross@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
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

On Wed, May 25, 2022 at 5:34 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> 5. run:
>
> git tag -s platform-drivers-x86-v5.19-1 for-next
> git request-pull v5.18-rc1 git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git platform-drivers-x86-v5.19-1 > pull

So there's your problem.

You're basically saying "give me a pull-request against v5.18-rc1".

Which is bogus, since you already sent me part of your pile after rc1,
and I already have it, so now your pull request will end up repeating
those parts.

So just do

     git fetch origin
     git request-pull origin/master git://git....

to let git figure out what the actual common state is with 'origin'
(and obviously you may have a different name for my upstream
repository, so replace "origin" with whatever that correct name is).

(That "git fetch origin" doesn't have to happen right before the pull
request, but it has to be done at *some* point so that your git tree
is basically aware of what I've merged from you previously).

Anyway, the important point is that you shouldn't try to remember -
incorrectly - what the last common point for us is.  Git knows - as
long as you just give it enough info.

                 Linus
