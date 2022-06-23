Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE02558769
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 20:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiFWSZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 14:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiFWSZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 14:25:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C714FC4C
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:26:49 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g18so3099296wrb.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 10:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TDx1GAcTZr/mKBq1FDoJ+WDlWvqn8HIrUeDOsFdpYQ=;
        b=ligNsGWDaeaYYd/G23On/R6o4SOm7zU5YC8HoZNU95O944imBcwrspvEgFwN/jGZhy
         BsqxtmSbvZWbeBbv+nhfMCexAkXOJe09iXp5EF8jD89itp1j+SwO0SyJqwT+axErD/Gb
         RLoYBG7mmML1wacS5w7d+BkAOcQFmQvKA/pXN1LSgzFGqLrJ4uawFe8Xc42ASPtIkwoj
         q/6hAWrCjPXdsSiMhicJLxhTYSpzYoslUad6fyTGV1PSr25ZDlw/QK7ERDUClaOKrabX
         8w8zveECT9r55DBweEavza7Ov5K5Z06nVub55c0/iBZGS/2SSDgVQZKOHdoAbnjZ1yMl
         AZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TDx1GAcTZr/mKBq1FDoJ+WDlWvqn8HIrUeDOsFdpYQ=;
        b=fKmodEUmop3+x69iYLOlUJB3PEqxrIv3d3i71DlnGg99ij7ouaZQUFZnLxb+WyZ2MD
         U6gYZ49wN7UX5mNLSepEkIZpqQT0CmOxAq8goRj/jGLunNby3xaLz3IH1RUawvJDCMBT
         rR7GpVaFTF1IrN+aj9nqfVGM8OSwknkWzXRVDejcQuudCGXetdbCkMMfp6jF3cqa0u8/
         3pEB3O3xP2Soj3b9xrZQODbFcl8nB2jSTVEOXpsR8A7Dsz7GWAVWmlcsa+Ma9MVOMfLe
         SDAacH0Igk7Bf5u97UmsvIbn+MqSAxueuVXHyoqAVqik7rluxxF34Tz9ltXLw+dKBTUp
         JDNw==
X-Gm-Message-State: AJIora8eEdL66DmBkg3pIIDYolgF7hoWhQUNOdx3Zw5h9TV69IzHkq3y
        S31SCQvsAkhZI+58j/aaTlStVmeo/IialsEcHR4N8w==
X-Google-Smtp-Source: AGRyM1ttFuXoFy+5+a07+hGzPPAvBJtwjefc2vBhdtGeCPnt72+WyG79pmSWHqGSSZGfFhRIy7loD1VK/eM0VISVIT4=
X-Received: by 2002:a5d:4308:0:b0:219:e5a4:5729 with SMTP id
 h8-20020a5d4308000000b00219e5a45729mr9194972wrq.210.1656005207539; Thu, 23
 Jun 2022 10:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220623000530.1194226-1-yosryahmed@google.com>
 <YrQe5A+FXnbgOR1f@dhcp22.suse.cz> <CAJD7tkanavKpKrQr8-jA8pukgD7OY4eOwJRZufJ2NoThD12G+Q@mail.gmail.com>
 <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
In-Reply-To: <YrSdFy3qYdG+rGR6@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 23 Jun 2022 10:26:11 -0700
Message-ID: <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
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

On Thu, Jun 23, 2022 at 10:04 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Thu 23-06-22 09:42:43, Shakeel Butt wrote:
> > On Thu, Jun 23, 2022 at 9:37 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Thu 23-06-22 09:22:35, Yosry Ahmed wrote:
> > > > On Thu, Jun 23, 2022 at 2:43 AM Michal Hocko <mhocko@suse.com> wrote:
> > > > >
> > > > > On Thu 23-06-22 01:35:59, Yosry Ahmed wrote:
> > > [...]
> > > > > > In our internal version of memory.reclaim that we recently upstreamed,
> > > > > > we do not account vmpressure during proactive reclaim (similar to how
> > > > > > psi is handled upstream). We want to make sure this behavior also
> > > > > > exists in the upstream version so that consolidating them does not
> > > > > > break our users who rely on vmpressure and will start seeing increased
> > > > > > pressure due to proactive reclaim.
> > > > >
> > > > > These are good reasons to have this patch in your tree. But why is this
> > > > > patch benefitial for the upstream kernel? It clearly adds some code and
> > > > > some special casing which will add a maintenance overhead.
> > > >
> > > > It is not just Google, any existing vmpressure users will start seeing
> > > > false pressure notifications with memory.reclaim. The main goal of the
> > > > patch is to make sure memory.reclaim does not break pre-existing users
> > > > of vmpressure, and doing it in a way that is consistent with psi makes
> > > > sense.
> > >
> > > memory.reclaim is v2 only feature which doesn't have vmpressure
> > > interface. So I do not see how pre-existing users of the upstream kernel
> > > can see any breakage.
> > >
> >
> > Please note that vmpressure is still being used in v2 by the
> > networking layer (see mem_cgroup_under_socket_pressure()) for
> > detecting memory pressure.
>
> I have missed this. It is hidden quite good. I thought that v2 is
> completely vmpressure free. I have to admit that the effect of
> mem_cgroup_under_socket_pressure is not really clear to me. Not to
> mention whether it should or shouldn't be triggered for the user
> triggered memory reclaim. So this would really need some explanation.

vmpressure was tied into socket pressure by 8e8ae645249b ("mm:
memcontrol: hook up vmpressure to socket pressure"). A quick look at
the commit log and the code suggests that this is used all over the
socket and tcp code to throttles the memory consumption of the
networking layer if we are under pressure.

However, for proactive reclaim like memory.reclaim, the target is to
probe the memcg for cold memory. Reclaiming such memory should not
have a visible effect on the workload performance. I don't think that
any network throttling side effects are correct here.

>
> > Though IMO we should deprecate vmpressure altogether.
>
> Yes it should be really limited to v1. But as I've said the effect on
> mem_cgroup_under_socket_pressure is not really clear to me. It really
> seems the v2 support has been introduced deliberately.
>
> --
> Michal Hocko
> SUSE Labs
