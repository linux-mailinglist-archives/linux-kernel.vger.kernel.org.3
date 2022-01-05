Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23BFF485909
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 20:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243448AbiAETS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 14:18:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243434AbiAETSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 14:18:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCEEC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 11:18:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id j6so354153edw.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aSZJ6lOXxe1t+UE4RzgH09dpup0DIvKIanGw3pdRDu0=;
        b=LOQbagsAdCakbS9BqHLeR4QV4V4qMq4xIFEygeAnWmmSU11M1jK8usHrq8Lzs4XUvk
         zUO+dRpDe/bweElJ9jb+PMTqN3LgVkzcNPfGMMrZXmiRYYOK1TQ6tlyGi4Gi9kewBvvW
         SV2Zkd5JvGn5e05wPGXEjDQUbYeVmq5+SQeNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aSZJ6lOXxe1t+UE4RzgH09dpup0DIvKIanGw3pdRDu0=;
        b=ZFKwblbinIp3lBICpfaz9ulc71hwNYPPEkk7rSNoo5CpFtwXcrk3SgTQTSaIzTiLh6
         UeB9aGAIjUFbp/w3k9copw4a+/IAYiyz1TsnnW7UfEm8FY78WU3rKFGDRpdrd8Nskp0Q
         uezb+coNzKL61wb83lMTvJlf6aK45I0UczKlt4cGUkHANdge9lgYN5voaCVhZck7JFFD
         BoUTKev6JjgPrWeZ+K2hBJSRY0cnXuKNOSk/bKuqIaz6u3m9RVADSBKGOtBLOMLmd52v
         rvKEyPP292KQGkjE9G7JeQsJzTQMhCuyuWfc2b+eBsM97uQovuTFbNlFQCyifo4h8kfI
         flqA==
X-Gm-Message-State: AOAM530EZAyonfdTvQlXNAnbovNeNdedthV/I7tzDQcNgwB7xlncW2bl
        0XkefXmttUo5aPhW/VqaWPbm66Puf6Cu7q0+D5o=
X-Google-Smtp-Source: ABdhPJxC/uCoDeop6+BD9EjgoBkItOehkGXJdmdJ6cjfba7CFa3XZM4TyWkD6JpTOJaMvw6wOSFeTQ==
X-Received: by 2002:a17:906:71d9:: with SMTP id i25mr33828082ejk.266.1641410330003;
        Wed, 05 Jan 2022 11:18:50 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id o1sm16162011edv.2.2022.01.05.11.18.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 11:18:49 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so13647wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 11:18:49 -0800 (PST)
X-Received: by 2002:a05:600c:4f13:: with SMTP id l19mr4148156wmq.152.1641410026707;
 Wed, 05 Jan 2022 11:13:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000e8f8f505d0e479a5@google.com> <20211211015620.1793-1-hdanton@sina.com>
 <YbQUSlq76Iv5L4cC@sol.localdomain> <YdW3WfHURBXRmn/6@sol.localdomain>
 <CAHk-=wjqh_R9w4-=wfegut2C0Bg=sJaPrayk39JRCkZc=O+gsw@mail.gmail.com> <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
In-Reply-To: <CAHk-=wjddvNbZBuvh9m_2VYFC1W7HvbP33mAzkPGOCHuVi5fJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Jan 2022 11:13:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
Message-ID: <CAHk-=wjn5xkLWaF2_4pMVEkZrTA=LiOH=_pQK0g-_BMSE-8Jxg@mail.gmail.com>
Subject: Re: psi_trigger_poll() is completely broken
To:     Eric Biggers <ebiggers@kernel.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>
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

On Wed, Jan 5, 2022 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Whoever came up with that stupid "replace existing trigger with a
> write()" model should feel bad. It's garbage, and it's actively buggy
> in multiple ways.

What are the users? Can we make the rule for -EBUSY simply be that you
can _install_ a trigger, but you can't replace an existing one (except
with NULL, when you close it).

That would fix the poll() lifetime issue, and would make the
psi_trigger_replace() races fairly easy to fix - just use

        if (cmpxchg(trigger_ptr, NULL, new) != NULL) {
                ... free 'new', return -EBUSY ..

to install the new one, instead of

        rcu_assign_pointer(*trigger_ptr, new);

or something like that. No locking necessary.

But I assume people actually end up re-writing triggers, because
people are perverse and have taken advantage of this completely broken
API.

               Linus
