Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0D95A17A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239326AbiHYREo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiHYREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 13:04:40 -0400
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82BB8F14;
        Thu, 25 Aug 2022 10:04:40 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-33dc345ad78so46094187b3.3;
        Thu, 25 Aug 2022 10:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VFddRmqhRJ8PwkmV4UOCyBvme8R3q7QB95c/CoXiGVs=;
        b=JGJeZHviJA+SwWEzh8B2WFCNOHiIFiLBXJEorcOPBAXxuKOeDbiZ7kLcmT4h80Mxlj
         lJePewQzi+gYk9QzVtd93rRkY9gxkrymRymHqvBkac5aelGZyzshahEUsU3Cxowq22tp
         rT1w0Q2T40tWe9jGyZ+4smoHBqLZGeByUBZfxFYA8FPcpfLcCv+1tXCxUNsdbYdMweTE
         UJhiNbIsQVBB5mUmumg4H9HdM8xlMGGIII6FZ50HPU7Kueqx5h0RRogrdv+eI0L+zdmD
         o7xheAOb+l0qcMWcokNuOOhUXF7X5IL0QpaU0HLh58yQnKPwwRyj0r2iMqtOLxSA4Tv+
         Lvfw==
X-Gm-Message-State: ACgBeo3YkyDhzaXsq/M9ZKuOWQmiwBg32RqNq0C6gfsF3COxo9pOlRUi
        b/gFyfmfJ7Nzu4g1V2Ns7XXgmWDsR5mUs38ZB7SGzbgy
X-Google-Smtp-Source: AA6agR6Xf2sZVdk6BlJPihHOyBkXnUI50kUBBQJkESXxdhD3nWpQKxz6Qoj7soiG5b+v/Co9JspHUU6Q1opzhU+u2u0=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr4768143ywa.515.1661447079090; Thu, 25
 Aug 2022 10:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220825164103.27694-1-andriy.shevchenko@linux.intel.com> <20220825164103.27694-5-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220825164103.27694-5-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 19:04:28 +0200
Message-ID: <CAJZ5v0if_gZpibSWx5mfoVpGXtF0sGe7MY+eRQJr09ONX0Q1rQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] ACPI: bus: Use the matching table, if ACPI driver
 has it
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Thu, Aug 25, 2022 at 6:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> In case we have an ACPI driver, check its ID table for matching,
> This allows to use some generic device property APIs in such
> drivers.

No new provisions for ACPI drivers, please.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/bus.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 3c0f2d050d47..17c98e826bde 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1049,14 +1049,30 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
>         return match->data;
>  }
>
> +static const struct acpi_device_id *acpi_device_get_ids(const struct device *dev)
> +{
> +       if (dev->driver->acpi_match_table)
> +               return dev->driver->acpi_match_table;
> +
> +       if (dev_is_acpi(dev)) {
> +               struct acpi_driver *drv = to_acpi_driver(dev->driver);
> +
> +               if (drv->ids)
> +                       return drv->ids;
> +       }
> +
> +       return NULL;
> +}
> +
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> +       const struct acpi_device_id *ids = acpi_device_get_ids(dev);
>         const struct acpi_device_id *match;
>
> -       if (!dev->driver->acpi_match_table)
> +       if (!ids)
>                 return acpi_of_device_get_match_data(dev);
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +       match = acpi_match_device(ids, dev);
>         if (!match)
>                 return NULL;
>
> --
> 2.35.1
>
