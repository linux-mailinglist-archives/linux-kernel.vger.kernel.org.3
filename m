Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7394AAD2E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 01:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347433AbiBFA0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 19:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBFA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 19:26:30 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65C6C061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 16:26:28 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id s13so31011421ejy.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 16:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QomwG8aKVU6gZfNh33WY4knCAq7doZFqpgAkZRU7DKE=;
        b=TqfCXlCrF5np6P+9RVE7A4t95MezAf6PXyBfvqkG3WH0Y2LhYUhQ7xZU348M2EQwXo
         yph9JsnbiwOeLU+optgxJYZKCU98C4ivEaX1qyXpN2zVHV2SiNdlLDXa4iOHv3ZWjPDj
         08moA1MuwkCErVctRdsek+vT96pvnXMxcNB/1bLZKLKZxLeWSwlv4ZSsfblgBHZ/znNP
         3kT06B8xNBLv0jA62SGeVlLv1IZvAY/0bdlrOZ7tb6zkQoids/z94gVuuT0GRtexh1na
         +y/vby2S01aMQf4tfoodjfDfO2UQpT8s1wJC8fHgJ3YRsAm7C3qLm3T9Q/D6wVqSJsOg
         m7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QomwG8aKVU6gZfNh33WY4knCAq7doZFqpgAkZRU7DKE=;
        b=qxg2h2Iw3jm/JA0iWR49RvDOGtp3lpZpv0rCnIuL3FbKDmfw7Mv28ew3zYW+UDSg6L
         YjoZG4Y3qsfcoTJRaIMqMWZ0vkvYeA796eTYUZLM8ReBnpv1ctYx+jAs0tsNnfe7xOb1
         U3IlloI9h+oXxTmRUo4WxPZZwXFAB8UEvP5prlIKDjEG6QUI26c32IBeTfSldfWWZaYa
         ujtyIid93LEEBfQEjhC7bm2mpdc18ndl4n8GTof/tPTp7gevHhgeAtiMCCaBclniRfv/
         BxS/GAWuV2BqgmTD3VH5APym3Rn1IIMgMz6nRlbenmdL4x7FXeVPH1HGN7XBI5G+jU1V
         XxOw==
X-Gm-Message-State: AOAM533tdjAKBPHuzgAnsyip56QDSWZVVFuzHb+DOowQruO8i8/2zetT
        Nxw8UO/2r0USEZJscuzEStvhYUhaSLOsVRh7dJs=
X-Google-Smtp-Source: ABdhPJxmUgrGEUgO1Tc5DTPebOU/NsqNqOt5UuHP2/OCgWaT1XXHg9aOz+b4C19fq5Zex6GNxhn7SCNYz4YnCvziaEc=
X-Received: by 2002:a17:907:1115:: with SMTP id qu21mr2401621ejb.192.1644107187128;
 Sat, 05 Feb 2022 16:26:27 -0800 (PST)
MIME-Version: 1.0
References: <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com> <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com> <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com> <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com> <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
 <CAGsJ_4zVEjFYoff=x=Y3i9xPxoi891x-gkfA6Lsdc+yT2ykRmQ@mail.gmail.com>
 <88e9287ef7a86f24999af00f90d6f122de024979.camel@linux.intel.com> <20220205171647.GA567616@chenyu-desktop>
In-Reply-To: <20220205171647.GA567616@chenyu-desktop>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 6 Feb 2022 13:26:15 +1300
Message-ID: <CAGsJ_4wEGEXTSByOiifjcXB_hm4phd7C-z-jmAf9JfoxYgm8gQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 6, 2022 at 6:16 AM Chen Yu <yu.c.chen@intel.com> wrote:
>
> On Fri, Feb 04, 2022 at 09:41:21AM -0800, Tim Chen wrote:
> > On Fri, 2022-02-04 at 23:49 +1300, Barry Song wrote:
> > > On Fri, Feb 4, 2022 at 11:28 PM Barry Song <21cnbao@gmail.com> wrote:
> > > > On Fri, Feb 4, 2022 at 8:33 PM Srikar Dronamraju
> > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > * Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:
> > > > >
> > > > > > On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> > > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> > > > > > >
> > > > > > > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > > > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > > > > > > >
> > > > > > > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > > > > > > <gautham.shenoy@amd.com> wrote:
> > > > > > > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang
> > > > > > > > > > > wrote:
> > > > > > > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > > > > > >
> > > > > > > > I am sorry I didn't get your question. Currently the code
> > > > > > > > works as below:
> > > > > > > > if task A wakes up task B, and task A is in LLC0 and task B
> > > > > > > > is in LLC1.
> > > > > > > > we will scan the cluster of A before scanning the whole
> > > > > > > > LLC0, in this case,
> > > > > > > > cluster of A is the closest sibling, so it is the better
> > > > > > > > choice than other CPUs
> > > > > > > > which are in LLC0 but not in the cluster of A.
> > > > > > >
> > > > > > > Yes, this is right.
> > > > > > >
> > > > > > > > But we do scan all cpus of LLC0
> > > > > > > > afterwards if we fail to find an idle CPU in the cluster.
> > > > > > >
> > > > > > > However my reading of the patch, before we can scan other
> > > > > > > clusters within
> > > > > > > the LLC (aka LLC0), we have a check in scan cluster which
> > > > > > > says
> > > > > > >
> > > > > > >         /* Don't ping-pong tasks in and out cluster
> > > > > > > frequently */
> > > > > > >         if (cpus_share_resources(target, prev_cpu))
> > > > > > >            return target;
> > > > > > >
> > > > > > > My reading of this is, ignore other clusters (at this point,
> > > > > > > we know there
> > > > > > > are no idle CPUs in this cluster. We don't know if there are
> > > > > > > idle cpus in
> > > > > > > them or not) if the previous CPU and target CPU happen to be
> > > > > > > from the same
> > > > > > > cluster. This effectively means we are given preference to
> > > > > > > cache over idle
> > > > > > > CPU.
> > > > > >
> > > > > > Note we only ignore other cluster while prev_cpu and target are
> > > > > > in same
> > > > > > cluster. if the condition is false, we are not ignoring other
> > > > > > cpus. typically,
> > > > > > if waker is the target, and wakee is the prev_cpu, that means
> > > > > > if they are
> > > > > > already in one cluster, we don't stupidly spread them in
> > > > > > select_idle_cpu() path
> > > > > > as benchmark shows we are losing. so, yes, we are giving
> > > > > > preference to
> > > > > > cache over CPU.
> > > > >
> > > > > We already figured out that there are no idle CPUs in this
> > > > > cluster. So dont
> > > > > we gain performance by picking a idle CPU/core in the
> > > > > neighbouring cluster.
> > > > > If there are no idle CPU/core in the neighbouring cluster, then
> > > > > it does make
> > > > > sense to fallback on the current cluster.
> > > >
> > > >
> >
> > We may need to take into consideration the utilization and
> > load average for the source and target cluster to make
> > better decision of whether it is worth placing the
> > task in the next cluster.  If the load of the target
> > cluster is too high, it is not worth pushing the task there.
> >
> > Those stats can be gathered during load balancing without adding
> > overhead in the hot task wakeup path.
> >
> > Chen Yu played around with cutting off the idle CPU search
> > in a LLC based on such stats and he saw some good
> > improvements over the default.
> >
> Yes, we used the sum of percpu util_avg to estimate if the LLC domain
> is overloaded. If it is too busy, skip searching for an idle cpu/core in
> that LLC domain. The util_avg is a metric of accumulated historic
> activity, which might be more accurate than instantaneous metrics(such as
> rq->nr_running) on calculating the probability of find an idle cpu.
> So far this change has shown some benefits in several microbenchmarks and
> OLTP benchmark when the system is quite busy. That change has introduced a
> per-LLC-domain flag to indicate whether the LLC domain is oveloaded,
> it seems that this flag could also be extended for cluster domain.
> Maybe I could post the draft patch to see if it would be helpful for this
> cluster patch serie.

yes. please send. my feeling is that select_idle_cpu() can select an "idle"cpu
which is actually very busy, but can be in "idle" state for a very
short period. it
is not always correct to get this kind of "idle" cpu. It could be
better to be still.
I am not quite sure your patch is directly related with clusters, but we will
try to figure out some connection, maybe we can integrate your patch into
this series afterwards.

>
> thanks,
> Chenyu
> > Tim
> >

Thanks
Barry
