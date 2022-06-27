Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F95C55D2E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiF0REd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbiF0REc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:04:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20D14D25
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:04:31 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b26so1575856wrc.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 10:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ZvfkO3IFf3n/ZVC71sBF9P6CPQM5ABge97UmMt98ps=;
        b=MjiW4IZIKNvnRLaZM4hrpDs4I/vEqDj5/3xOzyG/gv8hlURBfdXynnwR5LA4UVW70b
         o6v1EJHUzimguE8TQT2qD+Ab522RK1leX7GKKUj72qeBt/3gTwNZo3T7zB5s5GAWR77C
         kmZiLNM8c8QVC160v7Ww9LlRpm1EKOj9ecAo/uAQCARN/f/mgZjude7rkreOk0yXGga4
         Yc2oi4K5OYLJIn0wx5Z3wx0IbtNw5aTVQ4dxcBthCiW5NNtCuEvfM0Mj9ZlgHR8TiiCA
         U8V6ZkaLIF2+CvNbXCBVwy7P4laWgV05N1TKs+pMvPm7BtkXpcmeznV712/+QiAYbgHU
         HMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ZvfkO3IFf3n/ZVC71sBF9P6CPQM5ABge97UmMt98ps=;
        b=y9o6Eaqu2vyClAC8NQ6Ft4+oWte7Umf/mn0YdXTa+Sm7rloCSCKbFHUJ4z982Ye/3O
         /ljLP442urvKKusvSGEKsBHPaz0AL6iHpd7iVfzABlnJQ/LLeUlyCsRLEtd/GAiDuGnL
         IpVtSwdbQZcetIp12ZsFDmRnpPY1MjnlKL+eE7kAvvGCrNQsr9PgP34n66habFBxorSh
         h8C/jRnEcNiWplFVJsWF0VFs5w5mAOpa+qCCyUILHuu4AFD3ZB1b8H3XXDUuJFkmYNYJ
         PZ9SpBKQvg1ExzVWKp9To8ptlwbfNQ7Xxw6qmIweZh3ki+Cc9k1NXSAHrX+/heAc+J7h
         eDyA==
X-Gm-Message-State: AJIora/ufrZKvj9h4M66OGZv97kUwsSxSRZSKNSNoFHhfhs/pnmLR0hR
        cHDbDeatGN7KK8O+Hg7tlpHekbVk9UZqJxQIC+EYTA==
X-Google-Smtp-Source: AGRyM1tsM6jtK4W1ydOvV8tE+BMi6c/Kd8ao252QMgYmdkd1sbM1VIU0dS/5S3UTvHRiwBpXdREowoHR7zHRMY+vfNk=
X-Received: by 2002:a5d:6ac4:0:b0:21b:a724:1711 with SMTP id
 u4-20020a5d6ac4000000b0021ba7241711mr13037659wrw.80.1656349469508; Mon, 27
 Jun 2022 10:04:29 -0700 (PDT)
MIME-Version: 1.0
References: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz> <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz> <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
 <Yrl2T632Vfv8QGPn@dhcp22.suse.cz> <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
 <YrmjH2FZF7iNn8da@dhcp22.suse.cz>
In-Reply-To: <YrmjH2FZF7iNn8da@dhcp22.suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 27 Jun 2022 10:03:53 -0700
Message-ID: <CAJD7tkYemNQqu_O2nYG3cqxPWGELvc6Lh5i+KKNCtv6cgSPmdA@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 5:31 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 27-06-22 02:39:49, Yosry Ahmed wrote:
> [...]
> > (a) Do not count vmpressure for mem_cgroup_resize_max() and
> > mem_cgroup_force_empty() in v1.
>
> yes, unless you have a very good reason to change that. E.g. this has
> been buggy and we have finally understood that. But I do not see any
> indications so far.

I don't have any bug reports. It makes sense that users do not expect
vmpressure notifications when they resize the limits below the current
usage, because it should be expected that reclaim will happen so
receiving notifications here is redundant, and may be incorrectly
perceived by a different user space thread as being under memory
pressure. But I get your point that what the user sees as memory
pressure or not could be different, and is probably already defined by
the current behavior anyway, whether it makes sense or not.

I can also see some userspace applications depending on this behavior
in some way, either by handling that limit resize notification in a
certain way or deliberately dropping it. Either way, making this
change could throw them off. I don't expect any userspace applications
to crash of course (because there are cases where they won't receive
notifications, e.g. scanned < vmpressure_win), but perhaps it's not
worth even risk misguiding them.

So I agree that just because it doesn't make sense or is inconsistent
with other definitions of behavior then we can make a visible change
for userspace. I will drop the v1 changes in the next version anyway.

Thanks!

>
> > (b) Do not count vmpressure (consequently,
> > mem_cgroup_under_socket_pressure()) in v2 where psi is not counted
> > (writing to memory.max, memory.high, and memory.reclaim).
>
> I can see clear arguments for memory.reclaim opt out for vmpressure
> because we have established that this is not a measure to express a
> memory pressure on the cgroup.
>
> Max/High are less clear to me, TBH. I do understand reasoning for PSI
> exclusion because considering the calling process to be stalled and
> non-productive is misleading. It just does its work so in a way it is
> a productive time in the end. For the vmpressure, which measures how
> hard/easy it is to reclaim memory why this should special for this
> particular reclaim?
>
> Again, an explanation of the effect on the socket pressure could give a
> better picture. Say that I somebody reduces the limit (hard/high) and it
> takes quite some effort to shrink the consumption down. Should the
> networking layer react to that in any way or should it wait for the
> active allocation during that process to find that out?

I am out of my depth here. Any answer on my side would be purely
speculation at this point. Shakeel, can you help us here or tag some
networking people?
Thanks!

> --
> Michal Hocko
> SUSE Labs
