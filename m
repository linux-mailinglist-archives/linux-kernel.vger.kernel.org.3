Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2B4FBA0F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345751AbiDKKuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242985AbiDKKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:50:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449A543EE5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:48:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id k23so29971534ejd.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BcHIOe1dL4WfkzE1GB77PDzH4FLRjeSJNsCN1gvWgkQ=;
        b=RFSIAK8QEuA5OPaRzzqprA1xiYGQv+6n+Cgkdd5Prl4eFwGVup31EI5PUSbVWqp2Oi
         ok1dPTl0Cn5TIQBzYIka22VV5xHmTdGTQAeWwE9YjbmAJUbxiloGgCHwmvbkCh6g8EvE
         Vh0l58GpdYhoKmdytidDdVXXvzLaLVVtjkLSSaXwkZwDRS000jZZGuaqsaPpIVrt0A22
         6HpJULJYtq+AC5+zmzwGH3YRnmyFpelw+t1qNeb/0cKUZ41DSUGG2UNmdZ6wQrJguCht
         WGQYKXA/YtMrkkhqgAps0NF8oyFfiTcnXR9MRwflUKuBKQUS2mAhovrRDrU7d+mo//Ee
         j7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BcHIOe1dL4WfkzE1GB77PDzH4FLRjeSJNsCN1gvWgkQ=;
        b=nTkprUygrcHFtiGcnqe55md69DNTOAofIj+lj/Awqe1jbIXo4sWy4N5rE+CNGEoYLc
         VHn15b8wfdxDicbUhUrlu/Pdhavnu79rUvZLo2aXEDPxnX/9vrHE50Iu14SLZg0GHyH1
         GAECRO6toervLSaoLzin8KAbKYsgmsCNcfALZBqcksijl7wY66tLY2aCtNAXmWtgG+Hm
         IY64lFnVv7zTrDc2JA8VnUbWYkAkmbPtGGuLYAwsTlhFJfGaElFZOsLpSQWUtm+TEKi6
         axNL4ePJvAL3ns3jhdxzzA/sN8JLA6pmkoydIpjuCrDwnAEW/GXXo+XLybuOul7RTQbZ
         3rxw==
X-Gm-Message-State: AOAM533ARAZzgrY8Tf5uv4C8aMHVBTBPqU8GEEv/js0O4pmhfZNkx/c6
        eFyjT9lhAKKTCEEmHYLjU5eONuA6mGaGnuLs5WWAgg==
X-Google-Smtp-Source: ABdhPJy7yuKFkdddrtMSEnNQ+dL2XvCSBzs+UbSZ/uqEkdTeFf8E7+RPMarJtlJjQAJgxWaSKfM0Jnp51YNSFwJO7k4=
X-Received: by 2002:a17:907:97cf:b0:6df:846f:ad0a with SMTP id
 js15-20020a17090797cf00b006df846fad0amr30026266ejc.286.1649674113868; Mon, 11
 Apr 2022 03:48:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220411063324.98542-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220411063324.98542-1-andrei.lalaev@emlid.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 11 Apr 2022 12:48:23 +0200
Message-ID: <CAMRc=MfLnZ-qKFSrjSg6Gsg193v-+o_FprhDd_ZR5_vokqozbw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: of: fix bounds check for valid mask
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:36 AM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:
>
> Use "greater" instead of "greater or equal" when performs bounds check
> to make sure that GPIOS are in available range. Previous implementation
> skipped ranges which include last GPIO in range.
>
> Signed-off-by: Andrei Lalaev <andrei.lalaev@emlid.com>
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index ae1ce319cd78..7e5e51d49d09 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -910,7 +910,7 @@ static void of_gpiochip_init_valid_mask(struct gpio_chip *chip)
>                                            i, &start);
>                 of_property_read_u32_index(np, "gpio-reserved-ranges",
>                                            i + 1, &count);
> -               if (start >= chip->ngpio || start + count >= chip->ngpio)
> +               if (start >= chip->ngpio || start + count > chip->ngpio)
>                         continue;
>
>                 bitmap_clear(chip->valid_mask, start, count);
> --
> 2.25.1
>

Queued for fixes, good catch.

Thanks
Bart
