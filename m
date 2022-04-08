Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D584F93E2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiDHLZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiDHLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:25:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B25179B21;
        Fri,  8 Apr 2022 04:23:32 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so16698019ejd.5;
        Fri, 08 Apr 2022 04:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cRoyXCmCEfHW6FbxD2a5gAxg2fHOPCI7K6xvLP7LBlY=;
        b=OLcF3ugvB6AlRI055J9tJP1EjOYQdBpBT+XkuD7zndoJU11AGacmBG0mk67F36A7sV
         /hFA2veApJ1HXhiYh86006TKDvYD4t+E2QlFKC9lCt7JnwjqYOKX1AeY57SseQhW8FA2
         h/vVYNGtyuU++PyL6Mpo8/tsqUQx845T+UDGFMZifewrDlXr1ltR6c2pYS4KjTGVRnny
         GqRV2E7BWxjpx8Y9KBKYV7zPxSRxGXZTcrfQADOJzyfKbY/Z2dIxNA+E54a+1qOhTQUp
         F1dCghAsXSy1BL3OswS8qj7zWCPpRIBqHp5HhU/cnibFj0k7iK6cwSXitz9skmpzPL3m
         KMqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cRoyXCmCEfHW6FbxD2a5gAxg2fHOPCI7K6xvLP7LBlY=;
        b=Jz2fqYZ6Q5esfrkQb/yGRoBfw9S+kb5qfHrvnF9OqAii7L6Tv22OxljSIYDcNoL2YE
         4hwIQ/zyDJ8Bs0P1lO+lb+dHaZNhmh5kd2a1+yl465UQlzEMUf+n1B7q+igk0IQrvbC2
         BWW179u53taiVexR3gbkZR3lJ+LYW6kLU4IiTWZFR7qyx8wrJ3SM2F3HJRF89pBTx6zP
         caRKmYxeg+8SHE/BYnKlf4K9MzUQyIU5+rAdaQkD5g1lscjmN9Voa6TJ3qlPKbHrnvFW
         XJf5zkQhWg0u19VWUKLhlG24IRkvQwKNJORFFlEjbhYZ5/J+VGeDoSGTW6qyX5QzbrrH
         L2Rg==
X-Gm-Message-State: AOAM532+Zmc/B5HPmD4aFX3Te2bgIXb+VgaVE4gYh2b6KtEddutORG4R
        vrZN1aYnEzV68yiRUesNoV8/4o3WLNTutine4hU=
X-Google-Smtp-Source: ABdhPJykQNqDc7FaAjGw5x9RJlN7Ipzg84vVW8ik/7vJMM2bSnf0UwzV3g7qHKQy7+iLJ6yUnwC5p+UHpZTxxck2Pfw=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr17927638ejc.636.1649417010579; Fri, 08
 Apr 2022 04:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220407183941.36555-1-eajames@linux.ibm.com> <20220407183941.36555-3-eajames@linux.ibm.com>
In-Reply-To: <20220407183941.36555-3-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:19:15 +0300
Message-ID: <CAHp75VfcmhGitd6_6mDVG6_eE02sX2B3_iqZxeiX3iFDkmPShg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] leds: pca955x: Add HW blink support
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, patrick@stwcx.xyz
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

On Thu, Apr 7, 2022 at 10:43 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> Support blinking using the PCA955x chip. Use PWM0 for blinking
> instead of LED_HALF brightness. Since there is only one frequency
> and brightness register for any blinking LED, track the blink state
> of each LED and only support one HW blinking frequency. If another
> frequency is requested, fallback to software blinking.

...

> +#define PCA955X_BLINK_DEFAULT  1000

What's the unit of this number?

...

>   * Write to frequency prescaler register, used to program the
> - * period of the PWM output.  period = (PSCx + 1) / 38
> + * period of the PWM output.  period = (PSCx + 1) / <38 or 44, chip dependent>

Using <> in  formulas a bit confusing, what about

 * period of the PWM output.  period = (PSCx + 1) / coeff
 * where for ... chips coeff = 38, for ... chips coeff = 44.

?

...

> +               dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n",
> +                       __func__, n, ret);

Can be indented better. But I would rather see regmap, where this kind
of debugging is for free and already present in the regmap core/.

...

> +static u8 pca955x_period_to_psc(struct pca955x *pca955x, unsigned long p)
> +{
> +       p *= (unsigned long)pca955x->chipdef->blink_div;

Why casting?

> +       p /= 1000;

Does this 1000 have a meaning? (see units.h and other headers with
time / frequency multiplier definitions).

> +       p -= 1;

> +       return (u8)p;

Redundant casting.

> +}

> +static unsigned long pca955x_psc_to_period(struct pca955x *pca955x, u8 psc)
> +{
> +       unsigned long p = (unsigned long)psc;
> +
> +       p += 1;
> +       p *= 1000;
> +       p /= (unsigned long)pca955x->chipdef->blink_div;
> +
> +       return p;

Similar questions here.

> +}

...

> +       if (!p) {

Why not use a positive conditional?

> +               p = pca955x->active_blink ? pca955x->blink_period :
> +                       PCA955X_BLINK_DEFAULT;
> +       } else {
> +               if (*delay_on != *delay_off) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +
> +               if (p < pca955x_psc_to_period(pca955x, 0) ||
> +                   p > pca955x_psc_to_period(pca955x, 0xff)) {
> +                       ret = -EINVAL;
> +                       goto out;
> +               }
> +       }

...

> +       if (!keep_psc0) {

Ditto.

> +               psc0 = pca955x_period_to_psc(pca955x, pca955x->blink_period);
> +               err = pca955x_write_psc(pca955x, 0, psc0);
> +       } else {
> +               err = pca955x_read_psc(pca955x, 0, &psc0);
>         }

-- 
With Best Regards,
Andy Shevchenko
