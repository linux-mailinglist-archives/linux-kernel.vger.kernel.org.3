Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D741F54B3E5
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbiFNOwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244279AbiFNOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 10:52:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B34920F6F;
        Tue, 14 Jun 2022 07:52:32 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n28so12003072edb.9;
        Tue, 14 Jun 2022 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmnLHQKIq/Qwpw3bROli63abqMMrdwZuMr4hqttXvi8=;
        b=VaLkfDeTNu6KkT5rS6rZ4nkj8x7jr5Tbjxla6ZXrToXpigafc0fk2AEEqPXR3nyHt3
         ecKU50Si8+kMyq7s2CILNxQUI8KXD0m5ekQKxe1mDzheGgHVLLYuNKeExATL7FEb+uqT
         NqRwo2uU3W0xF01h/1ejx3SNwUkln0iU1u1vUBmFfIPCP76w8zKmGF3IarOf17QetP7m
         JgQeuvP+rq2QwkF4tzeU2/HADL4i5/iFd8+jcvV3TbzH/odMjB3lxBvEx/Q/cBDtIGNl
         CzoGOPQnK2hGHjJs6p9rKRPNifL6LvkYMu8auKgLx+sAkVqBBdAcS1qdaR8sJhDcvV79
         vl6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmnLHQKIq/Qwpw3bROli63abqMMrdwZuMr4hqttXvi8=;
        b=NXhaeCKnea5oPycNepu0IskEBdjOqCsnM0n71GNRJMGkgz942U4c+tWbpogosWdZBp
         vI/vpSi8KOS/MKKlBmztlxKfNwlfHMunAYgUNrwEkRMJEokK6GQPuqYV+I3DR53APb+v
         Hn91NLq0CODEXsfiu82uddIaHqGr5S2B6B19kqwF2iVNauWbWF4myiOGTBCr2z5rUuz3
         94n0k821gC0cpVWIhmb3eIvPLDytcleiS0t+9gJeJEaWpKDKpWQa+vLAWq5OBwxBN5hk
         Cnqgl6fs6pSWYx9w4TJ4jsgRAlGQV0QtcrV9ZysIPIG5KqRSCWwpT3ETO6dISIPzBvOL
         4DFA==
X-Gm-Message-State: AJIora/vwM3Elao82obJWH3yqhr7qyTD+aemOaFXR0xbUPy+zpbomKXD
        mMn6kqhmLO/cK9n+vem51ktrQMj50GEcNLLA/+o=
X-Google-Smtp-Source: ABdhPJwavfre5IkSew79d1lWafxiOtQ5nWlFLC7RO+RWMsDFfncyk6FoEkhpqtyBp2eDMdjA8iEDdBnOI3E8hYEs5/w=
X-Received: by 2002:aa7:c396:0:b0:42d:8b86:a8dc with SMTP id
 k22-20020aa7c396000000b0042d8b86a8dcmr6466658edq.54.1655218350390; Tue, 14
 Jun 2022 07:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220614142704.155496-1-jjhiblot@traphandler.com> <20220614142704.155496-4-jjhiblot@traphandler.com>
In-Reply-To: <20220614142704.155496-4-jjhiblot@traphandler.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Jun 2022 16:51:53 +0200
Message-ID: <CAHp75VdwiptUUHwDT8bZmY4r7beiiT9NFD9o_-=+KiqMcqGhcg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] leds: tlc5925: Add support for non blocking operations
To:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc:     Pavel Machek <pavel@ucw.cz>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Tue, Jun 14, 2022 at 4:27 PM Jean-Jacques Hiblot
<jjhiblot@traphandler.com> wrote:
>
> Settings multiple LEDs in a row can be a slow operation because of the
> time required to acquire the bus and prepare the transfer.
> And, in most cases, it is not required that the operation is synchronous.
>
> Implementing the non-blocking brightness_set() for such cases.
> A work queue is used to perform the actual SPI transfer.
>
> The blocking method is still available in case someone needs to perform
> this operation synchronously (ie by calling led_set_brightness_sync()).
>
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
> ---
>  drivers/leds/leds-tlc5925.c | 39 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/leds/leds-tlc5925.c b/drivers/leds/leds-tlc5925.c
> index eeab1138ba2c..2c083b04d7f6 100644
> --- a/drivers/leds/leds-tlc5925.c
> +++ b/drivers/leds/leds-tlc5925.c
> @@ -14,6 +14,7 @@
>  #include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/property.h>
> +#include <linux/workqueue.h>
>  #include <linux/spi/spi.h>
>
>  struct single_led_priv {
> @@ -24,10 +25,24 @@ struct single_led_priv {
>  struct tlc5925_leds_priv {
>         int max_num_leds;
>         unsigned long *state;
> +       struct spi_device *spi;
> +       struct work_struct xmit_work;
>         struct single_led_priv leds[];
>  };
>
> -static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
> +static int xmit(struct tlc5925_leds_priv *priv)
> +{
> +       return spi_write(priv->spi, priv->state, BITS_TO_BYTES(priv->max_num_leds));
> +}
> +
> +static void xmit_work(struct work_struct *ws)
> +{
> +       struct tlc5925_leds_priv *priv =
> +               container_of(ws, struct tlc5925_leds_priv, xmit_work);

+ Blank line.

> +       xmit(priv);
> +};
> +
> +static void tlc5925_brightness_set(struct led_classdev *cdev,
>                                             enum led_brightness brightness)
>  {
>         struct spi_device *spi = to_spi_device(cdev->dev->parent);
> @@ -40,9 +55,25 @@ static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
>         // assign_bit() is atomic, no need for lock
>         assign_bit(index, priv->state, !!brightness);
>
> -       return spi_write(spi, priv->state, BITS_TO_BYTES(priv->max_num_leds));
> +       schedule_work(&priv->xmit_work);
>  }
>
> +static int tlc5925_brightness_set_blocking(struct led_classdev *cdev,
> +                                           enum led_brightness brightness)
> +{
> +       struct spi_device *spi = to_spi_device(cdev->dev->parent);
> +       struct tlc5925_leds_priv *priv = spi_get_drvdata(spi);

> +       struct single_led_priv *led = container_of(cdev,
> +                                                  struct single_led_priv,
> +                                                  cdev);

Better:

       struct single_led_priv *led =
                        container_of(cdev, struct single_led_priv, cdev);

...

> +       // assign_bit() is atomic, no need for lock

The useless comment.

-- 
With Best Regards,
Andy Shevchenko
