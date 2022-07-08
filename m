Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F0056BBB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 16:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbiGHOej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 10:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbiGHOei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 10:34:38 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00842229D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 07:34:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so37988948ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 07:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qLu6DxVJLcdKBrX7bULlQ+iHq32WbsP+AYikNaT1u5Y=;
        b=Oe6P6gt6yZEz1SZb/Xa9whyMeeS2Ef2wF7JwgS5mkui57HlF40pckuYxTOOEUAi17U
         oY64xmTha8RSHbCPGOg1o1uyXc7NqpmkLQCF9sA23QCBPcg5Sn/EMhSPnwwic9CrRdtX
         Ixbsk/8+Mg2gQN/NzfIah2n6nVTarxQi6m/spSH2SMJiErnBTZKwl4I1hO35QJNHalfH
         3yw8YdPNRhDBQd+kRpQspZyR/wi6y1nFJIxSgnQFYDIMJZpJ1T8KB8j/TYWe+Umwk3Zq
         m0qH7Y0TelyT7mN4Y6/o9eCm6zwlNFxTly62jXZAdaLiWTw/h95lmdLddcbhjj5PTrqW
         4cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qLu6DxVJLcdKBrX7bULlQ+iHq32WbsP+AYikNaT1u5Y=;
        b=XiCALHBEbl9pLxjK3oY4/6ADilWH1tYhXFuoKzmUrLHUbPdQpSPZK7sAHfGU64TMLD
         c0hRFaNEM2NEX6vrKeIU7F8yc2tqNyC47qiYN39TSo16IsgkCEKzFnE318MgZF8rdb96
         fdPcjpdD7ERVKDROuVW5Mkpe//s6tG7Mwvy7Mqq6OqSrK5umBtRs3ZJ0L1rJ1c+Qi/kH
         5hDsm1YuD+ra+jdKtaYkLojLt8lD15Cu0mNVH5VkrP0U3KNj03leI5SDRwrhfHK9Sp5Q
         tg5E4YCPmYzjuG3LWfBFd8YODPQMb8KL1e58tiUySkRu1fVCsd8qs8nT1utiB+jIXxbA
         gIIA==
X-Gm-Message-State: AJIora9JwNyiq/1y0r5q2sfdcXuP4Q5NOUl2JQt1jVgmp358SJU5rfoS
        gcA52zhnThz+fnFIysKvOqll7HCaPpIg9Aq8RDEpxA==
X-Google-Smtp-Source: AGRyM1vCpD3FJAAxAVHvRx4L1441GBsP/4h6bDjtzgce6Xe1z2HpKztPCEvJZJKyOxwiGyQS68UgwEqrnKAvuQB0euU=
X-Received: by 2002:a17:907:3e20:b0:726:2c09:3fa4 with SMTP id
 hp32-20020a1709073e2000b007262c093fa4mr3816780ejc.101.1657290875491; Fri, 08
 Jul 2022 07:34:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220629113058.79617-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220629113058.79617-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 8 Jul 2022 16:34:24 +0200
Message-ID: <CAMRc=McZaRBKP2P8zY3GjnvrDQnCELc+sa7Zp2wt_T57-i+hPQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: of: Use device_match_of_node() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 1:30 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Instead of open coding, use device_match_of_node() helper.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-of.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 3d6c3ffd5576..23b8de98bf7c 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -720,7 +720,7 @@ static void of_gpiochip_remove_hog(struct gpio_chip *chip,
>
>  static int of_gpiochip_match_node(struct gpio_chip *chip, void *data)
>  {
> -       return chip->gpiodev->dev.of_node == data;
> +       return device_match_of_node(&chip->gpiodev->dev, data);
>  }
>
>  static struct gpio_chip *of_find_gpiochip_by_node(struct device_node *np)
> --
> 2.35.1
>

Applied, thanks!

Bart
