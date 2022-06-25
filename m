Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D22455AD9C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233570AbiFYXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiFYXn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:43:59 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEB6BE03
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:43:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id u15so11755775ejc.10
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhLEFEWSQRbam1YvxY7yQ4RPKHD6h3bly2df1kg2Kh4=;
        b=bKom/uo/JqKHAxEbU7+RneFpawB7xt8b5cFXzfj/CCY8owEqYeQ/ZQeb4RXfJUag6E
         U0/OdE0J4FVP0q28SNowikYNo4Jp6fSRgWDSO7Q3aww2e2GPvXjks8Zf4mp7z2kOw1pJ
         PqqO2ZJ8PW2qM+Ubf2QCOtsmsVmqDiefwouW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhLEFEWSQRbam1YvxY7yQ4RPKHD6h3bly2df1kg2Kh4=;
        b=pEUFrIY6JGCSiH7eBBI9HsLI24LYAr9RDduTaQD5MI3k7m3J98Xrls0zaPG81O60Bf
         Ur60TWiRxTz9gkzp2GbCeuNo84kQiptvHJyy4Ra7pzDYkaSM6tQ01GOHyQUOz3QX84z7
         fJ13DztXbuCp1tzYQSTjDz23vu65qA2qx3hEv1Bfi3KdDq2FrJM5LmLPIxxS10YPPV2j
         tA1C6DAE7dzn0xu26ZqU4vaC6r+Z5/wz5P5JsMSI6SyVU88cu/ZTzGaM1TubHpM7wLjT
         h1nuBN9jlAp01TieOPKIdJVfm+LZyRf2kDqZXUBqPKTHak7qRd/8/fXFh00zBYeUF9rW
         RpGw==
X-Gm-Message-State: AJIora/rBWWmXXbIbAcZdGNHHSmmsWGKDLTf3JYeDvYT0JvO39tOEWle
        WiSGFzIs+hab2OEnD3bDKGgeFy2VWAaSMAcH
X-Google-Smtp-Source: AGRyM1toGUpz1d8vNo5OtHmghlyqhiCCRh1BNoyNPDEtfQEbRgRb5nIap5+B1f+ZTf2/NDA6iUtcBQ==
X-Received: by 2002:a17:907:6d0a:b0:722:b0b5:be69 with SMTP id sa10-20020a1709076d0a00b00722b0b5be69mr6112303ejc.76.1656200636886;
        Sat, 25 Jun 2022 16:43:56 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id m14-20020a1709061ece00b007121361d54asm3135739ejj.25.2022.06.25.16.43.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 16:43:55 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id w17so7943419wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:43:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr5931643wrb.274.1656200635134; Sat, 25
 Jun 2022 16:43:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com> <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87pmiw1fy6.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 16:43:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
Message-ID: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <brauner@kernel.org>, Tejun Heo <tj@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
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

On Sat, Jun 25, 2022 at 4:28 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> I presume you mean kthreadd games?

Yeah, sorry.

> So with the introduction of kthreadd the kernel threads were moved
> out of the userspace process tree, and userspace stopped being able to
> influence the kernel threads.

Ahh. So essentially it's indeed just basically the parenting issue.

> I want to say that all that is required is that copy_process copies
> from kthreadd.  Unfortunately that means that it needs to be kthreadd
> doing the work, as copy_process does always copies from current.  It
> would take quite a bit of work to untangle that mess.

Hmm. Yeah, it would probably be painful to replace 'current' with
something else, due to locking etc. Using "current" has some
fundamental advantages wrt using another thread pointer that may or
may not be active at the same time.

That said, there *is* another thread that has very similar "we don't
need locking, because it's always around and it doesn't change":
init_task.

I wonder if we could basically get rid of every use of 'current' in
kernel/fork.c with just a task pointer that is passed in, and then for
kernel threads pass in 'init_task'.

I'd hate to duplicate copy_process() entirely, when we probably could
just consider it just a parenting issue, and say that you can have
either 'current' or 'init_task' as the parent. And that 'init_task'
would basically be the 'clean slate for kthreads'.

Christian, comments?

             Linus
