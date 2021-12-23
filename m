Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96A4547DD84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 02:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhLWBoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 20:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbhLWBok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 20:44:40 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D9DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:44:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id j6so15221023edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d4E3I94lbLlPXFEv10nZx1gpIaeSB2VvrufzgL5uqNs=;
        b=Rj55DD2ypmp+T2NB14PT9j9kRbSE48Rxug7Q0e06Y1fRs0Cs5VI1KZH9CZHxEdfaB+
         H1g+e03n2c3vUdfdYnyTjEuoykaguQSuIyGs6f7dToD7gb9dgOiNmIrvKYXIyVFNqVH0
         PckY0GGNAZUWB2hNWw9dVwA7P1YiVXlzEC73U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d4E3I94lbLlPXFEv10nZx1gpIaeSB2VvrufzgL5uqNs=;
        b=BInGhM3ix0iaQTLAzc1Y51kCEt9zR+3TC0R7yVJCrYSh9KL982j9ZmSwx473YSU47G
         ozUIvw3MFHIwGvh4GFr3bENOOJUVHgp/KtV8hhsYKelFQBlDX/sJIwgxCUIf4h+6z5t+
         sXP9wBvphB0LY6+0il/7suV24zX3BSup+GZSrRMrX026CxpspxP+I+8vjpo9kM/AHflH
         Rp0zm9XgNhd1JAJnAct3abeY+LK9jkfnQuTQacvywJ9CC4M9heedXWsXVvxPoXHSlXVz
         ntgBR5B+LG815vy7xjVYU/ZlWzs/2vte/xDvETzqTdBZXvBw59jY3Nrc/UZ1VGAAWsmN
         nWlA==
X-Gm-Message-State: AOAM533MZ+ZpO+G3xhlWLfBB2v6K+b1Qdbr51qIhQzEbc0iPEqK40r/e
        p0qrHcMobyUQGZ1vRWy1McirqJwhdutIVw/qyCw=
X-Google-Smtp-Source: ABdhPJz/w5nwmq4NVKQyIAnKluOWxoF4hrics6a2EoBUfH1htKX5FUkJcygr5+kgkeQ9YrP2NlftoQ==
X-Received: by 2002:a05:6402:2706:: with SMTP id y6mr289291edd.29.1640223878061;
        Wed, 22 Dec 2021 17:44:38 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id j5sm1209205ejo.171.2021.12.22.17.44.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Dec 2021 17:44:36 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id g132so2712718wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 17:44:36 -0800 (PST)
X-Received: by 2002:a05:600c:5108:: with SMTP id o8mr95044wms.144.1640223875699;
 Wed, 22 Dec 2021 17:44:35 -0800 (PST)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <20211208202532.16409-9-ebiederm@xmission.com> <YcNsG0Lp94V13whH@archlinux-ax161>
 <87zgoswkym.fsf@email.froward.int.ebiederm.org> <YcNyjxac3wlKPywk@archlinux-ax161>
 <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87pmpow7ga.fsf@email.froward.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Dec 2021 17:44:19 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
Message-ID: <CAHk-=wgtFAA9SbVYg0gR1tqPMC17-NYcs0GQkaYg1bGhh1uJQQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] kthread: Ensure struct kthread is present for all kthreads
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 3:25 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Solve this by skipping the put_user for all kthreads.

Ugh.

While this fixes the problem, could we please just not mis-use that
'set_child_tid' as that kthread pointer any more?

It was always kind of hacky. I think a new pointer with the proper
'struct kthread *' type would be an improvement.

One of the "arguments" in the comment for re-using that set_child_tid
pointer was that 'fork()' used to not wrongly copy it, but your patch
literally now does that "allocate new kthread struct" at fork-time, so
that argument is actually bogus now.

              Linus
