Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B9052BF35
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 18:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239771AbiERPzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbiERPzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:55:38 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F401D2FD9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:55:21 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id i23so3056770ljb.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LXB4PHczyG5oHbe4vyBbwBDKCH3Ytd8BOKpXNaIHy/k=;
        b=gTS4Ecx+KLnnH6CNoxgXoCl89JPbHcE197bOKVAl41bInBLS/kMF81zwc7RAcWGwlg
         N+1m/byE4xc9/VP0XqGLes6LZ1dMh84HwoscFIgZxBs3XWh0nmmqopWqY+RjkrC1DW7H
         w64GZZ8VjZphqi1fQYUrFefozRk6hcWKzapDGoYLgKNjVeJCvOF937bVCoiVW37lpH66
         Gs5KaPRFYIIw8bUtoeHGKen70boOq1b9chb0JG8TkfpXIsOJtkVDoiE2cSJtfhthGkkH
         wQWPKS4b1XlPQ0TxNhQOiB/PG5arr2sxfxZ6OdYMVX6cliH/KvMNtXGFTBC/ynuTSHMe
         GaOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LXB4PHczyG5oHbe4vyBbwBDKCH3Ytd8BOKpXNaIHy/k=;
        b=OaN7YWurrkQ4JCEb4A4JAnWXPOHGcA8xzvIu172LRlyiEdLXZZ0fwymRoLjvMi5IhV
         48Q44c17zxdef47xqOlOpFbUma4+9ukmhxFWXFGIyU94RaGquE3SdxAisAajtgQpFegJ
         N/5UMVijnJVdACuQzqCkORaQfAZDsYrixgvusICVG7AabQjpH3ARwRkYuUY4axS8sY4K
         P1no1CkIGG4AEMvAvGjLL5gFwaQAHYa54Y9bzeTHXV3vkxITEuYmyeBp8dTJJUfiV2DK
         FbJjHr80NjoH9poDxJH9bicnB3DkvmscF5gCv85GHpVAumcI0Bg9h+/bekHTVB2gxshG
         Zvig==
X-Gm-Message-State: AOAM532DasbzPfe5iFugU5otw2DHu+Hczl2C1uHMH4HJVySNOuIl/2Ie
        5yFWs8AetW0jfVnSPjxneU8DxBl7IBMe8VP8ThvKMQ==
X-Google-Smtp-Source: ABdhPJz9EvO2C5suzW/gjXYiMdSHDFYA2jjMoVgloR6ARreW+OoelbDGziZRLlGviyDvTGMc/QTw+MoceWQWmZz7YXU=
X-Received: by 2002:a2e:808a:0:b0:253:cd4e:b0ae with SMTP id
 i10-20020a2e808a000000b00253cd4eb0aemr49986ljg.6.1652889320141; Wed, 18 May
 2022 08:55:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
 <20220518102140.GF10117@worktop.programming.kicks-ass.net>
 <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
 <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com>
 <CAG+v+Kbfy-TuAWR9sfuWGyKb5Y+xjHDzB9hcoHuAN1kjYv5gWw@mail.gmail.com> <CAKfTPtA4qRUpMK4gw0STFg3kQqhpxCJpOMy9HgbSKaeVwfSjEQ@mail.gmail.com>
In-Reply-To: <CAKfTPtA4qRUpMK4gw0STFg3kQqhpxCJpOMy9HgbSKaeVwfSjEQ@mail.gmail.com>
From:   "Feiran Zheng ." <fam.zheng@bytedance.com>
Date:   Wed, 18 May 2022 16:55:09 +0100
Message-ID: <CAG+v+Kaa6Rfza_WewMw4K=vRTrt9UhRXp7G3XVi9cd_LvZkVEQ@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] sched: Enable root level cgroup
 bandwidth control
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com, fam@euphon.net,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 3:31 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:
> there is a DTPM powercap provider in the latest kernel and a scmi
> power capp provider is under review


Thanks, so DTPM can be a good solution for ARM. We could also deal
with AMD with acpi-cpufreq if powercap is not supported yet.

That aside, I think cpu cgroup has a familiar and simple sysfs
interface, and is more importantly hardware agnostic so it would be
really nice to have.

Alternatively, I assume we can look into a device-independent idle
injection mechanism?

Fam
