Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE39D5AAB3D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235679AbiIBJTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiIBJTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:19:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EBDBD1CB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:19:15 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j6so1226932qkl.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wN1g1xDoFb13lisdj6+cGYCXIaptZ92KuDnigLzcS88=;
        b=a7Nge74CosWKyQX1L03O/zbvmcA1xfA3j0HobwDvTY31WHlj98Ami8ApDE3Ae+E6Cc
         ROPMyJZcA0GBUu5jtF9amoi5RYqXj0R8N1E/Dn+rqAD+2y0WzOP6taxRKJJU5RTrUKR0
         v+wDPXvgvT/tk1DZpGS55Tfd1pNLTLZIGJ8Rc92BHhik0ZuKdWSPj3b339CZlid0j2Em
         pcg1HRkyCZ6lV+KiFQQR1uDEOFqAXYxXib3rlh+PQQwgzOvkWDoiaFJkAnfpGRwzpZaS
         Xp9QAiO/I3HFV32a8ToZZWBLAKTySV5GLJKg9SV07TO47ihBDKK0dEDxc5pVczClFyEA
         prZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wN1g1xDoFb13lisdj6+cGYCXIaptZ92KuDnigLzcS88=;
        b=MjdsBXirRwmj9+aF/RzSp05/WmFdXnvSBbYUqfsroafNgXVCG8/DIk/HXtPEwxY6E9
         xxva6VqyGhDaLmNZdrBrFmnMEDvfAfS+gTvIH61e3YA4EURw5qYVc3RRNyldX5eNzWJ3
         yXoX3RKegxb5cED7AihFuXdwlTILvbBy7K9Vexp6/GIROPYSx4iAmTa81YkabScEfbjt
         9UYS8P/4koNDzfCkmzBZfjpz/5KV2KN3y19ZmOabfbQeLdr1GF5Y5yE0XW4pHR8wAsUh
         X1KoM7HHGkLgGdDBr/obFZUSqSrqq6uPdSJ8DDFbzaO6NrEp36So+7L6+euadRwBBz2C
         oOjg==
X-Gm-Message-State: ACgBeo1DeJWfDzI309tk3q1IB852RU46zF3EEetis+jh9BEZm24QBUZY
        yyZjV1y8L7VuYBr7kDzMSSvu+AqjwV2hiYv9el0=
X-Google-Smtp-Source: AA6agR4katP00xVnTBW1U3/ZYh4xrZjbooFVNdP9HS5rJOykScomj2tHnTG8Rp6K5pKrfE1jskOuqDsLxWm/F5h9TcM=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr23120785qkp.504.1662110354404; Fri, 02
 Sep 2022 02:19:14 -0700 (PDT)
MIME-Version: 1.0
References: <1662104841-55360-1-git-send-email-john.garry@huawei.com> <1662104841-55360-6-git-send-email-john.garry@huawei.com>
In-Reply-To: <1662104841-55360-6-git-send-email-john.garry@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 12:18:38 +0300
Message-ID: <CAHp75VdfwGCUpZN3b1AD1kARc=FhyA4EDWDuZ8+1DKN3u73DeA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] bus: hisi_lpc: Use platform_device_register_full()
To:     John Garry <john.garry@huawei.com>
Cc:     "xuwei (O)" <xuwei5@hisilicon.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SoC Team <soc@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>
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

On Fri, Sep 2, 2022 at 11:10 AM John Garry <john.garry@huawei.com> wrote:
>
> The code to create the child platform device is essentially the same as
> what platform_device_register_full() does, so change over to use
> that same function to reduce duplication.

Now statistics plays for you and not against.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/bus/hisi_lpc.c | 64 ++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
> index 74f4448bff9d..3555a6857214 100644
> --- a/drivers/bus/hisi_lpc.c
> +++ b/drivers/bus/hisi_lpc.c
> @@ -472,9 +472,7 @@ static int hisi_lpc_acpi_clear_enumerated(struct acpi_device *adev, void *not_us
>
>  struct hisi_lpc_acpi_cell {
>         const char *hid;
> -       const char *name;
> -       void *pdata;
> -       size_t pdata_size;
> +       const struct platform_device_info *pdevinfo;
>  };
>
>  static void hisi_lpc_acpi_remove(struct device *hostdev)
> @@ -505,28 +503,45 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
>                 /* ipmi */
>                 {
>                         .hid = "IPI0001",
> -                       .name = "hisi-lpc-ipmi",
> +                       .pdevinfo = (struct platform_device_info []) {
> +                               {
> +                                       .parent = hostdev,
> +                                       .fwnode = acpi_fwnode_handle(child),
> +                                       .name = "hisi-lpc-ipmi",
> +                                       .id = PLATFORM_DEVID_AUTO,
> +                                       .res = res,
> +                                       .num_res = num_res,
> +                               },
> +                       },
>                 },
>                 /* 8250-compatible uart */
>                 {
>                         .hid = "HISI1031",
> -                       .name = "serial8250",
> -                       .pdata = (struct plat_serial8250_port []) {
> +                       .pdevinfo = (struct platform_device_info []) {
>                                 {
> -                                       .iobase = res->start,
> -                                       .uartclk = 1843200,
> -                                       .iotype = UPIO_PORT,
> -                                       .flags = UPF_BOOT_AUTOCONF,
> +                                       .parent = hostdev,
> +                                       .fwnode = acpi_fwnode_handle(child),
> +                                       .name = "serial8250",
> +                                       .id = PLATFORM_DEVID_AUTO,
> +                                       .res = res,
> +                                       .num_res = num_res,
> +                                       .data = (struct plat_serial8250_port []) {
> +                                               {
> +                                                       .iobase = res->start,
> +                                                       .uartclk = 1843200,
> +                                                       .iotype = UPIO_PORT,
> +                                                       .flags = UPF_BOOT_AUTOCONF,
> +                                               },
> +                                               {}
> +                                       },
> +                                       .size_data =  2 * sizeof(struct plat_serial8250_port),
>                                 },
> -                               {}
>                         },
> -                       .pdata_size = 2 *
> -                               sizeof(struct plat_serial8250_port),
>                 },
>                 {}
>         };
>
> -       for (; cell && cell->name; cell++) {
> +       for (; cell && cell->hid; cell++) {
>                 if (!strcmp(cell->hid, hid)) {
>                         found = true;
>                         break;
> @@ -540,31 +555,12 @@ static int hisi_lpc_acpi_add_child(struct acpi_device *child, void *data)
>                 return 0;
>         }
>
> -       pdev = platform_device_alloc(cell->name, PLATFORM_DEVID_AUTO);
> +       pdev = platform_device_register_full(cell->pdevinfo);
>         if (!pdev)
>                 return -ENOMEM;
>
> -       pdev->dev.parent = hostdev;
> -       ACPI_COMPANION_SET(&pdev->dev, child);
> -
> -       ret = platform_device_add_resources(pdev, res, num_res);
> -       if (ret)
> -               goto fail;
> -
> -       ret = platform_device_add_data(pdev, cell->pdata, cell->pdata_size);
> -       if (ret)
> -               goto fail;
> -
> -       ret = platform_device_add(pdev);
> -       if (ret)
> -               goto fail;
> -
>         acpi_device_set_enumerated(child);
>         return 0;
> -
> -fail:
> -       platform_device_put(pdev);
> -       return ret;
>  }
>
>  /*
> --
> 2.35.3
>


-- 
With Best Regards,
Andy Shevchenko
