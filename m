Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97144858AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243191AbiAESu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243180AbiAESu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:50:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92838C061201
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:50:53 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id b13so141306edd.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfHNQGe03MWFiDjULzVbgtf6gbGg6JH50kN5fzPFHfA=;
        b=ewSSp59OgURps0hS/LbW55Aq+2LDBhNRyITlsFPwMv1qN0xdjkSe8cJKmF/NCk/WBt
         R58wzWpaldO8LqJhB/qpMqjiN9D3/kGtQKNirCRALgXZp5BNYKxw1hgUKICOPRv6gKDu
         Ljv/jlukGMuGKpoZcZe1iXxy98uqcnQ97Dx4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfHNQGe03MWFiDjULzVbgtf6gbGg6JH50kN5fzPFHfA=;
        b=TMsnW3kbZCkKytMrcryP4mXvvDPKGOai6Fyi0BapFDiIsv2xuDK2kXEbdOAafpWU9m
         6EI1xdfbOMojACDiEO5QRckqsLacIU+Hiu6cWOcChpSH/kxMLp+Pnyuvk4g7kL99iZhh
         H4iv+QBE+eoB0du0+7yd6CgucVFS7OtlojZVGGVRMqUdBvn7mici/ijjrYQXyCP9drW9
         lLehxrMd+p8dfCwf2Qkal4zT70V0iINMfrOelqsoz2dKD9Pb+TXtowSCsaDdVo7BRL7b
         +mdGdAnvyJq7jJ3lig0wn2UcYUQvkEI49VCdLKtaSB68D1t8OO7fd7ngrHpT/nWC+YkN
         p07g==
X-Gm-Message-State: AOAM532u3zlYzai6+9/qZXHhFhxSnTgh1p3bZDikiKdcMco3VfAb5RpK
        Cipn4cECehgrnCgNsDtwTccldl94kT9LKI36+P0=
X-Google-Smtp-Source: ABdhPJznsZrgDSId6JVGFzXpY8NIc9R3Tnc4pe2X6IOh/n5hthWK7mTwx3ZvuIncX8rbIFWwI+8mRg==
X-Received: by 2002:a05:6402:3514:: with SMTP id b20mr56004757edd.178.1641408652056;
        Wed, 05 Jan 2022 10:50:52 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id k12sm4385723ejk.188.2022.01.05.10.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 10:50:50 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so3815604wmd.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 10:50:49 -0800 (PST)
X-Received: by 2002:a7b:c305:: with SMTP id k5mr4008893wmj.144.1641408649511;
 Wed, 05 Jan 2022 10:50:49 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
In-Reply-To: <YdW3WfHURBXRmn/6@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 10:50:33 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
Message-ID: <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+cdb5dd11c97cc532efad@syzkaller.appspotmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 5, 2022 at 7:21 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> [changed subject line to hopefully get people to stop ignoring this]
>
> Please see my message below where I explained the problem in detail.  Any
> response from the maintainers of kernel/sched/psi.c?  There are a lot of you:

Ok, this one is clearly a kernel/sched/psi.c bug, since the lifetime
isn't even maintained by the fiel reference.

I think the proper thing to do is to move the whole "get kref to
trigger pointer" in the open/close code, and keep the ref around that
way.

The natural thing to do would be to look up the trigger at open time,
save the pointer in seq->private, and release it at close time.

Sadly, right now the code actually uses that 'seq->private' as an
indirect rcu-pointer to the trigger data, instead of as the trigger
data itself. And that seems very much on purpose and inherent to that
'psi_write()' model, where it changes the trigger pointer very much on
purpose.

So I agree 100% - the PSI code is fundamentally broken. psi_write()
seems to be literally _designed_ to do the wrong thing.

I don't know who - if anybody - uses this. My preference would be to
just disable the completely broken poll support.

Another alternative is to just make 'psi_write()' return -EBUSY if
there are existing poll waiters (ie t->event_wait not being empty.  At
least then the open file would keep the kref to the trigger.

That would require that 'psi_trigger_replace()' serialize with the
waitqueue lock (easy), but all callers would also have to check the
return value of it

The cgroup code does

        psi_trigger_replace(&of->priv, NULL);

in the release function, but I guess that might work since at release
time there shouldn't be any pending polls anyway.

But it would also mean that anybody who can open the file for reading
(so that they can poll it) would be able to keep people from changing
it.

But yes, I think that unless we get some reply from the PSI
maintainers, we will have to just disable polling entirely.

I hope there are no users that would break, but considering that the
current code is clearly too broken to live, this may be one of those
"we have no choice" cases.

                         Linus
