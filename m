Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F25957663C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiGORmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiGORmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:42:51 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE617D1D9;
        Fri, 15 Jul 2022 10:42:50 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31d7db3e6e5so53649757b3.11;
        Fri, 15 Jul 2022 10:42:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tZzHbptN4npbvAsNflMEYdWtbeIwv+tCQbrW3jRFX6I=;
        b=mda/P2oyn2oITazcwco2EADDjX1W77mx1x2mWb+SM/u1yfIyjEBtYYOG7gX8EFdQg2
         8K3aMUZJPaHvaMolasaI5+jjniOA0nBRqwH9MVizc58oY/ATaqBlbbHZErN56s8dOMeR
         SyUs0at31asSonQ5lpVzfuTc41ysJYKhW7ClYVyBq8wtQtLhhc1gFlOOefxhfrldbFWQ
         mCnkOMq/Mf7iX2O54t46JoXp7psTYHW2IPhrbf+V5Mo04QL3J16D7o3HrcW+e1/32Ylp
         rZurOE+llC6mLk7H9BHg8U0mHxnMkUOsgROP8bJ+u15VqmHsl0V5k6R9FBEcI7IG2zI/
         t8Mg==
X-Gm-Message-State: AJIora+3dTMfTZuZ3DHyX3wcIYb/FN++QtetELv78M4JZDSRszYHS68r
        Zjp6SwPykLAw6t4uVhc9USBu5Lf5KzZGk+FSSOg=
X-Google-Smtp-Source: AGRyM1vJTUz0uFCWS6vTGAjlF+3d70DmG++vO6PflMLdEJq9B54+FHW3i4BdNSHJS4iuCs4r9fIkS9a4+9imZBG+oEQ=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr16578235ywb.326.1657906969944; Fri, 15
 Jul 2022 10:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp> <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
In-Reply-To: <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:42:39 +0200
Message-ID: <CAJZ5v0hPc8cSivEykTGcGRtcARfNcSkrTKQuag6-PYJOWwQ91A@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] PM: hibernate: call wait_for_device_probe()
 without system_transition_mutex held
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2022 at 4:25 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting hung task at misc_open() [1], for there is a race
> window of AB-BA deadlock which involves probe_count variable.
>
> Even with "char: misc: allow calling open() callback without misc_mtx
> held", wait_for_device_probe() (w_f_d_p() afterward) from
> snapshot_open() can sleep forever if probe_count cannot become 0.
>
> w_f_d_p() in snapshot_open() was added by commit c751085943362143
> ("PM/Hibernate: Wait for SCSI devices scan to complete during resume"),
>
>    "In addition, if the resume from hibernation is userland-driven, it's
>     better to wait for all device probes in the kernel to complete before
>     attempting to open the resume device."
>
> but that commit did not take into account possibility of unresponsive
> hardware, for the timeout is supposed to come from the SCSI layer in the
> general case. syzbot is reporting that USB storage, which is a very tiny
> wrapper around the whole SCSI protocol, is failing to apply timeout.
>
> Fortunately, holding system_transition_mutex is not required when waiting
> for device probe. Therefore, as one of steps for making it possible to
> recover from such situation, this patch changes snapshot_open() to call
> w_f_d_p() before calling lock_system_sleep().
>
> Note that the problem that w_f_d_p() can sleep too long to wait remains.
> But how to fix that part deserves different patches.
>
> Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
> Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Wedson Almeida Filho <wedsonaf@google.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
>  kernel/power/user.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 59912060109f..db98a028dfdd 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -51,6 +51,18 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>         if (!hibernation_available())
>                 return -EPERM;
>
> +       switch (filp->f_flags & O_ACCMODE) {
> +       case O_RDWR: /* Can't do both at the same time. */
> +               return -ENOSYS;

if ((filp->f_flags & O_ACCMODE) == O_RDWR)
              return -ENOSYS;

/* On resume, we may need to wait for the image device to appear. */
if ((filp->f_flags & O_ACCMODE) == O_WRONLY)
              wait_for_device_probe();

> +       case O_RDONLY: /* Hibernating */
> +               /* The image device should be already ready. */
> +               break;
> +       default: /* Resuming */
> +               /* We may need to wait for the image device to appear. */
> +               wait_for_device_probe();
> +               break;
> +       }
> +
>         lock_system_sleep();
>
>         if (!hibernate_acquire()) {
> @@ -58,28 +70,16 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>                 goto Unlock;
>         }
>
> -       if ((filp->f_flags & O_ACCMODE) == O_RDWR) {
> -               hibernate_release();
> -               error = -ENOSYS;
> -               goto Unlock;
> -       }
>         nonseekable_open(inode, filp);
>         data = &snapshot_state;
>         filp->private_data = data;
>         memset(&data->handle, 0, sizeof(struct snapshot_handle));
>         if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
> -               /* Hibernating.  The image device should be accessible. */

No need to remove this comment.

>                 data->swap = swap_type_of(swsusp_resume_device, 0);
>                 data->mode = O_RDONLY;
>                 data->free_bitmaps = false;
>                 error = pm_notifier_call_chain_robust(PM_HIBERNATION_PREPARE, PM_POST_HIBERNATION);
>         } else {
> -               /*
> -                * Resuming.  We may need to wait for the image device to
> -                * appear.
> -                */
> -               wait_for_device_probe();
> -
>                 data->swap = -1;
>                 data->mode = O_WRONLY;
>                 error = pm_notifier_call_chain_robust(PM_RESTORE_PREPARE, PM_POST_RESTORE);
> --
> 2.18.4
>
