Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A259580C0D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 09:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232263AbiGZHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiGZHBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 03:01:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB330A;
        Tue, 26 Jul 2022 00:01:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j22so24502502ejs.2;
        Tue, 26 Jul 2022 00:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOA8s3Oyn7qPnoSXjkf7YG13sN4RGL1iL6HFKActpLM=;
        b=XTa3QYNCdikYszlvZleeek4C/YDTDdRk7Cc+/fWEH9J0N31MfaQQlCAWUe42cqwINe
         yj63Ud7BWH+/B2HwPd49UQnFpxZZGwOuu8LJQJ9BOIPoqyEMAMeRr5W62+cuVGE05QPV
         qsFgZq1v/3Ie1tXQq20JtOlydJVaBMWyKWamiBwBmTZzsNjk6puWgLeQH+kCaVVdRquz
         O2cTfzEy8K3ENgLWh/r0csG/lAIfU6KpTIDx6zSCDaItL9KNBkArKsIFWVLb+Do8UnET
         WJz1PWBBorepsiiuWEDSQG3VpLPKirtbrL5LwQY+DaVacZuj0WeR3GV6VFxmFSMJwsYI
         7rhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOA8s3Oyn7qPnoSXjkf7YG13sN4RGL1iL6HFKActpLM=;
        b=5JUwj3dmIOMldg1Ew+wo1eywkQ/HbZARM7b49lYOpGossZRw6e2G/Ug0Ek7pA6aBNu
         aaJ9mTzeOPYGO/rxvWp9SGi8rPPfENP5sCodywqRotjydaM2Im4Mj/EOXXDkUQrg7ky0
         NRsyVhf5cXk7BAjKTnQR/N04qwjFVRnfASnh/oypShXiVVJZgb3XlAoF8zgnS8Qwwbz3
         dky5554z8bZz4RyKZ+uItzY9F/ptZMUkj5pRTpJpUFg6+AFNVNHMofviMxsfO9EopzxK
         TtLDUxlilym3PGJ4Kpv4YiAj/kS55P3CNq1Dxv2q7FCd2wTielYgvp6xXWvOTL6PLEvB
         1mIA==
X-Gm-Message-State: AJIora9Y1xdfzigaEjD/hsWE2JFs4YfiEWeXRKiFcK+QyBtk2ymunDdG
        Xgt/Mrqg3b1c2zMLopjbUC/GrViYeAB+E2LyEZnOyMXofwZZfQ==
X-Google-Smtp-Source: AGRyM1tM2PUe5bs+lQ1eFvRVNmNX2JVKsz87+eK4UaLd9rZ39cw6WUkBcUMtEiIqyecG1xKKEAn45L46Ri3potQlRiM=
X-Received: by 2002:a17:907:a063:b0:72b:52f7:feea with SMTP id
 ia3-20020a170907a06300b0072b52f7feeamr13086383ejc.740.1658818859397; Tue, 26
 Jul 2022 00:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220721093422.2173982-1-marcus.folkesson@gmail.com>
 <CAHp75VddBhc9peHXfNfTyTNni246kC8CyLqCrMFadn67LGDarQ@mail.gmail.com>
 <CACRpkdaczrU1tM5Yt7P-Q2h+ge8STOi6HvvYeTM-g+JwS8_gZw@mail.gmail.com>
 <CAHp75VfaExrFYto7LWa5Vnbm6JbiAqtutKmk0HzfeHmmi3PwOg@mail.gmail.com>
 <CACRpkdYHgD-fmt_2PWJrmyGY=AOP0Z+4jTkH=n3wJ+a0aApqcg@mail.gmail.com> <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com>
In-Reply-To: <CAHp75Vf_aDSocdB7R6zKFwEOBRwq0w2m6GdCM-5ujKoz4bGiqQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 26 Jul 2022 09:00:22 +0200
Message-ID: <CAHp75VfJvkm1LaVtD8BE9y1fsaJ2ToLqQ3H8dY4SshBfE6vtJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: gpio-74x164: add support for CDx4HC4094
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 26, 2022 at 8:54 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jul 26, 2022 at 12:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:

...

> See Figure 7 and Table 9 in the datasheet you linked to. When STR is

Table 9 --> Figure 9

> low, the data is not changed. Maybe it's not clear in this datasheet,
> I found somewhere
> in a more clear table.

If you have hardware and an oscilloscope you may test it. We will know
for sure :-)

-- 
With Best Regards,
Andy Shevchenko
