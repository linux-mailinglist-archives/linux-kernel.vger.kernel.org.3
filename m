Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C122D58404E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 15:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiG1Nsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 09:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiG1Nsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 09:48:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8681162A4C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:48:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id j22so3287625ejs.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+1TBu687nWQgnDLvnkVse0tVKy5rmaUjY9l5bul1bw=;
        b=mnYFb6Z0gowla85/6p8edOEMndatPD9pHHbUPzZ2s4k7oY8QU0bfnxMTqkBA21e7M9
         c2HgrfohogAzB8QnNIq1ZBa+YhuniXejTt3Dfv81dER5eYLZmVwEQrMljZ9MCdmcrPli
         72ZDcJm/ZLjMZLjDuDPbGuADQBUOXTGa1k1U/e5l5wZH7KDrYiF0tpU6RiVcUoQ/oseb
         MSZxyLJyqwlLnLmgeUaG5sEuziiKXyUpMyhDW8hAvdM5efY6/7saWadMWNdWSuNsJmFU
         Zjzsop40EXqXk3c8H7uinr3UkW9fd93I6Vyzm974gVlTX2/4xP7gUmiGBGeGN/4RBJXN
         WIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+1TBu687nWQgnDLvnkVse0tVKy5rmaUjY9l5bul1bw=;
        b=7ymAsFtWAhv1KRnSXj3iCHT37nzsLLNFR8lxB/9k2SOhaJH0VsM9UG+pKbRW+OWXDZ
         ArL2DycsqI6Dg8RHdvzVq5GDS2n9RS4jWfE6ODBw3awhvoApi7VcwWF9skHJWdp4k3q4
         8VTueEEMWHngJw1cwvs2D0oXBX0SB9e/9H9MB3WgzqlbTt1BXp62w0C69gfA3Kib8oGS
         Xf5KH4n5Mz4SM7CzMEZg7oZz8XgUuiI5N6YWgnKnB3b0zudf/HDFUpU/JVfjN5eWgDG3
         +mC1Sy8BUlpAk0cK5IGqoYk8LOU2r1aiOwABQNoF3zR6+i3a4vFiynouk0liCJ0Bm/pO
         Tn5Q==
X-Gm-Message-State: AJIora82Gux5iSXtqzmPET3TC37b2QIjlKAD6liX51w6TEjMJaV4H7ad
        hI1aHckQIVr/EFbsOv4U+Rs+No10bXopFFjp2yd/4A==
X-Google-Smtp-Source: AGRyM1sF5rXxF3KvP5Js0FEK0zzhguPLYc3HGt8R2vajyLSw++pPaBZPBHljYOhtWkFFGphjXk99ORezR9cjYgIjEg8=
X-Received: by 2002:a17:907:9482:b0:72b:8c16:dac0 with SMTP id
 dm2-20020a170907948200b0072b8c16dac0mr18130555ejc.286.1659016107934; Thu, 28
 Jul 2022 06:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220726091448.81746-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726091448.81746-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 28 Jul 2022 15:48:17 +0200
Message-ID: <CAMRc=MepfRwCvkos5yqQMHk0m=yXXqSv3O+nYWW0x6MuKE=t4Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: 74xx-mmio: Use bits instead of plain numbers
 for flags
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 11:14 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The initial code was misleading to use bitwise AND against plain number,
> and the commit d3054ba1db62 ("gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag
> in mmio_74xx_dir_in()") missed that. Switch definitions to be defined bits
> for the correct comparison.
>
> Fixes: d3054ba1db62 ("gpio: 74xx-mmio: Check MMIO_74XX_DIR_IN flag in mmio_74xx_dir_in()")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-74xx-mmio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-74xx-mmio.c b/drivers/gpio/gpio-74xx-mmio.c
> index cd399898ed12..0464f1ecd20d 100644
> --- a/drivers/gpio/gpio-74xx-mmio.c
> +++ b/drivers/gpio/gpio-74xx-mmio.c
> @@ -13,8 +13,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/property.h>
>
> -#define MMIO_74XX_DIR_IN       (0 << 8)
> -#define MMIO_74XX_DIR_OUT      (1 << 8)
> +#define MMIO_74XX_DIR_IN       BIT(8)
> +#define MMIO_74XX_DIR_OUT      BIT(9)
>  #define MMIO_74XX_BIT_CNT(x)   ((x) & GENMASK(7, 0))
>
>  struct mmio_74xx_gpio_priv {
> --
> 2.35.1
>

Applied, thanks!

Bart
