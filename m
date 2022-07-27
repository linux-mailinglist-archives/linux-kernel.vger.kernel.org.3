Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A2F58201C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiG0GaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0GaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:30:22 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA3C65D8
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:30:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so618671wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zq7afk5A7HkmolT7QcoisXy9IsqmfDH71CJs0dnz+0=;
        b=AkMigeY4Ahszuc2dT84B6RxFBcZu5T/wyMxU86ePs6tT9k+mnqaRDW0Ka/3kc8cDBf
         qWegsbmQW3OcyOiQWgaBw2MhKRWTP6nUFwu8pTD8jxOYJsw5TpjzweBPfFE5D3nBJaEz
         5zRaCFCrQV2TKir/xC9HYHeNKa52cr8swn6nrMaFy+QPqgTh01XYbAfwjYZyUnUNdhdf
         K2KUNaDtLn1tQzT8w3NxMT0RgQDqbjM9oEBuY0ODJFuWxgRNEKHEprcmNPZZglm5R4+1
         37CsmW9Z0JV9yT0zfYr18VlRM5Zjb7fXIpu7WYgvNjDyq+0o59FCKdm9GkA6nijkJ44F
         7ZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zq7afk5A7HkmolT7QcoisXy9IsqmfDH71CJs0dnz+0=;
        b=h8LtPsWimoqDxwUKEOdNnIhk0W0SgpByVLDnia74aJE+VeEaON14HVk+HAa5dq+ZXh
         YSBcW1GbJnm9B+XJ+XX2P2oyN3mTN+TxtE0Xhgv+8wZWNGlL9iB8M5ADgtLXVsuw0o5F
         Rae4CBQ33REb1g4a3WOwoqo5c4P7sADONuozMr67kQL9SUa4hqm5eXnjHBZvZyoCTKt+
         TnrVZjknTq8xaq5WXZY9zJqyjDthRRQhL4gFYf+VQRCJTgcnHWxPu8uCNfioTm7WEe+D
         MJsDzKJ77Rxp8c8MG4YEhsY+jYq+y3FJm4KuCB+eU5x1V7BKSHCuntC19ncKvANQ+3DV
         BUfA==
X-Gm-Message-State: AJIora+Bj/OelD0M9OMrqzAjJABDR9pYQXb48oYNv//2AwLKQTT8pPzP
        xrZmzTBM+9C4QRC0f59IEbsQI3uDFHBw0j8HDDc=
X-Google-Smtp-Source: AGRyM1uezH6asFohOD/K6ZCMIKseZ+4x+VJI1PyICogiJEsAzFnMFLNyAsWf51drOl3SI4Foy3oywv32F45VLpiaSjQ=
X-Received: by 2002:a05:600c:2287:b0:3a3:5333:8bce with SMTP id
 7-20020a05600c228700b003a353338bcemr1792272wmf.153.1658903419109; Tue, 26 Jul
 2022 23:30:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165743.3409313-1-vschneid@redhat.com> <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb> <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb> <YuAkroXHF+Zg45KU@slm.duckdns.org>
 <xhsmhmtcvehmx.mognet@vschneid.remote.csb> <CAJhGHyA3gRmL=VCq2TAcc+TgBHCAizADJeukNRGmisa29U969g@mail.gmail.com>
In-Reply-To: <CAJhGHyA3gRmL=VCq2TAcc+TgBHCAizADJeukNRGmisa29U969g@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 27 Jul 2022 14:30:07 +0800
Message-ID: <CAJhGHyAEHFbcqzVbBRHoFcRYJ+M9cf87WwV2u=V4=Acrgp-gkQ@mail.gmail.com>
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

On Wed, Jul 27, 2022 at 1:38 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Wed, Jul 27, 2022 at 4:36 AM Valentin Schneider <vschneid@redhat.com> wrote:
> >
> > On 26/07/22 07:30, Tejun Heo wrote:
> > > Hello,
> > >
> > > On Mon, Jul 25, 2022 at 11:21:37AM +0100, Valentin Schneider wrote:
> > >> Hm so my choice of words in the changelog wasn't great - "initial setup"
> > >> can be kernel init, but *also* setup of whatever workload is being deployed
> > >> onto the system.
> > >>
> > >> So you can be having "normal" background activity (I've seen some IRQs end
> > >> up with schedule_work() on isolated CPUs, they're not moved away at boot
> > >> time but rather shortly before launching the latency-sensitive app), some
> > >> preliminary stats collection / setup to make sure the CPU will be quiet
> > >> (e.g. refresh_vm_stats()), and *then* the application starts with
> > >> fresh-but-no-longer-required extra pcpu kworkers assigned to its CPU.
> > >
> > > Ah, I see. I guess we'll need to figure out how to unbind the workers then.
> > >
> >
> > I've been playing with different ways to unbind & wake the workers in a
> > sleepable context, but so far I haven't been happy with any of my
> > experiments.
>
>
> I'm writing code to handle the problems of cpu affinity and prematurely
> waking up of newly created worker.
>
> This work of unbinding the dying worker is also on the list.
> I haven't figured out a good solution.
>
> I was planning to add set_cpus_allowed_ptr_off_rq() which only set
> cpumasks to the task only if it is sleeping and returns -EBUSY otherwise.
> And it is ensured and documented as being usable in an atomic context
> and it is recommended to be used for dying tasks only.
>
> I can't really ensure it would be implemented as I'm expecting since
> it touches scheduler code.
>
> I'd better back off.
>
> >
> > What hasn't changed much between my attempts is transferring to-be-destroyed
> > kworkers from their pool->idle_list to a reaper_list which is walked by
> > *something* that does unbind+wakeup. AFAIA as long as the kworker is off
> > the pool->idle_list we can play with it (i.e. unbind+wake) off the
> > pool->lock.
> >
> > It's the *something* that's annoying to get right, I don't want it to be
> > overly complicated given most users are probably not impacted by what I'm
> > trying to fix, but I'm getting the feeling it should still be a per-pool
> > kthread. I toyed with a single reaper kthread but a central synchronization
> > for all the pools feels like a stupid overhead.
>
> I think fixing it in the workqueue.c is complicated.
>
> Nevertheless, I will also try to fix it inside workqueue only to see
> what will come up.

I'm going to kind of revert 3347fc9f36e7 ("workqueue: destroy worker
directly in the idle timeout handler"), so that we can have a sleepable
destroy_worker().

>
> >
> > If any of that sounds ludicrous please shout, otherwise I'm going to keep
> > tinkering :)
> >
> > > Thanks.
> > >
> > > --
> > > tejun
> >
