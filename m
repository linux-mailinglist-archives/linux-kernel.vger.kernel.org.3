Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52F0543AF5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 20:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233445AbiFHSAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 14:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbiFHSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 14:00:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4551952D3;
        Wed,  8 Jun 2022 11:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 43A09CE2AA9;
        Wed,  8 Jun 2022 18:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6B5C34116;
        Wed,  8 Jun 2022 17:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654711199;
        bh=ZHS7rXNbty/74eNWl54KvwVchQ2FSINAh3ZDHQ8PpeY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bPKhCAXnNftOckdc0fUPP+NVPbYL4VDkNoCLy+E0kyWjhDmJutOWhKvQfmSUjSr5F
         FGXeRbHVLamNmqkJTA8hEfJNMT5wIuLw28EzxSUh2iVFiS0pr11udAVHt0ccyQ6Rju
         kuitNimO1WGSrCvMhWh+hQGgnIkxv18fmM24kX/KQK/J2NzV+8nQq3Du3UmvjoOHoO
         tSDxYAHC05LeXLo0OI0mGGcx62udb/aUOE6422x5WicPzSL59aZV97u1f7x6zaTe3n
         qUCqFoEo6PHDi8cZt+wRlkD0hypW/41/zi+IvQo5Cd+7A83aMJna/OWtlH8/kBrS1C
         WeYPJFrkQuG0g==
Received: by mail-yb1-f178.google.com with SMTP id p13so37806274ybm.1;
        Wed, 08 Jun 2022 10:59:59 -0700 (PDT)
X-Gm-Message-State: AOAM532imy5lNAnP6QyO6njh5qz+rU5X9Ny+XzkndVvF1h5v3gauaLQZ
        sF7H58U5yux7+FoZR8oifchqU/vbsA/nVFb/bGE=
X-Google-Smtp-Source: ABdhPJzgzC7sV/bMN0wIKyu0cqIGCvcMasRU+c/KTI2aKDVzNMSyO1zwCMB3woZ/fcEO67m3BALRNiWuKFLMYOvpdWs=
X-Received: by 2002:a25:7e84:0:b0:650:10e0:87bd with SMTP id
 z126-20020a257e84000000b0065010e087bdmr35567251ybc.257.1654711198713; Wed, 08
 Jun 2022 10:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220608162756.144600-1-logang@deltatee.com> <20220608162756.144600-5-logang@deltatee.com>
In-Reply-To: <20220608162756.144600-5-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jun 2022 10:59:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6-kt+MvmaT_5aii7bnJ8N352S30Gr6wVoP4xjP20-GiQ@mail.gmail.com>
Message-ID: <CAPhsuW6-kt+MvmaT_5aii7bnJ8N352S30Gr6wVoP4xjP20-GiQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] md/raid5: Ensure array is suspended for calls to log_exit()
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Donald Buczek <buczek@molgen.mpg.de>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 9:28 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> The raid5-cache code relies on there being no IO in flight when
> log_exit() is called. There are two places where this is not
> guaranteed so add mddev_suspend() and mddev_resume() calls to these
> sites.
>
> The site in raid5_remove_disk() has a comment saying that it is
> called in raid5d and thus cannot wait for pending writes; however that
> does not appear to be correct anymore (if it ever was) as
> raid5_remove_disk() is called from hot_remove_disk() which only
> appears to be called in the md_ioctl(). Thus, the comment is removed,
> as well as the racy check and replaced with calls to suspend/resume.
>
> The site in raid5_change_consistency_policy() is in the error path,
> and another similar call site already has suspend/resume calls just
> below it; so it should be equally safe to make that change here.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/raid5.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 5d09256d7f81..3ad37dd4c5cd 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7938,18 +7938,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
>
>         print_raid5_conf(conf);
>         if (test_bit(Journal, &rdev->flags) && conf->log) {
> -               /*
> -                * we can't wait pending write here, as this is called in
> -                * raid5d, wait will deadlock.
> -                * neilb: there is no locking about new writes here,
> -                * so this cannot be safe.
> -                */
> -               if (atomic_read(&conf->active_stripes) ||
> -                   atomic_read(&conf->r5c_cached_full_stripes) ||
> -                   atomic_read(&conf->r5c_cached_partial_stripes)) {
> -                       return -EBUSY;
> -               }
> +               mddev_suspend(mddev);

Unfortunately, the comment about deadlock is still true, and we cannot call
mddev_suspend here. To trigger it:

   # create raid5 with journal:
   mdadm --create /dev/md0  -l 5 -n 3 /dev/nvme[0-2]n1 --write-journal
/dev/nvme3n1
   # start some writes
   fio ...
   # fail the journal
   mdadm --fail /dev/md0 /dev/nvme3n1

This will cause deadlock of the thread:
[<0>] raid5_quiesce+0x2a8/0x5f0
[<0>] mddev_suspend+0x26b/0x530
[<0>] raid5_remove_disk+0x12e/0x6f3
[<0>] remove_and_add_spares+0x5b2/0xef0
[<0>] md_check_recovery+0xe68/0x12b0
[<0>] raid5d+0xf4/0xf30
[<0>] md_thread+0x299/0x350
[<0>] kthread+0x29d/0x340
[<0>] ret_from_fork+0x22/0x30

Thanks,
Song


>                 log_exit(conf);
> +               mddev_resume(mddev);
>                 return 0;
>         }
>         if (rdev == rcu_access_pointer(p->rdev))
> @@ -8697,8 +8688,11 @@ static int raid5_change_consistency_policy(struct mddev *mddev, const char *buf)
>                         err = log_init(conf, NULL, true);
>                         if (!err) {
>                                 err = resize_stripes(conf, conf->pool_size);
> -                               if (err)
> +                               if (err) {
> +                                       mddev_suspend(mddev);
>                                         log_exit(conf);
> +                                       mddev_resume(mddev);
> +                               }
>                         }
>                 } else
>                         err = -EINVAL;
> --
> 2.30.2
>
