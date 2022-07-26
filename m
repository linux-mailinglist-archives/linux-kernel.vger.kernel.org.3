Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862595819E1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbiGZSmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbiGZSmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:42:08 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7422A2D1DC;
        Tue, 26 Jul 2022 11:42:07 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-31e7055a61dso152177397b3.11;
        Tue, 26 Jul 2022 11:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3Tjb8+yRHmF5ncvwObM9z3vY00LYdwKMo31sPhGwgxU=;
        b=ysnLIFR5HFU5ybcv1uTG/RtHy9IfQFoNu/B6j3dzxhcnBEKuJ0zcysaGpaR81JDBo6
         Ma2EkHSqrVQZg8mYjA7Ad4qgbq7QAWBGP2cLvVvbGdkZALexkJsc8Xc7X4Zr4UI+rVNI
         O4RDhuSnDzbUtHuykGCjCorLocSKe3+vumGEYpnCXpav+w4Ys5El+amKLhl6zt5GZ2AY
         W0oyDs0xTelV7Vwc9zGBCS0Lqf0lPGzM7VAhy4KCcX2WGzUhLOT1PpK8V70Gfp1qSjmQ
         foG+w8LMPecredDj5PydhdqGHPGsxUeOFHiDj8mN91yfGqjFCYBKjesu7XzcWYNgGlyu
         jceg==
X-Gm-Message-State: AJIora/X3YwzNgV/B3324uhO7n2AVv+xuPe9MkQuqkW9q/vJmUa/S/Iw
        mpvXLuiYBMcBn/42HU0G89i1/VRyVyrKPGgsQwE=
X-Google-Smtp-Source: AGRyM1vq/T8aGKh5BysIsvk3VwI4LkEctMSc6P9Q2W/dyr8+5gt8s9RELvYzu7VGtGuW95qVs9zsjmpsdb3RlXJBvzc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr15641987ywb.326.1658860926659; Tue, 26
 Jul 2022 11:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <04278747-41fe-3a0a-81bf-2935efaafac0@I-love.SAKURA.ne.jp>
In-Reply-To: <04278747-41fe-3a0a-81bf-2935efaafac0@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 26 Jul 2022 20:41:55 +0200
Message-ID: <CAJZ5v0jzPyTA_Ng_vB1iFR91ThGw9nT2Yzyh6xwTZJajAz+O0g@mail.gmail.com>
Subject: Re: [PATCH v3] PM: hibernate: defer device probing when resuming from hibernation
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 7:51 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> syzbot is reporting hung task at misc_open() [1], for there is a race
> window of AB-BA deadlock which involves probe_count variable. Currently
> wait_for_device_probe() from snapshot_open() from misc_open() can sleep
> forever with misc_mtx held if probe_count cannot become 0.
>
> When a device is probed by hub_event() work function, probe_count is
> incremented before the probe function starts, and probe_count is
> decremented after the probe function completed.
>
> There are three cases that can prevent probe_count from dropping to 0.
>
>   (a) A device being probed stopped responding (i.e. broken/malicious
>       hardware).
>
>   (b) A process emulating a USB device using /dev/raw-gadget interface
>       stopped responding for some reason.
>
>   (c) New device probe requests keeps coming in before existing device
>       probe requests complete.
>
> The phenomenon syzbot is reporting is (b). A process which is holding
> system_transition_mutex and misc_mtx is waiting for probe_count to become
> 0 inside wait_for_device_probe(), but the probe function which is called
>  from hub_event() work function is waiting for the processes which are
> blocked at mutex_lock(&misc_mtx) to respond via /dev/raw-gadget interface.
>
> This patch mitigates (b) by deferring wait_for_device_probe() from
> snapshot_open() to snapshot_write() and snapshot_ioctl(). Please note that
> the possibility of (b) remains as long as any thread which is emulating a
> USB device via /dev/raw-gadget interface can be blocked by uninterruptible
> blocking operations (e.g. mutex_lock()).
>
> Please also note that (a) and (c) are not addressed. Regarding (c), we
> should change the code to wait for only one device which contains the
> image for resuming from hibernation. I don't know how to address (a), for
> use of timeout for wait_for_device_probe() might result in loss of user
> data in the image. Maybe we should require the userland to wait for the
> image device before opening /dev/snapshot interface.
>
> Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
> Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Tested-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Oliver Neukum <oneukum@suse.com>
> Cc: Wedson Almeida Filho <wedsonaf@google.com>
> Cc: Rafael J. Wysocki <rjw@sisk.pl>
> Cc: Arjan van de Ven <arjan@linux.intel.com>
> ---
> Changes in v3:
>   Defer wait_for_device_probe() till first write()/ioctl() request.
>
> v2 is at https://lkml.kernel.org/r/03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp .
>
> v1 is at https://lkml.kernel.org/r/72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp .
>
>  kernel/power/user.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index ad241b4ff64c..d43c2aa583b2 100644
> --- a/kernel/power/user.c
> +++ b/kernel/power/user.c
> @@ -26,6 +26,7 @@
>
>  #include "power.h"
>
> +static bool need_wait;
>
>  static struct snapshot_data {
>         struct snapshot_handle handle;
> @@ -78,7 +79,7 @@ static int snapshot_open(struct inode *inode, struct file *filp)
>                  * Resuming.  We may need to wait for the image device to
>                  * appear.
>                  */
> -               wait_for_device_probe();
> +               need_wait = true;
>
>                 data->swap = -1;
>                 data->mode = O_WRONLY;
> @@ -168,6 +169,11 @@ static ssize_t snapshot_write(struct file *filp, const char __user *buf,
>         ssize_t res;
>         loff_t pg_offp = *offp & ~PAGE_MASK;
>
> +       if (need_wait) {
> +               wait_for_device_probe();
> +               need_wait = false;
> +       }
> +
>         lock_system_sleep();
>
>         data = filp->private_data;
> @@ -244,6 +250,11 @@ static long snapshot_ioctl(struct file *filp, unsigned int cmd,
>         loff_t size;
>         sector_t offset;
>
> +       if (need_wait) {
> +               wait_for_device_probe();
> +               need_wait = false;
> +       }
> +
>         if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
>                 return -ENOTTY;
>         if (_IOC_NR(cmd) > SNAPSHOT_IOC_MAXNR)
> --

Applied as 5.20 material, thanks!
