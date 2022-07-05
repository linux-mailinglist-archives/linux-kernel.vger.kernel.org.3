Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC51F5676EE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiGESya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiGESy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:54:27 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2913193FF
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:54:26 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 64so14179084ybt.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 11:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAczJeYcyqiN7KVfrRoJ6VQx+X3W9GuPya2JhuP15VI=;
        b=sbHLfy93zxO2jZlP14NUpxtJ70FHu6NB6T/IG9mWcGv5tfhayAmByj16/gfW2JJTLC
         pwyvgs/RB61a6y96htxrZJJCiCC+gTgfX4IpEfFg4cWaGCrvWy9f5O2wArdLz7xj1f/i
         DBJmC+SVM8qssWKoDUyp9xlh7DJ71g1ZZoT2kvYWsw6St9QatNK6VIdsHoFiXdUE8Jm+
         Yr6b5hUPYoG2NCXC6tn2l/5IKo1CTn7+GyY2egqgrDq6tPg7FU67vgtpUM1dRuktkEV9
         3QdX1xtQ2/GXBamSZ/4lzmX+0FdGDd9F5PUYZ7MWzrEbBEE9IKJxQCmSH5KKKUAYj5dp
         sKhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAczJeYcyqiN7KVfrRoJ6VQx+X3W9GuPya2JhuP15VI=;
        b=x34oxP0B4c/pTIiLDWHjo6FfAds7bJogxFZZg48Bn8Huq7yioi6CaxH2i9B5w4oemD
         QubNCpPq7t0APBrGN84Jmygb/RAXWLteZQgmuT9A9G3ONJOZ2LtVKGizJbLFLmOiLtrW
         QG8Yv4X1VJL2p1250N2r+M3tedh+DK3z/iHkWM5hrllmAGG328w6uGm6E6SrRXQONJp/
         an+Ml6BhZoJfg0c/oTVoj7t3hmwlQZw01TYy1l4zxLVJByw+W0Erp5wCsrh3UpMRYU9/
         4x2iLG0MVtUIDYxcASLObfeJHWJJXxbUCtC/bcBRICrnKzxpbcF584u0HNsKgyXREPZE
         jbYA==
X-Gm-Message-State: AJIora9oZoH3PiiN46zFFNDnklm6eSSjNvPIwtAbqwGG83OHLK6X3q6z
        ZdhVqpu0LJehLe/GsKPmsFP7LQpmEreojDrH+rM2Pw==
X-Google-Smtp-Source: AGRyM1tfiL0znY+SqkPuvB2I2t+PGDDF0kLxsNtor+Cn95IIsQTZo397fuVAAFbTQREbuQOwJSEKKzV0+gdwuwlF1g4=
X-Received: by 2002:a25:9947:0:b0:663:ec43:61eb with SMTP id
 n7-20020a259947000000b00663ec4361ebmr39017812ybo.115.1657047265825; Tue, 05
 Jul 2022 11:54:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220705131951.1388968-1-michael@walle.cc>
In-Reply-To: <20220705131951.1388968-1-michael@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 5 Jul 2022 11:53:49 -0700
Message-ID: <CAGETcx9W3W1P2fHVBuLOJNYz1rOU6hm9fc0=JukhbxJM6gRB1w@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: gadget: udc: atmel: check rc of devm_gpiod_get_optional()
To:     Michael Walle <michael@walle.cc>
Cc:     Cristian Birsan <cristian.birsan@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 6:19 AM Michael Walle <michael@walle.cc> wrote:
>
> devm_gpiod_get_optional() might still return an error code, esp.
> EPROBE_DEFER. Return any errors.
>
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index ae2bfbac603e..48355e0cee76 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2165,6 +2165,8 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>
>         udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
>                                                 GPIOD_IN);
> +       if (IS_ERR(udc->vbus_pin))
> +               return ERR_CAST(udc->vbus_pin);

I'm confused. Is it really an optional resource if you treat a failure to get it
as a reason to fail a probe?

-Saravana

>
>         if (fifo_mode == 0) {
>                 udc->num_ep = udc_config->num_ep;
> --
> 2.30.2
>
