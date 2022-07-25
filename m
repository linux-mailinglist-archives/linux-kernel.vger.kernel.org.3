Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31420580676
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 23:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiGYVZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 17:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiGYVZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 17:25:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC601D0F8;
        Mon, 25 Jul 2022 14:24:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fy29so22759743ejc.12;
        Mon, 25 Jul 2022 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YTknDddjpAEn0Nysyw1v1gQmmPikHyQfCRNmNWeBzvs=;
        b=nww1KyATuXZwCRvSKsbfyJVABtoZEj9O8cQWSz5hxVBZjlB4Af/zyCYm8Xu70CnnJK
         P5ezSwOgxlEOrgM0d0rqvk3fJjQ4Wh4bXZGRMFGvXJiWrZ238Wq55vMmsbu6ShbwBXC+
         tTgT6yHxDgMAkHZB2L5FuJ8ZvFXq6f1aeflvOomuR0pvdPkfhmUk1E29818BumXeSG6M
         rZxFYNuDbIFH31W8LVPel61jnYDI3jEXKgbGgERmB80nzFziWG6nC6QMqtMohZlG3LQ/
         4lxxDSB7JFH9Hp2/Jr7Qb+lERp4ryWmIriLZVOfnwdp7VrHlblXFP3EZNG4fDrt6H+F3
         2E+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YTknDddjpAEn0Nysyw1v1gQmmPikHyQfCRNmNWeBzvs=;
        b=gNp08DeaOAUs3tkGBq+eJAZwovu7aIYnWp7FkRTjwUooVwHTkVP0wXvP55La1GfFFc
         h845TwNGPxU/c30nDzgzwSVfp16rJj7+GvvOF+7JiiRwEl+Jq8L6ECYr6vmaWAuxDKxu
         Y93Q2i6UL0o8lTKvVDmddteP/5BFmwrEr2izY3RcPGo6E5eNhzwKvPEBbUtOpyol7YDU
         GZVqu8/0iprkD8Opqv+3GZAt6kFvFQUZab0LooBRs81WSrnFig2fdxP5nJL8fr2UPJZj
         KyzgygwBb8M+p19NnpaleJ0WHh3k0icNeohudSRnQYODC68XXjb6hBsDGp9Sz9KJdVGL
         PtnA==
X-Gm-Message-State: AJIora8dUtfGT1evKwSNWX2PJnBfvuyypCGdhyeHmqVpVwQt6E8xsuz/
        uJZvdS7VhRaBn5yF1EwxcCkf4c5cj2r6afLoZBe/r/pDolY=
X-Google-Smtp-Source: AGRyM1vtZh/Dmwj8gKEhVI/+HRnKot4lRdR0ZqbxH8HVfChJPdHma+4MO8AljiEO6Md6RFkTl+snUdwuNGI+xUsEFPQ=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr11692663ejc.740.1658784298276; Mon, 25
 Jul 2022 14:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220724164316.68393-1-matti.lehtimaki@gmail.com> <20220724164316.68393-2-matti.lehtimaki@gmail.com>
In-Reply-To: <20220724164316.68393-2-matti.lehtimaki@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 23:24:21 +0200
Message-ID: <CAHp75VfO_3xBWyOsS=v3uNKP=iR5KTmDEH6a90mKh0vFM-xOjQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: st_sensors: Fix null pointer on defer_probe error
To:     =?UTF-8?Q?Matti_Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 7:01 PM Matti Lehtim=C3=A4ki
<matti.lehtimaki@gmail.com> wrote:
>
> dev_err_probe() calls __device_set_deferred_probe_reason()
> on -EPROBE_DEFER error. The device pointer to driver core private
> structure is not yet initialized at this stage for the iio device causing
> a null pointer error. Use parent device instead.

the parent device pointer

...

>         pdata->vdd =3D devm_regulator_get(parent, "vdd");
>         if (IS_ERR(pdata->vdd))
> -               return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd)=
,
> +               return dev_err_probe(indio_dev->dev.parent, PTR_ERR(pdata=
->vdd),
>                                      "unable to get Vdd supply\n");

Why not use the 'parent' variable?

...

>         pdata->vdd_io =3D devm_regulator_get(parent, "vddio");
>         if (IS_ERR(pdata->vdd_io))
> -               return dev_err_probe(&indio_dev->dev, PTR_ERR(pdata->vdd_=
io),
> +               return dev_err_probe(indio_dev->dev.parent, PTR_ERR(pdata=
->vdd_io),

Ditto.

>                                      "unable to get Vdd_IO supply\n");


--=20
With Best Regards,
Andy Shevchenko
