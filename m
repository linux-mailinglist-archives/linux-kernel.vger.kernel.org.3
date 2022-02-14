Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7C4B53CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355421AbiBNOzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 09:55:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237244AbiBNOzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 09:55:33 -0500
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20791DA6A;
        Mon, 14 Feb 2022 06:55:25 -0800 (PST)
Received: by mail-vk1-f177.google.com with SMTP id a6so8947015vkc.3;
        Mon, 14 Feb 2022 06:55:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gC/Q1uh5kmjQ4hXMjIOzj5SEhCnmO+Fr6QfWIQK4Dw4=;
        b=KOO4fkJP0hJA1NDfpKgnVK0Z8QTv9OP4mXiARWqtojngCYyhO6xK4QHkUOIEQp1xX3
         XCoNhTZGbyQ6RAc+Df6QtIM62XrOmk513gAHg4MUlPnAa4CjDlxzJ+CYaSSXqQrKFkXP
         Y89Gv4+R2f8IsrkUqQWVtJlp4Myu6SYW347iL4YchnBl1fQgBOoN0G+Os9jBxk3gnY2o
         3aDKcUuI5B3ZWqlmM4zdJay+gzXZQqVurKs9eU1hubBnQEjO19AYVft5iQi9lXRwl+om
         BYvicGTzTfVhAN6ES50ayz1iHqxGr+gYi7aIkGGX6qdrxsrAKyezcsChX/OrbnYdIMt/
         R/5Q==
X-Gm-Message-State: AOAM532G62MczzTlfF5qgzanwjx1efjbntntqWGHamIiXB7HotHQhTbF
        cqA2aEpKki1qQVjQF8XkkJ8kzBGDdWxTLA==
X-Google-Smtp-Source: ABdhPJxYEsKXMIYanyq4SKxvO4NDWUy6BTGbJxfYNID4I2h63g3FJWnQbkHdFMiDn/Y1NWDyFC9/Yg==
X-Received: by 2002:a1f:2f81:: with SMTP id v123mr43583vkv.21.1644850524553;
        Mon, 14 Feb 2022 06:55:24 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id m3sm2369745vso.0.2022.02.14.06.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 06:55:24 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id e5so1620352vsg.12;
        Mon, 14 Feb 2022 06:55:24 -0800 (PST)
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr4041515vst.68.1644850523869;
 Mon, 14 Feb 2022 06:55:23 -0800 (PST)
MIME-Version: 1.0
References: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220214143248.502-1-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 14 Feb 2022 15:55:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXLSLsgap4ACtE0L2hOjuzGJ-HbPvGb-z-HEb55GjbntA@mail.gmail.com>
Message-ID: <CAMuHMdXLSLsgap4ACtE0L2hOjuzGJ-HbPvGb-z-HEb55GjbntA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] driver core: add a wrapper to device probe log
 helper to return pointer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>
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

Hi Andy,

On Mon, Feb 14, 2022 at 3:32 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Sometimes the ->probe() function can be split to the core and actual probe
> parts. In such cases the core one may return a pointer to the allocated
> resource, or error pointer in unsuccessful scenario. Allow that kind of
> core function to use dev_err_probe_ptr(), so the following excerpt
>
>         ret = bar(...);
>         if (ret) {
>                 dev_err_probe(dev, ret, ...);
>                 return ERR_PTR(ret);
>         }
>
> can be replaced with
>
>         ret = bar(...);
>         if (ret)
>                 return dev_err_probe_ptr(dev, ret, ...);
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -14,6 +14,7 @@
>
>  #include <linux/dev_printk.h>
>  #include <linux/energy_model.h>
> +#include <linux/err.h>
>  #include <linux/ioport.h>
>  #include <linux/kobject.h>
>  #include <linux/klist.h>
> @@ -982,6 +983,13 @@ void device_links_supplier_sync_state_resume(void);
>  extern __printf(3, 4)
>  int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
>
> +/* As above, but returns error pointer */
> +static inline __printf(3, 0)
> +void *dev_err_probe_ptr(const struct device *dev, int err, const char *fmt, va_list args)

Shouldn't this be a varargs function, like dev_err_probe()?

> +{
> +       return ERR_PTR(dev_err_probe(dev, err, fmt, args));
> +}
> +
>  /* Create alias, so I can be autoloaded. */
>  #define MODULE_ALIAS_CHARDEV(major,minor) \
>         MODULE_ALIAS("char-major-" __stringify(major) "-" __stringify(minor))

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
