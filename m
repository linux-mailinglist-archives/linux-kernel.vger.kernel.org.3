Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D304FA0E1
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 03:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbiDIBDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 21:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbiDIBDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 21:03:15 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0C523FF3D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 18:01:06 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so13459333ljr.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wdHWP0t2I4gTt2PnJNuvhJwBXPRJYjBIPAiVJ3HB0e0=;
        b=QtAta4NfzmiaG3n/anjUkJNn/RBokeZn0QIZMmuCVSGsHCTZUWaxqGlO1P8T9+WL0k
         zTWPE9DViaYKncd3qngYwMM3R+8/o0SagjzQJ385e/ugtsauPumK4FH43ZUlpCAInf/4
         n217oxniv5EAtBR7ErJqbWZE+J3gTSLW/PBa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdHWP0t2I4gTt2PnJNuvhJwBXPRJYjBIPAiVJ3HB0e0=;
        b=koBCM/svEzsI7hg57xjQjjmfNlWIr2kudrlFr9ZWf+7n2xrq2qvQ+Hf95WnEiolHgR
         eg35TtAyqmEdby1vilOObZ9MaWle+RQ0xrQktiMDrDwyPNUTQt5MZUsf3TxoLd+V62WV
         KKhHUVTiFKBXx/n0bEewqShWQoIqab83y7Q6bNTUrlBINbNCWN7QG6mreM4389BqOiV9
         lt/4Kp+9t1aTFmeSlZ4duVfdM3aa+Iu7nCf+sOHmIuJckvnJgDd95RmUt5t4oHkqQkwM
         CqJNCp6dRjMrQXCsGbMHqHmNx8RTf94vlo0ZLtXwrvKnrwdZho+5lIRrS8rwRJBXYHI8
         mvBA==
X-Gm-Message-State: AOAM5330pRdf2FhHxlaDO3ZPn1ASY5YH2+/RAUWLXQw9QKlAyiT4gbmJ
        eDyumhlMv/oH1nOjKUtx5xg/lA7bKS+7EcWt
X-Google-Smtp-Source: ABdhPJxds7tylQVSiuLVc5BoUUrCjhj4IbJ1M6jhCp0JIcLHOw5rc5btasWhoE0rK3QGDYDIepUbew==
X-Received: by 2002:a2e:b8c9:0:b0:249:90fc:71ba with SMTP id s9-20020a2eb8c9000000b0024990fc71bamr13267337ljp.466.1649466063892;
        Fri, 08 Apr 2022 18:01:03 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id e16-20020a196910000000b0044a13085dd5sm2596818lfc.270.2022.04.08.18.01.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 18:01:00 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s17so5519638ljp.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 18:01:00 -0700 (PDT)
X-Received: by 2002:a05:651c:b07:b0:24b:4af9:828 with SMTP id
 b7-20020a05651c0b0700b0024b4af90828mr4951637ljr.506.1649466060069; Fri, 08
 Apr 2022 18:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220407161745.7d6754b3@gandalf.local.home> <87pmlrkgi3.ffs@tglx>
 <CAHk-=whbsLXy85XpKRQmBXr=GqWbMoi+wVjFY_V22=BOE=dHog@mail.gmail.com>
 <87v8vjiaih.ffs@tglx> <20220408202230.0ea5388f@rorschach.local.home>
 <CAHk-=wg3icnjr+6aU-Wyw+kBoSRBM28P4o4iTgimOWDuuUiStQ@mail.gmail.com> <20220408204925.16361b44@rorschach.local.home>
In-Reply-To: <20220408204925.16361b44@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Apr 2022 15:00:43 -1000
X-Gmail-Original-Message-ID: <CAHk-=wg6ZTjCoWev039ijHkzJGOE8v1Psc=yDANkt5r3GBxc0w@mail.gmail.com>
Message-ID: <CAHk-=wg6ZTjCoWev039ijHkzJGOE8v1Psc=yDANkt5r3GBxc0w@mail.gmail.com>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
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

On Fri, Apr 8, 2022 at 2:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hmm, well, I'm not sure it would work for all architectures, but what
> about the MSB?  Setting it to zero on "shutdown"?

Let's just clear the whole thing for now. We don't actually _have_ any
timer_restart() cases yet.

I was more thinking that we might have situations where "I don't want
to race with timers, but I also don't want to take an interrupt-safe
lock" makes a lot of sense.

Most people most definitely are just about "module unload" and similar
issues, where it goes along with doing "task_work_cancel()" and
friends.

I do wonder if we want some way to shut down new timers that doesn't
actually wait for old ones to finish.

We've had issues with some code not being able to use del_timer_sync()
simply because they hold locks that could deadlock with any "wait for
running timer" situation.

Those places couldn't use a synchronous cancel operation either, for
the same reason.

I'm not sure a "make sure no future timers can start" operation is
sensible on its own, though. I can't think of a situation where that
wouldn't also need that "wait for existing ones to finish".

                       Linus
