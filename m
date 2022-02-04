Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9EB4A9804
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 11:49:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241130AbiBDKtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 05:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbiBDKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 05:49:32 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9363C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 02:49:31 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id d10so18131885eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 02:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3b5x+Tmnlj82Hd2UkZ0gpJKtxp2TsJeH6nAu5EKVtA=;
        b=lutCO0ID4JgFPg8B95/NGr8Q6Rg3bqBSSuEmQQdQkyHHjGCMffgEiZBaioQ79iObLj
         cclYJCXUwccK/NKg7LATro38ocYozIPuEHtqwE6ICu+uHCc1w9/dAAghulRKOM700AMj
         ZrHLADAA2tjujamVFDhDVH+XDm65UeK2oryK38P9Hourlm3PTD0miRCPFSjv13BpwCKP
         8Kn5QjpnbE28poIj3KjAbnjC5OVkIXesmM6d92KO3cRZa4cHZEg1h3FbSiqx2aVJkctc
         3czyWVeoPYeeIFUgL6OYGJ8sml0EA/KEa/DBBRB2YnPYaCBB7MoKuyxP6fuRP4FqEdGo
         qj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v3b5x+Tmnlj82Hd2UkZ0gpJKtxp2TsJeH6nAu5EKVtA=;
        b=eMOC62tsyB722aoC8VfkiQ6Od/hgizOSC3KXVmLrGOZaenns8OcN6912cEqrvgc2Qu
         Fb4hclgcTdyB0D5FJR1rLEPko2dAbKPiFrHGrySggwpb/pGtzvufUKc2GDT8wjlWdz+V
         lmCDrZHxJ2eJ0QkFWd55FFcsmDqXbOsxgJj9p/yKgg6ucC8D1xuWGJBj3n28YwI0fjcz
         oLFcwTy9iExO+/RYUNSJ+hVylDX6T1r62bB5mHiAquP9f9TGS4dCn4v4VuKXXIq9fsE2
         ldecDKnw1DmrAmjryIl8qsGFWHCQWRk2MMkGh9qfqAQ8TkYvMpIZPgnXOYXC6GC9eNyD
         oqTg==
X-Gm-Message-State: AOAM5311vmYFi6bHj5M66cAlCRFkbglZlgJxtzDfZNrMPP2E3EskktPH
        BGmnVNcRKqEYvpOCthZDxsUSJ0+6u260qcuhBGs=
X-Google-Smtp-Source: ABdhPJyb9TecWnFLhjsKcEyppiKvWeteUJNC9YejKUQCv6VR3ny+mnDfgXPjxt6Noy0oupfbKyxymZwUFSXlZXXQLio=
X-Received: by 2002:a17:907:72c3:: with SMTP id du3mr1980428ejc.457.1643971770270;
 Fri, 04 Feb 2022 02:49:30 -0800 (PST)
MIME-Version: 1.0
References: <20220126080947.4529-1-yangyicong@hisilicon.com>
 <20220126080947.4529-3-yangyicong@hisilicon.com> <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com> <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com> <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
In-Reply-To: <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 4 Feb 2022 23:49:17 +1300
Message-ID: <CAGsJ_4zVEjFYoff=x=Y3i9xPxoi891x-gkfA6Lsdc+yT2ykRmQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 4, 2022 at 11:28 PM Barry Song <21cnbao@gmail.com> wrote:
>
> On Fri, Feb 4, 2022 at 8:33 PM Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> >
> > * Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:
> >
> > > On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> > > <srikar@linux.vnet.ibm.com> wrote:
> > > >
> > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> > > >
> > > > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > >
> > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > > > >
> > > > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > > > <gautham.shenoy@amd.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang wrote:
> > > > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > > >
> > > > > I am sorry I didn't get your question. Currently the code works as below:
> > > > > if task A wakes up task B, and task A is in LLC0 and task B is in LLC1.
> > > > > we will scan the cluster of A before scanning the whole LLC0, in this case,
> > > > > cluster of A is the closest sibling, so it is the better choice than other CPUs
> > > > > which are in LLC0 but not in the cluster of A.
> > > >
> > > > Yes, this is right.
> > > >
> > > > > But we do scan all cpus of LLC0
> > > > > afterwards if we fail to find an idle CPU in the cluster.
> > > >
> > > > However my reading of the patch, before we can scan other clusters within
> > > > the LLC (aka LLC0), we have a check in scan cluster which says
> > > >
> > > >         /* Don't ping-pong tasks in and out cluster frequently */
> > > >         if (cpus_share_resources(target, prev_cpu))
> > > >            return target;
> > > >
> > > > My reading of this is, ignore other clusters (at this point, we know there
> > > > are no idle CPUs in this cluster. We don't know if there are idle cpus in
> > > > them or not) if the previous CPU and target CPU happen to be from the same
> > > > cluster. This effectively means we are given preference to cache over idle
> > > > CPU.
> > >
> > > Note we only ignore other cluster while prev_cpu and target are in same
> > > cluster. if the condition is false, we are not ignoring other cpus. typically,
> > > if waker is the target, and wakee is the prev_cpu, that means if they are
> > > already in one cluster, we don't stupidly spread them in select_idle_cpu() path
> > > as benchmark shows we are losing. so, yes, we are giving preference to
> > > cache over CPU.
> >
> > We already figured out that there are no idle CPUs in this cluster. So dont
> > we gain performance by picking a idle CPU/core in the neighbouring cluster.
> > If there are no idle CPU/core in the neighbouring cluster, then it does make
> > sense to fallback on the current cluster.
>
> What you suggested is exactly the approach we have tried at the first beginning
> during debugging. but we didn't gain performance according to benchmark, we
> were actually losing. that is why we added this line to stop ping-pong:
>          /* Don't ping-pong tasks in and out cluster frequently */
>          if (cpus_share_resources(target, prev_cpu))
>             return target;
>
> If we delete this, we are seeing a big loss of tbench while system
> load is medium
> and above.

While one system has a high load,  if we scan the neighbour clusters
after we fail to
get an idle cpu in the target. we can really successfully find an idle
cpu in neighbours
sometimes. There is no doubt of this. Our experiments have shown this is 100%
true. But the problem is that actually all cpus are very busy, so each
cpu gets a
very small idle time. After we migrate tasks to neighbours,  shortly
the neighbour
clusters will be full of tasks, then the neighbours might kick their
tasks out afterwards.
so we will see tasks move all around many clusters like monkeys, then we don't
gain performance.

>
> >
> > >
> > > >
> > > > Or Am I still missing something?
> > > >
> > > > >
> > > > > After a while, if the cluster of A gets an idle CPU and pulls B into the
> > > > > cluster, we prefer not pushing B out of the cluster of A again though
> > > > > there might be an idle CPU outside. as benchmark shows getting an
> > > > > idle CPU out of the cluster of A doesn't bring performance improvement
> > > > > but performance decreases as B might be getting in and getting out
> > > > > the cluster of A very frequently, then cache coherence ping-pong.
> > > > >
> > > >
> > > > The counter argument can be that Task A and Task B are related and were
> > > > running on the same cluster. But Load balancer moved Task B to a different
> > > > cluster. Now this check may cause them to continue to run on two different
> > > > clusters, even though the underlying load balance issues may have changed.
> > > >
> > > > No?
> > >
> > > LB is much slower than select_idle_cpu().  select_idle_cpu() can dynamically
> > > work afterwards. so it is always a dynamic balance and task migration.
> > >
> > > >
> > > >
> > > > --
> > > > Thanks and Regards
> > > > Srikar Dronamraju
> > >
> > > Thanks
> > > Barry
> >
> > --
>

Thanks
Barry
