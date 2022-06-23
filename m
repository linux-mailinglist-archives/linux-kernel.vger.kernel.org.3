Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF52C5575F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiFWIyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiFWIyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:54:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCBC37BC9;
        Thu, 23 Jun 2022 01:54:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ge10so8060802ejb.7;
        Thu, 23 Jun 2022 01:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ewocLK4QQe9PxZjCCcv8MwH3fNq/SZdcCp141CybdY=;
        b=Kqjw6Rve6l85j+tA8aUQq34+hQ66vEsjrz7vZgWhz7Ljx6vlzB/s0S3zyfFQUH/3BT
         ZkoVvbpAQT0P8iWwpcGzSap2PCc40eq4cSfiuq4QCtmnpAzDkPt+fMI4DBgkA+27LIrI
         eN16lc3f2jh7/ppkiKXiryX6aWvVb0L2f3CHOBu2BLisB23B+Mm+9+WAoyze/eNLdB86
         cQ6NsCSLdUsv8Nw+QsCT03NjVe4ZnUmWMNojoAUVbeFNtjfDZOzVbiJhuskuAzLjqHS8
         udz2ZBV/V0Phaa/vIIg9iK+PVwKhCxdnuv2P+h5O+NOvgH+8yzA4YG26sHiAhVavWVzX
         /36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ewocLK4QQe9PxZjCCcv8MwH3fNq/SZdcCp141CybdY=;
        b=Bq4CLLAM2UA13887kT4CGcFu3bjt9+1YYLlygNQk2c7KBl2dNhKVbhlkSccynjusvk
         5koI9pZKZJjhFhaqcQJW5rqCvbgkZZkfqr2dgiOpHLnRfjnsiC94rutEsNTcMJTAYeMv
         vkteWGfMRjhlHxnSIsa6blnvZQj70+Tuz5lm7JdPng2WV5b9E0VYq2bsM0UGWB4AP/rR
         0QiqWiBzqkyM9k8P9d/tcozA4VO7QhPsubfwp8ATRdNcwxY8lVF5NR+PDKG1SuWHMuyu
         6iU7VrBkv6fxbmLfa8VKFtCXGx8tHa9ek7yFid5xd/67pfKZVxE6Gus3iwj+ten850Rk
         eyNA==
X-Gm-Message-State: AJIora+pukWAxqt3wxjVn8X5WkbIPS/dudzhqWLwFFzRK77zxyXHqBG2
        wVeJhOuXYhLKmqELjcCHrS7z2z1uOwyv7bFv5jw=
X-Google-Smtp-Source: AGRyM1s/cuwwgO+0Sp2pW/dYpZ5m/GlC8Pm/9k9OqASIANcWAar3Aq5myyz+KQKUvdUTygA/txrImEaGpacIQGqXKII=
X-Received: by 2002:a17:907:6295:b0:703:92b8:e113 with SMTP id
 nd21-20020a170907629500b0070392b8e113mr7172323ejc.594.1655974482584; Thu, 23
 Jun 2022 01:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220607155324.118102-1-aidanmacdonald.0x0@gmail.com>
 <20220607155324.118102-3-aidanmacdonald.0x0@gmail.com> <YqDLflKTsYaupArl@sirena.org.uk>
 <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
In-Reply-To: <6YJcC5wyOg6x6Ny4Os8ujFbK2qB4alkU@localhost>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Date:   Thu, 23 Jun 2022 11:54:29 +0300
Message-ID: <CANhJrGMqUmnSvyNRgRyp40YnGQkD3N_2AZLn94NDp+4RG0_x5w@mail.gmail.com>
Subject: Re: [PATCH v2 02/17] regmap-irq: Add get_irq_reg to support unusual
 register layouts
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, Chen-Yu Tsai <wens@csie.org>,
        jic23@kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>, lars@metafoo.de,
        "Rafael J . Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi dee Ho peeps!

Sorry for the late reply.

pe 10. kes=C3=A4k. 2022 klo 18.43 Aidan MacDonald
(aidanmacdonald.0x0@gmail.com) kirjoitti:
>
> Mark Brown <broonie@kernel.org> writes:
>
> > On Tue, Jun 07, 2022 at 04:53:09PM +0100, Aidan MacDonald wrote:
> >
> >> -    if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
> >> +    if (chip->get_irq_reg) {
> >> +            reg =3D chip->get_irq_reg(base_reg, i);
> >> +    } else if (!chip->sub_reg_offsets || !chip->not_fixed_stride) {
> >
> > It seems like it would be cleaner and clearer to refactor things so tha=
t
> > we always have a get_irq_reg() with standard chips getting given a
> > default implementation which implements the current behaviour.
>
> I don't think that is a good way to clean things up. I only intended
> get_irq_reg() to be a quick hack to solve a problem; in my opinion it
> would be a poor abstraction to base the API around.
>
> What I'd suggest is something that will simplify regmap-irq. Instead of
> defining the base registers, etc. in the chip, introduce a new struct
> to describe a register group:
>
>     struct regmap_irq_reg_group {
>         unsigned int status_base;
>         unsigned int mask_base;
>         ...
>
>         unsigned int irq_reg_stride;
>
>         int num_regs;
>     };
>
> The idea is that the registers in a group are linearly mapped using the
> formula "base + (i * irq_reg_stride)". Then it's possible to allow for
> multiple register groups in regmap_irq_chip:
>
>     struct regmap_irq_chip {
>         const struct regmap_irq_reg_group *groups;
>         unsigned int num_groups;
>
>         unsigned int main_status_base;
>         unsigned int num_main_status_bits;
>         int num_main_regs;
>
>         ...
>     };
>
> It should be straightforward to fit existing chips into this model.
>
> - Chips that use a main status + sub-block IRQ layout will define
>   one register group for each sub-block and continue to describe the
>   location of the main status registers inside of regmap_irq_chip.
>   A group will only get polled if the corresponding main status bit
>   is set -- n'th group is polled if n'th bit is set.

Does this work for devices where a single main status bit can flag
IRQs in more than one sub-registers?

Best Regards
 -- Matti

--=20

Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));
