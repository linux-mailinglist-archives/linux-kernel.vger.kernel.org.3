Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068C7474964
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236366AbhLNR2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:28:10 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39692 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhLNR2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:28:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 82E63B81BB9;
        Tue, 14 Dec 2021 17:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5553BC34604;
        Tue, 14 Dec 2021 17:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639502885;
        bh=iWhZUpZug7nx6pfIKr0DItc2+D2cy9/JIdFzbQtsEhI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rYv9JVZ9YX6Z0mBpVDMKm5mu/TzapluDlyLScme2UrTuIXRhZgJB+QO6JHt2eHkyY
         3+Jqu7AOYi1QgWWEksD+65gGuD0VjAq1acIcvtuXXbqs+tH8BEhJowarrvQvSWSPCS
         8kJvbqQpEEGu3nXWKmkGoYBqfMPTzpI/yorx8TTNlK8WkzYco3Cu1XxPzAxUGbcxsY
         iO+svhxl9Uio5GhrkOjfUMJ1zxy9eQVcWcj0E5w9TM/2/0tMICRAFO/Yhd+T1cWrb7
         gJ3bLGn7U40/JibUXtbMYNVionNiTEfCchB2L6TzUJibY8OBopc2EEs98X8fh7TMjS
         l3SaS41aVL9JQ==
Received: by mail-yb1-f180.google.com with SMTP id d10so48128844ybe.3;
        Tue, 14 Dec 2021 09:28:05 -0800 (PST)
X-Gm-Message-State: AOAM530j4MZ4wwlvdqpMAD0OIlKF4S3mrXfdpeDpk1u9t+t3reWEPLgJ
        05JFBUiN2cHil5aUB3xrTVjkaylQzmD5FUbWWUY=
X-Google-Smtp-Source: ABdhPJzaIWhZ2KXfV3WBSipGqRCpcplKqZGV0U2L1BO8aObP0RNronSXvgKpJlPOO1T9RuBg8PP4FeHUtdss6/yaXVI=
X-Received: by 2002:a25:8284:: with SMTP id r4mr383980ybk.47.1639502884465;
 Tue, 14 Dec 2021 09:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20211214031553.16435-1-yajun.deng@linux.dev>
In-Reply-To: <20211214031553.16435-1-yajun.deng@linux.dev>
From:   Song Liu <song@kernel.org>
Date:   Tue, 14 Dec 2021 09:27:53 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
Message-ID: <CAPhsuW5X+zewpKoJLjMMGOUeSiJ1EYqD+0i1bA8y7SFtJLkMeg@mail.gmail.com>
Subject: Re: [PATCH] lib/raid6: fix abnormally high latency
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     stockhausen@collogia.de, open list <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:17 PM Yajun Deng <yajun.deng@linux.dev> wrote:
>
> We found an abnormally high latency when executing modprobe raid6_pq, the
> latency is greater than 1.2s when CONFIG_PREEMPT_VOLUNTARY=y, greater than
> 67ms when CONFIG_PREEMPT=y, and greater than 16ms when CONFIG_PREEMPT_RT=y.
> This is caused by disable the preemption, this time is too long and
> unreasonable. We just need to disable migration. so used migrate_disable()/
> migrate_enable() instead of preempt_disable()/preempt_enable(). This is
> beneficial for CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y, but no effect for
> CONFIG_PREEMPT_VOLUNTARY=y.
>
> Fixes: fe5cbc6e06c7 ("md/raid6 algorithms: delta syndrome functions")
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

We measure the speed of different RAID algorithms.If we don't disable
preempt, the result may be inaccurate, right? IIUC, we only disable preempt
for 16 jiffies. Why do we see 1.2 second delay?

Thanks,
Song

> ---
>  lib/raid6/algos.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/raid6/algos.c b/lib/raid6/algos.c
> index 6d5e5000fdd7..21611d05c34c 100644
> --- a/lib/raid6/algos.c
> +++ b/lib/raid6/algos.c
> @@ -162,7 +162,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
>
>                         perf = 0;
>
> -                       preempt_disable();
> +                       migrate_disable();
>                         j0 = jiffies;
>                         while ((j1 = jiffies) == j0)
>                                 cpu_relax();
> @@ -171,7 +171,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
>                                 (*algo)->gen_syndrome(disks, PAGE_SIZE, *dptrs);
>                                 perf++;
>                         }
> -                       preempt_enable();
> +                       migrate_enable();
>
>                         if (perf > bestgenperf) {
>                                 bestgenperf = perf;
> @@ -186,7 +186,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
>
>                         perf = 0;
>
> -                       preempt_disable();
> +                       migrate_disable();
>                         j0 = jiffies;
>                         while ((j1 = jiffies) == j0)
>                                 cpu_relax();
> @@ -196,7 +196,7 @@ static inline const struct raid6_calls *raid6_choose_gen(
>                                                       PAGE_SIZE, *dptrs);
>                                 perf++;
>                         }
> -                       preempt_enable();
> +                       migrate_enable();
>
>                         if (best == *algo)
>                                 bestxorperf = perf;
> --
> 2.32.0
>
