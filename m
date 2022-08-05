Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2018258A4CF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 04:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbiHECnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 22:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiHECnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 22:43:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A328706
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 19:43:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j4-20020a05600c1c0400b003a4f287418bso689268wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Ug9GaLVEzDKr8E/2pbg7eoP8pI50jU0zb4+GtKdpINA=;
        b=Q/CDJkVw5fS91ErUrwrb/JeKUFALovqcph1hUhIxY9IRbbMGyu885Suo790fezkv+r
         T0z4lVSQsdVU4m3SWURgbgyCnt1HXgKreBgcAEiSxtiXodczJ/2BGu/LhgC2v6oBgJdW
         IlZ7qqQW3nLNRsYSHZw/Kx/nms1rTNCJdBtQxgLDATBztaCEvwBQe0lKEmdIrTqBpMyH
         OrcDfmluGDAc5+bWSLJasjJHaNSRf4jFOxGDOIAmet+xuUNaZjNBmQOpLEzxfqekLGzq
         B5tPiNrcDyVsTWpyj62yntzyMPDKJ16YWrnQ5KsPAEoK/3hTrDxZRlDHYxhzQCcp8AQB
         UviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Ug9GaLVEzDKr8E/2pbg7eoP8pI50jU0zb4+GtKdpINA=;
        b=TJ6JkZPEGmkKCOR68w60+0DJ4qO+EieJLCmLaJxd9wg+q1P6BVencN1LxZcdutn0+o
         tu31ys3eDGuJGNOnyO5rWZ9uIKSlo1QG52C/DDgCsTKxkRv15wQxLyakfohb6kIZa5fI
         YaZ091MQ+JR1FR2Mumw+yaWSVB6RYFgE/Ex6e9BRZ/Dr8iFhELdyOiNixbViluKY+kbr
         vRSxO2IyR0wOtuIgzxn7ceLkjw8mt9sbvJVCeS9mVqTkjBGeuufUktX5HhWuM8OMYkCE
         cZtyPV2pQFBON3ZFxj0Xgs2/I9gJcfnbB60QjTwijfEIAf/QQhcazItyc0qFguy232RA
         iEFQ==
X-Gm-Message-State: ACgBeo0L8Lf1zXenS4FZJIgRMFXRGHAR9HEHPUbxZt2Y9I4EYZ1yfMrf
        +yXDpoObdV+hslbZTLYnigjQFJJ6qLyVMhqje7H1cB2BKl8=
X-Google-Smtp-Source: AA6agR52bImRK81rDFd4woDrTGPtOnkaX7UzqkjeMU/nmPuGoDFvfk7y/ylKi6tnTpjnHoSvPGCgXL7hJiHMi8fcL+k=
X-Received: by 2002:a7b:cb55:0:b0:3a5:41a:829c with SMTP id
 v21-20020a7bcb55000000b003a5041a829cmr5544307wmj.153.1659667398770; Thu, 04
 Aug 2022 19:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220802084146.3922640-1-vschneid@redhat.com> <20220802084146.3922640-2-vschneid@redhat.com>
 <c13c3fb4-4936-a5fd-cd28-1136d07d5f54@gmail.com> <xhsmhh72sck4a.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmhh72sck4a.mognet@vschneid.remote.csb>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 5 Aug 2022 10:43:07 +0800
Message-ID: <CAJhGHyA2Qz+6a9f25uWxUUG8znFyacPuP6AmvpQWam6d3u1a5g@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/3] workqueue: Hold wq_pool_mutex while affining
 tasks to wq_unbound_cpumask
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
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

On Thu, Aug 4, 2022 at 7:40 PM Valentin Schneider <vschneid@redhat.com> wrote:
>
> On 03/08/22 11:40, Lai Jiangshan wrote:
> > On 2022/8/2 16:41, Valentin Schneider wrote:
> >> When unbind_workers() reads wq_unbound_cpumask to set the affinity of
> >> freshly-unbound kworkers, it only holds wq_pool_attach_mutex. This isn't
> >> sufficient as wq_unbound_cpumask is only protected by wq_pool_mutex.
> >>
> >> This is made more obvious as of recent commit
> >>
> >>    46a4d679ef88 ("workqueue: Avoid a false warning in unbind_workers()")
> >>
> >> e.g.
> >>
> >> unbind_workers()                             workqueue_set_unbound_cpumask()
> >>    kthread_set_per_cpu(p, -1);
> >>    if (cpumask_intersects(wq_unbound_cpumask, cpu_active_mask))
> >>                                             cpumask_copy(wq_unbound_cpumask, cpumask);
> >>      WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, wq_unbound_cpumask) < 0);
> >>
> >> Make workqueue_offline_cpu() invoke unbind_workers() with wq_pool_mutex
> >> held.
> >
> > I would prefer to protect wq_unbound_cpumask with wq_pool_attach_mutex.
>
> That looks alright to me, do you want to push that separately as it's a
> standalone patch, or should I carry it with this series?
>

I'm Okay with both.

It needs review from Tejun.  If Tejun has not queued it before you send
a new update of this series, I will be glad if you carry it.
