Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF84EE76D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbiDAEsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244906AbiDAEse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:48:34 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3EA22D66F
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:46:45 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2ea1b9b3813so20548877b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pi8QNywYAT0MyhJv6uC9oGhQUkCGrwBEd0y/FiOxaX8=;
        b=Y2bnNtokSz5hQLPfg0nMEViTLgTkFe9RsSuM/h/YHobynuDwCfzjScgBCwjUKN6yxU
         rkboP/dW3LUx+47NS+r8Crn6Qflovu0JGDWkxfj151SqgHrW2GCIeCZ7RpYcNOSthDsm
         YGDtlLBch/G4zwLe+BLjSXuuQ4QOG0MrhZIvY9qbwF3u95pyxr62633NC5nTBa1b4S2u
         sG66fcCwAEUkKUc6Y+5jkAdganis49bex/RVtqKtA+wvL6y9t+ud2Ap45yRW9WLoK8dj
         9CcndqJx6HYP3c4DOL+Ww0oVbndmezVeTolcLY9SWit52TELGrVFRzyW+2S5mAlgm/I5
         LDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pi8QNywYAT0MyhJv6uC9oGhQUkCGrwBEd0y/FiOxaX8=;
        b=F5wxuxVL0i9YUMjbjs3P+AT4X/+rjSZb+1y8KbWbe24u5my1uaJ/hKN4f6JaGqhiXD
         /R5JdeQAVsa3HtVkrAPD0VlExYGmse443suiwxyJaUhkOPlTV2if+hy/JS9Y4qgmXrWa
         bjiykHIK3cEN9Kay9QWZeiCBXaKSHrW9mHJxlAHnrD6mQN9xw6zNl3OsltT0oM4PbAM2
         inUTbe8vQnpBs/C6gWZKkezSAalYjbGOfcxEzGaoPQ7oR9s5widc43nCnmvokM83MZ4H
         4gjCPYL3GwerUItPPsuOKAXRQKTBQLb47/fIfNl51drrUcyWW0j1BdSan1V36PxgHgt7
         OcQQ==
X-Gm-Message-State: AOAM531Wz/RKuUGPz3+8arNCaI40F+BCQcyVEU6+qCKB21m3SHEn1wj3
        4yxsh4jHPPX5nBsK/uCZmH+7hOr02qk+xRhTd3RSAA==
X-Google-Smtp-Source: ABdhPJx7Zsdrto0MnZK4QlrbhMSwYXFiqqMxUmPzf/kGhl0p0fB1akshrhOqTFC+v4cc1D66UdiNyjdNgIeWOeoOUe0=
X-Received: by 2002:a0d:ea4c:0:b0:2e5:8bf8:4587 with SMTP id
 t73-20020a0dea4c000000b002e58bf84587mr8346564ywe.180.1648788404617; Thu, 31
 Mar 2022 21:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <1648713656-24254-1-git-send-email-zhaoyang.huang@unisoc.com>
 <YkVt0m+VxnXgnulq@dhcp22.suse.cz> <CAGWkznF4qb2EP3=xVamKO8qk08vaFg9JeHD7g80xvBfxm39Hkg@mail.gmail.com>
 <YkWR8t8yEe6xyzCM@dhcp22.suse.cz> <CAJuCfpFgi+Dph-dcDAvGQXwgeZVDBhok1UQ3X5kxFEfPQnxSSg@mail.gmail.com>
 <CAGWkznHyAG1wZcUrGE4-amptT_MkSnpZCrDLy0vUWBm3z2cmJw@mail.gmail.com>
In-Reply-To: <CAGWkznHyAG1wZcUrGE4-amptT_MkSnpZCrDLy0vUWBm3z2cmJw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 31 Mar 2022 21:46:33 -0700
Message-ID: <CAJuCfpEyDqiB2a+KqC1+Un0UJB1m3c0Aej6y3Umna3fdCPhvaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] cgroup: introduce dynamic protection for memcg
To:     Zhaoyang Huang <huangzhaoyang@gmail.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        cgroups mailinglist <cgroups@vger.kernel.org>,
        Ke Wang <ke.wang@unisoc.com>
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

On Thu, Mar 31, 2022 at 6:51 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Fri, Apr 1, 2022 at 3:26 AM Suren Baghdasaryan <surenb@google.com> wrote:
> >
> > On Thu, Mar 31, 2022 at 4:35 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 31-03-22 19:18:58, Zhaoyang Huang wrote:
> > > > On Thu, Mar 31, 2022 at 5:01 PM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 31-03-22 16:00:56, zhaoyang.huang wrote:
> > > > > > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > > > > >
> > > > > > For some kind of memcg, the usage is varies greatly from scenarios. Such as
> > > > > > multimedia app could have the usage range from 50MB to 500MB, which generated
> > > > > > by loading an special algorithm into its virtual address space and make it hard
> > > > > > to protect the expanded usage without userspace's interaction.
> > > > >
> > > > > Do I get it correctly that the concern you have is that you do not know
> > > > > how much memory your workload will need because that depends on some
> > > > > parameters?
> > > > right. such as a camera APP will expand the usage from 50MB to 500MB
> > > > because of launching a special function(face beauty etc need special
> > > > algorithm)
> > > > >
> > > > > > Furthermore, fixed
> > > > > > memory.low is a little bit against its role of soft protection as it will response
> > > > > > any system's memory pressure in same way.
> > > > >
> > > > > Could you be more specific about this as well?
> > > > As the camera case above, if we set memory.low as 200MB to keep the
> > > > APP run smoothly, the system will experience high memory pressure when
> > > > another high load APP launched simultaneously. I would like to have
> > > > camera be reclaimed under this scenario.
> > >
> > > OK, so you effectivelly want to keep the memory protection when there is
> > > a "normal" memory pressure but want to relax the protection on other
> > > high memory utilization situations?
> > >
> > > How do you exactly tell a difference between a steady memory pressure
> > > (say stream IO on the page cache) from "high load APP launched"? Should
> > > you reduce the protection on the stram IO situation as well?
> >
> > IIUC what you are implementing here is a "memory allowance boost"
> > feature and it seems you are implementing it entirely inside the
> > kernel, while only userspace knows when to apply this boost (say at
> > app launch time). This does not make sense to me.
> I am wondering if it could be more helpful to apply this patch on the
> background services(system_server etc) than APP, while the latter ones
> are persistent to the system.
> >
> > >
> > > [...]
> > > > > One very important thing that I am missing here is the overall objective of this
> > > > > tuning. From the above it seems that you want to (ab)use memory->low to
> > > > > protect some portion of the charged memory and that the protection
> > > > > shrinks over time depending on the the global PSI metrict and time.
> > > > > But why this is a good thing?
> > > > 'Good' means it meets my original goal of keeping the usage during a
> > > > period of time and responding to the system's memory pressure. For an
> > > > android like system, memory is almost forever being in a tight status
> > > > no matter how many RAM it has. What we need from memcg is more than
> > > > control and grouping, we need it to be more responsive to the system's
> > > > load and could  sacrifice its usage  under certain criteria.
> > >
> > > Why existing tools/APIs are insufficient for that? You can watch for
> > > both global and memcg memory pressure including PSI metrics and update
> > > limits dynamically. Why is it necessary to put such a logic into the
> > > kernel?
> >
> > I had exactly the same thought while reading through this.
> > In Android you would probably need to implement a userspace service
> > which would temporarily relax the memcg limits when required, monitor
> > PSI levels and adjust the limits accordingly.
> As my response to Michal's comment. Userspace monitors introduce
> latency. Take LMKD as an example, it is actually driven by the
> PSI_POLL_PERIOD_XXX_MS after first wakeup, which means
> PSI_WINDOW_SIZE_MS could be too big to rely on. IMHO, with regards to
> the responding time, LMKD is less efficient than lmk driver but more
> strong in strategy things. I would like to test this patch in real
> android's work load and feedback in next version.

LMKD is a reactive mechanism which does not know when memory pressure
might rise, therefore its response latency matters.
The usecases you mentioned seemed to imply that userspace was aware of
increased memory demands of the process (app startup time, maybe the
moment the app becomes foreground, etc.). Therefore the userspace
could relax memory allowance before that memory is requested. Was my
understanding incorrect?

> >
> > >
> > > --
> > > Michal Hocko
> > > SUSE Labs
