Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1AA543EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbiFHWDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiFHWDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:03:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613401ADA1;
        Wed,  8 Jun 2022 15:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD8B961353;
        Wed,  8 Jun 2022 22:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E791C341C5;
        Wed,  8 Jun 2022 22:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654725778;
        bh=Wcbg0mcRZfOkGGdrQ82LwBzVQcYYeE9d9FRDXSzifQo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CZN98L6ANs+93vsJhUb0jmxKJJ+ZJnCqF9CnQJK/HWZS0BWRJ1Okj+qW3rylnniIt
         FQc7ork+96Z5mcOtHCMXgvBCl+IZxLJYXQ5cC7ldJ3y+ZWVzXx++JrURNgNSLo3dsl
         I0bdz/mpO/R605gwFoYL+1S/KfDLgqcE81ZPsytQ6IX0WntEsyEweInCgjMltMCnr2
         AWuytbecnxf5HR9WMrJk6pTifF8BaNKpb8XbJ+83VRpGjhTmk1WeyN5dp4WczPEfPN
         RjwKZ5wdpY7deMkLOuGx3TBIPQYU2foi/V+wg4H65pd54wi4lCd6rnx5HKB6QqV819
         QWdW14a6Ua1KA==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-3137316bb69so28705987b3.10;
        Wed, 08 Jun 2022 15:02:58 -0700 (PDT)
X-Gm-Message-State: AOAM531AiAvzG1a7Oa/2gmKQcON25cEWIQsI4HwNXHLI9MA+lPVDxJar
        tPrPISj6kl8z0qp+4uaSJwO/UvZXrwVhKNQXHik=
X-Google-Smtp-Source: ABdhPJwlE79U/Rr+Y8adxlrH+PPu/xQygUtJgmZ6dRd38mgaVOaoRTkgVEGx6D1wiKPff39/Q6rC93uv9luLFlYzi3M=
X-Received: by 2002:a0d:eb4d:0:b0:30c:9849:27a1 with SMTP id
 u74-20020a0deb4d000000b0030c984927a1mr38976872ywe.472.1654725777146; Wed, 08
 Jun 2022 15:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220608162756.144600-1-logang@deltatee.com> <20220608162756.144600-5-logang@deltatee.com>
 <CAPhsuW6-kt+MvmaT_5aii7bnJ8N352S30Gr6wVoP4xjP20-GiQ@mail.gmail.com> <08b80caa-d726-b9f3-7ce0-f486b8080ec5@deltatee.com>
In-Reply-To: <08b80caa-d726-b9f3-7ce0-f486b8080ec5@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Wed, 8 Jun 2022 15:02:46 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4nx_WAtAibZJ3s8pNy+rxKsRKsLE-NL3tuDuwoC5BaXw@mail.gmail.com>
Message-ID: <CAPhsuW4nx_WAtAibZJ3s8pNy+rxKsRKsLE-NL3tuDuwoC5BaXw@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 11:21 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2022-06-08 11:59, Song Liu wrote:
> > On Wed, Jun 8, 2022 at 9:28 AM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >> The raid5-cache code relies on there being no IO in flight when
> >> log_exit() is called. There are two places where this is not
> >> guaranteed so add mddev_suspend() and mddev_resume() calls to these
> >> sites.
> >>
> >> The site in raid5_remove_disk() has a comment saying that it is
> >> called in raid5d and thus cannot wait for pending writes; however that
> >> does not appear to be correct anymore (if it ever was) as
> >> raid5_remove_disk() is called from hot_remove_disk() which only
> >> appears to be called in the md_ioctl(). Thus, the comment is removed,
> >> as well as the racy check and replaced with calls to suspend/resume.
> >>
> >> The site in raid5_change_consistency_policy() is in the error path,
> >> and another similar call site already has suspend/resume calls just
> >> below it; so it should be equally safe to make that change here.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >> Reviewed-by: Christoph Hellwig <hch@lst.de>
> >> ---
> >>  drivers/md/raid5.c | 18 ++++++------------
> >>  1 file changed, 6 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> >> index 5d09256d7f81..3ad37dd4c5cd 100644
> >> --- a/drivers/md/raid5.c
> >> +++ b/drivers/md/raid5.c
> >> @@ -7938,18 +7938,9 @@ static int raid5_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
> >>
> >>         print_raid5_conf(conf);
> >>         if (test_bit(Journal, &rdev->flags) && conf->log) {
> >> -               /*
> >> -                * we can't wait pending write here, as this is called in
> >> -                * raid5d, wait will deadlock.
> >> -                * neilb: there is no locking about new writes here,
> >> -                * so this cannot be safe.
> >> -                */
> >> -               if (atomic_read(&conf->active_stripes) ||
> >> -                   atomic_read(&conf->r5c_cached_full_stripes) ||
> >> -                   atomic_read(&conf->r5c_cached_partial_stripes)) {
> >> -                       return -EBUSY;
> >> -               }
> >> +               mddev_suspend(mddev);
> >
> > Unfortunately, the comment about deadlock is still true, and we cannot call
> > mddev_suspend here. To trigger it:
>
> Ah, yes. What a tangle. I think we can just drop this patch. Now that we
> are removing RCU it isn't actually necessary to fix the bug I was
> seeing. It's still probably broken as the comment notes though.

How about we keep the suspend/resume in raid5_change_consistency_policy()?
Like the one I just pushed to md-next:

https://git.kernel.org/pub/scm/linux/kernel/git/song/md.git/commit/?h=md-next&id=ac1506992459fe45a085c1f93df74d51c381887b

Thanks,
Song
