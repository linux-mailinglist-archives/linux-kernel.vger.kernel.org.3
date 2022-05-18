Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6E252B80B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiERKiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 06:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiERKiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 06:38:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B70B30F79
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:38:14 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id p22so2823879lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0NTxAn+6T8w9hdTIq5Cgi6wlBNu0iH0H7rw7aIi/4xE=;
        b=WE8yOgYWIlCFKn3BmxelqQ8z0cjjx62N+D1DFq8X+98cqbZTXiEMtmqZTl+O8LPO/t
         EJDO25DHuNUV6zVcMgrSPZFpwWIH0h9N2cP2iF5r/4ZHoIcYz+HTbn/6oKHhQuHK71FJ
         eWOe9VCbBhz+/8uFkOeaFbdQ81U57R6OTPx9tWfM5ZLcnnwOavLSyPx+tGNobR51hSHx
         SBjt+92sKXxmpeob6HIMIjkCrSVQH5owrdCyWKRq7NPccPwnYO0srHWn76K4R/u0rmMQ
         T+zDYZNEBos+1sKtzK+yj97clDWQwwweh3VXgy2GxkZhM8PZdIpZprmioB9+Basswh/U
         y1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0NTxAn+6T8w9hdTIq5Cgi6wlBNu0iH0H7rw7aIi/4xE=;
        b=PsrGHNQO1lyaooullnmZhko934kK9Iet9nPgbrlSA1XlJR9m3Dj2TQOhBnzrBxHICx
         HNwxJ2boXj3xKJa+C7p0aszorlt5Pi7VlfTYJBeA5DxhLJTiBKsXV4+WndN6Mbb4eX3f
         Os+4qShwn3abyiZO4sm1AqIcMvjB+rSVjQiORvBnwj52YKaWdetpBMXczIHZZhiFqarH
         24k/71u5JoFmoAcH4jpnACHsTJcWs0M3dUsrk4H+x6g1+6nPyPfmjq8YB0KpD9TSPN5R
         tyLftZbAf2kEVt28EDm+mZ5WaGObwt255sJT6kDzM72uQuv/ZCJsITI3+HHUqu6p/sqD
         il7A==
X-Gm-Message-State: AOAM531Wq7H0euIrYeBiXekREM2/2dZ0c9/pKHmL7vD4kj/FFkF8OM3n
        OuCY9L12st287OADGEJZMYuDDPPC7NtBUBQOEzp4uQ==
X-Google-Smtp-Source: ABdhPJz95Pu6mvN7sneb+w+UwiN7N58yqxFti8Y9pz/wc22jLoKypJHa7M7XEU7IipN2UYUFTw4c20WWjuV+BG7fvX8=
X-Received: by 2002:a19:e303:0:b0:477:b578:7df3 with SMTP id
 a3-20020a19e303000000b00477b5787df3mr2420941lfh.54.1652870292902; Wed, 18 May
 2022 03:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220518100841.1497391-1-fam.zheng@bytedance.com> <20220518102140.GF10117@worktop.programming.kicks-ass.net>
In-Reply-To: <20220518102140.GF10117@worktop.programming.kicks-ass.net>
From:   "Feiran Zheng ." <fam.zheng@bytedance.com>
Date:   Wed, 18 May 2022 11:38:02 +0100
Message-ID: <CAG+v+Kb5ON2-49t8ZZwH2jT31Jvi+F_HYW0gQ3ss040GKdp0Zw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH] sched: Enable root level cgroup
 bandwidth control
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        zhouchengming@bytedance.com,
        Vincent Guittot <vincent.guittot@linaro.org>, fam@euphon.net,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        songmuchun@bytedance.com, Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 11:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, May 18, 2022 at 11:08:41AM +0100, Fam Zheng wrote:
> > In the data center there sometimes comes a need to throttle down a
> > server,
>
> Why?

For economical reasons there can be over-provisioning in DC power
supply (UPS capacity etc) because the utilization expectation of the
racks is not maximum value. But the workload can be client driven,
depending on how many users are online, and in the end the power
supply may overload and trip itself. To avoid that, upon a threshold,
some servers need to be brought down or throttled. The latter is
obviously going to be much more smooth.
