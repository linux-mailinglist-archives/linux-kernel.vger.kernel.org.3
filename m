Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC7527FF8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236210AbiEPIo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbiEPIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:44:13 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F34B1DD
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:44:06 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2fb965b34easo144891427b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WrH/uCV11zaK3gi4NBtuoC2ssefODQWs7qWIOkYeDX0=;
        b=JSSRWSLDRoqueiwjRYgAua4DvEmAULj2xxKZXkR0YbpFhO8CZv72sRhPAgSbqYd3Gt
         2eMiPFDAmuCtgnrpCCEqmrAgBhVcMP3H3cwTni/LdQfRiXDSKWjwjoUbohpSwPUM7lXh
         S4SgbxZ45YqRkx6DRSVZ9V4KhvTduOgk9YCdSM9izIDvHCUFsTjP0IKbOC2+KKVmcidD
         kP4+wfkYoDq/9TRbWjJF/DVv68KnWAWrVUgx6sJa38STxe/pE4JYgLmzRoY3qJ24vKj0
         nWdSUnUVklVL6EDdL4rI/XJT1l2GVeQPBlbzXSgWosY1sPRtg7/0/ljBY/9SZGt7LZ9j
         Zj9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WrH/uCV11zaK3gi4NBtuoC2ssefODQWs7qWIOkYeDX0=;
        b=hkQBKLp8nKN9OFSt2e1irDAs4qoiMC6CjJsGUzPBHselULM3bC5QSU3XsbmwydDcUH
         ZduXpk7+dh6ScE3XrAn4iWb6y4fXBcUjwMA4MXHCXlCxkXoaPS3H3ScvbXLyvSVRlbA6
         9pdJxHbSyWT8JgJsnK9kjYqgQQihx3P+v7DuTrigsrMHdeuGNT95fyJyKuB9h2Z69hH5
         o3TJZ5oGH1QKbzar7DeEL90f/L12aAbBqbdLa7eOsxowb2D1L6tqARFsB58g/7i9QUdB
         e0X4V5XVyZAX9lwJNQtSdX7jbahp7RYQDKWIS42GfQ2aOSftngY8ebtMwpODwt92FVAm
         k88g==
X-Gm-Message-State: AOAM530UE3xfEfTkwWm6lWaHoAZKhWEjKiO83yMgrObm93kX/EcXJMjM
        NZiNaKYiwIRjtajV1eQit8K85b94OI8gdytS0ucWXg==
X-Google-Smtp-Source: ABdhPJyCWaN3bQEreJQ0p+Ot1/7Q84mfkhD572qyNChjOJQjjw/1V6Q6NnNjGhqeBXnNyo+ph18vOM/mnLuOOjFuHlY=
X-Received: by 2002:a0d:d4d0:0:b0:2fe:b86b:472d with SMTP id
 w199-20020a0dd4d0000000b002feb86b472dmr15902880ywd.469.1652690645161; Mon, 16
 May 2022 01:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com> <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
In-Reply-To: <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 16 May 2022 01:43:54 -0700
Message-ID: <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com>
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall trigger
To:     Alex Shi <seakeel@gmail.com>
Cc:     Chen Wandun <chenwandun@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 1:21 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Sun, May 15, 2022 at 11:20 PM Alex Shi <seakeel@gmail.com> wrote:
> >
> >
> >
> > On 5/16/22 11:35, Chen Wandun wrote:
> > > Nowadays, psi events are triggered when stall time exceed
> > > stall threshold, but no any different between these events.
> > >
> > > Actually, events can be divide into multi level, each level
> > > represent a different stall pressure, that is help to identify
> > > pressure information more accurately.
>
> IIUC by defining min and max, you want the trigger to activate when
> the stall is between min and max thresholds. But I don't see why you
> would need that. If you want to have several levels, you can create
> multiple triggers and monitor them separately. For your example, that
> would be:
>
> echo "some 150000 1000000" > /proc/pressure/memory
> echo "some 350000 1000000" > /proc/pressure/memory
>
> Your first trigger will fire whenever the stall exceeds 150ms within
> each 1sec and the second one will trigger when it exceeds 350ms. It is
> true that if the stall jumps sharply above 350ms, you would get both
> triggers firing. I'm guessing that's why you want this functionality
> so that 150ms trigger does not fire when 350ms one is firing but why
> is that a problem? Can't userspace pick the highest level one and
> ignore all the lower ones when this happens? Or are you addressing
> some other requirement?
>
> > >
> > > echo "some 150000 350000 1000000" > /proc/pressure/memory would
> >
> > This breaks the old ABI. And why you need this new function?
>
> Both great points.

BTW, I think the additional max_threshold parameter could be
implemented in a backward compatible way so that the old API is not
broken:

arg_count = sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &arg3);
if (arg_count < 2) return ERR_PTR(-EINVAL);
if (arg_count < 3) {
    max_threshold_us = INT_MAX;
    window_us = arg2;
} else {
    max_threshold_us = arg2;
    window_us = arg3;
}

But again, the motivation still needs to be explained.

>
> >
> > Thanks
> >
> > > add [150ms, 350ms) threshold for partial memory stall measured
> > > within 1sec time window.
> > >
> > > Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> > > ---
> > >  include/linux/psi_types.h |  3 ++-
> > >  kernel/sched/psi.c        | 19 +++++++++++++------
> > >  2 files changed, 15 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> > > index c7fe7c089718..2b1393c8bf90 100644
> > > --- a/include/linux/psi_types.h
> > > +++ b/include/linux/psi_types.h
> > > @@ -119,7 +119,8 @@ struct psi_trigger {
> > >       enum psi_states state;
> > >
> > >       /* User-spacified threshold in ns */
> > > -     u64 threshold;
> > > +     u64 min_threshold;
> > > +     u64 max_threshold;
> > >
> > >       /* List node inside triggers list */
> > >       struct list_head node;
> > > diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> > > index 6f9533c95b0a..17dd233b533a 100644
> > > --- a/kernel/sched/psi.c
> > > +++ b/kernel/sched/psi.c
> > > @@ -541,7 +541,7 @@ static u64 update_triggers(struct psi_group *group, u64 now)
> > >
> > >                       /* Calculate growth since last update */
> > >                       growth = window_update(&t->win, now, total[t->state]);
> > > -                     if (growth < t->threshold)
> > > +                     if (growth < t->min_threshold || growth >= t->max_threshold)
> > >                               continue;
> > >
> > >                       t->pending_event = true;
> > > @@ -1087,15 +1087,18 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >  {
> > >       struct psi_trigger *t;
> > >       enum psi_states state;
> > > -     u32 threshold_us;
> > > +     u32 min_threshold_us;
> > > +     u32 max_threshold_us;
> > >       u32 window_us;
> > >
> > >       if (static_branch_likely(&psi_disabled))
> > >               return ERR_PTR(-EOPNOTSUPP);
> > >
> > > -     if (sscanf(buf, "some %u %u", &threshold_us, &window_us) == 2)
> > > +     if (sscanf(buf, "some %u %u %u", &min_threshold_us,
> > > +                             &max_threshold_us, &window_us) == 3)
> > >               state = PSI_IO_SOME + res * 2;
> > > -     else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) == 2)
> > > +     else if (sscanf(buf, "full %u %u %u", &min_threshold_us,
> > > +                             &max_threshold_us, &window_us) == 3)
> > >               state = PSI_IO_FULL + res * 2;
> > >       else
> > >               return ERR_PTR(-EINVAL);
> > > @@ -1107,8 +1110,11 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >               window_us > WINDOW_MAX_US)
> > >               return ERR_PTR(-EINVAL);
> > >
> > > +     if (min_threshold_us >= max_threshold_us)
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > >       /* Check threshold */
> > > -     if (threshold_us == 0 || threshold_us > window_us)
> > > +     if (max_threshold_us > window_us)
> > >               return ERR_PTR(-EINVAL);
> > >
> > >       t = kmalloc(sizeof(*t), GFP_KERNEL);
> > > @@ -1117,7 +1123,8 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
> > >
> > >       t->group = group;
> > >       t->state = state;
> > > -     t->threshold = threshold_us * NSEC_PER_USEC;
> > > +     t->min_threshold = min_threshold_us * NSEC_PER_USEC;
> > > +     t->max_threshold = max_threshold_us * NSEC_PER_USEC;
> > >       t->win.size = window_us * NSEC_PER_USEC;
> > >       window_reset(&t->win, 0, 0, 0);
> > >
