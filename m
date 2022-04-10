Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56BA4FABE0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 06:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiDJE30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 00:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiDJE3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 00:29:21 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE12633
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 21:27:11 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so16265211ljb.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 21:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Z1YLQ6CPp8qWYSXS6O3ReggvGyrIKglimVJl59baLE=;
        b=FcqLW9awS934gzVuSpON2tUcZg9aQBii+95gzCDBKmpWOTeF5pPT+AwkiXPREoO67S
         I85/O8SH3u9kIcfoyOvoUIaLO3i/R0YD0Riz9BJ0iyZ7hQio7lsfQVv+qjcQ7MqM7CA3
         SzEkytBk0Jt7+mEt8xTOE74CLkIQbrkqixg1Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Z1YLQ6CPp8qWYSXS6O3ReggvGyrIKglimVJl59baLE=;
        b=Ji+V+fnmLRONxwgc6mezJK6OLY0L9ojKH6kBfgFcioux0BASoNr4HHIrQ7gbPOIGpa
         ArAgcwp9E5R1O/oZ5KThuLSbP8mkUdPS5Y3M6D3BDXPLQqMBOh8JFjPML7ez1fnE9FyK
         yrlaipFgud91UGSBz9vZbERtMOqc6qyKhPcSa9WtF+V+3bYIDIt5F8Go7fPRt+z0GQNZ
         gky855zolRKU1hQsxDUQ3K/iMCBUNiOspY0857BMGtqdiW5m4Hu5DOZdIwrku0tCIfNw
         DYbOuYpKKqKqO2EfywA11CwhPCZwe96FMlR2+Nv0cWAkGeI4GUsOs9/mP0sic9T0lX/X
         elTA==
X-Gm-Message-State: AOAM530s/kexTGHqmYXkJBE/mBvq4dljXSywFZOy7XZMdnmyLmv/o3i5
        08oYSeT4CnZWxMrUj65uVbZ9SQ4mq3zk2vQS
X-Google-Smtp-Source: ABdhPJxqTZG+CeLsla4gfYifxO1zXNMCPPW55HaR2v9l7asniEjwqvdD6uAINd4rTfesA4/pXohxlQ==
X-Received: by 2002:a2e:a445:0:b0:24a:c1ba:b62f with SMTP id v5-20020a2ea445000000b0024ac1bab62fmr16519563ljn.81.1649564829720;
        Sat, 09 Apr 2022 21:27:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n19-20020a056512311300b0046b92bec151sm330511lfb.112.2022.04.09.21.27.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 21:27:09 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id bn33so16236926ljb.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 21:27:08 -0700 (PDT)
X-Received: by 2002:a2e:a549:0:b0:249:9ec3:f2b with SMTP id
 e9-20020a2ea549000000b002499ec30f2bmr16565379ljn.358.1649564827924; Sat, 09
 Apr 2022 21:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220409205134.13070-1-brgl@bgdev.pl>
In-Reply-To: <20220409205134.13070-1-brgl@bgdev.pl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 9 Apr 2022 18:26:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wgQbb0cvOnX1W5_Ho_SvpYqS4GuEo=gxhbw-UCjOaEpQg@mail.gmail.com>
Message-ID: <CAHk-=wgQbb0cvOnX1W5_Ho_SvpYqS4GuEo=gxhbw-UCjOaEpQg@mail.gmail.com>
Subject: Re: [GIT PULL] gpio: fixes for v5.18-rc2
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
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

On Sat, Apr 9, 2022 at 10:51 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Here's a single fix for a race condition between the GPIO core and consumers of
> GPIO IRQ chips.

I've pulled this, but it's horribly broken.

You can't just use a compiler barrier to make sure the compiler orders
the data at initialization time.

That doesn't take care of CPU re-ordering, but it also doesn't take
care of re-ordering reads on the other side of the equation.

Every write barrier needs to pair with a read barrier.

And "barrier()" is only a barrier on that CPU, since it is only a
barrier for code generation, not for data.

There are multiple ways to do proper hand-off of data, but the best
one is likely

 - on the initialization side, do

        .. initialize all the data, then do ..
        smp_store_release(&initialized, 1);

 - on the reading side, do

        if (!smp_load_acquire(&initialized))
                 return -EAGAIN;

        .. you can now rely on all the data having been initialized ..

But honestly, the fact that you got this race condition so wrong makes
me suggest you use proper locks. Because the above gives you proper
ordering between the two sequences, but the sequences in question
still have to have a *lot* of guarantees about the accesses actually
then being valid in a lock-free environment (the only obviously safe
situation is a "initialize things once, everything afterwards is only
a read" - otherwise y ou need to make sure all the *updates* are
safely done too).

With locking, all these issues go away. The lock will take care of
ordering, but also data consistency at updates.

Without locking, you need to do the above kinds of careful things for
_all_ the accesses that can race, not just that "initialized" flag.

                 Linus
