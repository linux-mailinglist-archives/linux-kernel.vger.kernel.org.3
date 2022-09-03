Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C75AC0EB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiICStr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiICSto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:49:44 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFC1A83B;
        Sat,  3 Sep 2022 11:49:42 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g5so7500064ybg.11;
        Sat, 03 Sep 2022 11:49:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bMwioAq1G1Ik7SGThRFgWwX+Nh6l9BOWyd8tJCEd6LE=;
        b=A962bgQWR/jnkoCetaU8qP1kGiKp6FGBd2wy8nHHHhSCWH7h+jQHeuKpjK9Ty+O7Tk
         pmC5peZv4IaltrXI5XVR1puq0kiYKeUlaHixWsvw0FQKCs7tgdoa7B98nOBcyY6fRIaC
         XUjpLfSvWG05Wy36xReGv7t+c74/P6gS7zp2ap2j69kbiisd8YDFo9pNO6/kFDdkglZN
         KrfD9RqTXpevagd6bpaotPXpseJwCEkix443mi2YoO4Qw5DmtxfpRFglZWWH5zdY+I1k
         NxX++XgNS+XvgLokCrPLeeB7Y4VuRxfruEJGQnjpvI3zmCJB8fOJ8T5NXV8gqyAEbIvx
         RKLA==
X-Gm-Message-State: ACgBeo0Lu1uoamS/HGEgDfYG7FS4jBXmR75HqE65d8Eyn86VMRSmk6v+
        taabBim7VnP+ILPIMB92bZlcimz8tdxjtSTr9jk=
X-Google-Smtp-Source: AA6agR4yngYHupCP9iZ9ZOxOiHJGLuL7Jj6UDvJN1fbcmawITR/dUO7g9x9qO4Sh8RG33d/m1lZSzAke3j9gaIBgiIg=
X-Received: by 2002:a25:b749:0:b0:68f:171f:96bd with SMTP id
 e9-20020a25b749000000b0068f171f96bdmr28896490ybm.137.1662230981787; Sat, 03
 Sep 2022 11:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220829141129.65916-1-andriy.shevchenko@linux.intel.com> <20220829141129.65916-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220829141129.65916-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:49:31 +0200
Message-ID: <CAJZ5v0hbEYrtLpKbeAOmn-hqSpKCH1Jo5QnQHfkws00UWBYK4A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] ACPI: LPSS: Deduplicate skipping device in acpi_lpss_create_device()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 4:11 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Add a new label to deduplicate skipping device code in the
> acpi_lpss_create_device(). No functional change intended.
>
> While at it, convert the last conditional to use the classical
> pattern, i.e.
>
>         if (err)
>                 ...handle err...
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/acpi_lpss.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
> index c39a0a88f3a3..7a73528aa9c2 100644
> --- a/drivers/acpi/acpi_lpss.c
> +++ b/drivers/acpi/acpi_lpss.c
> @@ -670,9 +670,7 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>         if (!pdata->mmio_base) {
>                 /* Avoid acpi_bus_attach() instantiating a pdev for this dev. */
>                 adev->pnp.type.platform_id = 0;
> -               /* Skip the device, but continue the namespace scan. */
> -               ret = 0;
> -               goto err_out;
> +               goto out_free;
>         }
>
>         pdata->adev = adev;
> @@ -683,11 +681,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>
>         if (dev_desc->flags & LPSS_CLK) {
>                 ret = register_device_clock(adev, pdata);
> -               if (ret) {
> -                       /* Skip the device, but continue the namespace scan. */
> -                       ret = 0;
> -                       goto err_out;
> -               }
> +               if (ret)
> +                       goto out_free;
>         }
>
>         /*
> @@ -699,15 +694,19 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
>
>         adev->driver_data = pdata;
>         pdev = acpi_create_platform_device(adev, dev_desc->properties);
> -       if (!IS_ERR_OR_NULL(pdev)) {
> -               acpi_lpss_create_device_links(adev, pdev);
> -               return 1;
> +       if (IS_ERR_OR_NULL(pdev)) {
> +               adev->driver_data = NULL;
> +               ret = PTR_ERR(pdev);
> +               goto err_out;
>         }
>
> -       ret = PTR_ERR(pdev);
> -       adev->driver_data = NULL;
> +       acpi_lpss_create_device_links(adev, pdev);
> +       return 1;
>
> - err_out:
> +out_free:
> +       /* Skip the device, but continue the namespace scan */
> +       ret = 0;
> +err_out:
>         kfree(pdata);
>         return ret;
>  }
> --

Applied along with the [2/2] as 6.1 material, thanks!
