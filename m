Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CC9531341
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbiEWPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237953AbiEWPgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:36:43 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E5E2E096
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:36:42 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ff53d86abbso133344177b3.8
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bwKyiDYE51FSv2CgfXwlvAU5QYU7Qji4+KtmcFnvQRo=;
        b=cuoKHK+r8FryJks2SiHnPmXbZ/0sz66qtrC9b7De2jR3MFvupZAnkge7TLUHTUftmk
         hH04HskNl8S6CIKkI3pSobr6ljmvwjGEQ5SLW5+EN6z20wELFfLyfiCgYsa1X88WffY1
         IPuh48E3wTPsp+xkSEzkItDpmLD5m9Y1kmFXzQ0iKXifUl4kFw7KpX2zrOoJ7zW/m3T8
         UqFjH9tMom7RFG7cXEKk9DCqJpZ/UjnEODqFS5oEbwsPQTHISkCIDHCWyXKtuONLb8eU
         kfl7hZe/eS+aMU/biXWBROYoE5Qbv4GW9mDFhbbozTiCG90Oec7gHj+fSEKpdwtJTmVF
         JHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bwKyiDYE51FSv2CgfXwlvAU5QYU7Qji4+KtmcFnvQRo=;
        b=t1kG+zaoe0qLusaZOih4Jmd+dBjx1pZQ2gU+PHcoLdQlIjS4O8nZjBEsSmzzB63S2P
         Id1/bjp9H8rp4hV3iz10s4iWSO9++osS0dpyosnCnTH6KDPF9ZDiOfFwGJxLmpoti6Ax
         eOfNX1H3sskr6F+TJi4o6z3TAB/F6tvwdaUj9ArBhm7u2957uMAB6NoJYxjaJlWbYryF
         7jq945tnO/DpTr8aB/sn5xKut+tU6KkBoet1WEMknCqxQA4BrNrPBDjr5yDC0Kj1Rrhx
         XjLzNSCKLhwYwU8TW/k96JsrPc727bX1g9LytWDKjpkRgGhpeXHKAM8aVc/WBEeqwSWQ
         lCYQ==
X-Gm-Message-State: AOAM533oc7gbSwuPBN0jY8wtdOfJXKFZ+dXAZZDgYdZ7wZNiMX5YLjad
        6+cMEPJLkGgbX/vwCVoK4Ftv2iIfWkv0gggpxg7dgw==
X-Google-Smtp-Source: ABdhPJxwifdebyZIjHjo+6FIcWEXxKK5AxqP1kfrmFVZEXQZ90DURVqYsnAn7XK1Cj9gjdCqY1n6PeNvLmi36cUnP2E=
X-Received: by 2002:a81:1f09:0:b0:2ff:dd8d:7d56 with SMTP id
 f9-20020a811f09000000b002ffdd8d7d56mr7146556ywf.67.1653320201337; Mon, 23 May
 2022 08:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com>
 <20220518102140.GF10117@worktop.programming.kicks-ass.net>
 <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
 <CAKfTPtBAkQpKtZMC5uV6hNeMqe9rJHd_GLHVFf2o3r=HvqH9fg@mail.gmail.com>
 <CAG+v+Kbfy-TuAWR9sfuWGyKb5Y+xjHDzB9hcoHuAN1kjYv5gWw@mail.gmail.com>
 <CAKfTPtA4qRUpMK4gw0STFg3kQqhpxCJpOMy9HgbSKaeVwfSjEQ@mail.gmail.com> <CAG+v+Kaa6Rfza_WewMw4K=vRTrt9UhRXp7G3XVi9cd_LvZkVEQ@mail.gmail.com>
In-Reply-To: <CAG+v+Kaa6Rfza_WewMw4K=vRTrt9UhRXp7G3XVi9cd_LvZkVEQ@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 23 May 2022 17:36:29 +0200
Message-ID: <CAKfTPtB9gd5M6vvX+h3aZdOBVkWw0d+U5G5kUUtwsWuH_vanZA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] sched: Enable root level cgroup
 bandwidth control
To:     "Feiran Zheng ." <fam.zheng@bytedance.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 May 2022 at 17:55, Feiran Zheng . <fam.zheng@bytedance.com> wrote:
>
> On Wed, May 18, 2022 at 3:31 PM Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> > there is a DTPM powercap provider in the latest kernel and a scmi
> > power capp provider is under review
>
>
> Thanks, so DTPM can be a good solution for ARM. We could also deal
> with AMD with acpi-cpufreq if powercap is not supported yet.
>
> That aside, I think cpu cgroup has a familiar and simple sysfs
> interface, and is more importantly hardware agnostic so it would be
> really nice to have.

cgroup is about allocating runtime to a group but you want to force a
system idle for power consideration so it looks like abusing the
interface

>
> Alternatively, I assume we can look into a device-independent idle
> injection mechanism?

Yes, idle injection is  device-independent and fit better with your needs

thermal framework already support cpu idle cooling device but I'm not
sure your case is only related to thermal so you might want a more
generic interface like powercap--> dtpm --> idle injection

>
> Fam
