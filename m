Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0D6550A2D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 13:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236442AbiFSLZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 07:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiFSLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 07:25:42 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFE55F67;
        Sun, 19 Jun 2022 04:25:41 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cf14so1759371edb.8;
        Sun, 19 Jun 2022 04:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MfTpm336cuBYZzkP2acrVbBvCS8+4Y29Ne3uwgFeW9Y=;
        b=l++D45ijPavfLV7Ac80KJhVk9aQUSLHhd02xSe6sdWF9tkBNYWKP2kEOgtPBuFGhab
         9r71F1CAtF89cCvZ+F4SIaRS9Cd355wrtF/OKvK9QHWygOqkSqhq4e5dsAweENKCqIli
         2UUypJF0NtbO5dUGLidFFnA+BSF827Q+GqHbc2PcsZAfMIjHx64qrSYPf+Fes2cwrLUp
         MNU4/tUkxGUhnI5UnI/WY0WUY8BPfZV6RwcsVNuo/2xn3JTYgFpFOaRAdP+aTZZml6Qr
         sNMPW6224LkgS9grlukrKOjr4fQEdFSJuL4A6MaoKUBm5VKK1Q3tt/tKd+gdsNqPMw/n
         /m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MfTpm336cuBYZzkP2acrVbBvCS8+4Y29Ne3uwgFeW9Y=;
        b=igIrPtR9RaalD90yrExo56VnhG3hJZSxYecb91GCHHMxfRQYGDkPmG3DypccmaO+4o
         eW3uKebTbPDK7cIODQDda6YOT4JpDq4n9/9sD+JQJC/90n2wA17sbwzr8lhTZLIStw79
         5+GjXa5XT9ivborGm1QCGyN85gIaCloSF5w3fYK9dKa+rtNc7w9lQcLnVCMvXuUdZb/a
         eD0VYRtqFQqNfNxNN6AMZ1DcdHg/wEEUyIWzWoqWWM18ukfslpGveqUZrOZ43pm9e7me
         0JyUZ5CUi/fLt6xOfflKCJbCBNvjNVS6cU10HK8X3dTjH5IyMbjUT+p4EM8DNHWEuOsd
         rltg==
X-Gm-Message-State: AJIora/7XKiEM3/Bg5/wdYHTHooJ945YJ8vWpsDvatxhAFC0pC+ZzPt9
        qAjzIrtlm5M0guG5yA/Ys7ZWtlRw9T1uPXc2rQQ=
X-Google-Smtp-Source: AGRyM1scR1dtdrWUkmjTKGJYOzbyqOwL3eFG13scvMMW2OI/ATbWuCB000TMCAlXRVUNgzgyxqrENnGS6Ef2pgwqwkg=
X-Received: by 2002:a05:6402:249e:b0:42d:bb88:865b with SMTP id
 q30-20020a056402249e00b0042dbb88865bmr22727590eda.141.1655637939780; Sun, 19
 Jun 2022 04:25:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220618214009.2178567-1-aidanmacdonald.0x0@gmail.com>
 <20220618214009.2178567-14-aidanmacdonald.0x0@gmail.com> <CAHp75Vev77nG-Ui9cp9Bz8KPcq67E3htCTYnu4NNMV0_UP9=rw@mail.gmail.com>
In-Reply-To: <CAHp75Vev77nG-Ui9cp9Bz8KPcq67E3htCTYnu4NNMV0_UP9=rw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 19 Jun 2022 13:25:03 +0200
Message-ID: <CAHp75VdTFF0r8oiYxavoGVo9ShLLaveU1p2BNzzqVgu2eKCBaw@mail.gmail.com>
Subject: Re: [PATCH v3 13/16] pinctrl: Add AXP192 pin control driver
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Sun, Jun 19, 2022 at 1:20 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Jun 18, 2022 at 11:40 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:

Hit 'Send' accidentally, here is the rest of the review, including
previous comments.

...

> > +config PINCTRL_AXP192
> > +       tristate "X-Powers AXP192 PMIC pinctrl and GPIO Support"
> > +       depends on MFD_AXP20X
>
>
> > +       depends on OF
>
> Why?
>
> > +       select PINMUX
> > +       select GENERIC_PINCONF
> > +       select GPIOLIB
>
> ...
>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
>
> Why?

Perhaps you missed mod_devicetable.h.

> ...
>
> > +struct axp192_pctl_function {
> > +       const char              *name;
> > +       /* Mux value written to the control register to select the function (-1 if unsupported) */
>
> Comment is misleading. -1 can't be a value of unsigned type.
>
> > +       const u8                *muxvals;
> > +       const char * const      *groups;
> > +       unsigned int            ngroups;
> > +};
>
> ...
>
> > +struct axp192_pctl_desc {
> > +       unsigned int                            npins;
> > +       const struct pinctrl_pin_desc           *pins;
> > +       /* Description of the function control register for each pin */
> > +       const struct axp192_pctl_reg_info       *ctrl_regs;
> > +       /* Description of the output signal register for each pin */
> > +       const struct axp192_pctl_reg_info       *out_regs;
> > +       /* Description of the input signal register for each pin */
> > +       const struct axp192_pctl_reg_info       *in_regs;
> > +       /* Description of the pull down resistor config register for each pin */
>
> Can you just convert these comments to a kernel-doc?
>
> > +       const struct axp192_pctl_reg_info       *pull_down_regs;
> > +
> > +       unsigned int                            nfunctions;
> > +       const struct axp192_pctl_function       *functions;
> > +};
>
> ...
>
> > +
> > +
>
> One blank line is enough.
>
> ...
>
> > +       switch (param) {
> > +       case PIN_CONFIG_BIAS_DISABLE:
> > +               ret = axp192_pinconf_get_pull_down(pctldev, pin);
> > +               if (ret < 0)
> > +                       return ret;
>
> > +               else if (ret != 0)
>
> 1. Redundant 'else'
> 2. if (ret > 0)
>
> > +                       return -EINVAL;
> > +               break;
> > +
> > +       case PIN_CONFIG_BIAS_PULL_DOWN:
> > +               ret = axp192_pinconf_get_pull_down(pctldev, pin);
> > +               if (ret < 0)
> > +                       return ret;
> > +               else if (ret == 0)
>
> Ditto.
>
> Looking at this I would rather expect the function to return something
> defined, than 0, non-0.
>
> > +                       return -EINVAL;
> > +               break;
>
> > +       default:
> > +               return -ENOTSUPP;
> > +       }
>
> ...
>
> > +       for (cfg = 0; cfg < num_configs; ++cfg) {
>
> cfg++ will work the same way and easier to read.

...

You may make some lines shorter by introducing here

  struct device *dev = &pdev->dev;

> > +       struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);

dev->parent

and so on...

...

> > +       pctl->pctl_dev = devm_pinctrl_register(&pdev->dev, pctrl_desc, pctl);
> > +       if (IS_ERR(pctl->pctl_dev))
> > +               dev_err_probe(&pdev->dev, PTR_ERR(pctl->pctl_dev),
> > +                             "couldn't register pinctrl driver\n");

With the above it probably fits one line.

-- 
With Best Regards,
Andy Shevchenko
