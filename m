Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F45342AE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243863AbiEYSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiEYSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:09:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695838D691
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:09:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id q15so4896641edb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRkHcd8s4ALLVT0dz9R8wU6Dyfv3RsX5g6d95y6kyVg=;
        b=CcNicq/uL1ohoK3ra8nNfQr0V3hGSWF8YX6N94AENAc3GcjN1oIxB1mjFPYdi2oYvk
         kDJMNSfWUCSJCHGc/4oY+60TyOp+cpqXrdMFyj/8AFKBF1FrJDB1TjYsHooiDwdeeHX6
         MGiXHaQlXmjXoCo4H4Ud/47qhGHeN7oBdnY/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRkHcd8s4ALLVT0dz9R8wU6Dyfv3RsX5g6d95y6kyVg=;
        b=Gn0TJgsZEkfSSForlwD0t/RzRMzVzesYDQLkkPQGc4IVux5xAiuzIajEsKvgzT0dX5
         0mqJqDAAbytnmCzQsYpaOq7XjpP7i+o2RwBJ1hxSfiWJ3eLqm+a1QvK8hgOjbINSDkr6
         iH5crOv3eGqAoFYmOpn/sgDvwC4ZMy2dum6nuL4GJg0TwfRAYNFm9reb6iDebCu+X//D
         Pg0VDqRMA/qXdDKz3jnsnKi1WhtG+fZ90XyNDoQZYjIpleeGDFBHD7Ij9+x32XimIAh4
         FHmjW5dNnJzjuiNaKCmsGW9HNZRFt8liPz5pBRJOIEWdX2hXMzDgyXfCx8Zko3V2iley
         9IOw==
X-Gm-Message-State: AOAM530ORN/0c5ZsHrjB62/nxZt6w35AJo3nhQq1LOdcAGTbNcNm01wY
        P/TtJopo+kfnpEBeKjToV++3YLIFWdpYxLl6DXo=
X-Google-Smtp-Source: ABdhPJz1ZEirQZ/xJRWsxcsd5gXPBnFEcxM+SezWMyVSDnq/j1HH2QDHSQeCPMrPXM03SPwHF+Wtpg==
X-Received: by 2002:a05:6402:48c:b0:42a:e585:103 with SMTP id k12-20020a056402048c00b0042ae5850103mr35781096edv.375.1653502161757;
        Wed, 25 May 2022 11:09:21 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906161400b006feba4ef020sm4975150ejd.180.2022.05.25.11.09.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 11:09:19 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id p189so12943586wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:09:19 -0700 (PDT)
X-Received: by 2002:a05:600c:4f0e:b0:397:6b94:7469 with SMTP id
 l14-20020a05600c4f0e00b003976b947469mr4160846wmq.145.1653502159032; Wed, 25
 May 2022 11:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <YouKQw72H7y9EJQK@alley>
In-Reply-To: <YouKQw72H7y9EJQK@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 11:09:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
Message-ID: <CAHk-=wgC47n_7E6UtFx_agkJtLmWOXGsjdFjybBFYNA1AheQLQ@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 5.19
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
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

On Mon, May 23, 2022 at 6:21 AM Petr Mladek <pmladek@suse.com> wrote:
>
>   There are situations when the kthreads are either not available or
>   not reliable, for example, early boot, suspend, or panic. In these
>   situations, printk() uses the legacy mode and tries to handle consoles
>   immediately.

Let's see how this works out, but I do have one complaint/query about
the series.

Looking through the commits, I don't see how that "printk: wake up all
waiters" makes any sense at all.

It *ALREADY* woke up all waiters as far as I can see.

Doing a wake_up_interruptible() will stop waking things up only when
it hits a *exclusive* waiter, and as far as I can tell, there are no
exclusive waiters there.

And if they were there, the "wake_up_all()" wouldn't be the right thing anyway.

So that commit seems to be fundamentally confused about things.

You should NEVER use wake_up_interruptible_all() in any normal code.

That "all()" form is only for when there are exclusive waiters (that
are expected to handle the situation entirely, or wake up the next
waiter if they don't), *and* you have some exceptional thing that then
causes *ALL* waiters to need to be woken up.

For example, a "read()" might be an exclusive wait, so that multiple
potential concurrent readers don't cause a scheduling herd of
processes all to wake up when somebody writes to the socket or pipe or
whatever.

So in that situation a write() uses a regular wakeup, so that we only
wake up the one waiter that will take care of things.

But then a *shutdown* event obviously does affect everybody, so that
would cause a "wake_up_interruptible_all()".

I really don't see why the printk() code decided to use that wakeup
function, and the commit message doesn't explain why it was done
either.

I'm sure we have lots of drivers that are confused about core things
like this, and I don't really care.

But when I see something really core like printk() get confused and
mis-understand basic wait queue behavior, that makes me go "This is
WRONG".

Please explain.

                    Linus
