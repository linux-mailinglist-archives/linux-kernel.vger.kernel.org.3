Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60BB2560B81
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbiF2VR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiF2VRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:17:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A937A3ED07;
        Wed, 29 Jun 2022 14:17:22 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id i15so30315837ybp.1;
        Wed, 29 Jun 2022 14:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DepFAV6QeaHF3ev/6GPaTTRPzY6c62USnFZFIh9IwUY=;
        b=bnpGvX5VMKi4/sXq3bAMLtCE5BnyLq9af638F2Ofe9pjoW4Cqt3PlMw2K8X4etwuK6
         FsnXXFZ2UDKUbEm3q0ta2DA1Wj/2g9lAtj50LYhYtWGKWg1T2VEqFrpEMePCg921gkvk
         Aj17UTyf+ZFGAbkDZcyIRtl4HGVXZpQpMnf3NsG8B5CKXBs9Wek0BP9D89/KXK8NuqxH
         bFIdtAmUXv5FTxgEh1Jkbe6yVl6XL1eB8ONFKiwgb0wPY5tGHevzbMgOIxu97jJpQQep
         ayPcLhgvecH3gwpBZkWwe2IBebtgT+3rUa37EWjpEc9/E79jMOxh88+BBFWyFOringq4
         ZP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DepFAV6QeaHF3ev/6GPaTTRPzY6c62USnFZFIh9IwUY=;
        b=2TtDr7A2MyMQidrWNvji5Yf5Dz0Z1SBDEPeVy6ENIhXaHRTqn5MMY3mk+RrK/8jZpT
         FK6AxTa3t8qCdykh4PzCrBAHCn0NJ88dCd/Sqz8uhHw9YBFgCeiFRj2p+5ue2o+XfW3j
         7rZFvkEq6ItQO4Q6KC6vEq8AZ3sOeQgTxPEmzMz402QNktD7rbM/Xd4Jj5o8heuBvxRM
         EDjYopUL4kMNywLWbSPWrth0tfDAkhEozLtWHD1AYo6tXRCx3oaS40QtgorufIFZO390
         WvHJ5FEg/Qer8H4Kz8ynTdm8SPoWuKkEGOao+7yRmV0aRdBTZ0vbK6LRIjQnTjYOQ4Ki
         KQ6Q==
X-Gm-Message-State: AJIora86DnB9hoY0YM9u276Af4/LSd+EAmq9xstq5Wy84hvfaCAPtAPo
        bnxT3rAdkQlkjD8AAJDD8kKbm2sbJ9MtMXQ2k0Y=
X-Google-Smtp-Source: AGRyM1uQdq7YqjRKBCH4iQN3j1UTYFzNswehs8Ma8PNpmNYZFYN+iFToU2ckC64GdaKFx9r/iuGaPBf2B39V12/alCw=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr6041966ybg.296.1656537441873; Wed, 29
 Jun 2022 14:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <CAHp75Vc=PWXauEKDNX+vmqv=oO1LDv8-GgU3OFZXjf8yJrG8wA@mail.gmail.com>
In-Reply-To: <CAHp75Vc=PWXauEKDNX+vmqv=oO1LDv8-GgU3OFZXjf8yJrG8wA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 23:16:42 +0200
Message-ID: <CAHp75VeqvCnWtWLF1zySPGkfBT5obosu0h_pZEhz+pOQWzMdWQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] Add support for AXP192 PMIC
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 11:14 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 29, 2022 at 4:29 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
> >
> > Changes in v4:
> >
> > * Drop regmap-irq patches and rebase on top of the regmap-irq
> >   refactoring series[1], which implements the same functionality.
> > * Reorder mfd_cells, putting one-line entries at the bottom.
> > * Fix incorrect example in axp192-gpio device tree bindings.
> > * Perform adc_en2 flag -> adc_en2_mask conversion in axp20x_adc
> >   as a separate patch.
> > * Simplify axp192_usb_power_set_current_max().
> > * Drop unneeded OF dependency in pin control driver, and document
> >   tables used for describing register layouts.
> > * Various style fixups suggested by Andy Shevchenko.
>
>
> For patches 6-11
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Ditto for patches 13-15.

Very good made series, thanks!

> > This patch series adds support for the X-Powers AXP192 PMIC to the
> > AXP20x driver framework.
> >
> > The first patch is a small change to regmap-irq to support the AXP192's
> > unusual IRQ register layout. It isn't possible to include all of the
> > IRQ registers in one regmap-irq chip without this.
> >
> > The rest of the changes are pretty straightforward, I think the only
> > notable parts are the axp20x_adc driver where there seems to be some
> > opportunities for code reuse (the axp192 is nearly a duplicate of the
> > axp20x) and the addition of a new pinctrl driver for the axp192, since
> > the axp20x pinctrl driver was not very easy to adapt.

-- 
With Best Regards,
Andy Shevchenko
