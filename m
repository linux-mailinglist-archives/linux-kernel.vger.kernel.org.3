Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7AA589609
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 04:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiHDCST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 22:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239344AbiHDCRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 22:17:55 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712D561108
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 19:16:40 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dc19so11744197ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 19:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=gWfB+VoJpyYH7MVy8NFfYamTDBAr8iMYEneTb6NC9lw=;
        b=AbMyIOhgL2dl1hzzmxIOuXXLlv2CHsUHyc0nBU0b9kYHeBhKNJpvT4yy4gbNcHULNL
         lELD4wT/TU/PA4httB4Gp0LkUc5L81fXdda4je4IfbFClE7yrwfgNhqGJjJ2aClFDO3Z
         vNlGwYP5ZH/Id4nKRTdzm9trYbDJX4uWZXjXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=gWfB+VoJpyYH7MVy8NFfYamTDBAr8iMYEneTb6NC9lw=;
        b=sC00+cyLGsbkJfbMtWR9SSbmiTFarYl7e4CNo8DKa+dnSMpKtd+rfEWwN2x9RTmMeO
         DBkMvRwfclJGrYhz2wLI55eBydeg8Mr5JctAbq0hHa8/sAhT5gTezqknVnO8uz8sa9Lh
         xfLMzIxZHugGmVFqL/XURcn0jslHTr28LG6dyCsZItVb5on6TWNHQxrzpUi7A+eEyOqJ
         yJvEUJyRNWp+DhXjgrz1WJJ7egwlo2Ms6OEpcRaw6NFvo5G56C5GKyoPjKZcW8eUXmVT
         ADiNEdgDuHDH3qbZTVLqDsaYcZ3uA5Hw37t18/FkIWSZFJjekfU3JL6Dpvh94Kz0KlB6
         HdIg==
X-Gm-Message-State: AJIora97teszIcAHvnRxrvrDxBXn1sLVGD/tJLolFUXMONc5fV/iZHdu
        o0bXx7Go14/yFVo0FdcaDVlDnyg6S21IQD/x
X-Google-Smtp-Source: AGRyM1t5Gbx3s1Qwcr2Yl21wMzQO/pxQFzAc9AW50OLkgtV5cTl/0YHpovCrh1HDT9YnzjY8R596mw==
X-Received: by 2002:a17:906:1315:b0:72c:5348:a153 with SMTP id w21-20020a170906131500b0072c5348a153mr22089492ejb.446.1659579390471;
        Wed, 03 Aug 2022 19:16:30 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b006fee98045cdsm99527ejo.10.2022.08.03.19.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 19:16:29 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id i128-20020a1c3b86000000b003a3a22178beso1797757wma.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 19:16:29 -0700 (PDT)
X-Received: by 2002:a05:600c:2d07:b0:3a3:585:5d96 with SMTP id
 x7-20020a05600c2d0700b003a305855d96mr4620406wmf.38.1659579388908; Wed, 03 Aug
 2022 19:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <YurA3aSb4GRr4wlW@ZenIV> <CAHk-=wizUgMbZKnOjvyeZT5E+WZM0sV+zS5Qxt84wp=BsRk3eQ@mail.gmail.com>
 <YuruqoGHJONpdZcK@home.goodmis.org> <CAHk-=whJvgykcTnR+BMJNwd+me5wvg+CxjSBeiPYTR1B2g5NpQ@mail.gmail.com>
 <20220803185936.228dc690@gandalf.local.home> <YusDmF39ykDmfSkF@casper.infradead.org>
 <CAHk-=wh6VSqsnANHkQpw=yD-Hkt90Y1LX=ad9+r+SusfriUOfA@mail.gmail.com>
 <YusV8cr382PeBNLM@casper.infradead.org> <20220803213255.3ab719e3@gandalf.local.home>
In-Reply-To: <20220803213255.3ab719e3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 19:16:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiMFU1+pyG9AgbGSZfxNpoOzOEmjVyy87J6Q8aPKAJ7jQ@mail.gmail.com>
Message-ID: <CAHk-=wiMFU1+pyG9AgbGSZfxNpoOzOEmjVyy87J6Q8aPKAJ7jQ@mail.gmail.com>
Subject: Re: [git pull] vfs.git pile 3 - dcache
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Wed, Aug 3, 2022 at 6:33 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We don't care if the lock is held or not. The point of the matter is that
> spinlocks in RT do not disable preemption. The code that the
> preempt_disable_under_spinlock() is inside, can not be preempted. If it is,
> bad things can happen.

I think you're missing Willy's point - the use would be to verify that
the spinlock really *is* held, because that's what disables preemption
on non-RT.

But no, I don't think it's worth the pain to have to specify which
spinlock is held, because the spinlock might have been taken by the
caller and we don't even have access to it - or care - we just know
somebody did take it.

If we want extra debuggingm it might be something like just verifying
that yes, the preempt count (on a non-RT preemptible kernel) really is
elevated already.

> I wonder if raw_preempt_disable() would be another name to use?

NO!

The point is that normal non-RT code does *not* disable preemption at
all, because it is already disabled thanks to the earlier spinlock.

So we definitely do *not* want to call this "raw_preempt_disable()",
because it's actually not supposed to normally disable anything at
all. Only for RT, where the spinlock code doesn't do it.

             Linus
