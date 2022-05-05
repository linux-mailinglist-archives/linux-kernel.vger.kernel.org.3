Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCDF751C93F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384731AbiEEThH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242764AbiEEThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:37:01 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215185BE52
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 12:33:20 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id i1so5320528plg.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dRHgD9SEP6VxecvOJKMO+hE0skmrxwLBPBgRgtV/MUU=;
        b=cRbJ1Voo0Pa/pnGw+etrw1nN4wsyMSamotM9s29deoo46EfHIwdES8lYAf2BicHXYh
         cbUp7UQn497jeuMx6r582K3O7sammfm2CYNakU5Sb48i4jDKZ1/hFLj6g+yGHbGJg678
         pNktgCkMDanFMuxNLRXwMiyGeLVgOhm//W+PEJVfg+oRO9cOlW+7w99LZd25UFx/xpnw
         0PST6Um2u2Ibhy/5pt+x2B+DTaCcyj4HM4TxHjiiNvODWTuv3Qwv0YeTP3NAfk5RQGGr
         gWMXiYl5ck3Cr5eZRPzA0PTQ66o9qX9DoCCrsFx+1hjhm2KMdvZNlU04BokxyrIOe33N
         lB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dRHgD9SEP6VxecvOJKMO+hE0skmrxwLBPBgRgtV/MUU=;
        b=mCawaRJUPb+hWA3qwxjuc3REldRAfQhN0TX6HH1iNdHcIGDlDayRLu8MrFuT+VrYUW
         YCGfE1QRI4EjOO6wxUGte3/Z7osol0De+Omm0PiCfQYHuGIQvQt4LlUk1ODYBduhpUPW
         nzrQwVkLon++jiX2Wo5xDOD3+kysNxQyjrr2kjaJVp2VURWZVY3xb221Nf/vIlip2zn+
         DVb9pOQ46ZLrRkuMmlUPgXWgNUDb7tZ4lF8sPaP5RqOY68SGIVwi4Q0dP+V/+2AxACnt
         H0ppGLZ5h0kuVnJeAe/Deq7xFVuZ2Ubyr/HRlNyAU+1clq8/PPsUS+sggpsppXuNBs+W
         hBXw==
X-Gm-Message-State: AOAM532YHl3n7wNQzJoVfZSJtqTyKaatKAw1CLdPGVif56HEO7VkgDUE
        c39dKZtUjhNEyj23mOaJFsts6QViSBLsJZ6SPSTNFw==
X-Google-Smtp-Source: ABdhPJxGguelLKMMpEx0uxbQpKMJbjQY6h5B3jSBojaGuvXcuco6MYRM1sPTvh64MqlKMdIMtg8Lwvyr/Ct7WyXrOzU=
X-Received: by 2002:a17:90b:1d83:b0:1dc:4362:61bd with SMTP id
 pf3-20020a17090b1d8300b001dc436261bdmr8009409pjb.126.1651779199526; Thu, 05
 May 2022 12:33:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220427160016.144237-1-hannes@cmpxchg.org> <20220427160016.144237-5-hannes@cmpxchg.org>
 <Ymmnrkn0mSWcuvmH@google.com> <YmmznQ8AO5RLxicA@cmpxchg.org>
 <Ymm3WpvJWby4gaD/@cmpxchg.org> <CALvZod5LBi5V6q1uHUTSNnLz64HbD499a+OZvdYsUcmcWSt8Jg@mail.gmail.com>
 <YmqmWPrIagEEceN1@cmpxchg.org> <CALvZod7wOyXpA3pycM2dav9_F9sW5ezC84or-75u8GdQyu30nw@mail.gmail.com>
 <CAHbLzkqOUkaud4hQZeAbnO3T6VJpku4aKn1EYv9RunB+Kmu9Sg@mail.gmail.com>
In-Reply-To: <CAHbLzkqOUkaud4hQZeAbnO3T6VJpku4aKn1EYv9RunB+Kmu9Sg@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 5 May 2022 12:33:08 -0700
Message-ID: <CALvZod5CReJZeGxkX9i6k7+R+3kF5dikXx9akbiP_L0j4Qu=6A@mail.gmail.com>
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
To:     Yang Shi <shy828301@gmail.com>,
        Suleiman Souhlal <suleiman@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 9:54 AM Yang Shi <shy828301@gmail.com> wrote:
>
[...]
> > Yes, we have some modifications to zswap to make it work without any
> > backing real swap. Though there is a future plan to move to zram
> > eventually.
>
> Interesting, if so why not just simply use zram?
>

Historical reasons. When we started trying out the zswap, I think zram
was still in staging or not stable enough (Suleiman can give a better
answer).
