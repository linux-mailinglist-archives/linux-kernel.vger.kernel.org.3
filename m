Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5A560EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 04:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiF3CJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 22:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiF3CJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 22:09:21 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1DD37A9A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:09:20 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so12651748wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 19:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdyIx5FpirbeiM+KXQcsxG+JTSX3RaLyAakby7DKvG0=;
        b=l4PlpC1uBr51seSmaB9EGzmAqLAQ0Uff7iJI49CFKx7B2nDssvIwo7joJuymZEKEXh
         qrVj7fBKDs1YhOHFVS4aVFYunry1OnCTTqwUYeHcrkNEUHrDmaUbO9A6jq57dqT3+PKD
         6wrc/cUkZNmp20ylvzD0WG2fVPWfY1Zp4G6Tb6J5rpyPRsFSWHxp9HqeUFevf85Fl5el
         71CekmS8rklU2Og6zrz100Qj1ZX1hYVJ88clB73SAUVfQoqmqQ8JyTXH40QAsmKhOAYw
         Z6goZd6OBvIHpp1DGjDLTP5+Cc5gjn7f5YFkl9CVpNn1k04wKCYSz0V+qtgdt7jmHrlw
         VAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hdyIx5FpirbeiM+KXQcsxG+JTSX3RaLyAakby7DKvG0=;
        b=GYpLabOvFLG5BS0ZQcQDavolUocRVGc9uL66cmGTLDjwWrsKoGzLEbQxF4ReECSxx1
         xN5GHNYxUbwzp1J1ACs/8L6B63Jn6c5AMOdH90ROL4dLVE0qzHSyUWFmp1oZzwRyBFfO
         QBy6Pmbwp75Rd6MKSwP+t8NsSvv8nV7rIX5SWzYfKdR2YU05qKIXIPSs+YTtQR0lUNHG
         a/PugPUMPA0xMkfOrHJ0XftIguKnKq9CrIv9lhxySkvwBrI3TfYsVX/Fv2al6AhRyRQ/
         gQOZ3QdqKcPzQslWEmDrUpZl36aKzrp/mbRQ25BmGgXWkQvi5nXHQyFIu/pLIYarDLW3
         yNpQ==
X-Gm-Message-State: AJIora/F6bAq7TAlVbNmzQWi2OLHIqj3Kh8FOCh7Zn8LM1EPEyKjeRHX
        URSDQtULAJpSombxWPeaIrbtYey2Vr31JndFPHC94g==
X-Google-Smtp-Source: AGRyM1sTmn7NUX08Wg8Mx/WoDWKA8WR3jj26GmIlUKo6fXqusf252Qh5r32vaIWazO4psbQB43iblGLVll5kV7oWQdE=
X-Received: by 2002:adf:f146:0:b0:21b:8c7d:7294 with SMTP id
 y6-20020adff146000000b0021b8c7d7294mr5812219wro.582.1656554958597; Wed, 29
 Jun 2022 19:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <YrQ1o3CeaZWhm+h4@dhcp22.suse.cz> <CAJD7tkadsLOV7GMFAm+naX4Y1WpZ-4=NkAhAMxNw60iaRPWx=w@mail.gmail.com>
 <YrSWruhPlJV1X9kp@dhcp22.suse.cz> <CALvZod6eLa1X1FJ2Qi6FXhFA-qBCP4mN2SB31MSgjj+g8hKo6Q@mail.gmail.com>
 <YrSdFy3qYdG+rGR6@dhcp22.suse.cz> <CAJD7tkZNEtzJMDsLMHuNHkxFfurS37UuK=zFcPCkOkWfN-dbJQ@mail.gmail.com>
 <YrlpcdgF1HzA7bHS@dhcp22.suse.cz> <CAJD7tkYVy2uNwaPiiJdPKT5P_O-9WgxD68iFJ6vw=TLJcQV3Ag@mail.gmail.com>
 <Yrl2T632Vfv8QGPn@dhcp22.suse.cz> <CAJD7tkZzwzHq7Q7KKUdVSdO4LWTPkrGprp0Q-ze_SWhUd_mTMw@mail.gmail.com>
 <YrmjH2FZF7iNn8da@dhcp22.suse.cz> <CAJD7tkYemNQqu_O2nYG3cqxPWGELvc6Lh5i+KKNCtv6cgSPmdA@mail.gmail.com>
 <CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com>
In-Reply-To: <CALvZod68WdrXEmBpOkadhB5GPYmCXaDZzXH=yyGOCAjFRn4NDQ@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 29 Jun 2022 19:08:42 -0700
Message-ID: <CAJD7tkZeySa9V+nuoGfmugrOcxaiaXFspPKLkgTFkvsrri=J3g@mail.gmail.com>
Subject: Re: [PATCH] mm: vmpressure: don't count userspace-induced reclaim as
 memory pressure
To:     Shakeel Butt <shakeelb@google.com>, Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
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

On Wed, Jun 29, 2022 at 6:07 PM Shakeel Butt <shakeelb@google.com> wrote:
>
> On Mon, Jun 27, 2022 at 10:04 AM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Mon, Jun 27, 2022 at 5:31 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> [...]
> > >
> > > I can see clear arguments for memory.reclaim opt out for vmpressure
> > > because we have established that this is not a measure to express a
> > > memory pressure on the cgroup.
> > >
> > > Max/High are less clear to me, TBH. I do understand reasoning for PSI
> > > exclusion because considering the calling process to be stalled and
> > > non-productive is misleading. It just does its work so in a way it is
> > > a productive time in the end. For the vmpressure, which measures how
> > > hard/easy it is to reclaim memory why this should special for this
> > > particular reclaim?
> > >
> > > Again, an explanation of the effect on the socket pressure could give a
> > > better picture. Say that I somebody reduces the limit (hard/high) and it
> > > takes quite some effort to shrink the consumption down. Should the
> > > networking layer react to that in any way or should it wait for the
> > > active allocation during that process to find that out?
> >
> > I am out of my depth here. Any answer on my side would be purely
> > speculation at this point. Shakeel, can you help us here or tag some
> > networking people?
>
> So, the effect of returning true from mem_cgroup_under_socket_pressure() are:
>
> 1. Reducing send and receive buffers of the current socket.
> 2. May drop packets on the rx path.
> 3. May throttle current thread on the tx path.
>
> Now regarding the behavior from the reclaim due to reducing max or
> high, I think the kernel should not ignore vmpressure. Please note
> that unlike PSI which is associated with the current process,
> vmpressure is associated with the target memcg. So, any reclaim on
> that memcg due to real shortage of memory should not be ignored. That
> reclaim can be global reclaim or limit reclaim of ancestor or itself
> or reclaim due to lowering the limit of ancestor or itself.

So it seems like we should only ignore vmpressure for proactive
reclaim (aka memory.reclaim).

Michal, let me know what you think here, I can drop psi and
limit-setting changes in v3 and basically just ignore vmpressure for
memory.reclaim (MEMCG_RECLAIM_PROACTIVE / sc->proactive instead of
MEMCG_RECLAIM_CONTROLLED / sc->controlled maybe).
