Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B0581F93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbiG0FjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiG0FjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:39:04 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E2073B95B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:39:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id x23-20020a05600c179700b003a30e3e7989so449129wmo.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 22:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMameTnBAoiarUgSLVWyT4MKNj8tsJRNE7nQMvYzCBM=;
        b=SFXy23Rf+rLEeDnruHAsTdl4Jh/zlg6QJfcdGhSUQk/AKIsHuHBpUPlByPTjyNxfJL
         AEQB6WKOteYpWeA+awAy3xX2nJfrazfT9wEqrn1vyPf5oHXSh+J8vLuI4OGjSNTl4eb7
         46wY/RU3z3y30ZQBqDP/hrOo4lgoFDAlCd8v6e/ihbtKtzFp8Rz5W30m/1aBepODvth4
         brSgvJvnvUheCwFj43+d6aN4PdBO9QGZcXITMG80BH56M13mtjwdFf0rOuT1jhNHJ9i6
         +IvwdsO82VoVD0nZnteatM1K1nLUKjBziD944NNCulUvtCelqfcqXLtax4GYfFewZdcB
         TnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMameTnBAoiarUgSLVWyT4MKNj8tsJRNE7nQMvYzCBM=;
        b=ViP00sEhazGNpUJSwPkv36E/L4uIG9vwLika3ZyjebyogO4BhjiOQ9qf3x9ucFC1e+
         7UCdMDrjIcvveAYpnNpkoMen9o1PB2x6plJA6U4WO3Ine5a4A405Ud8VxaZvftGtxPLB
         fElNeS+jbs5+8qw9akE/J4CAmeoAsU8wvPpP+fnLec5hjr83M2UpLlgIdqy5EZKOL/S7
         7Fk8J0PYNPC1w1UNPJkmdhb8Drawg+5fwOvzsLIRkZ7XnpXkY7dRmSMKKS6aDSB9Z3Zw
         /+TtqgYrsNya9yDRjKpYlDCbY0XUWQ3sceLUDYSU49hWi6I8ON9JfgSPLXrO9IK+w8qW
         Vclg==
X-Gm-Message-State: AJIora9+7oxo5QSXp4EIHlI+qOnVQ+ICcQkXG2GhuIZTs+UlIgNIr25C
        qnZ5tyn/+npkG3vw3QV1lEajIkzaoLj13QfgCRU=
X-Google-Smtp-Source: AGRyM1s5tSKLfbal5GKlMJM1vwOqClRei2VKGwzNzkFdAy6Nlez8VmOgcLvUPmivlo8VaGlB8z1qtXricmb/puWoUkE=
X-Received: by 2002:a05:600c:3847:b0:3a3:5333:8bcd with SMTP id
 s7-20020a05600c384700b003a353338bcdmr1632919wmr.36.1658900341745; Tue, 26 Jul
 2022 22:39:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165743.3409313-1-vschneid@redhat.com> <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb> <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb> <YuAkroXHF+Zg45KU@slm.duckdns.org> <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhmtcvehmx.mognet@vschneid.remote.csb>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 27 Jul 2022 13:38:49 +0800
Message-ID: <CAJhGHyA3gRmL=VCq2TAcc+TgBHCAizADJeukNRGmisa29U969g@mail.gmail.com>
Subject: Re: [RFC PATCH] workqueue: Unbind workers before sending them to exit()
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 4:36 AM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 26/07/22 07:30, Tejun Heo wrote:
> > Hello,
> >
> > On Mon, Jul 25, 2022 at 11:21:37AM +0100, Valentin Schneider wrote:
> >> Hm so my choice of words in the changelog wasn't great - "initial setup"
> >> can be kernel init, but *also* setup of whatever workload is being deployed
> >> onto the system.
> >>
> >> So you can be having "normal" background activity (I've seen some IRQs end
> >> up with schedule_work() on isolated CPUs, they're not moved away at boot
> >> time but rather shortly before launching the latency-sensitive app), some
> >> preliminary stats collection / setup to make sure the CPU will be quiet
> >> (e.g. refresh_vm_stats()), and *then* the application starts with
> >> fresh-but-no-longer-required extra pcpu kworkers assigned to its CPU.
> >
> > Ah, I see. I guess we'll need to figure out how to unbind the workers then.
> >
>
> I've been playing with different ways to unbind & wake the workers in a
> sleepable context, but so far I haven't been happy with any of my
> experiments.


I'm writing code to handle the problems of cpu affinity and prematurely
waking up of newly created worker.

This work of unbinding the dying worker is also on the list.
I haven't figured out a good solution.

I was planning to add set_cpus_allowed_ptr_off_rq() which only set
cpumasks to the task only if it is sleeping and returns -EBUSY otherwise.
And it is ensured and documented as being usable in an atomic context
and it is recommended to be used for dying tasks only.

I can't really ensure it would be implemented as I'm expecting since
it touches scheduler code.

I'd better back off.

>
> What hasn't changed much between my attempts is transferring to-be-destroyed
> kworkers from their pool->idle_list to a reaper_list which is walked by
> *something* that does unbind+wakeup. AFAIA as long as the kworker is off
> the pool->idle_list we can play with it (i.e. unbind+wake) off the
> pool->lock.
>
> It's the *something* that's annoying to get right, I don't want it to be
> overly complicated given most users are probably not impacted by what I'm
> trying to fix, but I'm getting the feeling it should still be a per-pool
> kthread. I toyed with a single reaper kthread but a central synchronization
> for all the pools feels like a stupid overhead.

I think fixing it in the workqueue.c is complicated.

Nevertheless, I will also try to fix it inside workqueue only to see
what will come up.

>
> If any of that sounds ludicrous please shout, otherwise I'm going to keep
> tinkering :)
>
> > Thanks.
> >
> > --
> > tejun
>
