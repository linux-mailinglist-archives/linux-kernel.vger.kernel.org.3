Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6EB5A4722
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiH2K2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH2K2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:28:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C56621EC78;
        Mon, 29 Aug 2022 03:28:31 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id cb8so5780673qtb.0;
        Mon, 29 Aug 2022 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oyLuIO191oPFAdUBGExhG1LQql3RLJYD3yyEkPdMHco=;
        b=Z6etRM3qVay6FXg/5ukZMy7N+xR7PZrZ+XB/D0gGD0u7hKq3bHVsmuECXZnwfyzUoQ
         m4AMuGXv7OIiRbd8/DnBeHmLx5j31ixAupPW0Z68EkdbONeei8sN9ers5iuLQnu2UEg3
         Wpv4nUqB9Vmq1PDcLaC4rzkkfjmW4iOCQVTD4EozDrlyq7HCauIoq0M+6dIJMxmD1iVp
         lW4/9Qi742JVlDGtfRRJrTTxxMaDZv+sYCqwSg67LXR9EvAmSJNKMRi8dGwiO9DAdUVH
         +UCa8dVmjULb2C+ZjjJHx9YKn0RAsSwhgZt1wAhsrsTHBgmQ3pKVdpLC9SsjzsWf8oy/
         lJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oyLuIO191oPFAdUBGExhG1LQql3RLJYD3yyEkPdMHco=;
        b=17jyALbkzkkezfrenElUcvwaJ+UNcdjpZCbh43qr2yYGurQP81MQesy2tZqI9QHPyF
         f73IYSiLTAtobb5rPWP+GeAS6dwdGxmWfIh3Lj/G77+Jr9Ej2ytxDZDMIgg1BMrkEJO1
         ElPEZ7xEzwkBe3FEX+fE9eKzoxmJTuye8Nc7SLqNG2U586ckRCaKXz3M3mAsmu0wD5Tn
         A5AeLNJAr4pljQPOinkTHejlETuXoRFG7rn58IYs8i1ELk7fKw2t1U4X6pBm3F3Edkvr
         xB5plK5vjHUpt2+P/KOwlN2DO/ZtjuFA5akpl0lYqR2BFke/aPo1EyrDaofLtgBjPokm
         mOPA==
X-Gm-Message-State: ACgBeo0tVZ6KfB+q+BXJpPM2fSu0F/P2q3ZgL7P3jqs6P8iuJzkgwR1T
        W/559S8Bz4x2mQHitSuPKAQItQwJXzay4Lxia80=
X-Google-Smtp-Source: AA6agR7Tnh11kmJ3WwmMnHW0eQ53zV03s8aibhPrcicEHTjsvdUvotWLj9u5xV+fvtn+18GiAqSQacE3ZSNDib9bz2w=
X-Received: by 2002:a05:622a:491:b0:344:95bf:8f05 with SMTP id
 p17-20020a05622a049100b0034495bf8f05mr9567065qtx.61.1661768910839; Mon, 29
 Aug 2022 03:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220829091840.2791846-1-vincent.whitchurch@axis.com>
In-Reply-To: <20220829091840.2791846-1-vincent.whitchurch@axis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 13:27:54 +0300
Message-ID: <CAHp75Vd2q13864ynhSCvPXAGH3fFeSrcQYWL3eMHm4HY8Ujqzg@mail.gmail.com>
Subject: Re: [PATCH v2] iio: Use per-device lockdep class for mlock
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, kernel@axis.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <mranostay@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 12:18 PM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> If an IIO driver uses callbacks from another IIO driver and calls
> iio_channel_start_all_cb() from one of its buffer setup ops, then
> lockdep complains due to the lock nesting, as in the below example with
> lmp91000.
>
> Since the locks are being taken on different IIO devices, there is no
> actual deadlock.  Fix the warning by telling lockdep to use a different
> class for each iio_device.
>
>  ============================================
>  WARNING: possible recursive locking detected
>  --------------------------------------------
>  python3/23 is trying to acquire lock:
>  (&indio_dev->mlock){+.+.}-{3:3}, at: iio_update_buffers
>
>  but task is already holding lock:
>  (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store
>
>  other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(&indio_dev->mlock);
>    lock(&indio_dev->mlock);
>
>   *** DEADLOCK ***
>
>   May be due to missing lock nesting notation
>
>  5 locks held by python3/23:
>   #0: (sb_writers#5){.+.+}-{0:0}, at: ksys_write
>   #1: (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter
>   #2: (kn->active#14){.+.+}-{0:0}, at: kernfs_fop_write_iter
>   #3: (&indio_dev->mlock){+.+.}-{3:3}, at: enable_store
>   #4: (&iio_dev_opaque->info_exist_lock){+.+.}-{3:3}, at: iio_update_buffers
>
>  Call Trace:
>   __mutex_lock
>   iio_update_buffers
>   iio_channel_start_all_cb
>   lmp91000_buffer_postenable
>   __iio_update_buffers
>   enable_store


This looks much better than the previous version, thanks!
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 67e17300dc1d76 ("iio: potentiostat: add LMP91000 support")
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>
> Notes:
>     v2:
>     - Use a different lockdep class for each iio_device, instead of using
>       mutex_lock_nested.
>     - Add fixes tag pointing to first IIO driver which used this API.
>     - Trim call stack in commit message.
>
>  drivers/iio/industrialio-core.c | 5 +++++
>  include/linux/iio/iio-opaque.h  | 2 ++
>  2 files changed, 7 insertions(+)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 0f4dbda3b9d3..921d8e8643a2 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -1621,6 +1621,8 @@ static void iio_dev_release(struct device *device)
>
>         iio_device_detach_buffers(indio_dev);
>
> +       lockdep_unregister_key(&iio_dev_opaque->mlock_key);
> +
>         ida_free(&iio_ida, iio_dev_opaque->id);
>         kfree(iio_dev_opaque);
>  }
> @@ -1680,6 +1682,9 @@ struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
>         INIT_LIST_HEAD(&iio_dev_opaque->buffer_list);
>         INIT_LIST_HEAD(&iio_dev_opaque->ioctl_handlers);
>
> +       lockdep_register_key(&iio_dev_opaque->mlock_key);
> +       lockdep_set_class(&indio_dev->mlock, &iio_dev_opaque->mlock_key);
> +
>         return indio_dev;
>  }
>  EXPORT_SYMBOL(iio_device_alloc);
> diff --git a/include/linux/iio/iio-opaque.h b/include/linux/iio/iio-opaque.h
> index 6b3586b3f952..d1f8b30a7c8b 100644
> --- a/include/linux/iio/iio-opaque.h
> +++ b/include/linux/iio/iio-opaque.h
> @@ -11,6 +11,7 @@
>   *                             checked by device drivers but should be considered
>   *                             read-only as this is a core internal bit
>   * @driver_module:             used to make it harder to undercut users
> + * @mlock_key:                 lockdep class for iio_dev lock
>   * @info_exist_lock:           lock to prevent use during removal
>   * @trig_readonly:             mark the current trigger immutable
>   * @event_interface:           event chrdevs associated with interrupt lines
> @@ -42,6 +43,7 @@ struct iio_dev_opaque {
>         int                             currentmode;
>         int                             id;
>         struct module                   *driver_module;
> +       struct lock_class_key           mlock_key;
>         struct mutex                    info_exist_lock;
>         bool                            trig_readonly;
>         struct iio_event_interface      *event_interface;
> --
> 2.34.1
>


-- 
With Best Regards,
Andy Shevchenko
