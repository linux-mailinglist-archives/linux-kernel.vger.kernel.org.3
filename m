Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E255C365
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiF0Ik1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiF0Ik0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:40:26 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FD56313
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:40:25 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id v65-20020a1cac44000000b003a03c76fa38so4387356wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XRmJjWWFtnuNSlD/e9eL++RxDIH2gU2v0iOznKKFYn8=;
        b=Wuf9RiWGC4Ck7nVJZxIuaXqlmtEYZQSIQ/XU/Z3BJHvJoGLTwlZuqu5MCm4eK8t4D6
         fSnBv50+/jxAWA+u1iNE8whVMBdy0DjEnq1FbrGKA0TR37/yl1d/wO9Ser1jFscjBj6c
         QW15NB1JthAErb3q383ZT/lBSAQVHiH11T3Z/Le9O3AL3nzdk2slefDkprcvlxggRPD2
         E7zlM652mFNrNCuRTHdqzfs5qO/5QlGtZJh6nVcsRgHPMGrTLUPKgtqkhBYboGYjExQX
         +QMRShFRn4BvAwX0BPOX8fJsMYKSGCo62b1c7mA0RzQ1z5SYVxFCGQEWFZ0hVr9xMuvu
         eJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XRmJjWWFtnuNSlD/e9eL++RxDIH2gU2v0iOznKKFYn8=;
        b=0H4kCrKdMDbxf9rbEb/OzQjfDo+lZAIEyLw/cwOiC2xhd7pQTuLW3Z3dbsOBudn4sf
         9qCeQtphp+JWqchoD6i1VOVmlahPub+Bf2pej6TnmYFqfaillgdIVf8f0bDAZu3SWUz2
         jpJmxz411yTGizvGP8AOKxQHiaJuCsMQN8hlceX/RjbkE5O8F7mY1TJCH3E1hPgyQ9Fq
         Hn9dtF88apEg2Go400k4jK9APKqTr6FdGxifS2Z/MD/JikMqvyD9Wj23kZQtXz0aphbm
         iEhHqaeN0/wGfQaOgHQPHSuym6kl4P3VnJLCxvZ31sz968gHWVKc659QO4NWowOET5pb
         H+zw==
X-Gm-Message-State: AJIora9KrwF+U6d/twRzaER020xfIW5N1A9wQ6r4qJMkOyaBiHAQfxba
        JqUGzoawdXAf5mdSJ7tHwuy4NTjdbxh7Uij22rVbmg==
X-Google-Smtp-Source: AGRyM1vfAz4nYaYXojroBzq5KWiZRFn5bk/JU96hitxFveZR7fyQu+0CEcHEugmroP8FCBjpV7cdOQ0hrleKIxj6Rxo=
X-Received: by 2002:a05:600c:1906:b0:39c:7f82:3090 with SMTP id
 j6-20020a05600c190600b0039c7f823090mr18668927wmq.152.1656319223415; Mon, 27
 Jun 2022 01:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz> <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
In-Reply-To: <YrlpcdgF1HzA7bHS@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 01:39:46 -0700
Message-ID: <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
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

On Mon, Jun 27, 2022 at 1:25 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 10:26:11, Yosry Ahmed wrote:
> > On Thu, Jun 23, 2022 at 10:04 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 09:42:43, Shakeel Butt wrote:
> > > > On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > > > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > > > >
> > > > > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > > > > [...]
> > > > > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > > > > exists in the upstream version so that consolidating them does not
> > > > > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > > > > pressure due to proactive reclaim.
> > > > > > >
> > > > > > > These are good reasons to have this patch in your tree. But why is this
> > > > > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > > > > some special casing which will add a maintenance overhead.
> > > > > >
> > > > > > It is not just Google, any existing vmpressure users will start seeing
> > > > > > false pressure notifications with memory.reclaim. The main goal of the
> > > > > > patch is to make sure memory.reclaim does not break pre-existing users
> > > > > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > > > > sense.
> > > > >
> > > > > memory.reclaim is v2 only feature which doesn't have vmpressure
> > > > > interface. So I do not see how pre-existing users of the upstream kernel
> > > > > can see any breakage.
> > > > >
> > > >
> > > > Please note that vmpressure is still being used in v2 by the
> > > > networking layer (see mem_cgroup_under_socket_pressure()) for
> > > > detecting memory pressure.
> > >
> > > I have missed this. It is hidden quite good. I thought that v2 is
> > > completely vmpressure free. I have to admit that the effect of
> > > mem_cgroup_under_socket_pressure is not really clear to me. Not to
> > > mention whether it should or shouldn't be triggered for the user
> > > triggered memory reclaim. So this would really need some explanation.
> >
> > vmpressure was tied into socket pressure by 8e8ae645249b ("mm:
> > memcontrol: hook up vmpressure to socket pressure"). A quick look at
> > the commit log and the code suggests that this is used all over the
> > socket and tcp code to throttles the memory consumption of the
> > networking layer if we are under pressure.
> >
> > However, for proactive reclaim like memory.reclaim, the target is to
> > probe the memcg for cold memory. Reclaiming such memory should not
> > have a visible effect on the workload performance. I don't think that
> > any network throttling side effects are correct here.
>
> Please describe the user visible effects of this change. IIUC this is
> changing the vmpressure semantic for pre-existing users (v1 when setting
> the hard limit for example) and it really should be explained why
> this is good for them after those years. I do not see any actual bug
> being described explicitly so please make sure this is all properly
> documented.

In cgroup v1, user-induced reclaim that is caused by limit-setting (or
memory.reclaim for systems that choose to expose it in cgroup v1) will
no longer cause vmpressure notifications, which makes the vmpressure
behavior consistent with the current psi behavior.

In cgroup v2, user-induced reclaim (limit-setting, memory.reclaim, ..)
would currently cause the networking layer to perceive the memcg as
being under memory pressure, reducing memory consumption and possibly
causing throttling. This patch makes the networking layer only
perceive the memcg as being under pressure when the "pressure" is
caused by increased memory usage, not limit-setting or proactive
reclaim, which also makes the definition of memcg memory pressure
consistent with psi today.

In short, the purpose of this patch is to unify the definition of
memcg memory pressure across psi and vmpressure (which indirectly also
defines the definition of memcg memory pressure for the networking
layer). If this sounds good to you, I can add this explanation to the
commit log, and possibly anywhere you see appropriate in the
code/docs.

>
> --
> Michal Hocko
> SUSE Labs
