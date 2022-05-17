Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBE52A961
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351521AbiEQRgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351523AbiEQRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:36:01 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF9B6322
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:35:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id p139so12701630ybc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wwzgUHRsCLggIkC5NC+EPo9MpFcIXu4w5MPrf4BKUlQ=;
        b=ZUEK3diX7JRmLbiOD6/vWVJxyxr5ezSp/7armWAMQNq4tDG6T6+z0OwteUIewQjJl4
         R7LU+AyfSoU8ngyTtnE0YIvQCeT5XPZHKNMWbMo4V6nMQ3YK9ydnR44oGrY+TlhWVdUD
         hFwRaPNu8cJGyd0qMMTpFadxmB7wKFx6/6o6LIu3koy7t/g0AVU9rjfWiTweDZpm2PdJ
         OH2ai0gpCod3AdT//km24qJcTkXcjFJdD/PU7Hm2KB4aJ0nlIlH65gkHzLBG/AiwSWBB
         jHnWpjMBc8I8aWJNnDEQyabPvae+kMsZ+fxu+9/MK56LchHkuTejruaBTXjvq7TdQ7zs
         FW8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wwzgUHRsCLggIkC5NC+EPo9MpFcIXu4w5MPrf4BKUlQ=;
        b=dRiF6nqhlrFcktmflN0tda8YuTEFoOuK9TyVY1Q/ZE1Kbo/IL/qztyunWr0hf7zUq0
         vLfL/D3f54yClW0JGdSekttSJpmEeltCi9jtzjlR3mS33tDwHVyWE5yXsxWp72LEVdHM
         TdgctGQw8X7TskBdLetOBsAQUPwXhMfBSwmdACykKWJb2D7Ksb7PnrAyxuqAmPZCsYQ+
         3gpfdOJowx9Xs9ifh0hBECd89LXlYcwA8bI1bK11YzIeL347LlK/VzHl5iEIpaHTbHP+
         skViN0GOsnzkgYidLGrbIq0U2atKXxACQIyCtma7PAU2ao+RmwWR+tKJ0SqQf6e6jheD
         WncQ==
X-Gm-Message-State: AOAM5301ZzCRr/weeisbnY9awKi8oWNo/G1D99B+xdiNExqtDcugzaQl
        cgVTNfBQcC56Kr2sNFRensu+SdY5KeydV0H97pbshTvgtJY=
X-Google-Smtp-Source: ABdhPJxhyiaejWmLfL0jcBQwk14D6Er/zZaFi5HAmRIBCWwGMNufopHvkzlyDGI4jyZWsYY8P7MjE6LUGDo5qD+2Py4=
X-Received: by 2002:a25:1c0b:0:b0:64d:6b11:6a32 with SMTP id
 c11-20020a251c0b000000b0064d6b116a32mr17131995ybc.441.1652808956948; Tue, 17
 May 2022 10:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220516033524.3130816-1-chenwandun@huawei.com>
 <30b37eeb-e77b-882e-fc24-3367321a8ca3@gmail.com> <CAJuCfpE7fBsp8ntYVeLsW7Cd0Z09OmxN75X9Az_Qco0GJrz3Wg@mail.gmail.com>
 <CAJuCfpH-BDqsft1YvGFhkbR60VC0TJgfXKRVN+80e0iqQdhxpA@mail.gmail.com> <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
In-Reply-To: <3a31521f-a68a-b2a9-baae-9a458ee17033@huawei.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 17 May 2022 10:35:46 -0700
Message-ID: <CAJuCfpF4pdREUYvhU6zDB67fjZ2R-wn9XQbA3k7u7_e_jMr7xw@mail.gmail.com>
Subject: Re: [PATCH 1/2] psi: add support for multi level pressure stall trigger
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     Alex Shi <seakeel@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, May 17, 2022 at 5:46 AM Chen Wandun <chenwandun@huawei.com> wrote:
>
>
>
> =E5=9C=A8 2022/5/16 16:43, Suren Baghdasaryan =E5=86=99=E9=81=93:
> > On Mon, May 16, 2022 at 1:21 AM Suren Baghdasaryan <surenb@google.com> =
wrote:
> >> On Sun, May 15, 2022 at 11:20 PM Alex Shi <seakeel@gmail.com> wrote:
> >>>
> >>>
> >>> On 5/16/22 11:35, Chen Wandun wrote:
> >>>> Nowadays, psi events are triggered when stall time exceed
> >>>> stall threshold, but no any different between these events.
> >>>>
> >>>> Actually, events can be divide into multi level, each level
> >>>> represent a different stall pressure, that is help to identify
> >>>> pressure information more accurately.
> >> IIUC by defining min and max, you want the trigger to activate when
> >> the stall is between min and max thresholds. But I don't see why you
> >> would need that. If you want to have several levels, you can create
> >> multiple triggers and monitor them separately. For your example, that
> >> would be:
> >>
> >> echo "some 150000 1000000" > /proc/pressure/memory
> >> echo "some 350000 1000000" > /proc/pressure/memory
> >>
> >> Your first trigger will fire whenever the stall exceeds 150ms within
> >> each 1sec and the second one will trigger when it exceeds 350ms. It is
> >> true that if the stall jumps sharply above 350ms, you would get both
> >> triggers firing. I'm guessing that's why you want this functionality
> >> so that 150ms trigger does not fire when 350ms one is firing but why
> >> is that a problem? Can't userspace pick the highest level one and
> >> ignore all the lower ones when this happens? Or are you addressing
> >> some other requirement?
> >>
> >>>> echo "some 150000 350000 1000000" > /proc/pressure/memory would
> >>> This breaks the old ABI. And why you need this new function?
> >> Both great points.
> > BTW, I think the additional max_threshold parameter could be
> > implemented in a backward compatible way so that the old API is not
> > broken:
> >
> > arg_count =3D sscanf(buf, "some %u %u %u", &min_threshold_us,  &arg2, &=
arg3);
> > if (arg_count < 2) return ERR_PTR(-EINVAL);
> > if (arg_count < 3) {
> >      max_threshold_us =3D INT_MAX;
> >      window_us =3D arg2;
> > } else {
> >      max_threshold_us =3D arg2;
> >      window_us =3D arg3;
> > }
> OK
>
> Thanks.
> > But again, the motivation still needs to be explained.
> we want do different operation for different stall level,
> just as prev email explain, multi trigger is also OK in old
> ways, but it is a litter complex.

Ok, so the issue can be dealt with in the userspace but would make it
simpler if max_threashold is supported by the kernel. I can buy this
argument if the kernel implementation is not complex and max_threshold
is added in a way that does not break current users. I believe both
conditions can be met.

>
> >
> >>> Thanks
> >>>
> >>>> add [150ms, 350ms) threshold for partial memory stall measured
> >>>> within 1sec time window.
> >>>>
> >>>> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> >>>> ---
> >>>>   include/linux/psi_types.h |  3 ++-
> >>>>   kernel/sched/psi.c        | 19 +++++++++++++------
> >>>>   2 files changed, 15 insertions(+), 7 deletions(-)
> >>>>
> >>>> diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
> >>>> index c7fe7c089718..2b1393c8bf90 100644
> >>>> --- a/include/linux/psi_types.h
> >>>> +++ b/include/linux/psi_types.h
> >>>> @@ -119,7 +119,8 @@ struct psi_trigger {
> >>>>        enum psi_states state;
> >>>>
> >>>>        /* User-spacified threshold in ns */
> >>>> -     u64 threshold;
> >>>> +     u64 min_threshold;
> >>>> +     u64 max_threshold;
> >>>>
> >>>>        /* List node inside triggers list */
> >>>>        struct list_head node;
> >>>> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> >>>> index 6f9533c95b0a..17dd233b533a 100644
> >>>> --- a/kernel/sched/psi.c
> >>>> +++ b/kernel/sched/psi.c
> >>>> @@ -541,7 +541,7 @@ static u64 update_triggers(struct psi_group *gro=
up, u64 now)
> >>>>
> >>>>                        /* Calculate growth since last update */
> >>>>                        growth =3D window_update(&t->win, now, total[=
t->state]);
> >>>> -                     if (growth < t->threshold)
> >>>> +                     if (growth < t->min_threshold || growth >=3D t=
->max_threshold)
> >>>>                                continue;
> >>>>
> >>>>                        t->pending_event =3D true;
> >>>> @@ -1087,15 +1087,18 @@ struct psi_trigger *psi_trigger_create(struc=
t psi_group *group,
> >>>>   {
> >>>>        struct psi_trigger *t;
> >>>>        enum psi_states state;
> >>>> -     u32 threshold_us;
> >>>> +     u32 min_threshold_us;
> >>>> +     u32 max_threshold_us;
> >>>>        u32 window_us;
> >>>>
> >>>>        if (static_branch_likely(&psi_disabled))
> >>>>                return ERR_PTR(-EOPNOTSUPP);
> >>>>
> >>>> -     if (sscanf(buf, "some %u %u", &threshold_us, &window_us) =3D=
=3D 2)
> >>>> +     if (sscanf(buf, "some %u %u %u", &min_threshold_us,
> >>>> +                             &max_threshold_us, &window_us) =3D=3D =
3)
> >>>>                state =3D PSI_IO_SOME + res * 2;
> >>>> -     else if (sscanf(buf, "full %u %u", &threshold_us, &window_us) =
=3D=3D 2)
> >>>> +     else if (sscanf(buf, "full %u %u %u", &min_threshold_us,
> >>>> +                             &max_threshold_us, &window_us) =3D=3D =
3)
> >>>>                state =3D PSI_IO_FULL + res * 2;
> >>>>        else
> >>>>                return ERR_PTR(-EINVAL);
> >>>> @@ -1107,8 +1110,11 @@ struct psi_trigger *psi_trigger_create(struct=
 psi_group *group,
> >>>>                window_us > WINDOW_MAX_US)
> >>>>                return ERR_PTR(-EINVAL);
> >>>>
> >>>> +     if (min_threshold_us >=3D max_threshold_us)
> >>>> +             return ERR_PTR(-EINVAL);
> >>>> +
> >>>>        /* Check threshold */
> >>>> -     if (threshold_us =3D=3D 0 || threshold_us > window_us)
> >>>> +     if (max_threshold_us > window_us)
> >>>>                return ERR_PTR(-EINVAL);
> >>>>
> >>>>        t =3D kmalloc(sizeof(*t), GFP_KERNEL);
> >>>> @@ -1117,7 +1123,8 @@ struct psi_trigger *psi_trigger_create(struct =
psi_group *group,
> >>>>
> >>>>        t->group =3D group;
> >>>>        t->state =3D state;
> >>>> -     t->threshold =3D threshold_us * NSEC_PER_USEC;
> >>>> +     t->min_threshold =3D min_threshold_us * NSEC_PER_USEC;
> >>>> +     t->max_threshold =3D max_threshold_us * NSEC_PER_USEC;
> >>>>        t->win.size =3D window_us * NSEC_PER_USEC;
> >>>>        window_reset(&t->win, 0, 0, 0);
> >>>>
> > .
>
