Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02D2657581D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 01:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbiGNXmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 19:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGNXmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 19:42:53 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC0D11C37
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:42:51 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31d85f82f0bso32315657b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hrcyqVkvy4izwFpTLzF8br5+AKNersnOh/LCuMYgV0U=;
        b=krFYEnJYL0KRGD9bGZMA+2mzLrUX+/bHrobwdwcvzV9kfqgfyi75TUDf9zdeU1qqWR
         AJA2DFnEXbJ1ngAXsCuziCfL2hI53zvUf3yPlrviGOA6YsHuGlfQnFq68atNlQ5cou+k
         dqtIMqB9wvNVsxfSwFl7Qoc3ECy+jenTAIBF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hrcyqVkvy4izwFpTLzF8br5+AKNersnOh/LCuMYgV0U=;
        b=SCErADFcXUZq1XVE2zrbqHceRmXLuYh4466rViln/FUK5CqAO6qj7P/7bZXFdC7Ufv
         FKqZI7bbDd79r+X2//T9eB0Ec0cCe/hZQoCH3hDEZPb/fbvpGZvPTXJ4xfUsiv2oiU0q
         gdc6o6Uu7ggbv1Gb0tbPPLrM222x5QUjY5bRp7S3JUcGr14a+9j4HZIR1zYTNZCFxVJS
         UsoSSeN6QR56PZe3Su2aYRSH4RfTN6HWo15R4oLjigE0q7J1akN5Mv7YbK6xcgx19Z0H
         DHf3N4szyn/2L26cPzat+Z5EoJXRogNtU1YFsEntBm0JqjeLqgVfweRPf4koQeqkTOle
         qgGw==
X-Gm-Message-State: AJIora82/oQskL6o1KGs5yrc3spzG/z/atWZeNKLjz6dxM6wCv0tSS3A
        ZQlB3/ryqyPDZaIK7eo8wvF15oju1/oxu+w800OcPA==
X-Google-Smtp-Source: AGRyM1swk3ZebWHTl5akundABJu3szM9NM1kLcNezSZ8tPiefLK5HQYfShJehVqnXx5XxLK+oiQC7CJN42AWYT7KO+M=
X-Received: by 2002:a0d:f147:0:b0:31c:c8fd:7160 with SMTP id
 a68-20020a0df147000000b0031cc8fd7160mr12868565ywf.420.1657842170848; Thu, 14
 Jul 2022 16:42:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220704000225.345536-1-dlunev@chromium.org> <20220704100221.1.I15b3f7a84ba5a97fde9276648e391b54957103ff@changeid>
 <YtB45Lte5UhlEE6y@redhat.com>
In-Reply-To: <YtB45Lte5UhlEE6y@redhat.com>
From:   Daniil Lunev <dlunev@chromium.org>
Date:   Fri, 15 Jul 2022 09:42:39 +1000
Message-ID: <CAONX=-dEG121RQ6L-4fPMXrLXb3JeYNVNiPzHXNaRLbwRzb3bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] dm: add message command to disallow device open
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Brian Geffon <bgeffon@google.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,
Thank you for your response. I should have probably added more context
to the commit message that I specified in the cover letter. The idea is to
prohibit access of all userspace, including the root. The main concern here
is potential system applications' vulnerabilities that can trick the system to
operate on non-intended files with elevated permissions. While those could
also be exploited to get more access to the regular file systems, those firstly
has to be useable by userspace for normal system operation (e.g. to store
user data), secondly, never contain plain text secrets. Swap content is a
different story - access to it can leak very sensitive information, which
otherwise is never available as plaintext on any persistent media - e.g. raw
user secrets, raw disk encryption keys etc, other security related tokens.
Thus we propose a mechanism to enable such a lockdown after necessary
configuration has been done to the device at boot time.
--Daniil

On Fri, Jul 15, 2022 at 6:13 AM Mike Snitzer <snitzer@kernel.org> wrote:
>
> On Sun, Jul 03 2022 at  8:02P -0400,
> Daniil Lunev <dlunev@chromium.org> wrote:
>
> > A message can be passed to device mapper to prohibit open on a certain
> > mapped device. This makes possible to disallow userspace access to
> > raw swapped data if the system uses device mapper to encrypt it at rest.
> >
> > Signed-off-by: Daniil Lunev <dlunev@chromium.org>
>
> This commit header and patch make little sense to me.
>
> If you're concerned about a normal (non-root) user having read access
> to the swap device then disallow non-root user access permissions on
> the swap device.
>
> Why is an encrypted swap device any different than any other encrypted
> device?
>
> As is, this patch seems to be the wrong way to achieve your desired
> result.  If you or someone else on the chromium team can better
> defend/explain the need for this change please do so.
>
> Thanks,
> Mike
>
>
> > ---
> >
> >  drivers/md/dm-core.h          |  1 +
> >  drivers/md/dm-ioctl.c         | 10 ++++++++++
> >  drivers/md/dm.c               | 12 ++++++++++++
> >  drivers/md/dm.h               | 10 ++++++++++
> >  include/uapi/linux/dm-ioctl.h |  5 +++++
> >  5 files changed, 38 insertions(+)
> >
> > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > index 4277853c75351..37529b605b7c4 100644
> > --- a/drivers/md/dm-core.h
> > +++ b/drivers/md/dm-core.h
> > @@ -140,6 +140,7 @@ struct mapped_device {
> >  #define DMF_SUSPENDED_INTERNALLY 7
> >  #define DMF_POST_SUSPENDING 8
> >  #define DMF_EMULATE_ZONE_APPEND 9
> > +#define DMF_DISALLOW_OPEN 10
> >
> >  void disable_discard(struct mapped_device *md);
> >  void disable_write_zeroes(struct mapped_device *md);
> > diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
> > index 87310fceb0d86..e35d560aa2ff3 100644
> > --- a/drivers/md/dm-ioctl.c
> > +++ b/drivers/md/dm-ioctl.c
> > @@ -815,6 +815,9 @@ static void __dev_status(struct mapped_device *md, struct dm_ioctl *param)
> >       if (dm_test_deferred_remove_flag(md))
> >               param->flags |= DM_DEFERRED_REMOVE;
> >
> > +     if (dm_test_disallow_open_flag(md))
> > +             param->flags |= DM_DISALLOWED_OPEN;
> > +
> >       param->dev = huge_encode_dev(disk_devt(disk));
> >
> >       /*
> > @@ -1656,6 +1659,13 @@ static int message_for_md(struct mapped_device *md, unsigned argc, char **argv,
> >               }
> >               return dm_cancel_deferred_remove(md);
> >       }
> > +     if (!strcasecmp(argv[0], "@disallow_open")) {
> > +             if (argc != 1) {
> > +                     DMERR("Invalid arguments for @disallow_open");
> > +                     return -EINVAL;
> > +             }
> > +             return dm_disallow_open(md);
> > +     }
> >
> >       r = dm_stats_message(md, argc, argv, result, maxlen);
> >       if (r < 2)
> > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > index 82957bd460e89..3e53d1bd40f0c 100644
> > --- a/drivers/md/dm.c
> > +++ b/drivers/md/dm.c
> > @@ -327,6 +327,7 @@ static int dm_blk_open(struct block_device *bdev, fmode_t mode)
> >               goto out;
> >
> >       if (test_bit(DMF_FREEING, &md->flags) ||
> > +         test_bit(DMF_DISALLOW_OPEN, &md->flags) ||
> >           dm_deleting_md(md)) {
> >               md = NULL;
> >               goto out;
> > @@ -403,6 +404,12 @@ int dm_cancel_deferred_remove(struct mapped_device *md)
> >       return r;
> >  }
> >
> > +int dm_disallow_open(struct mapped_device *md)
> > +{
> > +     set_bit(DMF_DISALLOW_OPEN, &md->flags);
> > +     return 0;
> > +}
> > +
> >  static void do_deferred_remove(struct work_struct *w)
> >  {
> >       dm_deferred_remove();
> > @@ -2883,6 +2890,11 @@ int dm_test_deferred_remove_flag(struct mapped_device *md)
> >       return test_bit(DMF_DEFERRED_REMOVE, &md->flags);
> >  }
> >
> > +int dm_test_disallow_open_flag(struct mapped_device *md)
> > +{
> > +     return test_bit(DMF_DISALLOW_OPEN, &md->flags);
> > +}
> > +
> >  int dm_suspended(struct dm_target *ti)
> >  {
> >       return dm_suspended_md(ti->table->md);
> > diff --git a/drivers/md/dm.h b/drivers/md/dm.h
> > index 9013dc1a7b002..da27f9dfe1413 100644
> > --- a/drivers/md/dm.h
> > +++ b/drivers/md/dm.h
> > @@ -163,6 +163,16 @@ int dm_test_deferred_remove_flag(struct mapped_device *md);
> >   */
> >  void dm_deferred_remove(void);
> >
> > +/*
> > + * Test if the device is openable.
> > + */
> > +int dm_test_disallow_open_flag(struct mapped_device *md);
> > +
> > +/*
> > + * Prevent new open request on the device.
> > + */
> > +int dm_disallow_open(struct mapped_device *md);
> > +
> >  /*
> >   * The device-mapper can be driven through one of two interfaces;
> >   * ioctl or filesystem, depending which patch you have applied.
> > diff --git a/include/uapi/linux/dm-ioctl.h b/include/uapi/linux/dm-ioctl.h
> > index 2e9550fef90fa..3b4d12d09c005 100644
> > --- a/include/uapi/linux/dm-ioctl.h
> > +++ b/include/uapi/linux/dm-ioctl.h
> > @@ -382,4 +382,9 @@ enum {
> >   */
> >  #define DM_IMA_MEASUREMENT_FLAG      (1 << 19) /* In */
> >
> > +/*
> > + * If set, the device can not be opened.
> > + */
> > +#define DM_DISALLOWED_OPEN   (1 << 20) /* Out */
> > +
> >  #endif                               /* _LINUX_DM_IOCTL_H */
> > --
> > 2.31.0
> >
