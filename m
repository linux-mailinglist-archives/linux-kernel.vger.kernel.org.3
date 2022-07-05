Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B66B5676E2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiGESwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiGESwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:52:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EE51EEDA;
        Tue,  5 Jul 2022 11:52:30 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j7so17097526ybj.10;
        Tue, 05 Jul 2022 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yja7doOEpycm6RswSNt6Ndu5Y1PCKNLpIKO/qkkV0nE=;
        b=a55i++zWl7RlFm3zSrT5LvAALOmVDqFD54SzizUFEfNwQRdB6Ou3Nnn7B+iZEQf1lU
         PdGlmjvHtewS8WBW4VCSms4/L+CEQKjCVM3IHfw5EZdIlVypuM0/ZF13ZqFeCJ6phl7f
         9Z5WQ21aGvw1n3m7g5oAcPQAZLEJMf8xV+hvC5Y0Mq9uOJy/YHfJUsnVccZnWAlDsMmQ
         D+sNWKP+6nw9Gp/QWzcYQWt9nwX63aHvWbkOLhJjKZGupYEu7hN21C6tpra2B7n5oqB9
         gfNrGNfFKEzRy9rpeyFHhZLpzE8Yf3kdH4CbwgbX5mGrkzBvGZi78uxoOEfNUf9/ahUt
         Fl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yja7doOEpycm6RswSNt6Ndu5Y1PCKNLpIKO/qkkV0nE=;
        b=QMYylGvFUFs7EZi5kNXYW4fXRWs74bcQppWVI0qn8NG1wc2Zfji8bnq3ufeN8aKwtE
         RwzwSjuZty2fqNLx0nAgqPt9EUD9DvUTXhQUCAxrPs2P6jGp41OmbFJ+WMNCXlOURI5M
         ZSkFAoMh4bEm1dxPyZWZ2x+0Vp5YpbfGjbCUsU/udaMvD1Sotx3w23D5I9ULf7+KcxDF
         +tb6zfiscsTOyiQzD+A5EpHodEAiNr9lfeOUsu8AULS/bDoT+90Hvq4SNyGyTsblbMkK
         man47PYgeB+0IFA0/gLeI8LaPI1+cgr47l9TeTMlXFklK/N+7WrPZ0C8rwtJMUWdrqJe
         UXqw==
X-Gm-Message-State: AJIora/fDQospK+tOYRwfab8vtez3GnxRMK3895qamdnlklQ1d9hUoUl
        h3tnvsxb3prXlEa1kDgQiOyXQEsCNDJCwf8trUM6s4htNPzxHw==
X-Google-Smtp-Source: AGRyM1sXCXdmA1oh73EjPE613SlrQgJJ687u6/+ASegMiKcdwlMvgS9s5xDQMB5NWi9NuWyPo1By384NQC0dTgbyMks=
X-Received: by 2002:a25:858e:0:b0:66e:4898:63e2 with SMTP id
 x14-20020a25858e000000b0066e489863e2mr14635194ybk.296.1657047149337; Tue, 05
 Jul 2022 11:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220705163136.2278662-1-vincent.knecht@mailoo.org> <20220705163136.2278662-6-vincent.knecht@mailoo.org>
In-Reply-To: <20220705163136.2278662-6-vincent.knecht@mailoo.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 20:51:52 +0200
Message-ID: <CAHp75VexCGKRVovaMhfzonFkju6vh_TR6_A3vLtZVox3AhAvYg@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] leds: is31fl319x: Move chipset-specific values in
 chipdef struct
To:     Vincent Knecht <vincent.knecht@mailoo.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
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

On Tue, Jul 5, 2022 at 6:33 PM Vincent Knecht <vincent.knecht@mailoo.org> wrote:
>
> Allow setting chips' specifics in chipdef struct by adding fields for:
> - the reset register address
> - a pointer to a regmap_config struct
> - a pointer to a brightness_set function
> - current default, min and max values
> - a boolean to distinguish 319{0,1,3} and 319{6,9} chips
> and use those fields in places where distinction has to be made.
>
> The fields for 319{0,1,3} still point to 319{6,9} values.
> No functional change.

...

> +static bool is31fl319x_readable_reg(struct device *dev, unsigned int reg)
> +{ /* we have no readable registers */

Non-standard place for comments.

> +       return false;
> +}

...

> +static const struct reg_default is31fl3196_reg_defaults[] = {
> +       { IS31FL3196_CONFIG1, 0x00},
> +       { IS31FL3196_CONFIG2, 0x00},
> +       { IS31FL3196_PWM(0), 0x00},
> +       { IS31FL3196_PWM(1), 0x00},
> +       { IS31FL3196_PWM(2), 0x00},
> +       { IS31FL3196_PWM(3), 0x00},
> +       { IS31FL3196_PWM(4), 0x00},
> +       { IS31FL3196_PWM(5), 0x00},
> +       { IS31FL3196_PWM(6), 0x00},
> +       { IS31FL3196_PWM(7), 0x00},
> +       { IS31FL3196_PWM(8), 0x00},

Missed space before }.

>  };

-- 
With Best Regards,
Andy Shevchenko
