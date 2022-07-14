Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE59575557
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240840AbiGNStW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiGNSs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:48:57 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BED193C5;
        Thu, 14 Jul 2022 11:48:56 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-31c8a1e9e33so26264037b3.5;
        Thu, 14 Jul 2022 11:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WpMw7VFybVn09eTble/DBccI1cGG5NqeJngB3jlTGyo=;
        b=RVYwFmhQDC1NgcI+4ySLBxJ18fn8Yyuh5Ln3RXLbjDk+uFTyuLZpakTOCxSYaIHPQA
         grDmHCEqFTbS0XFwrRF8jlVBe2BhmHxwzvE+eyx5ScwED5l2a8mgsQtCgXZJidluHDuj
         2KfAeyIfSS3JIfYzHNWv4bzK2MNbpYdUUKebkpWk04u2TOCoE3Ex8vHL6oxCKjCjfX+G
         tqxriFJq3gnNC6gDDuL3hDWinGCgfu3woc1jE/ur0TdnsvjYktKUW8MeoJXo/+ZQzhvw
         S9gTYYEiVl+GqnxlbRsrXnqeCPhSEAqj1Pp4k7alMRfsd8FOPkK1FQSX8Q3rzlU84pjD
         h6LQ==
X-Gm-Message-State: AJIora+j7YpYRJ0b8WY2GHc6T8ikKovgsFelLCdUt01ScPb1apBEa34C
        Txe7/9yhTriFtJlmKAbBKolZ+7nHpbjZ/6nejdgqYP0l95E=
X-Google-Smtp-Source: AGRyM1tvddjPvQRD3fcJQhJAHFcKkNcf+lZzZGvRREfYsWlqCn/DcsrGTjbgGguYXoUqXZ1suOBhTabeMb9qbas9Ov4=
X-Received: by 2002:a81:a184:0:b0:31c:b00e:b5c4 with SMTP id
 y126-20020a81a184000000b0031cb00eb5c4mr11882753ywg.149.1657824535619; Thu, 14
 Jul 2022 11:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <03096156-3478-db03-c015-28643479116c@I-love.SAKURA.ne.jp>
 <48d01ce7-e028-c103-ea7f-5a4ea4c8930b@I-love.SAKURA.ne.jp>
 <2646e8a3-cc9f-c2c5-e4d6-c86de6e1b739@I-love.SAKURA.ne.jp>
 <YsvbgxJ80kMP5juv@kroah.com> <601436f2-b13e-6c24-bcfd-29548e288f23@I-love.SAKURA.ne.jp>
 <CAJZ5v0g9v35m9vaSeBC19axqRuNqG7qp+AGPn8wRb3Gzn+H9CA@mail.gmail.com> <7ad25274-fa10-c5f1-44f4-fe7786169fa1@I-love.SAKURA.ne.jp>
In-Reply-To: <7ad25274-fa10-c5f1-44f4-fe7786169fa1@I-love.SAKURA.ne.jp>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Jul 2022 20:48:44 +0200
Message-ID: <CAJZ5v0hOrPkF0KTp00c40Px30kXJWURZd=BcTWTyMONmOMz0fg@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] PM: hibernate: allow wait_for_device_probe() to
 timeout when resuming from hibernation
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Oliver Neukum <oneukum@suse.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Len Brown <len.brown@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 3:52 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2022/07/12 3:14, Rafael J. Wysocki wrote:
> > On Mon, Jul 11, 2022 at 1:21 PM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> On 2022/07/11 17:12, Greg KH wrote:
> >>>                                                        creating a
> >>> locking loop like this should be resolved first,
> >>
> >> Rafael and Arjan, can we agree with removing wait_for_device_probe() from snapshot_open() ?
> >
> > No, we can't.
>
> Then, can we defer wait_for_device_probe() till first write()/ioctl()
> which is called without locks?

Yes, wait_for_device_probe() can be deferred to right before the first
actual access.

>  kernel/power/user.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/power/user.c b/kernel/power/user.c
> index a00a728ddfc1..92aecb989c76 100644
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
> 2.18.4
