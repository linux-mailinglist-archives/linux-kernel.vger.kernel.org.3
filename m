Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9252467600
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 12:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380325AbhLCLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 06:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380318AbhLCLSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 06:18:11 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7102C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 03:14:47 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id v1so10158451edx.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 03:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q2LJ6/GRHQsVTGh/1AOapK3ccuMB9P2tvuIxgfqInTk=;
        b=YiG4vYaqjnSAZ/sLDflHVebVor1xsVHUi+ARNGGNpO3VC0w1lS4ZRGUZlYZzqtdgeH
         +uW1PVd0TSCVYiOCAnQ7sd9iK51RXbL7zs0AwWo7lUT+9khYsbP6r5v7U2rqu4O/Pdnp
         u10rr87vzdh6Oa6WcWgl5hNqqwoqYjrD5nel3CDyDvMdg7fcQPOUCmudjSPj+vP+dGcS
         uMtIjvea02DqUCECpwaFfT/fwVRYiOAOyr+ai5xaQvNrRbUemtk0+MYTxCwDMuVi7huA
         twkNO0VID5o1ShWkA59BxMu8yfVfxvcZOs0fxqAp1u+mKqhgwvJcU7AQ6VQSyiv9pQKw
         5qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q2LJ6/GRHQsVTGh/1AOapK3ccuMB9P2tvuIxgfqInTk=;
        b=apYPlO+xHyHbNHQrBA9PusmdvGvfzLRKWmVkwzevcX1G7MWozy8YsUoF3HISDhy1RT
         MLGBNF7ArYD3IBsgPHcITEKBR737R2eowxfz3ujy1djep7sqWF4dNoRB/hQPHj2wzjl7
         nBPAewDOJwNZmrDTvVrvkuoLBBC48mbOW7Ee336w3hvMGiy1gBpsyiRYuYgrMEjsscKq
         BZ359aPawF3GVe0pKdejIzZXpMaHfGfSt18wKfv8F+ohC5yiq53XGLtvj8NWQluXOKWr
         1vB3GjnVZzf32IBkWvet0yvSf47rVdq/xibrvrIxSZwy//ofFNApT1Di4Ta567RTLyrj
         mdZQ==
X-Gm-Message-State: AOAM532GipDFWphqRc77OZ2vOFTcLYvgTgEJLQb2a4QcYtJTisXb42v1
        MLoO+/FwwEzOGJrsW3jMG462TK3ZEfYxxDrOMQo=
X-Google-Smtp-Source: ABdhPJwBoyHvhVIGdalfiiThlxcetnhQQdXBDbqXjC4Oc+Jody55fenKY8DY+LRFpoV/H1LTz4fFl5DHPjQKw9qPsQ4=
X-Received: by 2002:a05:6402:60c:: with SMTP id n12mr26360730edv.17.1638530086231;
 Fri, 03 Dec 2021 03:14:46 -0800 (PST)
MIME-Version: 1.0
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net> <CAGsJ_4xuYH8d18r9f5vUGYjNxtZ31FZrNZepEh8QCZbLW+3a6Q@mail.gmail.com>
 <20211203105055.GB3366@techsingularity.net>
In-Reply-To: <20211203105055.GB3366@techsingularity.net>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sat, 4 Dec 2021 00:14:33 +1300
Message-ID: <CAGsJ_4zigz0rs9ubPjJKn0s9FsHp6A1Gpoh+cyc=cQnnMEMgYg@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 11:50 PM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Dec 03, 2021 at 09:15:15PM +1300, Barry Song wrote:
> > > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > > index d201a7052a29..fee2930745ab 100644
> > > --- a/kernel/sched/topology.c
> > > +++ b/kernel/sched/topology.c
> > > @@ -2242,6 +2242,26 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> > >                 }
> > >         }
> > >
> > > +       /* Calculate allowed NUMA imbalance */
> > > +       for_each_cpu(i, cpu_map) {
> > > +               int imb_numa_nr = 0;
> > > +
> > > +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > > +                       struct sched_domain *child = sd->child;
> > > +
> > > +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > > +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > > +                               int nr_groups;
> > > +
> > > +                               nr_groups = sd->span_weight / child->span_weight;
> > > +                               imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> > > +                                               (nr_groups * num_online_nodes()));
> >
> > Hi Mel, you used to have 25% * numa_weight if node has only one LLC.
> > for a system with 4 numa,  In case sd has 2 nodes, child is 1 numa node,
> > then  nr_groups=2, num_online_nodes()=4,  imb_numa_nr will be
> > child->span_weight/2/2/4?
> >
> > Does this patch change the behaviour for machines whose numa equals LLC?
> >
>
> Yes, it changes behaviour. Instead of a flat 25%, it takes into account
> the number of LLCs per node and the number of nodes overall.

Considering  the number of nodes overall seems to be quite weird to me.
for example, for the below machines

1P * 2DIE = 2NUMA:    node1 - node0
2P * 2DIE = 4NUMA:    node1 - node0  ------ node2 - node3
4P * 2DIE = 8NUMA:    node1 - node0  ------ node2 - node3
                                      node5 - node4  ------ node6 - node7

if one service pins node1 and node0 in all above configurations, it seems in all
different machines, the app will result in different behavior.

the other example is:
in a 2P machine, if one app pins the first two NUMAs, the other app pins
the last two NUMAs, why would the  num_online_nodes() matter to them?
there is no balance requirement between the two P.

>
> --
> Mel Gorman
> SUSE Labs

Thanks
Barry
