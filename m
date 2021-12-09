Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F9646F23E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242550AbhLIRnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:43:24 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:51730 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbhLIRnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:43:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2D45ACE276D;
        Thu,  9 Dec 2021 17:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30F32C341CD;
        Thu,  9 Dec 2021 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639071586;
        bh=qYNFqkQwxVAeHZsMMhQPC8pTvIDP3euSi+noorx7pH0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ef7a/pLzC84q6l0bpD1Ouuu1jwXd9CWk/Vz2wkWVKxQ7tCBT3dqKVso4VDjGCCNcN
         iOYw70pMI/Vtqz8DMuFPHN9toXpn2/49PWrnVCkvZQs8YvrdZP9JMtm5aFra7VUMp7
         r+q6Ag0ZWAuiiBHEY98DuYrIauEmeMGClXRe9ZZbsXd8SgpSqH/C50CLOU6tpHjW6R
         AZeQnk/fCXVbm3gCwmWcuItUckwfsfr7ebaLl/65hbv6Z8mbgWPFxGF36Vw808OXUc
         hgtwmxv1UdgGGMYP/a/pR6tR6Ph8Xev9v33uzVll1X7fop/0nwYxLecdcfibHzpqxS
         7p7/CiYFwfWCg==
Received: by mail-yb1-f176.google.com with SMTP id q74so15366898ybq.11;
        Thu, 09 Dec 2021 09:39:46 -0800 (PST)
X-Gm-Message-State: AOAM530Rj5B5jyTGf3VhWpdqdaJQ/4l3SgyyYF6BmhauaXNqu8AtCU38
        K0/4quzpBRvRPzjTZ0xF/dApKlhB418ej8UILmA=
X-Google-Smtp-Source: ABdhPJwEaoB1dnsF15BdtCtWtqwmPOt+eNaurSXpzIIW1JOastQNXdj6/+OJ3JEn15TvFp68O0n7N/B+1jxAhdPcpLo=
X-Received: by 2002:a25:3bc3:: with SMTP id i186mr8303350yba.282.1639071585209;
 Thu, 09 Dec 2021 09:39:45 -0800 (PST)
MIME-Version: 1.0
References: <20211201032712.3684503-1-lijinlin3@huawei.com>
In-Reply-To: <20211201032712.3684503-1-lijinlin3@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 9 Dec 2021 09:39:34 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5sv5D8vmiJxS9SqCcit1a05F8kw80Q1TV9+26+QJkEsA@mail.gmail.com>
Message-ID: <CAPhsuW5sv5D8vmiJxS9SqCcit1a05F8kw80Q1TV9+26+QJkEsA@mail.gmail.com>
Subject: Re: [PATCH] md: Fix unexpected behaviour in is_mddev_idle
To:     Li Jinlin <lijinlin3@huawei.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Tejun Heo <tj@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 6:56 PM Li Jinlin <lijinlin3@huawei.com> wrote:
>
> The value of curr_events may be INT_MAX when mddev initializes IO event
> counters. Then, rdev->last_events will be set as INT_MAX.
> If all the rdevs of mddev are in this case,
> 'curr_events - rdev->last_events > 64' will always false, and
> is_mddev_idle() will always return 1, which may cause non-sync IO very
> slow.
>
> Fix by using atomic64_t type for sync_io, and using long type for
> curr_events/last_events.
>
> Signed-off-by: Li Jinlin <lijinlin3@huawei.com>
> ---
>  drivers/md/md.c       | 6 +++---
>  drivers/md/md.h       | 4 ++--
>  include/linux/genhd.h | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 5111ed966947..f47035838c43 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8429,14 +8429,14 @@ static int is_mddev_idle(struct mddev *mddev, int init)
>  {
>         struct md_rdev *rdev;
>         int idle;
> -       int curr_events;
> +       long curr_events;
>
>         idle = 1;
>         rcu_read_lock();
>         rdev_for_each_rcu(rdev, mddev) {
>                 struct gendisk *disk = rdev->bdev->bd_disk;
> -               curr_events = (int)part_stat_read_accum(disk->part0, sectors) -
> -                             atomic_read(&disk->sync_io);
> +               curr_events = (long)part_stat_read_accum(disk->part0, sectors) -
> +                             atomic64_read(&disk->sync_io);
>                 /* sync IO will cause sync_io to increase before the disk_stats
>                  * as sync_io is counted when a request starts, and
>                  * disk_stats is counted when it completes.
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index 53ea7a6961de..3f8327c42b7b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -50,7 +50,7 @@ struct md_rdev {
>
>         sector_t sectors;               /* Device size (in 512bytes sectors) */
>         struct mddev *mddev;            /* RAID array if running */
> -       int last_events;                /* IO event timestamp */
> +       long last_events;               /* IO event timestamp */

I think we need long long here to be safe on 32-bit systems.

Thanks,
Song
