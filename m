Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220451CD02
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 01:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347153AbiEEX6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238237AbiEEX6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:58:20 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5862F60AA5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 16:54:39 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id u205so5705213vsu.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 16:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDDyzRVab5pN0l0Oc9TAGru6/qJIRko7NAIbkOiJF8A=;
        b=r1hLylWIOOOhaGFz+p6F3AydVEizM2PBMopIl7xCwgCpXpdj2SokxxV2SHoaI7PsS5
         O5XPHbELH3T7ucpExD9G9kVlFRitPY7R7wqnjKFPFLIxiMf35ksgPBUGvOAa8J2qSLnA
         QyTdGasRks2Hu/SE+misUqRIisf3JSGLfx/+ngOcXh4xDTDaEcERE/5fhgMDAaNmg9eE
         XxGq2KReyZ+PuXCPEUzSvCQVdKgX+qxpRhgSMBPttinWyGCEIuhX/kpStjsbylnebD2X
         vAkIk10ud0IVJn1anD+35kseqge1JuMc50aIHwAcrX8491ZfphZk/mlv0nA3ZBCz5Afe
         GC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDDyzRVab5pN0l0Oc9TAGru6/qJIRko7NAIbkOiJF8A=;
        b=KxCzbV0KkL6jvq7zK1XUSy8Ja2CwB8/xjPrT4vGOosHG6wYSNeWzScNaW+rchHfB1V
         s9YsoMUrfv9wY5YkCxPjssj2W/Iqf0zOt9iA2oYASs8soqLoGf/cVMvcaen3v2FyPt7z
         N1W+zvxZw0M9qsbCpkSK/TTgTKLdDwmcbwvie5kfGINeiCkYqK+/iqVPjMSSH0nf6/XR
         dzBj5rBNepNOK6xpC+MzH3b8XBV8Fs7MetCs7U4uYfAKQH6WmXbbjMRuMSwpRwx4JdO4
         GyuECbOxUeaFD2XCSo5GvyUudBvZ8zEhTUPqZJ1qYVvH4xe5inl23O+x+giDFr5SO0LA
         Dn3A==
X-Gm-Message-State: AOAM531wjlzD/kRNeytDPzSO+jrGDjmLAkLH+WC4gb2aX+0xOdnDe1E7
        w/UolI0IXQK3HroqONCa3CFwxc5wsbCcmu7Y5kxK6A==
X-Google-Smtp-Source: ABdhPJxopamlFqZOgSKVhG7nIetrG2PG7cgpRoI22LRBUGNQCpa8b8bZVtse6QuNZy6mGp6tZHSNhz6wiA/JWjuxyp0=
X-Received: by 2002:a05:6102:c13:b0:32d:518f:feaf with SMTP id
 x19-20020a0561020c1300b0032d518ffeafmr174918vss.84.1651794878401; Thu, 05 May
 2022 16:54:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
 <CAHbLzkqOUkaud4hQZeAbnO3T6VJpku4aKn1EYv9RunB+Kmu9Sg@mail.gmail.com>
 <CALvZod5CReJZeGxkX9i6k7+R+3kF5dikXx9akbiP_L0j4Qu=6A@mail.gmail.com> <CABCjUKAoTmqvyBbFH7A188s8Hwi1XbLgfb6znzgFOuRWBMBxig@mail.gmail.com>
In-Reply-To: <CABCjUKAoTmqvyBbFH7A188s8Hwi1XbLgfb6znzgFOuRWBMBxig@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 5 May 2022 16:54:02 -0700
Message-ID: <CAOUHufbnc3Q2qNd5f=SUgmzdSG6_c_ddZgDFEcxNajdSz=Ty3g@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Suleiman Souhlal <suleiman@google.com>,
        Yang Shi <shy828301@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, May 5, 2022 at 3:25 PM Suleiman Souhlal <suleiman@google.com> wrote:
>
> On Fri, May 6, 2022 at 4:33 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Thu, Apr 28, 2022 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > [...]
> > > > Yes, we have some modifications to zswap to make it work without any
> > > > backing real swap. Though there is a future plan to move to zram
> > > > eventually.
> > >
> > > Interesting, if so why not just simply use zram?
> > >
> >
> > Historical reasons. When we started trying out the zswap, I think zram
> > was still in staging or not stable enough (Suleiman can give a better
> > answer).
>
> One of the reasons we chose zswap instead of zram is that zswap can
> reject pages.
> Also, we wanted to have per-memcg pools, which zswap made much easier to do.

Yes, it was a design choice. zswap was cache-like (tiering) and zram
was storage-like (endpoint). Though nowadays the distinction is
blurry.

It had nothing to do with zram being in staging -- when we took zswap,
it was out of the tree.
