Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6044B552E79
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349039AbiFUJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349026AbiFUJfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:35:48 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AAD25E83;
        Tue, 21 Jun 2022 02:35:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id o7so26235150eja.1;
        Tue, 21 Jun 2022 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a56PheGcF+r+BjhYmHX7tYRduE7y97a0JE0aqCMtBZI=;
        b=UixjmExeWC3NrbmY2//fqkfPnJRAmI3sK61SBW8J25ecyvNRu8cdjcXzZrB9vFZaVW
         YUpJGfwbiuk1/Q15sPGbqfe6e4JyoZUF59VlyzpkI8jO20sjRrqotK1X7unN/KnfUqEu
         p1Se6aKX+tKaHJYE71hUPqHSk+sEw3O9OOYNMtYAQ70/ZfGxiMBPLX85OQUMZjK6B5Cg
         tPCfGRSWvPAgVwm+hlCyY4iVKhj6g7/5PYEeerpe5McbZ3g4CAAkUyCi8c3KpFsTdeoC
         DSdWLIDZ7kz2SMZgvQ71gwC1mUwdwSgDGv5XUY5Mjm6N+iOs/pHvh4h7V4c3k1ultgT7
         JV+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a56PheGcF+r+BjhYmHX7tYRduE7y97a0JE0aqCMtBZI=;
        b=Sw9eadQ6MF9Ihh396x1XTGe72sh6gINc4glSzuppK97VEbI/eaNhlom+TUH3ifdIyd
         r1NVx6ZKQu/UZJG6F0NP+6SNTV9m9JjaxiYaS9oacoQoyHoJLEgG3c/bbRDYBVh3kNRJ
         SF7kus/fXiNykx4TmQVNkTNrvg9VPlXVWtZ6jwkuEyhc0B5TCBUOw0Ws05Rxwl1yfskQ
         neKIPPXMUs+XqR+vYtwz2OsHk8VDgGM11vb6K+QOgCnDrma4k3UJzDJEcBlhtQI2wyTU
         GmyxptSl8xRt/c8y1/6UWXHQGkxOLsL598EFJgMTk96UTfocd1+1hAJDfQRvWMUtWO8P
         aFhw==
X-Gm-Message-State: AJIora8xiGFQs9YY0PRnObRLhEnGPzvuyJh/YjYffTjcGkIrk6EGag4o
        C6ZE14poDXLOK6WrP4wN4NreMad5uKtGD4AlLXE=
X-Google-Smtp-Source: AGRyM1vsBhYdy8df/ZvLMM++hzJQmiiHBbGOufLVS/g7a50OxkgQ40vccBsdp5QFt6gNbEpmAGHvXM35Y2xJUEtiTAs=
X-Received: by 2002:a17:906:d9d9:b0:710:f2ae:b455 with SMTP id
 qk25-20020a170906d9d900b00710f2aeb455mr25461664ejb.77.1655804146381; Tue, 21
 Jun 2022 02:35:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220620200644.1961936-1-aidanmacdonald.0x0@gmail.com> <20220620200644.1961936-19-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220620200644.1961936-19-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 21 Jun 2022 11:35:09 +0200
Message-ID: <CAHp75Vea8F5ogP8kjfdP4SK3aeohoRnkGZ7LtsLuwfXwL+APvA@mail.gmail.com>
Subject: Re: [PATCH 18/49] mfd: qcom-pm8008: Add broken_mask_unmask irq chip flag
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

On Mon, Jun 20, 2022 at 10:08 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The qcom-pm8008 appears to use "1 to enable" convention for
> enabling interrupts, with separate set and clear registers.
> It's relying on masks and unmasks being inverted from their

It relies

> intuitive meaning, so it needs the broken_mask_unmask flag.

How has it worked until now?

-- 
With Best Regards,
Andy Shevchenko
