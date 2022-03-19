Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A598F4DE979
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 18:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiCSRRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 13:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbiCSRRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 13:17:39 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F333292D8E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:16:18 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id h7so1180062lfl.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ywV9XezMCx96rb4VrZooCjtIbQpi7/ARRh5JvVZdJYE=;
        b=iKqZ2o7G85SB3bYZDrttGen1nkl6dTn5mjWR9h1otmceslBE1UK0h4hpkSAePhgwAC
         2ZyEy5c49q2rTc/zTUrorAFPhJVKJLxhErUuQs0PuA/zWyhAwY3EIUIpsbKPotmmC/rw
         Hkmw/8Hu76komc+A1QTfhAIXburQEBsFompOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ywV9XezMCx96rb4VrZooCjtIbQpi7/ARRh5JvVZdJYE=;
        b=N3f2HDtZqGvSPexykXXWNISrzMD2eLGBnD3Y1BLqaWH79XVrCoKfxXGi6/C/KBfoqY
         TbpTJG/64siWuQej1cNn/lrphrbYblEQhl9fZAeZgxle0PSQECDVlDlV+35DL7bB2dfR
         vBRXYFmh3q248byOtZa6Ib2eL16OLpzuQtO6ccbCjC2XTC1UsecGuBoiUr7U2xHRMFcE
         Zm1XTTC64xRsx9GQUsFpeickYvwvt3V0AhIa8Pxkw9r6b4/BM4eC/nyFXD15krt7ggd5
         b6Wf7EOkPl0/KBrdVai6PKDIFkX7Fm5BhqDKLB7QEOZpamQzex5ia/M7681r/hhq0hcW
         s+Bg==
X-Gm-Message-State: AOAM5319srt7swhtZn9O2oVG90/R2jcjn+A43/rJQJSoNZcWEYe+MTVg
        HCnX9OcEvtnbI8Xv2HjLUhekGg5KSuZf0t6MUfg=
X-Google-Smtp-Source: ABdhPJyeexHHRNxYFFLNZAg3o4TqZ38QWKXf8nUEQ5fhlXhyeOMgfX6sy5CcyroS6VQLanZrhSxi6g==
X-Received: by 2002:a05:6512:3043:b0:448:4c96:b812 with SMTP id b3-20020a056512304300b004484c96b812mr9322745lfb.275.1647710175972;
        Sat, 19 Mar 2022 10:16:15 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w18-20020ac254b2000000b00448324df809sm1342621lfk.86.2022.03.19.10.16.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 10:16:15 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id s25so14984870lji.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 10:16:14 -0700 (PDT)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr9823629ljc.506.1647710174683; Sat, 19
 Mar 2022 10:16:14 -0700 (PDT)
MIME-Version: 1.0
References: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
In-Reply-To: <2efd5461-fccd-f1d9-7138-0a6767cbf5fe@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Mar 2022 10:15:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
Message-ID: <CAHk-=wgiCVcF4vJCOcg1hDw9PMT6zNSgt-pPuZL8ihWEcVv3eg@mail.gmail.com>
Subject: Re: [PATCH v3 (repost)] workqueue: Warn flushing of kernel-global workqueues
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Fri, Mar 18, 2022 at 9:43 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since flush operation synchronously waits for completion, flushing
> kernel-global WQs (e.g. system_wq) might introduce possibility of deadlock
> due to unexpected locking dependency. Tejun Heo commented that it makes no
> sense at all to call flush_workqueue() on the shared WQs as the caller has
> no idea what it's gonna end up waiting for.

NAK on this patch for a very simple reason:

  static inline void flush_scheduled_work(void)
  {
        flush_workqueue(system_wq);
  }

and now grep for flush_scheduled_work().

The *other* system workqueue flushes may be rare and "that subsystem
should just be converted to do its own workqueue".

But flush_scheduled_work() is literally exported as an explicit and
separate interface,

The fact that the function has a big warning in the comment above it
doesn't change that fact. At the very least, this patch has to be
preceded by a couple of other patches that fix a couple of subsystems
and document "this is what you should do".

Because suddenly saying "hey, we gave you this interface, now we're
warning about it because it's going to go away" without actually
showing how to do it instead is not acceptable.

And honestly, I don't personally see a good conversion. We literally
have all those "schedule_{delayed_}work{_on}()" etc helper functions
that are *designed* to use this system_wq. People *need* the ability
to flush those things, even if it's only for module unload.

So I really think this patch on its own is completely broken. It'd not
pointing to a way forward, it's just saying "don't do this" with no
really acceptable way to not do it.

Removing flush_scheduled_work() needs to be paired with removing the
"schedule_{delayed_}work{_on}()" helpers too.

And I don't see you having a good alternative.

So until that clear way forward exists, NAK.

             Linus
