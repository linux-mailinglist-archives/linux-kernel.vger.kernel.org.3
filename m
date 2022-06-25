Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A283755AC0A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiFYSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233158AbiFYSnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 14:43:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F44C13D1E
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:43:35 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id sb34so10945508ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CAtiJ7Fqxz7Xp2tdDVs8xqgo4XUvoEIeTTKZQGqRoOI=;
        b=RMJajRl6faKiPc+/QM9xNc370CQrXHO9zwSvmpXbdvg27C8rvZeckmprPppSKvNpza
         Kq4Nl3Oq5pJMPCT08aQR35ZlJNEyTlW9GDTff+kP10TCt5mESs4ThI9g7klJTs9lEWAB
         qMXYzvC1DzivKaAmG33mHO+SaQ8uKeAR+RV7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CAtiJ7Fqxz7Xp2tdDVs8xqgo4XUvoEIeTTKZQGqRoOI=;
        b=ejOILNnHnQGG1bxwzTASBKEXSCTmZOxbTLgHwJ7WiRJvib0clG5JeXumeReFdqqktD
         aDwm8rsjUju5UDbk3ciGEdKHFi5+D5RA6gdG0ytoBByACH6K+Yzz0aK/5obn30mlNDXF
         4iz1K7pfOyUKK8lwFW9fF/mDjdfnRMLi+LJ3c5/ftoDdNfe+jFwyL89XPpEH0Zw2p/IP
         RMSLwGaVL9KUB7pphIVi/1CdDOJHMm3B9gAKIRTBFTGRGfjHAhIyOBsOdkQ35AF5+Cua
         hjY6VZCD/1cnyuYffUA9PSnCTOMho5BK1Vjm06hSR2NzRAIlCDq//SpOPR6pj4K0/LrO
         C9Mg==
X-Gm-Message-State: AJIora/Y2wyyJX5j79fzP3nERJ/C6e5Vs7nTSVRA7coSXcn2zcHFbhj4
        bFStMKtZlxCrR3I4dU1vWRZ1efk5jd+OfP2q
X-Google-Smtp-Source: AGRyM1txWxORk8kKXIK3sMQQBosIzay47qbqESJpXmVA5Ms2uMNTLwzGrAUhXVuujV9+dfeA/NHdMw==
X-Received: by 2002:a17:906:dc8f:b0:725:28d1:422d with SMTP id cs15-20020a170906dc8f00b0072528d1422dmr4915517ejc.131.1656182613970;
        Sat, 25 Jun 2022 11:43:33 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id v10-20020a1709063bca00b00706e8ac43b8sm2888560ejf.199.2022.06.25.11.43.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 11:43:32 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id d17so1771175wrc.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 11:43:32 -0700 (PDT)
X-Received: by 2002:a5d:48c1:0:b0:21a:3574:e70c with SMTP id
 p1-20020a5d48c1000000b0021a3574e70cmr4857133wrs.97.1656182611761; Sat, 25 Jun
 2022 11:43:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
In-Reply-To: <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 11:43:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
Message-ID: <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
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

On Sat, Jun 25, 2022 at 11:25 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And that's not at all what the kthread code wants. It wants to set
> affinity masks, it wants to create a name for the thread, it wants to
> do all those other things.
>
> That code really wants to just do copy_process().

Honestly, I think kernel/kthread.c should be almost rewritten from scratch.

I do not understand why it does all those odd keventd games at all,
and why kthread_create_info exists in the first place.

Why does kthread_create() not just create the thread directly itself,
and instead does that odd queue it onto a work function?

Some of that goes back to before the git history, and very little of
it seems to make any sense. It's as if the code is meant to be able to
run from interrupt context, but that can't be it: it's literally doing
a GFP_KERNEL kmalloc, it's doing spin-locks without irq safety etc.

So why is it calling kthreadd_task() to create the thread? Purely for
some crazy odd "make that the parent" reason?

I dunno.  The code is odd, unexplained, looks buggy, and most fo the
reasons are probably entirely historical.

I'm adding Christian to this thread too, since I get the feeling that
it really should be more tightly integrated with copy_process(), and
that Christian might have comments.

Christian, see some context in the thread here:

  https://lore.kernel.org/all/CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com/

for some of this.

               Linus
