Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C6546680
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 14:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344200AbiFJMVc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 08:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiFJMVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:21:30 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A9F2D057B;
        Fri, 10 Jun 2022 05:21:29 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id x62so35038778ede.10;
        Fri, 10 Jun 2022 05:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z4WE6SPckcHYXKwLFBH2TH8FBe4r/iUtHZtiPwsKkZE=;
        b=nYI9RtFrLo87bOVdy88dqGE7TDNOJs6Tx6UarjskgiVmzG4fPyrX6ezNb3bFs7BHf/
         ko9Ql8aC6w/QdXBke5I5KTLmNTx3m+Ge/M+W9YEwapfijdrIACn9R+eAyUzdJRip70S1
         OdPNIkC78R8l4syzI+USBmvE6B9B41xqFafj+9qVrjsuS+yJs7eLdG+fUhZzZWh/dfTM
         rEZdm0lL8HwE5Hmq8wJo21PORAB0+JiWWQU5Cj+Hib7DgV9ndASl8SscgkdCxDsZ3xL7
         lwSXoThp2tPVGi0hJhwyLqEYfrQ8+o8kU3cobZJc/GBXz2/3p7lSEWQNmkfjTqV3oo2f
         OUuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z4WE6SPckcHYXKwLFBH2TH8FBe4r/iUtHZtiPwsKkZE=;
        b=Rhbr4bA3+nw6w9CEz/u87VPl7mk3P5R4M4Wt4AbCY3dBAI2PXcNedqHBZOEn5X0DuE
         QHVDstI5yn+rENLEE1LlVWrQ2Jq5Z4T9ZE+KY6IBgCh9lPLLia3LFv6XGkaWrct5uxec
         CR40cKBCUUnfn8l6QPXyRzacW/fSlb2ungW2MyZopPuOATos4yjHUQ1wKEN7Q16MyVrI
         8uRv5F73FBPKrau7Yuh47CwhQiRxcfYTsbL9h86cPWqvMDZDCULVEErYVPEGdTfbQAPZ
         k1toDICpatMyJ8w3YQ/s3Nkz78mO0PuFeJlUctNXPg2rAjYFx4ny5K/MQpFG3rN9eIFr
         k5fg==
X-Gm-Message-State: AOAM530k/Kf/eZ8gJsb0OVaQI9dFoG17uryPT0TIiGfnCpYkV4ZWJKHj
        WRjT2jhq4ZVO8JR5jFWmcp1XeyfyV/zEomMan00=
X-Google-Smtp-Source: ABdhPJzFFuRxIChqu1tHzziKPb2NjNtL/4TLgbeELvEDNLv5LS8epx4uibDWB0e6PW5xOgpx3Dpyd5nncoOfdc415cA=
X-Received: by 2002:aa7:d303:0:b0:42d:d192:4c41 with SMTP id
 p3-20020aa7d303000000b0042dd1924c41mr51502895edq.178.1654863688079; Fri, 10
 Jun 2022 05:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220610054622.21281-1-a-govindraju@ti.com>
In-Reply-To: <20220610054622.21281-1-a-govindraju@ti.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jun 2022 14:20:51 +0200
Message-ID: <CAHp75VdPXHF96B5QWNOS3zfF+EOnWeRe+LCGnjvLBcb30kVzWg@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: davinci: Add support for system suspend/resume PM
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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

On Fri, Jun 10, 2022 at 8:08 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> Add support for system suspend/resume PM hooks, save the
> register context of all the required gpio registers on suspend
> and restore the context on resume.

the resume

...

> +       writel_relaxed(0xFFFFFFFF, &g->intstat);

GENMASK(31, 0) ?

...

> +static int __maybe_unused davinci_gpio_suspend(struct device *dev)

> +static int __maybe_unused davinci_gpio_resume(struct device *dev)

> +static const struct dev_pm_ops davinci_gpio_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(davinci_gpio_suspend, davinci_gpio_resume)
> +};

> +               .pm = &davinci_gpio_dev_pm_ops,

Can you utilize pm_sleep_ptr() and corresponding macros instead of
__maybe_unused?

-- 
With Best Regards,
Andy Shevchenko
