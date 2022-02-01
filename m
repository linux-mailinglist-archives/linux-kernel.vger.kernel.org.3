Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0563D4A63D3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbiBASa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiBASaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:30:23 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000A4C061714;
        Tue,  1 Feb 2022 10:30:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l13so7404717plg.9;
        Tue, 01 Feb 2022 10:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxjgGOUhkR1dbEpwd0qsIng+RbhHC9RNemQtqTU19N8=;
        b=pg5Tb+20bkyKjmC+o21iLE5v9XZRrW8/cB6DArErSAu9C6iVQ4nD62RNucCbaMLRYg
         QFs8YC/MApzO/EI6/eJqsRbwfxoHu8xhaa/4rYQwzhUsUnfWPkp0wxucMQOqzVYpahVx
         z/vPksF3sLgDXsEkK/zAb0Svm/dr7KnIdKrLXgPhV/I6yoFR2PeldRpZHZ9EyVVDujEm
         lyN6iX/c4xax37yQY+LiMD7FARApqEzhlk8fEz0vRhT5ytcXkuKVujdWIs3p5PFJS59f
         8AFIKenty/jMu94FMKJXqjgydLGwHKy5jNFYfxz7VnTgQ3qw2MigEstL+17aRe1lZFfU
         S/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxjgGOUhkR1dbEpwd0qsIng+RbhHC9RNemQtqTU19N8=;
        b=SiDAS6OWm5YPWwqA768/qFUtcj0bUMacQss0Hwlk2aTBqO59hoiS6s2zlBaZkDalg2
         RLdMAm2Dt+Fsw55RhmNKsxeqpw3AWP+XqKj2FIEWcucfDm+YtF6ajsA6VBiAhmgNQK0u
         +XcfxaOQddy+ct8oBP5Q0BUA7g+c9Biq15R/3lqPjaP+Z0uGmuDvnQpREKzCROOfvC1T
         dqhOggvQlOv2KDsGu/4JVbPNbZDszUnjuUsoDHyG39LYA7x0/XnHpbj0IGdPXi710c94
         TP7KfwemZaIQtQe2Hse4Mq498pGvVt+f/RD9XiqqieAzvDrcGkkSoh8VDGg6OQz1R+N0
         DwQg==
X-Gm-Message-State: AOAM5328kNUmjONpo4YsLJBH9Ej1kc0IANH8Cw0f2V4jPWzZZDJ+K/rx
        Jek2Ooddk3H5cZdWrcLPzJLDvzkXQigdtquIIAU=
X-Google-Smtp-Source: ABdhPJwQVsTtMhWmzsDmYJZ7J4Q5haZNJf+WRuiv/JpU+o6VSACuvm7GT+W7nxgCGpA0Dni/1nf0Wld441wZfyyOHV8=
X-Received: by 2002:a17:90a:141:: with SMTP id z1mr3775429pje.87.1643740222430;
 Tue, 01 Feb 2022 10:30:22 -0800 (PST)
MIME-Version: 1.0
References: <20220131014648.941629-1-yury.norov@gmail.com> <YffF3e+uUIDVO7hm@FVFF7649Q05P>
In-Reply-To: <YffF3e+uUIDVO7hm@FVFF7649Q05P>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Tue, 1 Feb 2022 10:30:22 -0800
Message-ID: <CAAH8bW_y4+edCY9viJayfmfvAFuJ1A7jqwDQCL++_Qv2Bo5Kew@mail.gmail.com>
Subject: Re: [PATCH] kernel/cpu.c: fix init_cpu_online
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 3:20 AM Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> Hi Yury,
>
> On Sun, Jan 30, 2022 at 05:46:48PM -0800, Yury Norov wrote:
> > cpu_online_mask has an associate counter of online cpus, which must be
> > initialized in init_cpu_online().
> >
> > Fixes: 0c09ab96fc82010 (cpu/hotplug: Cache number of online CPUs)
>
> Aren't the increments/decrements from set_cpu_online() enough?

It will only count cpus onlined by this function . Those onlined before will
never be counted.

> I guess we could argue that this isn't a private function and the
> num_online_cpus should be updated here. But unless I missed something,
> init_cpu_online() is only called in ia64 arch, in the !SMP case.

Yes, this looks weird. In !SMP case this counter and function are not needed
at all, and this is  the only case when the function is used.

In SMP case, things work just because the cpu_online_mask and
num_online_cpus are both initialized to 0. If this is the intentional behavior,
and it would be like this forever, then the init_cpu_online() must be dropped,
otherwise it needs to be fixed. Isn't?

> Is this the problem you're trying to tackle?

It was initially a part of a bigger series that added 3 more counters like this:

https://lkml.org/lkml/2021/12/18/253

But now it's postponed.

> If not, I'm not sure that warrants a "Fixes:" tag

The patch 0c09ab96fc82010 adds the counter but does not initialize it properly.
For me it sounds like a fix.

> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > ---
> >  kernel/cpu.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/cpu.c b/kernel/cpu.c
> > index 407a2568f35e..cd7605204d4d 100644
> > --- a/kernel/cpu.c
> > +++ b/kernel/cpu.c
> > @@ -2616,6 +2616,7 @@ void init_cpu_possible(const struct cpumask *src)
> >  void init_cpu_online(const struct cpumask *src)
> >  {
> >       cpumask_copy(&__cpu_online_mask, src);
> > +     atomic_set(&__num_online_cpus, cpumask_weight(cpu_online_mask));
> >  }
> >
> >  void set_cpu_online(unsigned int cpu, bool online)
> > --
> > 2.30.2
> >
