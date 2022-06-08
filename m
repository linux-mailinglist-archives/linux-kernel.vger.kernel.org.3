Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D4A542F36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238049AbiFHLaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbiFHLah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:30:37 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389031AD583;
        Wed,  8 Jun 2022 04:30:35 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id w2so36004213ybi.7;
        Wed, 08 Jun 2022 04:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlgYO+bip0yzJhTmaDAIl+udLxQZzTWVZEkxEFdd1Mc=;
        b=V/bTwBCch+vzdcmHbZA/s62YgqoITcahP3x5Z3IZvGBJqOuE+gLB8DRLNhQWKZh6Mn
         CIytul3c1Ltzgk0TW7HWExoYKgrKB+8JOJ7I5Dpg4b6eK7gGXylS+tAE4xNzw8tOOZsQ
         atY5GBm7cKT9elgubCFh+Lks/7CfOMAmWh4ARyYTd4XJh5o2aA2JP6Mv45I/nnbIZxi5
         1UQ3iim4xGBl5bYADeQ0vQ4Q0Q1CRxbyyIFb2mg4w96TOOa1qpMmOt4+GL9nLVpYQBU2
         dhg1xMLbmpwsAWY+dbSTcb4FBdroDd2jw/SgByOnW+wKXd5m5LhK/d+w8EfPmWuuChRb
         8m/Q==
X-Gm-Message-State: AOAM530mqqp64DYwa8HXZkJBSvGPYkuHWPLWsm5DTzyhk/gGSf4QzCtg
        SnycZXiKGGIaFT5fb3lSECZrI0S0h78woeMgHok=
X-Google-Smtp-Source: ABdhPJyjJt66ywABix4n+Uqr4v5bKlnNj/pg34gwqyDLf5AarFlUIZ3d2wh1QuEZO767pg+ED8NQyl9Iqo/SYjLzO/I=
X-Received: by 2002:a25:6b50:0:b0:64f:4b33:664 with SMTP id
 o16-20020a256b50000000b0064f4b330664mr36316791ybm.153.1654687834352; Wed, 08
 Jun 2022 04:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220607202058.8304-1-andriy.shevchenko@linux.intel.com> <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220607202058.8304-2-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 8 Jun 2022 13:30:23 +0200
Message-ID: <CAJZ5v0i-2gRL2ujY7mBUPjU9v_eCdBDZzQo3KD6SBEgTJDsyTw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] spi: Use device_find_first_child() instead of
 custom approach
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Tue, Jun 7, 2022 at 10:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> We have already a helper to get the first child device, use it and
> drop custom approach.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Nice cleanup.

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/spi/spi.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index ea09d1b42bf6..87dc8773108b 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -2613,11 +2613,6 @@ int spi_slave_abort(struct spi_device *spi)
>  }
>  EXPORT_SYMBOL_GPL(spi_slave_abort);
>
> -static int match_true(struct device *dev, void *data)
> -{
> -       return 1;
> -}
> -
>  static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
>                           char *buf)
>  {
> @@ -2625,7 +2620,7 @@ static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
>                                                    dev);
>         struct device *child;
>
> -       child = device_find_child(&ctlr->dev, NULL, match_true);
> +       child = device_find_first_child(&ctlr->dev);
>         return sprintf(buf, "%s\n",
>                        child ? to_spi_device(child)->modalias : NULL);
>  }
> @@ -2644,7 +2639,7 @@ static ssize_t slave_store(struct device *dev, struct device_attribute *attr,
>         if (rc != 1 || !name[0])
>                 return -EINVAL;
>
> -       child = device_find_child(&ctlr->dev, NULL, match_true);
> +       child = device_find_first_child(&ctlr->dev);
>         if (child) {
>                 /* Remove registered slave */
>                 device_unregister(child);
> --
> 2.35.1
>
