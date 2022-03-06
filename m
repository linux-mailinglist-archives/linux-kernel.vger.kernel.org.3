Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00BB4CEE26
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 23:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbiCFWYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 17:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiCFWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 17:24:36 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CB13E01;
        Sun,  6 Mar 2022 14:23:40 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id bg10so28224443ejb.4;
        Sun, 06 Mar 2022 14:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jik7THNsWU+1K6UwzM/hvD2NC7hSIAI2UJJfc3zzqWY=;
        b=WyMKAl947JIYgDfUPiQxq55P+NpZe7ABPq9+NTqm/CSoy7pJIjhE/BFisQuq8qWION
         OP9/cid2jIMK+tz5ACrz2dzNOOV2tK/GluKdFUb//LkHbGKloMfwVbTDEKGn9jKOmT0x
         BAEaMSpySZzUYCA3135keDHIgB2gWITYlKZfUfQI4r78Ia44xlS1hyu3yZ8iOSDKHPT3
         VFZ1xsRxYD2cABrd/bVyimuNLNDJ3G9oqGg0iCG1xZ/i5XemZ50bnDpWaC23z75ocdH3
         tdBFkj/aD3rg9O1fKM5JJQTsQNIpDHDaXNRFBglJmFYCyGthQ7HDnaYv/C7j86M+hqrS
         TMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jik7THNsWU+1K6UwzM/hvD2NC7hSIAI2UJJfc3zzqWY=;
        b=JwcU7bPMCQWroqoJTRkb86EmNeGytCJzxSoGTVz67fjCF6JnHcJlFy8Ve4V3b604uP
         vVvZZI96okvWUC7PkWcBV8HTJpge2J2Vqsqs0yIDrAsiiUUeqJb0bDLLGT3I5Z+jmv/z
         KAYNe5H3o1kB3XCczZygil7ZY40jV3bNUmwojv0/+1vUkpKLd32FyVQPTYzcsetP/bZf
         fXQBfZRIgLGAu8aSvS86zmklMbgSNb4b/2BIGQS//NAhZTdY4QELZnmxqWX85pE9tXdG
         jxXq6qBuX07bLicZ+5VyVum//YnH+GIJidQW1Pr/zzOKIaVl5Krf4kSK9LjS4zM8skb+
         TbnA==
X-Gm-Message-State: AOAM533hCvK+8Xw4PH5clBoslIOMGbwrJ70VAM7zaSS0wnd7wLQH1QAC
        X4y5bBv2nEtulIDF1MIGWt5iwnlvIp5+Mixdy3A=
X-Google-Smtp-Source: ABdhPJyfKDDUImbvmTrKP2jdGWTqm6lFPRNfnEe1hApKP7jti1ByDsZuIco8uh1J8IEhTkONMdMlDOhKr1wxavAUhyc=
X-Received: by 2002:a17:906:cc12:b0:6b5:ec8f:fdf2 with SMTP id
 ml18-20020a170906cc1200b006b5ec8ffdf2mr6793942ejb.579.1646605419340; Sun, 06
 Mar 2022 14:23:39 -0800 (PST)
MIME-Version: 1.0
References: <20220306193420.99714-1-brgl@bgdev.pl> <CAHp75Vfgsa5Ru5aA7Bx_mV--h-GFKSX9Uocf+njvh8Rc1yNTow@mail.gmail.com>
In-Reply-To: <CAHp75Vfgsa5Ru5aA7Bx_mV--h-GFKSX9Uocf+njvh8Rc1yNTow@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 7 Mar 2022 00:23:03 +0200
Message-ID: <CAHp75Vd8Z-XmSE-JxM55rLAzMqFqm5D7B2HsQ+P_vdh==deOJQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: check for overflow when reading the 'ngpios' property
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 7, 2022 at 12:19 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Mon, Mar 7, 2022 at 12:11 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > The ngpio fields both in struct gpio_device as well as gpio_chip are
> > 16-bit unsigned integers. Let's not risk an overflow and check if the
> > property value represented as a 32-bit unsigned integer is not greater
> > than U16_MAX.
>
> ...
>
> > +               if (ngpios > U16_MAX) {
> > +                       ret = EINVAL;
> > +                       goto err_free_descs;
> > +               }
>
> I don't think it's a fatal error in this case. I would perhaps print a
> warning and simply use a masked (which is done implicitly by an
> assignment of the different type) value. Note, the above is buggy on
> the buggy DTs, where the upper part of the value is not used. After
> this patch you effectively make a regression on, yes, broken DTs.

Like

    if (ngpios > U16_MAX)
        chip_warn(gc, "line cnt %u is greater than supported; use
%u\n", ngpios, (u16)ngpio);


-- 
With Best Regards,
Andy Shevchenko
