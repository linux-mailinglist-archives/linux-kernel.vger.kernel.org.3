Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45665305C3
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 22:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351013AbiEVULM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 16:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242363AbiEVULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 16:11:07 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412C8CE29
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:11:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id gi33so16336265ejc.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 13:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XbAugljicpY/y7Zy1EEXCv1U3t4omHv8RYC64W6lHFg=;
        b=RH0617/a3hE57yA5bfOEtRbVlvoZZ/lXnbDnJEPXIt4AA5RqWlPA8AhxizHNehnYEI
         YhDsy1R2t7aHOEHZ8RPC0I2e+4DkQA6GSy6+AdnIbqpMX92LrT6ob6V7sLyJNVzzrBeW
         fl256B2WWJjVctMBQH2g/aJ67jKbnboB4TjlOYDZUIgKIlLf3FlL9oQt5WCdulj2j7W+
         aF2ePVq9DTprxl44nfKSOG0z7mFieHUXQBWwcH7Ni1JjdEBhRZiojUh6w9iowhhmBPOG
         Vd1+hz7bhxSUsUB1FTRByyv+K5CPSVQuhIUe395ppH037CkQIy1xp8Ug4SRC7Icu7Rre
         wbYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XbAugljicpY/y7Zy1EEXCv1U3t4omHv8RYC64W6lHFg=;
        b=n8YfmlbVB6B1gcIoCYToQsl5L7j+MO4ioRat8dfh7jtsJgiR6gHfzNmUvjC+r5InFm
         yc9ahlmH3Js+4bqGlbfUEPwj10bnz22YPlHPtVBrivGEYSS2aNKJjGrzFn4wQi1umC/V
         JJkUYA2K65zjemGbAxAHA2duUFzeSXDrQ8GReVnSxkVW5qQTN4B6XZ82IsmQgoBLLRgp
         L8rep4kEnjILI+Xmoeb9qH6j89dr5nwkNsJ/KSoNVDuvpstjE/4l8Tm4CgNmZsqTotY2
         Ua7tcc6jFaU64st1dYI1lse+ceGbMy39RJ+91/WBMIAVoK786FVeaodUsLVaztJSFiwW
         +4EQ==
X-Gm-Message-State: AOAM533yUsB52QBTSiC5NFBA31gtD/q2E7bniuepmQPE4k1bdGp9y9cm
        1TGCbOUwcRrouhnLmOpamWMDyZOs+tEV0Zl3BWdLqQ==
X-Google-Smtp-Source: ABdhPJzc5GUR9U9Il0WUoTYcgZGdj3P4tfGqlFhaPWz4WKm4XeGYOe7uuIWsUJWHY2Wr50WmK05jU4mkxgrUi5D4x1Y=
X-Received: by 2002:a17:907:6eab:b0:6fe:b5e2:7b0e with SMTP id
 sh43-20020a1709076eab00b006feb5e27b0emr9939588ejc.736.1653250263841; Sun, 22
 May 2022 13:11:03 -0700 (PDT)
MIME-Version: 1.0
References: <dde628b73ca95e3e7598cb755cf2350a8e9e4796.1653074495.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <dde628b73ca95e3e7598cb755cf2350a8e9e4796.1653074495.git.christophe.jaillet@wanadoo.fr>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sun, 22 May 2022 22:10:52 +0200
Message-ID: <CAMRc=McR+=55XooEikdee5vCfsLyfPKuc_pvAdfDwvn_dfnc7Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: sim: Use correct order for the parameters of devm_kcalloc()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 9:21 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> We should have 'n', then 'size', not the opposite.
> This is harmless because the 2 values are just multiplied, but having
> the correct order silence a (unpublished yet) smatch warning.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpio/gpio-sim.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
> index 41c31b10ae84..98109839102f 100644
> --- a/drivers/gpio/gpio-sim.c
> +++ b/drivers/gpio/gpio-sim.c
> @@ -314,8 +314,8 @@ static int gpio_sim_setup_sysfs(struct gpio_sim_chip *chip)
>
>         for (i = 0; i < num_lines; i++) {
>                 attr_group = devm_kzalloc(dev, sizeof(*attr_group), GFP_KERNEL);
> -               attrs = devm_kcalloc(dev, sizeof(*attrs),
> -                                    GPIO_SIM_NUM_ATTRS, GFP_KERNEL);
> +               attrs = devm_kcalloc(dev, GPIO_SIM_NUM_ATTRS, sizeof(*attrs),
> +                                    GFP_KERNEL);
>                 val_attr = devm_kzalloc(dev, sizeof(*val_attr), GFP_KERNEL);
>                 pull_attr = devm_kzalloc(dev, sizeof(*pull_attr), GFP_KERNEL);
>                 if (!attr_group || !attrs || !val_attr || !pull_attr)
> --
> 2.34.1
>

Applied with an added Fixes tag.

Bart
