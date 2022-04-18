Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E327505E30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347520AbiDRS6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiDRS6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:58:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA50A31368
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:55:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id s18so28561731ejr.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2hqEMF0SQt3Ev5/ZYy1++/1e1/ROKFU2euV2ifFUNuE=;
        b=14NLESNX+aFjGEEjMHODu7rTFhKSWwZ0Wm9bcxI739nEvV8STZfP+Umf1QNL8Fc5YM
         u6itvVJrpta2IGb2LPJ2lxRAUW0wSeICI41tsAHwkseMPdX/PVb/VTMQ125K/XEhZsgO
         d1a+WxP95zF6HsKvucAP6ADFk/kpmDGZt36sUjG6V2Tq7ySBGCRgDjfioTmu1NYJjCCn
         lJk7SXLdS913JEnjwTybnBhw7dxfATBik0CfLUmU+qrixLu4qI7EP6qsk5oQnev9k+Vp
         msgew0yB0REihnJsnrFDp9kb+KX6EzfLLNu0guoNqqKvwEEfB3qoTEx6h17Ib3pa9FF6
         4V7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2hqEMF0SQt3Ev5/ZYy1++/1e1/ROKFU2euV2ifFUNuE=;
        b=GYtsyP+EWbkAKaDa0eUTZmhA0irU1FuPhoC9SToZY93XbeRALs6HrC4K0RHkAvdPRf
         s6WDwv9yXq2pFJ0TWmtn7n/r9c6U3GYOXROlQgHKTtA+eJkBtGKpqx270qH3rOumge38
         XET6AzsZWNDoEhW9hIiT+GNzjK/HsM2LNe7yESqMSC1FedU4JL3yF1c4RPK77axPyPFL
         /3cAK8twWn8aVGJ4eT1sgUoJkAYlRUcbs3srSTgbHuefgUGd5ULHbuu7zPP6ygIwRhhZ
         sjLa9WVR9X2lYm/UsVzBFpLOZHsTX905lnEvksfk9xFH/MpvYpyQQUz18lN8dn85jeVq
         VQ2Q==
X-Gm-Message-State: AOAM532rHjcU9WkvOrhJDyyHwjkEGEvkDaFVAMlh2jHJ/926dCO0AkBm
        y6g3Fb26IaezwjgHelL9umy8HABszUCIXrju1s2mhg==
X-Google-Smtp-Source: ABdhPJyFImeKjeK3IybZg1PYdTIxXaHcourdmByWh4gVXUPrKxIyy8Ztvn7tx21VA596zDAbk15nqcVEGUJKy2FrYBs=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr10356091ejc.636.1650308148385; Mon, 18
 Apr 2022 11:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220418110811.2559529-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220418110811.2559529-1-chi.minghao@zte.com.cn>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 18 Apr 2022 20:55:37 +0200
Message-ID: <CAMRc=MeHPTAnvPQ4OefpOVgPFTuXMRZYpa_KqRHw0MVwaEYAWA@mail.gmail.com>
Subject: Re: [PATCH] misc/eeprom: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
To:     cgel.zte@gmail.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 1:08 PM <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
>

The commit subject should be "eeprom: at24: ..." and the commit
message is missing the *why* for this change. Otherwise looks good.

Bart

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
> ---
>  drivers/misc/eeprom/at24.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
> index 633e1cf08d6e..0a5bdd629427 100644
> --- a/drivers/misc/eeprom/at24.c
> +++ b/drivers/misc/eeprom/at24.c
> @@ -431,11 +431,9 @@ static int at24_read(void *priv, unsigned int off, void *val, size_t count)
>         if (off + count > at24->byte_len)
>                 return -EINVAL;
>
> -       ret = pm_runtime_get_sync(dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(dev);
> +       ret = pm_runtime_resume_and_get(dev);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         /*
>          * Read data from chip, protecting against concurrent updates
> @@ -478,11 +476,9 @@ static int at24_write(void *priv, unsigned int off, void *val, size_t count)
>         if (off + count > at24->byte_len)
>                 return -EINVAL;
>
> -       ret = pm_runtime_get_sync(dev);
> -       if (ret < 0) {
> -               pm_runtime_put_noidle(dev);
> +       ret = pm_runtime_resume_and_get(dev);
> +       if (ret < 0)
>                 return ret;
> -       }
>
>         /*
>          * Write data to chip, protecting against concurrent updates
> --
> 2.25.1
>
>
