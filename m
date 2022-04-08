Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661D14F9395
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 13:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbiDHLR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 07:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiDHLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 07:17:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2122527BD;
        Fri,  8 Apr 2022 04:15:21 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z99so1065473ede.5;
        Fri, 08 Apr 2022 04:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa7QZzIFVFDFbunq9XhVZaHXC3Qs6q5HoIqOfQS/Ym0=;
        b=Ebq/3CFzWxM8qOh59YVH2MLYRjSnNcFwOCUvzxHE9Tbiurl/HsdJniiD1qliVZEERU
         egaLCA4UmdSfDDN4EPXlUQ+PS23hRirNXWulOyJhJfUged92Dj3FhTk1J4IJz6ZUyLAu
         eyZiQgZ64kpqJK+yU6ddWURM04C7fRJ9zFadeHEtp96BCtlb+gQpFIysmzvQkmIKjs+S
         yHJ0SontZJT/j9Q1IYD+29wUihigkLmLLmjmhlkqmm/c7z9LVxxiiB3t8XGHCl/rpJOD
         76p5WnLAs7lPxHuxR0L12v31RA0rUoi9fnTewbklVrxk03jNZkTbX+2Wg/R9zcGYHzLt
         VpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa7QZzIFVFDFbunq9XhVZaHXC3Qs6q5HoIqOfQS/Ym0=;
        b=VIbor8fRrXjG13k6iochpisGjz0af4DalIM1Ffsebdffk2AIcx1X4bImnm0T1br08S
         AYGNwahAsR1bkfbHNTxbQXkIthUXa7j1Ly9dGYKabV2SaC43cTLWrbrcEkGOH97hhk3t
         IqiOI2qjxC19+DJLx2L7rduf3gMKBnRHBraPyzfAIrt7mkJHO0L4lT9bZTEb44F/9Zar
         QT4YWd3pKJrTOiYxGQdRs9f7xeUmjNEAGj9Tg2gPf+ERtxOdQPSXHF5QlK3kDM+wcSKn
         HvGeamWmW3y95Br6m/YHiGFnPlrgilw5ivSLXW5GxTkIi4BUxPkYaLJk6LNtKr9HSyIJ
         5a1Q==
X-Gm-Message-State: AOAM532PwW7UUY//ro7mT438QsK3T/eI2biiRGudp1Gta5P3K/Zpt8UM
        fm6ETkpydXdi/vTRBXZnng5AhSrlBAb/w6xmwBtQYtGIKNLyDEjQ
X-Google-Smtp-Source: ABdhPJwTfsTBXB3ob+uJK79ZSJa5OgMnE+cTkAqMYO9XInOo/wP0oHo9pORKY6Cub50GFUTgpI9H5oRJ7wNnqKs1i0g=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr19167579edm.122.1649416520116; Fri, 08
 Apr 2022 04:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220407183941.36555-1-eajames@linux.ibm.com> <20220407183941.36555-2-eajames@linux.ibm.com>
In-Reply-To: <20220407183941.36555-2-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Apr 2022 14:11:05 +0300
Message-ID: <CAHp75VedZdEYB-BjJTVaKJgPwQ9a1DhTp=MYsrh1Ve9Eyfnytw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] leds: pca955x: Clean up and optimize
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>, patrick@stwcx.xyz
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

On Thu, Apr 7, 2022 at 10:42 PM Eddie James <eajames@linux.ibm.com> wrote:
>
> Clean up the I2C access functions to avoid fetching the pca955x
> driver data again. Optimize the probe to do at most 4 reads and
> 4 writes of the LED selector regs, rather than 16 of each.

> Rename some functions and variables to be more consistent and
> descriptive.

Separate patch.

> +               dev_err(&pca955x->client->dev,
> +                       "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n, val,
> +                       ret);

This can be indented better.

I would add a temporary dev pointer variable and put this on one line.

 struct device *dev = &pca955x->client->dev;

               dev_err(dev, "%s: reg 0x%x, val 0x%x, err %d\n",
__func__, n, val, ret);

...

> +               dev_err(&pca955x->client->dev,
> +                       "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n, val,
> +                       ret);

Ditto.

...

> +               dev_err(&pca955x->client->dev,
> +                       "%s: reg 0x%x, val 0x%x, err %d\n", __func__, n, val,
> +                       ret);

Ditto.

...

> +               dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n",
>                         __func__, n, ret);

Ditto.

...

> +               dev_err(&pca955x->client->dev, "%s: reg 0x%x, err %d\n",
>                         __func__, n, ret);

Ditto.

...

> +       struct pca955x_led *pca955x_led = container_of(led_cdev,
> +                                                      struct pca955x_led,
> +                                                      led_cdev);

Is it used once? If more than once, consider a helper for that as well.

-- 
With Best Regards,
Andy Shevchenko
