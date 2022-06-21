Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43AED552E3A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348597AbiFUJZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347053AbiFUJZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:25:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF97240A0;
        Tue, 21 Jun 2022 02:25:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g25so26122750ejh.9;
        Tue, 21 Jun 2022 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NOMsJgOH3MiCNjts6Vy2cOyGVGYl5lD+qutJwwCIfsM=;
        b=U4TmMXAVNZeGSibLS1ghJJrIiOQVgWj4Qhzr2zXpZ+UjaA8vQDXSqrB0mhffAZ6Y9d
         XaJxAG/q3qhi8lBbjSlIe4BCARpAkrbeLvmp7yJ8wuR7IahJDrPRtLyghlHUZlUs4nWB
         FZTWmbA6jN6Dl+1dTCiUI5xSy7dHbNcZ9mHyH7xWZpPiLD4CjNeKT3bkajbgNmUNGssT
         58FkgHEVrYlyPbFS9MvU+nFY1iGFJ3jlS3X3KFvPTYe8GBn4g2yDEArJsar8PRNVwU3S
         TIAQj0k8aL5a3We6gBozjvqbKtUmm2XGgOixTPoPN+2bY4+KThPsVwTq4sbr78gBo2r6
         edBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NOMsJgOH3MiCNjts6Vy2cOyGVGYl5lD+qutJwwCIfsM=;
        b=KN2GuPZKkvOFKroLm3qy8kHCV0JXXd5xe2DrI7Njfq9xMQxJ5yCowZ41SFbAHmMTrh
         XMNhSYXlVYx9JQDxkxwbPEnrmNGkGdhl52k8/HFktNHoUIzaDE/LO5bTFMvfKELoplSu
         szrLyvn5XsVkGLLzDBDGZiDXOOvao/CXo9u0LmH3hk9x6pomEiAD222rSOLx3LooFGcT
         fp6CMZ93pQwegN1h1//0PcBMKqQ95SFoqjPLruZ1U5d6NhjlQpQrOWq7SHcOQmXqhcMh
         qcyEnEWkJHpYZjw39HOeF9/muhm3ooc8WVXLRQ6KveRDiEPSGCZX0GhMxeqhrdXIT+c3
         9b4g==
X-Gm-Message-State: AJIora+boOTEvvYSiXs8Oqw4KcqLERi4qXboNANvkGyKhUJaH4JfhCsS
        qiH8Nb+WM3ewZTzBR+mjAEzznUsaHFmKnuMdzo4=
X-Google-Smtp-Source: AGRyM1se8Q5QQtyQhqZ276ze+sQZWIHL5X2Uisw4LahZgr/oEQb+koeaLdBeR+uqRMsLqk/klYDHMQOlZMtTnGjBf6c=
X-Received: by 2002:a17:907:72c7:b0:722:e5af:f666 with SMTP id
 du7-20020a17090772c700b00722e5aff666mr1241803ejc.44.1655803552679; Tue, 21
 Jun 2022 02:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:25:16 +0200
Message-ID: <CAHp75VcQ5xZV2eoC93zu3qA2TcE3LyMgZLMX=r0ibzQ1Fg6U0Q@mail.gmail.com>
Subject: Re: [PATCH 00/49] regmap-irq cleanups and refactoring
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Michael Walle <michael@walle.cc>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, tharvey@gateworks.com,
        rjones@gateworks.com, Matti Vaittinen <mazziesaccount@gmail.com>,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-actions@lists.infradead.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
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

On Mon, Jun 20, 2022 at 10:07 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Hi Mark,
>
> Here's a bunch of cleanups for regmap-irq focused on simplifying the API
> and generalizing it a bit. It's broken up into three refactors, focusing
> on one area at a time.
>
> * Patches 01 and 02 are straightforward bugfixes, independent of the
>   rest of the series. Neither of the bugs are triggered by in-tree
>   drivers but they might be worth picking up early anyhow.
>
> * Patches 03-13 clean up everything related to configuring IRQ types.
>
> * Patches 14-45 deal with mask/unmask registers. First, make unmask
>   registers behave more intuitively and usefully, and get rid of the
>   mask_invert flag in favor of describing inverted mask registers as
>   unmask registers. Second, make the mask_writeonly flag more useful
>   and enable it for two chips where it makes sense.
>
> * Patches 46-49 refactor sub_irq_reg() as a get_irq_reg() callback,
>   and use that to eliminate the not_fixed_stride flag.
>
> The approach I used when refactoring is pretty simple: (1) introduce new
> functionality in regmap-irq, (2) convert the drivers, and (3) remove any
> old code. Nothing should break in the middle.
>
> The patches can be re-ordered to some extent if that's preferable, but
> it's best to add get_irq_reg() last to avoid having to think about how
> it interacts with features that'll be removed anyway.
>
> I can't test most of the devices affected by this series so a lot of the
> code is only build tested. I've tested on real hardware with my AXP192
> patchset[1], although it only provides limited code coverage.
>
> qcom-pm8008 in particular deserves careful testing - it used all of the
> features touched by the refactors and required the most changes. Other
> drivers only required trivial changes but there are three of them worth
> mentioning: wcd943x, wcd9335, and wcd938x. They have suspicious looking
> IRQ type definitions and I'm pretty sure aren't working properly, but
> I can't fix them myself. The refactor shouldn't affect their behavior
> so how / when / if they get fixed shouldn't be much of an issue.
>
> Oh, and I added the 'mask_writeonly' flag and volatile ranges to the
> stpmic1 driver based on its datasheet[2] as a small optimization. It's
> probably fine but testing would be a good idea.
>
> [1]: https://lore.kernel.org/linux-iio/20220618214009.2178567-1-aidanmacdonald.0x0@gmailcom/
> [2]: https://www.st.com/resource/en/datasheet/stpmic1.pdf

Cool series, thanks for cleaning this up!

-- 
With Best Regards,
Andy Shevchenko
