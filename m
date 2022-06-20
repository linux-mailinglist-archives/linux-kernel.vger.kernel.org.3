Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06808552458
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 21:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245171AbiFTTAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 15:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235833AbiFTTAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 15:00:38 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2ED6BE00
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:00:37 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ej4so12426590edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5v87My5pWd/ScMD1cGRA8968H2kyvPxCNbjzskX56BA=;
        b=bsSaQjdIh//2dMMXYjMtjm7Em1QJ+kgCZW/Z3eAuDVYy1WS8s7vG478NxsiQMdl6F8
         n3KZrzU/zDiavZK1/rJQhswJqCq25mp536TKeiRJU+Raf2sbqUzbOP+t9mj3Sny59UOg
         W3/PXuLq/jVhJuW20AKZtgj0sQjn2zyPpws0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5v87My5pWd/ScMD1cGRA8968H2kyvPxCNbjzskX56BA=;
        b=3jXhbOhC6OWqshXig031pO/R4aFh5vHV3wH6JAZmgaXjPL41a7uAlzhiwfj2cgRZir
         mt17Xk0dHcldB+SZnRz5pBJfrO0r+zSHtj4JrfgyskbLoK6SolPjGHAdH+03c7VllzRZ
         t1bgq4QDWjeaLX1ENUcVvQGAPnxkOzibJ3S5Gy7JD+yd1uaoQLp5Nbi2cXSWZ4b+gz3A
         hxhyVbnYi7kxJtVC7RS1y4kbHGzxr+J1y2lKaG7dQyygLI+vXegl0JE/hYZll20SqIh/
         43pC9NiuCuEQvI0LypTPUPW2pjB3q6iHbNCshRhgkKAUSZYeofQpm9NLPZ2cl+T3HiGs
         k2CQ==
X-Gm-Message-State: AJIora/v2F3R5v7Qf+Fj3tSO3lk0VhcFV11NlprvuJvpJwmlkGl4078o
        Nisd18iaVvVjnqJyrzUrdDFRPxKargCmoXKe
X-Google-Smtp-Source: AGRyM1vQRQsF/vQgFMQeM0PtWZTbXTs6gBYF6EzQxNWufDZe05gWkn1+eDlslHSfoSG5SUBtnMpMcg==
X-Received: by 2002:a05:6402:5002:b0:435:1ff1:99ee with SMTP id p2-20020a056402500200b004351ff199eemr30743897eda.230.1655751636087;
        Mon, 20 Jun 2022 12:00:36 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id w1-20020a170906480100b006fe9f9d0938sm6488770ejq.175.2022.06.20.12.00.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 12:00:35 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id n1so15646398wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 12:00:34 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr25014782wrb.442.1655751634546; Mon, 20
 Jun 2022 12:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220405163931.1108442-1-jannh@google.com> <CAHmME9pW6heXtPrfCP7J6ODgSc8sotsv6E3dnJoVBaPi+Ph=HA@mail.gmail.com>
 <YqywapDM7NPC/X+E@linutronix.de> <Yq0EcG9GsAkoiF3H@zx2c4.com> <YrAlPKeOowD5qv/B@linutronix.de>
In-Reply-To: <YrAlPKeOowD5qv/B@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jun 2022 14:00:18 -0500
X-Gmail-Original-Message-ID: <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
Message-ID: <CAHk-=wg5jqTdjZrwbSsMsd=NUSi_acBHoLQmRDgNArMvXWj8bw@mail.gmail.com>
Subject: Re: [PATCH] random: Fix signal_pending() usage
To:     Sebastian Siewior <bigeasy@linutronix.de>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jann Horn <jannh@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Mon, Jun 20, 2022 at 2:44 AM Sebastian Siewior <bigeasy@linutronix.de> wrote:
>
> Based on that, I don't see a problem dropping that signal check
> especially that requests larger than 4KiB are most likely exotic.

Why would we do that?

Anybody who doesn't handle -EINTR is a clown, not a security issue.

Your "6s isn't that bad" is ridiculous, since

 (a) 6 seconds is forever

 (b) there are issues like "oops, we're out of memory, you got a
signal because root is trying to kill your annoying stupid program
using top"

and the fact is, anybody who asks for more than a few kilo-*bits* from
the kernel is already doing something questionable to begin with, and
there is no reason to bend over backwards and try to make such a crazy
use suddenly act differently from ALL OTHER character devices.

Handling signals is the *default* behavior. It is only regular files
where that doesn't happen. This is not a regular file, and the "it's
about security" is not an argument.

As mentioned, expecting an uninterruptible read is not "security". It's garbage.

              Linus
