Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D671F484C45
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 02:56:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbiAEB4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 20:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236991AbiAEB4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 20:56:30 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB6BC061784
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 17:56:29 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e202so70688200ybf.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 17:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0CTVeYrQLBXeJ/hr42oXjaVY0bTM3pTmbjTFyrIN+Ak=;
        b=L4dSmP+6ZIcA9YIZU7wA2OZv4nKsXSNDegbwC3TP96NqD4wLog/I9lh536xv8f4R1T
         ZGfQ+OEuzFVdyuHykEA8pK03gThdkwMi+A8ljsuphf885vZlufbWP8gJRQRPqtQy5Wmm
         B+K7De1uB0JO2dOS2dbKqcGyU2IpZaN+kw+/xQ1Cj0FpsuAp4E/io8IQuqn6LY6w8aX0
         zl+/l6Yf8W+If5Vs++PgVM79Kvl7UveVh9au2PL+1oW777ZwLGH3C3t1VKCtA8tXG0Iy
         btpCdoVIP33Q1UTjkyUrMUmQRwRecANvxT2HvOgayPMbMnVstXUsOeFzJUVZgCTcY86f
         cgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0CTVeYrQLBXeJ/hr42oXjaVY0bTM3pTmbjTFyrIN+Ak=;
        b=jjxpF4eYnNNPVuwSzJ3GsXqEtaVrOLlY+Xt96s6jJ5tdeeY0FAXT0FQ+vuQ/2hoRQy
         34SpArr3WdH+E0jNNYOAs5O9gQ025D9iacPFwNQqi8Jr3eaQrYa7swU0MAzsLcxiVxfy
         kXBvlVm4MJbAxswMxkIQzAfktqREJnjOrRH2G64mKbN9bwhBDhjI1tvVmo6Anf50tDpO
         xzewXOJp/eTB7IwSQG4EumA2jdaMpXdPqQUVMtMfdOyOcR72ou21VvKuROtXVI90JPhM
         m7qVt2vBqTixXlr+AYOgZ8CNoqqp641Xtnh/wkFMhd4Oxiy0qSp6QKhNLPRolz7u9MMP
         iV/Q==
X-Gm-Message-State: AOAM531X/uPCIbMbyeMC5F7MZkMZwanTAaxplM3sv5yThxWB0AujBvHR
        cNyHlkJev354xeHolnxJe/eNpqNqZe8j2PjuIrwZOw==
X-Google-Smtp-Source: ABdhPJyqK9Y064QOcSOsyqxmGjHOY5Q4tuqwnvimGxYpa4VGPw9P+C5c6ZVFcER5owC4sX5pscFH4WeNNpDiZxALItk=
X-Received: by 2002:a25:2e0a:: with SMTP id u10mr42539402ybu.246.1641347788872;
 Tue, 04 Jan 2022 17:56:28 -0800 (PST)
MIME-Version: 1.0
References: <1640262603-19339-1-git-send-email-CruzZhao@linux.alibaba.com> <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
In-Reply-To: <1640262603-19339-3-git-send-email-CruzZhao@linux.alibaba.com>
From:   Josh Don <joshdon@google.com>
Date:   Tue, 4 Jan 2022 17:56:17 -0800
Message-ID: <CABk29NsP+sMQPRwS2e3zoeBsX1+p2aevFFO+i9GdB5VQ0ujEbA@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/core: Uncookied force idle accounting per cpu
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

On Thu, Dec 23, 2021 at 4:30 AM Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>
> Forced idle can be divided into two types, forced idle with cookie'd task
> running on it SMT sibling, and forced idle with uncookie'd task running
> on it SMT sibling, which should be accounting to measure the cost of
> enabling core scheduling too.
>
> This patch accounts the forced idle time with uncookie'd task, and the
> sum of both.
>
> A few details:
>  - Uncookied forceidle time and total forceidle time is displayed via
>    the last two columns of /proc/stat.
>  - Uncookied forceidle time is ony accounted when this cpu is forced
>    idle and a sibling hyperthread is running with an uncookie'd task.

What is the purpose/use-case to account the forced idle from
uncookie'd tasks? The forced-idle from cookie'd tasks represents
capacity loss due to adding in some cookie'd tasks. If forced idle is
high, that can be rectified by making some changes to the cookie'd
tasks (ie. their affinity, cpu budget, etc.).
