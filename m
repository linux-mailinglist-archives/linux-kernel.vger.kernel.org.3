Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8E5673AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiGEP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiGEP7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 11:59:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4246C13DCD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 08:59:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so22382275eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 08:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVxNdksJTPOevalf7BH9L1TRDCo8ZI9OB7mA3/aAEj8=;
        b=WXZTIBU9zcO43MUvBFqYfuCH7aGFfk5nMeKMiu6m7yQmfM/t7iOMGon6fEDky+7f0K
         j3HZhHPUg2BNRBxIXSh/kfJ92zL+0ZCvgF/ySQv4XzgYkHnHz5SRGef43pyzDEhkIDXu
         SC7UPUw8+zZ2Q+C4zN33YsjGZVo2raTjHfkJ3tbFJCv0t2+tC6ZLJhqYc5LQjnSlqrV/
         S7T4ALECYtyTmx4ktsDxmGLniWcYyuo7EzcvyefqFjR5tgNHfDiIznTjNGcgKrmxKlJP
         ZVp1a4zdDcDBHkIfSsDSU/efA3uBvN0HkeiqkXsMw8gD6LBk6VmEPwqDZOFZcXYi5xns
         0otQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVxNdksJTPOevalf7BH9L1TRDCo8ZI9OB7mA3/aAEj8=;
        b=sob3mEVfudJMgnNSEvxo5M6WKpKtUtAwjZY8ZIDzruM6dnzlcNW65N3UxUvNYXGANv
         ijngFOIE6CHvTfzn7e84U0cv9D8sItzdJhTa+PxqlzUq7uXJRdB/vhDgqzY/Z99W9dgA
         OuHAaPs6CF7I3MbYzL7kBrZUVVRpqNewEHEB+ndd8tXSN84CJvBDWk2XirkKvPgppa7R
         du6l2oBlFU9u1/WNj/m2YwFLW8cD/i7a6aP8SOJotXw5TeaFrFdqYEBCdHhpTEMvNw/4
         /yG3kJ+EnU5X/uKD7+QdrEuv2pENsTs7/BMjxhRaqWijkQd1MVKnoarrMnSKhc5G+bcr
         fiWQ==
X-Gm-Message-State: AJIora/sGY2LZUmGy/f6guguXy4RqwcSDWH/hilY/t1Tgj1jTdg9k2eQ
        4rKUbVtXKO3NeYlXnODWZwDb/5ggfpjlP5H+TaI=
X-Google-Smtp-Source: AGRyM1sw14PYQgx4fDDohP9Y7fIl+IS4r51qvLbc2ltU8iplXj66xVjCUG/0gsBD8GFYDO/k8AVTBGFlG5L1j4lUgis=
X-Received: by 2002:a17:907:60cc:b0:722:e564:eb11 with SMTP id
 hv12-20020a17090760cc00b00722e564eb11mr34082648ejc.736.1657036784885; Tue, 05
 Jul 2022 08:59:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220705132032.702972-1-yangyingliang@huawei.com> <20220705132032.702972-2-yangyingliang@huawei.com>
In-Reply-To: <20220705132032.702972-2-yangyingliang@huawei.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 5 Jul 2022 08:59:43 -0700
Message-ID: <CAMo8BfJvXaDnsXrA1ELKJz1QZmW+8NcQpkhkjKbkp1zxMTePCg@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] xtensa: iss: change the return type of
 iss_net_configure() to void
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yang,

On Tue, Jul 5, 2022 at 6:10 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> Change the return type of iss_net_configure() to void, because it's not used.
>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  arch/xtensa/platforms/iss/network.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

This change removes a lot of code that was added in the previous change.
Maybe fold both patches into one to avoid that pattern of adding and then
immediately removing code? Or, if you feel that changing the return type
of the iss_net_configure is an important separate step, maybe do it first?

> diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
> index 5e475f7472e4..e38ff51ce833 100644
> --- a/arch/xtensa/platforms/iss/network.c
> +++ b/arch/xtensa/platforms/iss/network.c
> @@ -472,16 +472,15 @@ static const struct net_device_ops iss_netdev_ops = {
>         .ndo_set_rx_mode        = iss_net_set_multicast_list,
>  };
>
> -static int iss_net_configure(int index, char *init)
> +static void iss_net_configure(int index, char *init)
>  {
>         struct net_device *dev;
>         struct iss_net_private *lp;
> -       int err;
>
>         dev = alloc_etherdev(sizeof(*lp));
>         if (dev == NULL) {
>                 pr_err("eth_configure: failed to allocate device\n");
> -               return -ENOMEM;
> +               return;
>         }
>
>         /* Initialize private element. */
> @@ -509,7 +508,6 @@ static int iss_net_configure(int index, char *init)
>         if (!tuntap_probe(lp, index, init)) {
>                 pr_err("%s: invalid arguments. Skipping device!\n",
>                        dev->name);
> -               err = -EINVAL;
>                 goto err_free_netdev;
>         }
>
> @@ -518,8 +516,7 @@ static int iss_net_configure(int index, char *init)
>         /* sysfs register */
>
>         if (!driver_registered) {
> -               err = platform_driver_register(&iss_net_driver);
> -               if (err)
> +               if (platform_driver_register(&iss_net_driver))
>                         goto err_free_netdev;
>                 driver_registered = 1;
>         }
> @@ -530,8 +527,7 @@ static int iss_net_configure(int index, char *init)
>
>         lp->pdev.id = index;
>         lp->pdev.name = DRIVER_NAME;
> -       err = platform_device_register(&lp->pdev);
> -       if (err)
> +       if (platform_device_register(&lp->pdev))
>                 goto err_free_netdev;
>         SET_NETDEV_DEV(dev, &lp->pdev.dev);
>
> @@ -541,23 +537,22 @@ static int iss_net_configure(int index, char *init)
>         dev->irq = -1;
>
>         rtnl_lock();
> -       err = register_netdevice(dev);
> -       rtnl_unlock();
> -
> -       if (err) {
> +       if (register_netdevice(dev)) {
> +               rtnl_unlock();
>                 pr_err("%s: error registering net device!\n", dev->name);
>                 goto err_unregister_device;
>         }
> +       rtnl_unlock();
>
>         timer_setup(&lp->tl, iss_net_user_timer_expire, 0);
>
> -       return 0;
> +       return;
>
>  err_unregister_device:
>         platform_device_unregister(&lp->pdev);
>  err_free_netdev:
>         free_netdev(dev);
> -       return err;
> +       return;

No need for 'return' at the end of the void function.

-- 
Thanks.
-- Max
