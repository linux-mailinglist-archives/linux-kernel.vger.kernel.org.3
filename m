Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3FB582288
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiG0IzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiG0IzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:55:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C262DF15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:55:22 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so788314wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRQoZkjmZfE8O1djY2QjyYMX/NSZIdmEZDkQG5Rmd1w=;
        b=iepyriGyNUPsmkTZkmH1AwbRQX8bIMMCJ/QFJDjCqt5hqUj0vS2FJUi0Py7oxN0+ok
         VIVbCVdA4sBd4ESGffkLW8XrntYoLwrT3e0e1tmEZ2KHKUinxmHKTd6oZv81fAE4fS7L
         bjyQx2IrISfFV/et8oKcTj4tdpYE3sO6U+XqqMNK5w2ZxeDj06v+6fC5V5klZstqvnUv
         u2KlPgOl8UWfJArPpo1pMPwtiKLEYB9jpDsFpWzlwEambbk8eSXaobbekopPC53ucSge
         p6/soybS2HOyrLuoyRbrPX/JshxS2LBEVLK4wg1eKXl1Lh32GFCKGyHmyUFI39sQ432k
         TScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRQoZkjmZfE8O1djY2QjyYMX/NSZIdmEZDkQG5Rmd1w=;
        b=foU08DMA3D3ujUUi/RFqPn86M06ljY8W3LE6Th+ETp3ClnO/nZ1v1fV7o51ECvX7K8
         kpd/UWqvjrk8Js5qz0pDKDkW91u1lsJy5Mvto+CpYhjErrpyxPCoMiUHxHl6KBsYaK/E
         3g9Z3pdifMmeaXs6dGHXmo63IZDqykfjLxflqlYi82BaI+plnFQoyDj3a4l2tGLZGS2+
         eOYLgglez1+jBCYQmqiWcJKDtXohYyybi9qNdOUE7xfiJC4B6A5ohrnJxrz1d/k+3Jze
         UGCJxQOHgfIqpaaAUne2aJzDiIi3WxShYeczE0wRQoHvZW0k4yQF63Mh5F9T1ckdkYJ5
         W/3A==
X-Gm-Message-State: AJIora/vm9i7iu8rc0CEB3QjNo/vE7/FQL1ojhLWkv+Ry1h6uncA8EKK
        LMRDEQtN+0GTRXGGICtkd45X+4EJLCV5hpBWLO0RJuxiwDQ=
X-Google-Smtp-Source: AGRyM1tAbJ1YH+Z4wrN3swlFnKyKkYaN9Bue3vcom2q/uMl1btPBi2aGMbZtrhi5+kEPaOHG513oZuISb6VpcdqlHJE=
X-Received: by 2002:a05:600c:1c9d:b0:3a3:2631:2fcb with SMTP id
 k29-20020a05600c1c9d00b003a326312fcbmr2236621wms.161.1658912121021; Wed, 27
 Jul 2022 01:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220719165743.3409313-1-vschneid@redhat.com> <YthDjPq3CtWc+o0/@slm.duckdns.org>
 <CAJhGHyAso+JH+QMXcfKTyOqq4yBD9Vc19sBbebEXohHe5znL8Q@mail.gmail.com>
 <xhsmhv8rqfu6w.mognet@vschneid.remote.csb> <YtuEJLDkO/lATYeb@slm.duckdns.org>
 <xhsmh8rohfq6m.mognet@vschneid.remote.csb> <YuAkroXHF+Zg45KU@slm.duckdns.org>
 <xhsmhmtcvehmx.mognet@vschneid.remote.csb> <CAJhGHyA3gRmL=VCq2TAcc+TgBHCAizADJeukNRGmisa29U969g@mail.gmail.com>
 <CAJhGHyAEHFbcqzVbBRHoFcRYJ+M9cf87WwV2u=V4=Acrgp-gkQ@mail.gmail.com>
In-Reply-To: <CAJhGHyAEHFbcqzVbBRHoFcRYJ+M9cf87WwV2u=V4=Acrgp-gkQ@mail.gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Wed, 27 Jul 2022 16:55:09 +0800
Message-ID: <CAJhGHyDQ537NatcsTFAsTz=pKadnCtTYfvK_tXE=Z5oRp5FQyA@mail.gmail.com>
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

On Wed, Jul 27, 2022 at 2:30 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> >
> > >
> > > What hasn't changed much between my attempts is transferring to-be-destroyed
> > > kworkers from their pool->idle_list to a reaper_list which is walked by
> > > *something* that does unbind+wakeup. AFAIA as long as the kworker is off
> > > the pool->idle_list we can play with it (i.e. unbind+wake) off the
> > > pool->lock.
> > >
> > > It's the *something* that's annoying to get right, I don't want it to be
> > > overly complicated given most users are probably not impacted by what I'm
> > > trying to fix, but I'm getting the feeling it should still be a per-pool
> > > kthread. I toyed with a single reaper kthread but a central synchronization
> > > for all the pools feels like a stupid overhead.
> >
> > I think fixing it in the workqueue.c is complicated.
> >
> > Nevertheless, I will also try to fix it inside workqueue only to see
> > what will come up.
>
> I'm going to kind of revert 3347fc9f36e7 ("workqueue: destroy worker
> directly in the idle timeout handler"), so that we can have a sleepable
> destroy_worker().
>

It is not a good idea.  The woken up manager might still be in
the isolated CPU.

On Wed, Jul 27, 2022 at 6:59 AM Tejun Heo <tj@kernel.org> wrote:
>
> I mean, whatever works works but let's please keep it as minimal as
> possible. Why does it need dedicated kthreads in the first place? Wouldn't
> scheduling an unbound work item work just as well?
>

Scheduling an unbound work item will work well.
