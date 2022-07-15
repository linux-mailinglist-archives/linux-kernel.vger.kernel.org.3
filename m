Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14ED576658
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiGORrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiGORrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:47:01 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E1C85FA8;
        Fri, 15 Jul 2022 10:46:27 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-31c8bb90d09so53882477b3.8;
        Fri, 15 Jul 2022 10:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gCtUxpEgLriEFjbBJCI6PHjSEJZkybZsvm0/K7MOLjk=;
        b=H8wodtbiYxVJoZk1f7ZlhOXyNFZijLkoFaxqRZrnOVhNXJl2SrlUexKOSHOAgh4Npq
         EosnneoWCEu+lL6TOtM52tC6WQKu8GvDqYOFiNADl5ywaDGE2xko3yUdvCb5zXx6n7Kd
         Z2Kr5g9ywSimwLsr8/CqzskroomOGDmBOOFqz+ZrLpGZsbo3z9GhYDp9jTmf9vGgaqBM
         i1n1G6vZ9RVSIKKO3tMf4TJYmJh41pwHtmZCAetJmoPThdCSEfv7jHAQx1opG64INnQi
         Rx1pgOZEGNf37ZALWtS3QtITO50dza/9E/gMAfKqH7wbXr7k3rwU3ws9iCflF3rPoCp3
         jwcg==
X-Gm-Message-State: AJIora+B2DBX1H9uZLW5icjqkhMEY23unb+wVEamZbx4tr2jvtvwLX84
        L96p/v8NsjD56CBkR35GYFIHRgQJfOUI+3J4a+0=
X-Google-Smtp-Source: AGRyM1t3a401uD3BV4mbB4Zad2yp0MBh5FsQkSToei8hQ694wkOGzR0WuWi+WKuWGAYYqZujog6ddop5ojrFD+upljo=
X-Received: by 2002:a81:5957:0:b0:31c:f620:17ef with SMTP id
 n84-20020a815957000000b0031cf62017efmr16671677ywb.19.1657907186515; Fri, 15
 Jul 2022 10:46:26 -0700 (PDT)
MIME-Version: 1.0
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
 <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp> <273ec8c8-8b70-0a0e-4688-5b943ac8e648@I-love.SAKURA.ne.jp>
In-Reply-To: <273ec8c8-8b70-0a0e-4688-5b943ac8e648@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:46:15 +0200
Message-ID: <CAJZ5v0gMZ1mPOJ697buOmCWxj8TkJmP3bazGQQOXb5tVvymJdQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: hibernate: don't set PF_FREEZER_SKIP flag when
 manipulating /dev/snapshot
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

On Sun, Jul 10, 2022 at 4:26 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Since khungtaskd skips threads with PF_FREEZER_SKIP flag set, currently
> we can't report unbounded uninterruptible sleep when something went wrong
> while manipulating /dev/snapshot interface.
>
> Let's change snapshot_{open,read,write}() to use mutex_lock_killable()
> and change snapshot_release() to use mutex_lock(), so that khungtaskd can
> report unbounded uninterruptible sleep, by not setting PF_FREEZER_SKIP
> flag.
>
> Since /dev/snapshot is exclusive due to hibernate_acquire(), we could
> choose mutex_trylock() for snapshot_{open,read,write}() as with
> snapshot_ioctl(). But until we confirm that this patch does not
> break something, let's stay mutex_lock_killable().
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Pavel Machek <pavel@ucw.cz>
> ---
> This patch is only compile tested. Need to review if somewhere depends
> on PF_FREEZER_SKIP flag being set.

Yes, it does.  The process operating the snapshot device cannot be
frozen, which is why it sets PF_FREEZER_SKIP in the first place.

>
>  kernel/power/user.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index 32dd5a855e8c..9936efa07022 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -68,7 +68,8 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>                 break;
>         }
>
> -       lock_system_sleep();
> +       if (mutex_lock_killable(&system_transition_mutex))
> +               return -EINTR;
>
>         if (!hibernate_acquire()) {
>                 error = -EBUSY;
> @@ -102,7 +103,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>         data->dev = 0;
>
>   Unlock:
> -       unlock_system_sleep();
> +       mutex_unlock(&system_transition_mutex);
>
>         return error;
>  }
> @@ -111,7 +112,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
>  {
>         struct snapshot_data *data;
>
> -       lock_system_sleep();
> +       mutex_lock(&system_transition_mutex);
>
>         swsusp_free();
>         data = filp->private_data;
> @@ -128,7 +129,7 @@ static int snapshot_release(struct inode *inode, struct file *filp)
>                         PM_POST_HIBERNATION : PM_POST_RESTORE);
>         hibernate_release();
>
> -       unlock_system_sleep();
> +       mutex_unlock(&system_transition_mutex);
>
>         return 0;
>  }
> @@ -140,7 +141,8 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
>         ssize_t res;
>         loff_t pg_offp = *offp & ~PAGE_MASK;
>
> -       lock_system_sleep();
> +       if (mutex_lock_killable(&system_transition_mutex))
> +               return -EINTR;
>
>         data = filp->private_data;
>         if (!data->ready) {
> @@ -161,7 +163,7 @@ static ssize_t snapshot_read(struct file *filp, char __user *buf,
>                 *offp += res;
>
>   Unlock:
> -       unlock_system_sleep();
> +       mutex_unlock(&system_transition_mutex);
>
>         return res;
>  }
> @@ -173,7 +175,8 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>         ssize_t res;
>         loff_t pg_offp = *offp & ~PAGE_MASK;
>
> -       lock_system_sleep();
> +       if (mutex_lock_killable(&system_transition_mutex))
> +               return -EINTR;
>
>         data = filp->private_data;
>
> @@ -195,7 +198,7 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>         if (res > 0)
>                 *offp += res;
>  unlock:
> -       unlock_system_sleep();
> +       mutex_unlock(&system_transition_mutex);
>
>         return res;
>  }
> --
> 2.18.4
>
