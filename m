Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A05557FC10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbiGYJKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGYJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:10:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7557B140BD;
        Mon, 25 Jul 2022 02:10:05 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so19409011ejr.5;
        Mon, 25 Jul 2022 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BSEtgg8+Hpw/EtiHjL5IRktNHYkZQ4l9B8QMcHNKzRs=;
        b=DvY9h9DoO0kblI5Gb7JOwMF5uAXyYh+0N98faLjkVtDpKYgYiZXw8rUpaon1Qsb+x/
         y8PR5FRgsPRxbCvYRmi6JyQZHxlbh7MXccC1nAKDIdus48fm9phu/mVPu5c/7jnzpiUa
         CeYdC3SruNmPOz8QR4pQRYz+9lbX/PiafhwNwu9n1G7QLCs3uqxyNxwD3CM2frokPBsH
         DkjmmlsnQziUrFfN7mDBzyVBjS82vigYVYvIcaX8uI8LEUmNiadHmdk5ix5lNuZ/1UZ/
         NGL0Cy1cT3KvSr2YKUSTaA8mjLj8kGwovaeEc5qHPC+CgkPbA4CYf9Td2TeI9EthK4eN
         F2CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BSEtgg8+Hpw/EtiHjL5IRktNHYkZQ4l9B8QMcHNKzRs=;
        b=NslrMZ5f6I5mWX5JpKL7DuOYDqURoD3YpuEXmU1oZytERSQagJTrj0I4F41CB8iZCu
         5e0iIcyVN28dlKxkbGucyXvZ6lJtrSkqnGKQmlfNy6xtYAHwGLG8tHsyKeIxE8ru9HyF
         9DErc0ZbvY0UouD6yy5HWppQYzUkPXOG7ujfVUYU4ZSJdz0iG+wyBCIA5xFUb28loMIg
         o7X6AwFLu4cUtPcddtQ7D4ttza7Y4HuTlrWv2jtexYywisJ+B5hOTFLnp0cxUZfazDFG
         EX8GmNajUoxskItnRrxCulluUMHprqfwceJuBj3wdoD6T6hq6w5WOwezm0NjpnTx48YW
         YJFw==
X-Gm-Message-State: AJIora9xNIqvD722EYwBt0oMcuhu/EvVZdvkb+WWLyTW7rUhzCeiwFjc
        NSPkfLDqoM4hF3AOJsxqY0RvYlrJcu3XEBpxfXY=
X-Google-Smtp-Source: AGRyM1u9Nn1gh/K3al7D9YTYNDVE3nZB3C3o2fD7AeOdyqGaPbXnVSlqvpk1KEgMM6wZM2t+cB6cSp8E5+GGA2PWOz8=
X-Received: by 2002:a17:907:6297:b0:72f:9aad:fcb with SMTP id
 nd23-20020a170907629700b0072f9aad0fcbmr9108533ejc.161.1658740203874; Mon, 25
 Jul 2022 02:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220722102407.2205-1-peterwu.pub@gmail.com> <20220722102407.2205-8-peterwu.pub@gmail.com>
 <CAHp75VfiKMROzxeEaCH6qCthK9qanJPqbjADLMVH-V0upKf+9Q@mail.gmail.com>
 <CABtFH5++4N1mECJ0vN-79WsJJWcBTVxLFgvkiouPf1qev7LHHQ@mail.gmail.com>
 <CAHp75VfKihBLjUFqe_Sj5dqTO7-wjLehAF+9_8-sbUeyJ-ZAmg@mail.gmail.com> <CABtFH5+LvvcVscRotyRYXhXs1pPkCahbVe0NcSFxC4k_WMMsuQ@mail.gmail.com>
In-Reply-To: <CABtFH5+LvvcVscRotyRYXhXs1pPkCahbVe0NcSFxC4k_WMMsuQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Jul 2022 11:09:26 +0200
Message-ID: <CAHp75Vd53faWJ8oD2WGQEMAVc-NfoceUUjpOJwy7piaraH8CNA@mail.gmail.com>
Subject: Re: [PATCH v6 07/13] mfd: mt6370: Add MediaTek MT6370 support
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        cy_huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 11:06 AM ChiaEn Wu <peterwu.pub@gmail.com> wrote:
> On Mon, Jul 25, 2022 at 4:43 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> > > > > +#define MT6370_REG_DEV_INFO    0x100
> > > > > +#define MT6370_REG_CHG_IRQ1    0x1C0
> > > > > +#define MT6370_REG_CHG_MASK1   0x1E0
> > > > > +
> > > > > +#define MT6370_VENID_MASK      GENMASK(7, 4)
> > > > > +
> > > > > +#define MT6370_NUM_IRQREGS     16
> > > > > +#define MT6370_USBC_I2CADDR    0x4E
> > > >
> > > > > +#define MT6370_REG_ADDRLEN     2
> > > > > +#define MT6370_REG_MAXADDR     0x1FF
> > > >
> > > > These two more logically to have near to other _REG_* definitions above.

...

> > You lost me. Namespace has a meaning, i.e. grouping items of a kind.
> > In your proposal I don't see that. If REG_MAXADDR and REG_ADDRLEN are
> > _not_ of the _REG_ kind as per above, why do they have this namespace
> > in the first place?

> oh... Sorry, I just got the wrong meaning
> maybe it should be revised like this, right??

I don't know. I am not an author of the code, I do not have access
(and don't want to) to the hardware datasheets, all up to you. From
the style perspective below looks good.

> -------------------------------------------------------------------
> #define MT6370_REG_DEV_INFO    0x100
> #define MT6370_REG_CHG_IRQ1    0x1C0
> #define MT6370_REG_CHG_MASK1   0x1E0
> #define MT6370_REG_MAXADDR     0x1FF // Move it to here
>
> #define MT6370_VENID_MASK      GENMASK(7, 4)
>
> #define MT6370_NUM_IRQREGS     16
> #define MT6370_USBC_I2CADDR    0x4E
>
> #define MT6370_MAX_ADDRLEN     2    // Rename



-- 
With Best Regards,
Andy Shevchenko
