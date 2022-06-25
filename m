Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8841D55AD9E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 01:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiFYXtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 19:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbiFYXtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 19:49:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248213E22
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:48:58 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id ej4so8221644edb.7
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hAI6KmvKAAtQ1Qu3VP1eVgrrocL1S7m79Jvw8A7f7Lo=;
        b=PgO7KS6MC+Z+/fQPY5/ekehrEKs2tWTPDiZ6fbahHq2CcFdYYrNb3LmEzaHr2pg6em
         lBfhGotW2sXJeWk58SB8+ipIxNwdNNoYdF67jlzZl69g5yEzEE8HunGgp6GEnEVOwtjD
         fboWRDYvU934IAsFFz3RdWNQWJaGYuQzzWqq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hAI6KmvKAAtQ1Qu3VP1eVgrrocL1S7m79Jvw8A7f7Lo=;
        b=iwIF2te7ZprCOs4g1loTPoXRO5ZDYenIfMaCZy/2XskfQb2F5zs2MoNdwKA5xwwgRB
         eR5XhNGEIi/H2PTOcWFa3x/TzwZ1pMu2pcjWRu5WZznjrg5NBpQjbv9xdhfPr+QojQwh
         0lyUz19zC7NpD2IlHImntt58p50wyCpWLIMhIEzAlOz6xcCDgfoIXUPwA8r3kd6aenmG
         cOBJzwK9fKWgDcNWnVHd2bEXHn6bMbDEJko71ULx05AE+Rpum+pzre8f0/1PUTN5n0Vy
         GfWxOcxSz+8aIIB+jpRMSPipWRtDhUQDKFg/gM1tWJ4LdFzGpZo5v/IjJP+pHisZ3tRK
         fFOg==
X-Gm-Message-State: AJIora/c7iIpd2fvLk36NgpD5aaExYYSX1nMQK9Jr9J0jjAf8wbP9/kn
        b4HpIDGQ58IRmwnRi5sv+W53UYsnvXAplxUk
X-Google-Smtp-Source: AGRyM1vXuN0/Mc35gqXRI+lSwV9Tx48KpGXEaaOMOYJ8HqldAB5Nqf70nhTRn0NBfA9FL0Wca0uJsA==
X-Received: by 2002:a50:fb9a:0:b0:435:6c0e:3342 with SMTP id e26-20020a50fb9a000000b004356c0e3342mr8050796edq.337.1656200936899;
        Sat, 25 Jun 2022 16:48:56 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id w2-20020a170906384200b00722f8d02928sm3168339ejc.174.2022.06.25.16.48.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jun 2022 16:48:55 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id s1so7930259wra.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 16:48:55 -0700 (PDT)
X-Received: by 2002:a05:6000:1148:b0:21b:a4b2:ccd3 with SMTP id
 d8-20020a056000114800b0021ba4b2ccd3mr5648811wrx.193.1656200934779; Sat, 25
 Jun 2022 16:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220622140853.31383-1-pmladek@suse.com> <YraWWl+Go17uPOgR@mtj.duckdns.org>
 <CAHk-=wiC7rj1o7vTnYUPfD7YxAu09MZiZbahHqvLm9+Cgg1dFw@mail.gmail.com>
 <874k0863x8.fsf@email.froward.int.ebiederm.org> <CAHk-=wgTG2K3erROP19320zBN6BHVf0hRfXGdawkGR4gzrJN6w@mail.gmail.com>
 <CAHk-=whLsaRKaFKS0UffeCYYCVyP0bbiB4BTYTaXtScgu6R9yA@mail.gmail.com>
 <87pmiw1fy6.fsf@email.froward.int.ebiederm.org> <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
In-Reply-To: <CAHk-=wiutNT47oNhyk_WvMj2qp4pehYFptXCUzW=u_2STLQiww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 25 Jun 2022 16:48:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
Message-ID: <CAHk-=whX_=BNZ4kVEAu2NV3CMnhwsuYTyE65FQXUMx8VPNOAOA@mail.gmail.com>
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

On Sat, Jun 25, 2022 at 4:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I wonder if we could basically get rid of every use of 'current' in
> kernel/fork.c with just a task pointer that is passed in, and then for
> kernel threads pass in 'init_task'.

That might even help code generation. Instead of doing the 'look up
current' all the time, just having the parent task as an argument
might actually simplify things.

We historically used to do those kinds of things exactly because it
helps generate better code (particularly with inline functions, and
things like 'exit' that calls many different things), but have mostly
avoided it because 'current' may generate some small asm snippet all
the time, but it clarifies the "it can't be a random thread" and
locking issues.

But if it's always 'current or init_task', we don't have many locking issues.

Of course, there might be some reason not to want to use init_task
because it is _so_ special, and so parenting to something silly like
kthreadd ends up being simpler. But..

Anyway, the whole "don't wake up thread until it's all done" is a
separate and independent issue from the "odd use of kthreadd" issue.

          Linus
