Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F228F4D0403
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244156AbiCGQYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244160AbiCGQYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:24:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F605468E;
        Mon,  7 Mar 2022 08:23:21 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m21so15194211edc.0;
        Mon, 07 Mar 2022 08:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lgB59yw3g0bu2ykbYWPoRlo9RUjg9qF+aAh9DDjOKHY=;
        b=NO/HnPQdxIJbfmED45RumCUVwNi1TCt6YC2nvRaKY3ljyoLEF4oBonLnv73/A7IHGH
         jgyLyMkoLOTlPti2IFJxxsPLNBuAMcp/8+IkC7214ztb3zoaDtpINMt+b7y5O6Y4U7Bn
         8saDkQEhl2Dpm7qgWa6fB5v8lJX4N8eBRzQlkKzg8dvCu837emVGI6kfTN4gzo5EEX20
         jm/U92Wv6X9gny+cnUjpGH5jOHwqTGGwhh1onLSABfGBWfUiMyG9urtqdema9ul1yDLX
         fuIe7GRTeCBBYIHQPgbGOhtOBfb4u+dgAvzintK22mekbRVWk3i1QitCJn4U6lY+BD3z
         9Law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lgB59yw3g0bu2ykbYWPoRlo9RUjg9qF+aAh9DDjOKHY=;
        b=BRwBx9OlftPiRNiccF12LqHTqWZh7nhMITy54iZdBna6doFkG6wL3vj7bGR+p9CKrZ
         EvRDdrvgqmH3cDqlwj5wGa8C3skDhqrmr8l9MboeQ5o9LpfGy1EuhlbkXOt0s7RJy5nE
         4CRWIHJxbVuqjUvT2zGJWCQh7f4NBfR/2iHup2RjE7J6xx7NhK1aganSVuogIJL/9aMP
         4eXEDLMUf3jtlZq/MMXM/Hwczo27s1c0sR0LYNS8INyP91C5Z7TwN3bejZA2fYDWlWpV
         vpc6jCzexfX3Sa72HgTVC/5j6Cq9+s9PBHKMR4EO0BlMuCW9ZYpceyJHyi9TJQKELylV
         bi/w==
X-Gm-Message-State: AOAM531b5qdMTQuqWnvyzW+g1rw8Cv6avp2b/UEuBA8e4x4i9mIxYV88
        BkxxEcSChcp7o5yiVUpICGfmQR9iqnfNFahuOlPISu7qWUg=
X-Google-Smtp-Source: ABdhPJwYMx49eAVmc3bE0GA6Yek3/Ga4xVbF9mzzuducnFpGjPSbzxJobnZcRaAx4n3G5B4sjUhwzhmjMxcq2+G3vH4=
X-Received: by 2002:aa7:da93:0:b0:416:4aca:bef7 with SMTP id
 q19-20020aa7da93000000b004164acabef7mr4815740eds.296.1646670199967; Mon, 07
 Mar 2022 08:23:19 -0800 (PST)
MIME-Version: 1.0
References: <20220307141955.28040-1-alifer.m@variscite.com>
In-Reply-To: <20220307141955.28040-1-alifer.m@variscite.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 18:22:02 +0200
Message-ID: <CAHp75Vf=vQd5-PGPu3Pcx9bhKSfhdnYDOSOmZKQZQ+bxVkpmYg@mail.gmail.com>
Subject: Re: [PATCH] driver: pca953x: avoid error message when resuming
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, eran.m@variscite.com,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        pierluigi.p@variscite.com,
        FrancescoFerraro <francesco.f@variscite.com>
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

On Mon, Mar 7, 2022 at 5:04 PM Alifer Moraes <alifer.m@variscite.com> wrote:
>
> From: FrancescoFerraro <francesco.f@variscite.com>
>
> Avoids the error messages "pca953x 1-0020: failed reading register"
> when resuming from suspend using gpio-key attached to pca9534.

Thanks for your report and fix. My comments below.

First of all, how many of them do you get and why is it a problem?

...

>         const struct pca953x_reg_config *regs;
> +       int is_in_suspend;

Usually we call it is_suspended or so, check existing code by `git
grep ...`. And it can be boolean.

...

>         ret = regmap_bulk_read(chip->regmap, regaddr, value, NBANK(chip));
>         if (ret < 0) {
> -               dev_err(&chip->client->dev, "failed reading register\n");
> +               if (!chip->is_in_suspend)
> +                       dev_err(&chip->client->dev, "failed reading register\n");

Hmm... Maybe we can simply move it to debug level?

>                 return ret;
>         }

...

>         chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
>         if (chip == NULL)
>                 return -ENOMEM;

> +       chip->is_in_suspend = 0;

Redundant change.

-- 
With Best Regards,
Andy Shevchenko
