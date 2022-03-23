Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7480D4E513B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 12:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243871AbiCWLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 07:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243866AbiCWLW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:22:56 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFA37893C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:21:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bi12so2174323ejb.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 04:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q428jPB3LI7YHZ1TPk4eUv6mjfb7Ccik6IuwbzunlN8=;
        b=qk78RGmu57m+WoTO9wCDpvaz8ymit5RglIS5kWuFOL3VPbzAb56W2jFcujjmoJ/UGs
         3EMPCUm15+UV7uYDmswOYIvQIRmiOmXioXyrRkhAZgoLMXbJ+zsL9cKQLdgUtLWFtVkT
         Z3S+uVKDof7qiuUWrur20pLRxaVjPJzXAaT9Emz+jj9qoCBPt4uM9eUeb0J27HVnDGdm
         aPrDDx/gd+JHrEaI5SEKc48yhCncdM2nrlC5X/9w4AU/s8nHQ0fGcvwlLyX0/6ayhbNl
         T6vs+W+6SaJZP90z0JVLIAefcdVL2wcfO6TlH6LbtjOol8X4VugVItB/ReHWiQtK6JrY
         hVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q428jPB3LI7YHZ1TPk4eUv6mjfb7Ccik6IuwbzunlN8=;
        b=WFM7XRbKB3fGaWa2Zk+Z1jD/U+SwGy8SC+XEGqZqVxXze9KjVYFlVaZaHJXfzYTOZ9
         DJEDQifVddR3MiD8cT5Zn1wSseX0dMk8ETnzzR2S1M8/ZXuraRTSMrGFUFT2Qqqm/e0E
         mYOH+GuJ00ccbbT5QrmADEKLSCA0fsSkAHSxiGxHCFh5/kaFiqv61WX/ZcEnLjleUN/W
         bv/M4ESGvE2rOCOQaCYvht6X0xl/jP0lt18Mbxr6MqfEkiIwu9mGtSeZf5NbMoOHdy+W
         dr/ZqHukByQNaJIrodrGJrAhmoPw1UQQXJ0V80RmSJCzFxazeyLB3072mkKLs05G1MoL
         rKog==
X-Gm-Message-State: AOAM532GBooFbghwJzF5skBtwbJ/HnJIh0InBLGeKuVF/Z2D2pFvO2vy
        dMECYqixGDto0v0xMbU0jCLFZ5hr2E0i0KCku/MI
X-Google-Smtp-Source: ABdhPJyeZxP1pcZPz6bj3JhcI1N6gvpSUjdNdladDO5oGiHAiqqYZoRaKWuZ9Ngs5Pq/FT2Q6BrtFvuDlEhpUxtD9Gs=
X-Received: by 2002:a17:907:6e09:b0:6e0:6bd1:ab5a with SMTP id
 sd9-20020a1709076e0900b006e06bd1ab5amr1173845ejc.622.1648034484978; Wed, 23
 Mar 2022 04:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <YjotekJZcSvwoZhp@localhost.localdomain>
In-Reply-To: <YjotekJZcSvwoZhp@localhost.localdomain>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 23 Mar 2022 19:21:25 +0800
Message-ID: <CACycT3vz4hYTFpHo0Jphs-xE-k--y63+vedTFAaDRWhpi4_5rg@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 4:11 AM Josef Bacik <josef@toxicpanda.com> wrote:
>
> On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > The rescuer thread might take over the works queued on
> > the workqueue when the worker thread creation timed out.
> > If this happens, we have no chance to create multiple
> > recv threads which causes I/O hung on this nbd device.
> >
> > To fix it, we can not simply remove the WQ_MEM_RECLAIM
> > flag since the recv work is in the memory reclaim path.
> > So this patch tries to create kthreads directly to
> > handle the recv work instead of using workqueue.
> >
>
> I still don't understand why we can't drop WQ_MEM_RECLAIM.  IIRC your argument
> is that we need it because a reconnect could happen under memory pressure and we
> need to be able to queue work for that.  However your code makes it so we're
> just doing a kthread_create(), which isn't coming out of some emergency pool, so
> it's just as likely to fail as a !WQ_MEM_RECLAIM workqueue.  Thanks,
>

I think the key point is the context in which the work thread is
created. It's the context of the nbd process if using kthread_create()
to create a workthread (might do some allocation). Then we can benefit
from the PR_SET_IO_FLUSHER flag, so memory reclaim would never hit the
page cache on the nbd device. But using queue_work() to create a
workthread, the actual thread creation happens in the context of the
work thread rather than the nbd process, so we can't rely on the
PR_SET_IO_FLUSHER flag to avoid deadlock.

Thanks,
Yongji
