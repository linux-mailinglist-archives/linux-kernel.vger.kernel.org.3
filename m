Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3C356D6FC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiGKHnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiGKHnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:43:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D116568;
        Mon, 11 Jul 2022 00:43:29 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id o12so2608935ljc.3;
        Mon, 11 Jul 2022 00:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6+Eje+BI4mgYWYNE16gkK8LI+X4SswO3LLw9Mljelro=;
        b=jcaIQZW81P74s1CpNAYO8N8l0GZfj7ayncDoX4MF8kXAAWbl4HvPSxXIfhr6A+3/nx
         O2ZTotadCJTDen2eFsibLo3TqpPkBw+NUjgBTB7Af8Mw7S5UftVGJMQSon7jl6ecbkgZ
         EQSw+JHmykzIY8For3YASqO7XzibR5TeF/gb8MClV4iPy86bXdZ9BFx+PW/7Z9s42sqT
         UZWwv9GJ8JC6+k1rOzTvSKIo2c52vAxnyYaRDOEmm+T7z48Lu9aSKMxmcz+TioEzGAN7
         UghtWSk4Ct41GfxY16+1v6eaTagFAp/21tzaJUNRtO4it+xNy+BXVBlybJynr583Msin
         pw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6+Eje+BI4mgYWYNE16gkK8LI+X4SswO3LLw9Mljelro=;
        b=c9mx3EgKZYvSVlSRIondbxnBTLWzH0gRlp9W12cCwVyOwQsW3BmIb+mlRPscujToyw
         VgOWzQ2OQoJORBT3JFuVrjBjt3AK1OHcZ1EZWTrKYfcLA2Crxu87ZOhqm1ZEC8rjHRKY
         2bTHHrkibChZsefr63sq5C4E04raXfz54L0u4yky58S7ShnCl8wec1rndk+X84QGimDD
         ip94TNBVUWpUMfcE9im/aXKLM8HEkJ8onu/laCPi+jIpk3JIIFIC+rwBUie2VSgtPyG5
         Mw2ecPJKFdXPz8NB7M6SiK+6PR8FpLcetQer/XNhBmATqevX97flQsGh228dDM4aHgmG
         XHHA==
X-Gm-Message-State: AJIora+BwqHYyKVhlKzCli7XQT46LNKebWAX/fd6K8OE4NEcQqUAHcbU
        E1omtcw9u2kc9IrWNrfmHx4BZQ4D9vw46XTatpQ=
X-Google-Smtp-Source: AGRyM1sWvpjgSJFW19NE3gcXq3cbOwxFZbvPtLSl2rdJY2M8qgy5upBrRLJTDyNwcyAnlw4QRDKk67ablDHOMGZeV7c=
X-Received: by 2002:a2e:bf20:0:b0:25a:45a6:7587 with SMTP id
 c32-20020a2ebf20000000b0025a45a67587mr9504164ljr.377.1657525408206; Mon, 11
 Jul 2022 00:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220705123705.764-1-xuewen.yan@unisoc.com> <CAB8ipk8w1=cMJV2_ZjWuX6T9RH9VXCMdUaZhLEkCziarhpy-5w@mail.gmail.com>
 <9ade9d43-3ed1-1239-f26e-73145856275a@arm.com>
In-Reply-To: <9ade9d43-3ed1-1239-f26e-73145856275a@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 11 Jul 2022 15:43:17 +0800
Message-ID: <CAB8ipk_Y5vaUMnRQVJsbHUue_J00qqy0E1ifu3W_hFSspL1r1w@mail.gmail.com>
Subject: Re: [PATCH] sched/schedutil: Fix deadlock between cpuset and cpu
 hotplug when using schedutil
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org,
        ke.wang@unisoc.com, xuewyan@foxmail.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 3:32 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Xuewen,
>
> On 7/11/22 08:21, Xuewen Yan wrote:
> > Hi all
> >
> > This deadlock is inevitable, any comment?
>
> Could you tell me how to reproduce this?
> Is there a need of special cgroup setup?

This deadlock occurs when we run the monkey test on an Android phone,
at the same time, randomly put online or offline a cpu core.
Indeed the thread-A which get the cgroup_threadgroup_rwsem and waiting
for the cpu_hotplug_lock is the thread whose name is "OomAdjuster" in
android.

And I see the cpu_hotplug_lock is added by the patch:
https://lore.kernel.org/all/20220121101210.84926-1-zhangqiao22@huawei.com/

Thanks!

>
> Regards,
> Lukasz
