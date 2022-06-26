Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F6E55B3F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 22:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiFZT7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 15:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbiFZT7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 15:59:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D9FF67
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:59:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ay16so14961956ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5UWv11VNJ/YPSJfroU2OJEJHY0p68aKQdefLMtRTM+s=;
        b=WcVCBYqELLfShlSDUapvAXjyqQDHiiXW1so9DXggwd7mpoEXwut+oVplzuFyFGbk9H
         3zs37YmB1V+vvH2ipbVvs3rajq0UMirKiw4AU2RC/3paB8v23eCncIBWo0qmqXCzEalv
         vhQM1RyZRvYTtCaapDtLLBWvaObrSJIWXGyDM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5UWv11VNJ/YPSJfroU2OJEJHY0p68aKQdefLMtRTM+s=;
        b=ocbYz5MqIAQeEmDWr53wAVaJk2q1QrRnx0Oka9b4BcUddOCa3s5N/29xb04AhM7W9Y
         ixxKsAXlRK43aqikbSCX9piewbf4CxfT3Rfs3juuXkySxtTm2+IOUbuyfJHPhgtRVMl7
         CsYHgxdEiHJ6XKukor1skCmM9sAF8bvfLk+6NGbXNVmPCXIbnoCfvsetU9HHXOaa6T4N
         pzwAQStraKQpIcIFHnYMz7dUbFy/Epf5B3L6k0S/azlkcqYgid20bpGgy22GORc+FM3O
         wDSPDeGcq0v9MTuC+eh2+bHD9TZeixQ0JmBwJsK4QSTdUGHt0ILsz4jw6xEh+d6ZzddD
         Rm+w==
X-Gm-Message-State: AJIora9JCkHPzrr+rejXG4fuL7Yl6TtnJIJn7whAoi1EPRg3QHygBjAt
        HW5ajrGkTMuaeTPRrOfxWmtYG6ILhN2TT10S
X-Google-Smtp-Source: AGRyM1uTsFnW5isW+XcSsNaC1h9QIkDEcp8ziRO5UaBdK0bvNv7qba0IhKFrozndv5am87L0fuOVyw==
X-Received: by 2002:a17:906:380a:b0:722:fbf8:29a4 with SMTP id v10-20020a170906380a00b00722fbf829a4mr9072341ejc.139.1656273567620;
        Sun, 26 Jun 2022 12:59:27 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0042a2d9af0f8sm6262276edc.79.2022.06.26.12.59.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jun 2022 12:59:26 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id k22so10249822wrd.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 12:59:25 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8d:b0:21b:aaec:ebae with SMTP id
 bw13-20020a0560001f8d00b0021baaecebaemr9527634wrb.274.1656273565426; Sun, 26
 Jun 2022 12:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
 <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
 <87ilonuti2.fsf_-_@email.froward.int.ebiederm.org> <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
In-Reply-To: <871qvbutex.fsf_-_@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Jun 2022 12:59:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
Message-ID: <CAHk-=wg9eqtrpYrjJ=yobkwkTimWFtiDd_JOfADttG0fyAJrqg@mail.gmail.com>
Subject: Re: [PATCH 3/3] kthread: Stop abusing TASK_UNINTERRUPTIBLE (INCOMPLETE)
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

On Sun, Jun 26, 2022 at 12:16 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> Instead leave the task as a new unscheduled task and require the
> caller to call wake_up_new_task.

So I think this is somewhat error-prone, and we should probably
abstract things out a bit more.

Almost every single case that does this does this for one single
reason: it wants to run setup code before the new kthread is actually
activated.

And I think *that* should be the change - add a "setup()" function
pointer to the whole kthread infrastructure. Allow it to return an
error, which will then just kill the new thread again without ever
even starting it up.

I'd really prefer to avoid having random drivers and subsystems know
about the *very* magical "wake_up_new_task()" thing.  Yes, it's a real
thing, but it's a thing that normal code should not ever use.

The whole "wake_up_process()" model for kthread creation was wrong.
But moving existing users of a bad interface to using the even more
special "wake_up_new_task()" thing is not the solution, I feel.

Also, since you're very much in this area - you also please look into
getting rid of that horrible 'done' completion pointer entirely? The
xchg games on that thing are horrendous and very non-intuitive.

              Linus
