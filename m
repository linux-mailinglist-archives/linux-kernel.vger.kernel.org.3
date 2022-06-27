Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7155D470
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiF0Spb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 14:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236776AbiF0Sp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 14:45:29 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97738CFB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:45:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id fd6so14346992edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fEFrep1j3Uu5nF0cbVefR8+inlpQOoCUDjH9kHDkIPc=;
        b=ZikMXjupiG7Bsmscz0RDOlUHVSF6PLfqJ6Bcji/5l4g8u5nSeOiVY8S0WMpp9R7Zqh
         ZgkgXWUTga3UlSEGWIslHjNJUvALPgYkCdupZmdCAVCHH2Fg7tdyok2RC9xwsteTQnLi
         mzhZ4h6QbZZrIIyhzU+LwwGlaaS0o8v7I5Dsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fEFrep1j3Uu5nF0cbVefR8+inlpQOoCUDjH9kHDkIPc=;
        b=cPxW73N4QEiCJx5FxZKoIiOC1xq91KYxZKzJwPS19uvAfBeZvokVfCqW2R286W8kUw
         rsSJFSMfZAWhAwvmF9Tl3t3OPnHZLmfFtbzB/7+kHJ5yLo6A+rFufZa0r2A/Uy9CQWlV
         CEYCdRBrijqaqS5JsbaAarxZtWaZIFcNu5NbMIeDj9G/+qoHyCyvv+V1UHSSGc3oTgMo
         bLeKUusfqDmrQ0wCl1xdU883nZ1/NNDXYY3aFBTCXqSj9kqhhUqDmDGcQ2Dsr8KXOqjY
         8HRhHBVnU9taWfwEgVfBbwgBD8olFIGE/Nw7XPTbQalP1Q3m+fl7l2d4tS0Nt9QIxI/4
         pNbQ==
X-Gm-Message-State: AJIora8ZEEbM5UjJ6KthaxdLHlFoul064aSfftI2YZYqhVzMh8cxy82W
        t1Io1NG7aXC0F+ObPG2lTmON7lasJdOu5bBE
X-Google-Smtp-Source: AGRyM1si34CnU+kFLWwJ/fyVYvySHGt8qYo8kBYWIvGQnyss34swOUMdgOvz56XxTn7OY/XFM6H32Q==
X-Received: by 2002:aa7:c2cf:0:b0:435:6576:b7c0 with SMTP id m15-20020aa7c2cf000000b004356576b7c0mr18708632edp.18.1656355525893;
        Mon, 27 Jun 2022 11:45:25 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id jw14-20020a170906e94e00b007263481a43fsm5003407ejb.81.2022.06.27.11.45.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 11:45:23 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id i25so8798449wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:45:22 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr14401547wrb.274.1656355521955; Mon, 27
 Jun 2022 11:45:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87y1xkwa28.fsf@email.froward.int.ebiederm.org> <YrjxcR2M6AD6S9dW@google.com>
 <YrlYDppYKw6HRP1j@hirez.programming.kicks-ass.net> <Yrn1nQU3h+vHK1nz@google.com>
In-Reply-To: <Yrn1nQU3h+vHK1nz@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 11:45:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjHto1Uvb7HY7J003-=7BuJ-8AhEuLco30S8tdqLQTDUw@mail.gmail.com>
Message-ID: <CAHk-=wjHto1Uvb7HY7J003-=7BuJ-8AhEuLco30S8tdqLQTDUw@mail.gmail.com>
Subject: Re: re. Spurious wakeup on a newly created kthread
To:     Wedson Almeida Filho <wedsonaf@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Tejun Heo <tj@kernel.org>, Petr Mladek <pmladek@suse.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Mon, Jun 27, 2022 at 11:23 AM Wedson Almeida Filho
<wedsonaf@google.com> wrote:
>
> Yes, I wonder how many more instances of this kind of bug we have
> lurking around given that this one in core kernel code appears to have
> been around for at least 17 years.

The good news is that this "explicit wait loop" pattern is actually
starting to be pretty rare.

New code seldom uses it, because "wait_event()" and friends are just
*so* much easier to use, and will magically expand to that kind of
loop properly.

So the explicit loop with add_wait_queue and friends is very
traditional and our original wait model (well, I think I did have
"sleep_on()" *very* early, but I fixed that broken model quickly since
it fundamentally doesn't work for multiple events), but it's not
actually very common any more.

And the "just call schedule, wait for wakeup" should be very rare
indeed. It has never been a valid pattern, so that kthread code is
just plain strange, and I wouldn't expect to see it commonly
elsewhere. It's simply not how things have ever been supposed to be
done.

               Linus
