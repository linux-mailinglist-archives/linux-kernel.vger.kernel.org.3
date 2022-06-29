Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FEE5609C1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbiF2Suo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiF2Sum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:50:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2391A050
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:50:41 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id fi2so34352058ejb.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VGp0r8sM5mZknQfVI2yfDxCg19sys5aNVE3+EWpAW9s=;
        b=Tl/EXqGcU+gTZSJmaC6LTPd+O7MER1FPtuy99jHEqhAJI/gQ51pcJXiwpACzJZ7SES
         PVtX7w8SgecUl6H809W36x0KyBpId8SOGe53QQQmllzidRX780Cdeb22xUz+c+JqVPAX
         RvSKHQahI3BCy0KxOdr2vuBHV3vOztuK15zP8XJ5LsSMJArgDvy7pgMr4DDaLjeckJcU
         hNGq233FtQPYdjVFDJ+yMrJd4FPogy3Ovb/9HgQkQSoUe8aLTGjrspqcTADrDNsFm1DH
         xIeJJh9tVwExx6FB5MlJIAA21YDuuIEbD1gTBEEXl46NYq5uHl6p05LnaTjge0MUpoqA
         PViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VGp0r8sM5mZknQfVI2yfDxCg19sys5aNVE3+EWpAW9s=;
        b=GQu3rkar/KUVP96fd9HUdLJb8BtC92at+V6nORpGw+G/Ko/Gp73Rs4qQR4DLzPv6Y5
         F0RTgplIGMJckBvQg9XXj8X6/0hf/pt0WW677vyzs4RQkdsWWpfaHyPl0QkWFjyTV5tr
         oc/Tt+Asc7svd3L0sFao4/1H9Twr8Mo/L7mbZvBXBtNKsNeMH+LhVlwIavYDpg/kWDXn
         KJSjhhQM64QEXOgPEB1zzPIywPxMXGW0s/oCDNQGTWWr5/eobTDFr65PHEUzLQBO/5PF
         OgPHUvjYXgL8vn7DeKCD7PFGPIyzpTH9qUlYpxoKlcqXf7+TGfgsb0J2u8LSBsVFKhEu
         1gcQ==
X-Gm-Message-State: AJIora/vwW7zT+5LgGKXsK9jNEBbHdSZ2o5RAbpuqlIyX8/C+9WUf7Mp
        6ZXhr+TQehP8MUErxx7we+HUO05mQ+Qak6Df7dwLxQ==
X-Google-Smtp-Source: AGRyM1uAEQa5n0jWp6G0//caHTKUPFeS+Y57BmjJG23TZwaIXDhf11hwGuBY2nZ8ndjyCfvJbyaKABb3F1Guh9y72+0=
X-Received: by 2002:a17:907:60cc:b0:722:e564:eb11 with SMTP id
 hv12-20020a17090760cc00b00722e564eb11mr4643048ejc.736.1656528640056; Wed, 29
 Jun 2022 11:50:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220629115010.10538-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 29 Jun 2022 20:50:28 +0200
Message-ID: <CAMRc=MccLs3SNp30d=fPEim8r1q3nPda5USnbM08dYNJA_VL3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] of: unittest: Switch to use fwnode instead of of_node
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frank.rowand@sony.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
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

On Wed, Jun 29, 2022 at 1:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> GPIO library now accepts fwnode as a firmware node, so
> switch the module to use it.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3: no changes
>  drivers/of/unittest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 7f6bba18c515..5a842dfc27e8 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -1602,7 +1602,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, devptr);
>
> -       devptr->chip.of_node = pdev->dev.of_node;
> +       devptr->chip.fwnode = dev_fwnode(&pdev->dev);
>         devptr->chip.label = "of-unittest-gpio";
>         devptr->chip.base = -1; /* dynamic allocation */
>         devptr->chip.ngpio = 5;
> @@ -1611,7 +1611,7 @@ static int unittest_gpio_probe(struct platform_device *pdev)
>         ret = gpiochip_add_data(&devptr->chip, NULL);
>
>         unittest(!ret,
> -                "gpiochip_add_data() for node @%pOF failed, ret = %d\n", devptr->chip.of_node, ret);
> +                "gpiochip_add_data() for node @%pfw failed, ret = %d\n", devptr->chip.fwnode, ret);
>
>         if (!ret)
>                 unittest_gpio_probe_pass_count++;
> --
> 2.35.1
>

Reviewed-by: Bartosz Golaszewski <brgl@bgdev.pl>
