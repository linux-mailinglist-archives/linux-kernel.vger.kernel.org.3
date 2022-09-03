Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AA5AC0E4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbiICSnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 14:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233014AbiICSnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 14:43:21 -0400
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79A55A2F3;
        Sat,  3 Sep 2022 11:43:07 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-33dce2d4bc8so41714767b3.4;
        Sat, 03 Sep 2022 11:43:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HwYOgy3zjOIkUemctgk5rYZBZTmWSTF6W5pZxZvAJgQ=;
        b=6DXtTvyAfhrXKNHu8fam1Ys0tS5VnN4PY5eLjpst7AjLv9WWv6dUAgYTiOcbqRXqwH
         fvLobn9c0B7TbJl5igG9WoON+1d8BD7+uZJ8kSoFyVZW8AjSZTNRlxhxzxMo0FxN+UMS
         iYJJqH8G2anTmCBQF3E6/xITzy+CNLr7aZekQKif4cT1EtooHpj67Y87hXixJcUoXsUN
         1s2r26my1kF7+fsUbeC2X4Lcl+rlFXCqk/wVobqwncuQ6tLtEGIpy5xpuEZ9G+5Wb7Nk
         xEwdWEwPQMln0FIIpyz+gU3vj5fcXnWLGBukRqh3uNV2CvKQiA4YT1bWEOBJ0dW6hDa8
         hyvg==
X-Gm-Message-State: ACgBeo2Cnu00mvxN8yn+Xn5aCp8cGIzMAWwmEqtKCW47kD5rY9+7DCLu
        qxTxC/tMgrGzvwky6s+aoEQCQEloDPEwMSwsYmE=
X-Google-Smtp-Source: AA6agR5hTZSytWkFK60t4lqd3xPUE1Kkrp5WF+DjNbCz9cnaCaGumC2NHors5Mf8d+bn8AFN4GwRC/sg1xazozUYhoA=
X-Received: by 2002:a81:4850:0:b0:33c:922b:5739 with SMTP id
 v77-20020a814850000000b0033c922b5739mr32031824ywa.515.1662230586823; Sat, 03
 Sep 2022 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220826171635.15652-1-andriy.shevchenko@linux.intel.com> <20220826171635.15652-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220826171635.15652-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 3 Sep 2022 20:42:55 +0200
Message-ID: <CAJZ5v0g93SH6ty2J=36jOV0fs+KoGc8h5DtbU=FU0S-yNiAQGg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ACPI: bus: Refactor ACPI matching functions for
 better readability
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

On Fri, Aug 26, 2022 at 7:16 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> With temporary variables for OF and ACPI IDs, it's easier to read
> the code. No functional change intended.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: refactored another function (due to drop the rest of the series)
>  drivers/acpi/bus.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index f3e868d35144..d466c8195314 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -925,12 +925,13 @@ static const void *acpi_of_device_get_match_data(const struct device *dev)
>
>  const void *acpi_device_get_match_data(const struct device *dev)
>  {
> +       const struct acpi_device_id *acpi_ids = dev->driver->acpi_match_table;
>         const struct acpi_device_id *match;
>
> -       if (!dev->driver->acpi_match_table)
> +       if (!acpi_ids)
>                 return acpi_of_device_get_match_data(dev);
>
> -       match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +       match = acpi_match_device(acpi_ids, dev);
>         if (!match)
>                 return NULL;
>
> @@ -948,14 +949,13 @@ EXPORT_SYMBOL(acpi_match_device_ids);
>  bool acpi_driver_match_device(struct device *dev,
>                               const struct device_driver *drv)
>  {
> -       if (!drv->acpi_match_table)
> -               return acpi_of_match_device(ACPI_COMPANION(dev),
> -                                           drv->of_match_table,
> -                                           NULL);
> -
> -       return __acpi_match_device(acpi_companion_match(dev),
> -                                  drv->acpi_match_table, drv->of_match_table,
> -                                  NULL, NULL);
> +       const struct acpi_device_id *acpi_ids = drv->acpi_match_table;
> +       const struct of_device_id *of_ids = drv->of_match_table;
> +
> +       if (!acpi_ids)
> +               return acpi_of_match_device(ACPI_COMPANION(dev), of_ids, NULL);
> +
> +       return __acpi_match_device(acpi_companion_match(dev), acpi_ids, of_ids, NULL, NULL);
>  }
>  EXPORT_SYMBOL_GPL(acpi_driver_match_device);
>
> --

Applied along with the [1/2] as 6.1 material, thanks!
