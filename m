Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67F252710D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiENMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiENMuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:50:25 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0017331B
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:50:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n10so20843366ejk.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MwFfS+OAdHA65KRpJdHlUNnMUxuYShxJqABqPAsn8EY=;
        b=PnAfYtk40okN43z/Nyfjb3+xagS0nOdWUqIXByULEv5vFKQLtkABzpyXlEYaqtJ5Y4
         aSaBX/PPbBIitnkGj13Y7pP1aeAMK0aC2sqT8xApotZq/t53oVV6hFeFCQ4rnxxqldCq
         z9qu7L+f8NQtNQJXGUjc7t/Oy1WZw2un9I4fyCIwpFt8Jc6Etpq/WZ3ccYmxE6DaG1YK
         y+yfbqj/gorIqAnF9pu6Ek5Qa7ioOllAaQNfCUL+PpnBe5l80fFkcUuUCl3JVYNE1OUz
         v6ZI1nqM2KEcFuu0q4neDFCROawfT4MGSrEKJDPPeh9IB5lhgBOpQeywm4hNGbNRi9Ej
         dsSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MwFfS+OAdHA65KRpJdHlUNnMUxuYShxJqABqPAsn8EY=;
        b=4ArzEZZtIooGa6h1wJKl6kaIYYceMl/7jU8nBMEhb0tc6pfKVOay3JwcQmxB0o5W3p
         w1MroMdf8q4bR2APhc4GkkpOwbz0386XBfObgbSuBRHte1TJx98Pf2ymb+8oWpXgixnY
         GizxeVqUyATcsu3ujcEzQbi7z/DlkiuG/Q4r36OHEhY36TpoK6BfiaJ2fP4BwfkBmVGJ
         CWiFWRfUger5PcTbR2hrHkOM2QXsqBvXwtXvnyzeW/IlvljQy8ByDfPnG/Q0DUSoBKP/
         NLy78kJhXA+DyJjIPekOhEjWklEyGS4BGZbbKzJ5uzMsZW/oSP6bhHwP8KAE0vuhrOG+
         T/bA==
X-Gm-Message-State: AOAM532GvlEbMwgsRp+ytl3zRM0O26uXPPou0kUODnwu16F19eGqBUMp
        WLXrPNYWhqYhO1uZXAN0IcsEvAxxOvhVW2cViUmbRg==
X-Google-Smtp-Source: ABdhPJzp2MFudM+PfQz6FPW6Sts16d/qrTCDFnBdfFPfU6xxchvVUctpNm0uVF+QsKs+8mr9R+Cr/qR7JiL3Cy7rcTs=
X-Received: by 2002:a17:907:6d8b:b0:6fe:874:25bf with SMTP id
 sb11-20020a1709076d8b00b006fe087425bfmr6026136ejc.734.1652532621482; Sat, 14
 May 2022 05:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75Vfz-Qq3qo3Re7tsL0mfXNVYZYspGDFCDXhtZxwac7bEiw@mail.gmail.com>
 <20220512124755.2360648-1-zheyuma97@gmail.com>
In-Reply-To: <20220512124755.2360648-1-zheyuma97@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 14 May 2022 14:50:11 +0200
Message-ID: <CAMRc=McaXXUdRT-QrEhs2CjhsnamQMjCbbOS0c2cwo4CA4H+8A@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: ml-ioh: Add devm_free_irq() call to remove flow
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 2:48 PM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> When removing the module, we will get the following flaw:
>
> [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> [   14.209994] RIP: 0010:remove_proc_entry+0x389/0x3f0
> [   14.217820] Call Trace:
> [   14.218264]  unregister_irq_proc+0x14c/0x170
> [   14.220206]  pci_disable_device+0x1ad/0x380
> [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
>
> Fix this bug by adding devm_free_irq() call to remove flow.
>
> Fixes: e971ac9a564a ("gpio: ml-ioh: use resource management for irqs")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---
> Changes in v2:
>     - Remove unimportant lines from the call trace.
>     - Add the fixes tag.
> ---
>  drivers/gpio/gpio-ml-ioh.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpio/gpio-ml-ioh.c b/drivers/gpio/gpio-ml-ioh.c
> index b060c4773698..09bf317876b0 100644
> --- a/drivers/gpio/gpio-ml-ioh.c
> +++ b/drivers/gpio/gpio-ml-ioh.c
> @@ -508,6 +508,8 @@ static void ioh_gpio_remove(struct pci_dev *pdev)
>         struct ioh_gpio *chip = pci_get_drvdata(pdev);
>         void *chip_save;
>
> +       devm_free_irq(&pdev->dev, pdev->irq, chip);
> +

If you need to use devm_free_anything() in the remove callback then
something is simply wrong in the resource handling. Can you instead
use devm_gpiochip_add_data() in probe? This most likely would fix this
problem because it would correctly order the freeing of resources.

Bart

>         chip_save = chip;
>
>         for (i = 0; i < 8; i++, chip++)
> --
> 2.25.1
>
