Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80CBD51F26F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 03:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235870AbiEIBcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 21:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233966AbiEHXzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 19:55:12 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6A63F8;
        Sun,  8 May 2022 16:51:21 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z18so13694333iob.5;
        Sun, 08 May 2022 16:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jvGYRgc/B1cVUQHYWbyzOUJsJsb2JybLUg0MtrNHLxU=;
        b=gzCU6N4K+RH0gJYDOFzdClMUoqs+sC5dLzprBeR0gAh2NBdsFoIUDmtm6UrsHl1C22
         hhvvyVwkcr85Bem8HAES8601Svm4cXUnKRpqZoX8B82AmRxwtFFhe+5rEgd2+b5IsAVc
         Ehjr2JxnbzsUtzOTCQt7zyUweMkWn98QmUIOyiJXmdSGJjb7Y2Vt2HHaF5zHjCVr5HeS
         C99xRgPNO6MydfVvHXf3vQvagErptsjIu4JbDRnLo1RFgGcMU4ziuIJU/ac6wD3Pxt6R
         /muL6QOrnANd9gjDvltFI7JhWsuPEeGkS8/eevwKXB3U+H9nokx36TkYQHhfUaB7A7yh
         U4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvGYRgc/B1cVUQHYWbyzOUJsJsb2JybLUg0MtrNHLxU=;
        b=1DcziIkBiYwJrYGc7DosG5IlHAOiDx906xdl/iMsWX/e0fk2Mmq8cgFnFG2rpxmkYI
         p55cExKOmlGGBULvH+wYJqHDnRQVobX+MIBKCfvCGAUg9QHmla5CDYIOKvW0NVIU1TTD
         fOyOltTCPVHYt0EcjYIjLUWrIdY4gx8zZZSsp8HX+NYytT35HG2b1+DxPtsa75d0oENM
         HXqoAyf05EegINk0ybyIbuXOvWhs8r7e26WjhlO0qKpsY7W1WSNgX7eahM2DAqqfvjx0
         uUEPg91S4wzO6UHdBdU7LK6vLj4TOVLjS/DZ5NtD9MF0QO5zyhNm78PKXQMEAJJRhJIN
         UcNw==
X-Gm-Message-State: AOAM533yBk3gcMvsz4ysDqzsta9vtIBQbZqp3L14P50bfYuAAqWl2Uz9
        3qpM8H2fJpVDz6l/F2Os2uWHGno6olyilfB9QY8=
X-Google-Smtp-Source: ABdhPJwwPq9wn3ToVdj7TM4CBY43GWLA0vghTvzHEPJnEJWTSpaC+IvmSDLcXNrhXJOAZnPYA62+yHm5rItxqhEhuos=
X-Received: by 2002:a05:6638:168f:b0:32d:8105:7646 with SMTP id
 f15-20020a056638168f00b0032d81057646mr630122jat.9.1652053880413; Sun, 08 May
 2022 16:51:20 -0700 (PDT)
MIME-Version: 1.0
References: <YnfVEcOWO63uIGs5@rowland.harvard.edu> <20220508150247.38204-1-schspa@gmail.com>
In-Reply-To: <20220508150247.38204-1-schspa@gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 9 May 2022 01:51:09 +0200
Message-ID: <CA+fCnZexPtGYX0kiwpA3-vgRbqbw0hk-fRpz9jUZrykJj-HN=w@mail.gmail.com>
Subject: Re: [PATCH v3] usb: gadget: fix race when gadget driver register via ioctl
To:     Schspa Shi <schspa@gmail.com>
Cc:     stern@rowland.harvard.edu, Julia Lawall <Julia.Lawall@inria.fr>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Wei Ming Chen <jj251510319013@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
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

On Sun, May 8, 2022 at 5:03 PM Schspa Shi <schspa@gmail.com> wrote:
>
> The usb_gadget_register_driver can be called multi time by to
> threads via USB_RAW_IOCTL_RUN ioctl syscall, which will lead
> to multiple registrations.
>
> Call trace:
>   driver_register+0x220/0x3a0 drivers/base/driver.c:171
>   usb_gadget_register_driver_owner+0xfb/0x1e0
>     drivers/usb/gadget/udc/core.c:1546
>   raw_ioctl_run drivers/usb/gadget/legacy/raw_gadget.c:513 [inline]
>   raw_ioctl+0x1883/0x2730 drivers/usb/gadget/legacy/raw_gadget.c:1220
>   ioctl USB_RAW_IOCTL_RUN
>
> This routine allows two processes to register the same driver instance
> via ioctl syscall. which lead to a race condition.
>
> Please refer to the following scenarios.
>
>            T1                                  T2
> ------------------------------------------------------------------
> usb_gadget_register_driver_owner
>   driver_register                    driver_register
>     driver_find                       driver_find
>     bus_add_driver                    bus_add_driver
>       priv alloced                     <context switch>
>       drv->p = priv;
>       <schedule out>
>       kobject_init_and_add // refcount = 1;
>    //couldn't find an available UDC or it's busy
>    <context switch>
>                                        priv alloced
>                                        drv->priv = priv;
>                                        kobject_init_and_add
>                                          ---> refcount = 1 <------
>                                        // register success
>                                        <context switch>
> ===================== another ioctl/process ======================
>                                       driver_register
>                                        driver_find
>                                         k = kset_find_obj()
>                                          ---> refcount = 2 <------
>                                         <context out>
>    driver_unregister
>    // drv->p become T2's priv
>    ---> refcount = 1 <------
>    <context switch>
>                                         kobject_put(k)
>                                          ---> refcount = 0 <------
>                                         return priv->driver;
>                                         --------UAF here----------
>
> There will be UAF in this scenario.
>
> We can fix it by adding a new STATE_DEV_REGISTERING device state to
> avoid double register.
>
> Reported-by: syzbot+dc7c3ca638e773db07f6@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/all/000000000000e66c2805de55b15a@google.com/
>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
>
> ---
>
> Changelog:
> v1 -> v2:
>         - Add a STATE_DEV_REGISTERING as Alan Stern suggested.
> v2 -> v3:
>         - Adjust STATE_DEV_REGISTERING position to reflect the actual
>           order in which the states occur.
>         - Add the fault scenarios to comments.
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> index b3be8db1ff63..241740024c50 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -145,6 +145,7 @@ enum dev_state {
>         STATE_DEV_INVALID = 0,
>         STATE_DEV_OPENED,
>         STATE_DEV_INITIALIZED,
> +       STATE_DEV_REGISTERING,
>         STATE_DEV_RUNNING,
>         STATE_DEV_CLOSED,
>         STATE_DEV_FAILED
> @@ -508,6 +509,7 @@ static int raw_ioctl_run(struct raw_dev *dev, unsigned long value)
>                 ret = -EINVAL;
>                 goto out_unlock;
>         }
> +       dev->state = STATE_DEV_REGISTERING;
>         spin_unlock_irqrestore(&dev->lock, flags);
>
>         ret = usb_gadget_register_driver(&dev->driver);
> --
> 2.24.3 (Apple Git-128)
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks, Schspa!

Thanks for the review, Alan!
