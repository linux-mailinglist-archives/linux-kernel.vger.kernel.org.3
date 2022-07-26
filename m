Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1F058185F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239332AbiGZR2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiGZR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:28:39 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CC72B61F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:28:38 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z22so18532857edd.6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rh723Ajvwuei+YLNOSUmMDaBNCt50o8njISA3FQglhk=;
        b=pFZbkYkvjyITzKTAIiENpYWaTK9at4DFJwxk7achMTIby49sgYQvdle04Gj7AlwEgS
         XfGjp1YTd8Wmck8g9WlKPaaucsW3ogzcsrzxd1ZkYks6Z2FVzD73F9NClC3YRaDvN6gJ
         Y7bDKz1sxNk/JTQlVi90Mg/kdEcaqMzQ98+YIf4b40nmSipECR1Vsv569gwCitv7Nclq
         csV881RIlMHDxbYrlTMUyJknlEHggDzbowYZanewehED3qIjwH5wU+VIyz+PQADIZYFD
         Zk+YAJilWW4cM46x8n12wA8mg0P/oMLOCQVVHxu5lKcqT+yJPuBmT5+ozUFvOU0H1MZf
         1qaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rh723Ajvwuei+YLNOSUmMDaBNCt50o8njISA3FQglhk=;
        b=ARehYoDWATmClQ62/+ce8Hw1c9POjc+4MJtanMIWoGeHBl4r+QoSBi6zMa+jvxzpV8
         /ICSO4agjgjhJNtXQTPLunqniZqu76/pE7Dedhux/+DOiTNzH3tVmmUZ+Dx0PWYHofY2
         Yk8laXCBtzxlO6dfzu9Otpvy13b4+brFPjz27B84nn+WfBgOPX9oNaN1/UtosEbR7PtU
         Oz9Tjnk6nrsJMjb/B68yBD2k5qxzcQX1zqZVgGMNizQ5/vSmP4UEkha2MjbANY/MDZvI
         3Fu/ZZcjDpIMSKQ7vo07q8l4mXERJLzm/cueu/t332OShd+KbXIeqjDo1hMd2LGxOZl3
         UOzg==
X-Gm-Message-State: AJIora+QT+6APlyFzynnk3fH8SWit9PWPBa1flIIgQNoB9Kaed8/J3Ai
        DspGQlXtgj/ouDF53c6lv9SiqjKI3QTIIGT5+EtKaw==
X-Google-Smtp-Source: AGRyM1tdMtW8pxo+xOoBqXEMHvrtyrex3wL8QPPn8ukNyuo5R7wDh7EM4MyHzEhuL6voJo83fja+5xSfM+cZ/mfyxwI=
X-Received: by 2002:a05:6402:1d4c:b0:43b:c85f:5c95 with SMTP id
 dz12-20020a0564021d4c00b0043bc85f5c95mr19575068edb.213.1658856517092; Tue, 26
 Jul 2022 10:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220721101416.18129-1-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220721101416.18129-1-aidanmacdonald.0x0@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 26 Jul 2022 19:28:26 +0200
Message-ID: <CAMRc=Mdd_mzaNqT0jjiPxYFwHt-_7WjTRdfXsqSiPdHtpzHCeA@mail.gmail.com>
Subject: Re: [PATCH -next] gpio: sl28cpld: Replace irqchip mask_invert with unmask_base
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:13 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> Following recent changes in regmap-irq, unmask registers can now
> describe inverted mask registers where a '1' bit enables an IRQ.
> Because this implements the same functionality as mask_invert and
> is more straightforward, the mask_invert flag has been deprecated.
>
> Update the driver by replacing all uses of mask_base & mask_invert
> with unmask_base.
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Michael Walle <michael@walle.cc>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
> This patch depends on the "regmap-irq cleanups and refactoring" series
> which (at time of writing) is already in linux-next.
> Link: https://lore.kernel.org/lkml/20220623211420.918875-1-aidanmacdonald.0x0@gmail.com/
>
>  drivers/gpio/gpio-sl28cpld.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
> index 52404736ac86..2195f88c2048 100644
> --- a/drivers/gpio/gpio-sl28cpld.c
> +++ b/drivers/gpio/gpio-sl28cpld.c
> @@ -70,8 +70,7 @@ static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
>         irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
>         irq_chip->num_regs = 1;
>         irq_chip->status_base = base + GPIO_REG_IP;
> -       irq_chip->mask_base = base + GPIO_REG_IE;
> -       irq_chip->mask_invert = true;
> +       irq_chip->unmask_base = base + GPIO_REG_IE;
>         irq_chip->ack_base = base + GPIO_REG_IP;
>
>         ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
>
> base-commit: 353f7988dd8413c47718f7ca79c030b6fb62cfe5
> prerequisite-patch-id: a45db1cac7537769dc10087fc61f977dc150744c
> prerequisite-patch-id: cb8aa009c7bb7a6575eb05e3af65342dc8d0efa3
> prerequisite-patch-id: 8d32557e53b894d1fb17250d2d0eb3673f068d37
> prerequisite-patch-id: 5b293867ef81e3697892ac51b941bb53680a70dc
> prerequisite-patch-id: 8138d39a4817e804141bfe8c2ad37d9c55456a40
> prerequisite-patch-id: b01216129e887519d441cf556bbc75c397871773
> prerequisite-patch-id: b5dcf0c0609113c2d81bc557c1fc95ef23f40811
> prerequisite-patch-id: 622ca1c10e851b1889aaa567c1d2a0adf43cca44
> prerequisite-patch-id: d28c5187f9bf0e43f27b2f4aa8dcf7fd91842a03
> prerequisite-patch-id: d29d54b756be73304f844abeeaf9b46a5c0119d5
> prerequisite-patch-id: 5d405790ae89c0831b46a359f86e94bac5a67470
> prerequisite-patch-id: c90120e79acbb52ffa148bfedee1df9d35b5eced
> prerequisite-patch-id: 2e35247a5cfe5a28565c9272b85fc6835011b032
> --
> 2.35.1
>

Who took the prerequisite series? Do you mind if we wait until the
next merge window with it, that way we'll simply apply it without
having to pull in other branches?

Bart
