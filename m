Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA15734EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbiGMLI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiGMLIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:08:24 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC139FE529;
        Wed, 13 Jul 2022 04:08:22 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 20so8321926qky.5;
        Wed, 13 Jul 2022 04:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Oo6klbm63qFTddEWFtIVJFRecDH3MaiqQdekaNqNRts=;
        b=hv/4y8XMTu7hWpAwUYub0wWknicp49B81mcByPFcZVDMaLvKKJbG5g4goAoFZfgfdM
         TrEkRr6AaAH4yxqZ3DGhT/2Cu45V0at7Os6XxE3l7e6XFOPR3uVbW+iiWjFnbQ0NK1zq
         N2dAkxjmq+pmaGbx3cnqp7gfswiw6d+0BVBhk8+/1A/tQmFeNOTU+9b6QcLD2JOq6KCa
         oWpQlgMKf4H7oeiaUoPOEuFM+5uyrJEgbtTd5zYK0DyUH0jD978FuXlKfUKnCkaPPNlv
         aa7s9LQJA5Ub3ls5WnbNFI+CZM2EWIeIsOrAlrTbswdGI5xWLZfv+PwGaAUxGKPO9L1Y
         VjyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Oo6klbm63qFTddEWFtIVJFRecDH3MaiqQdekaNqNRts=;
        b=Kg7iuDENZY8lvCErJbcwTXQ+b4f3V0eP0Ij+92EbZMqkxskhpHc/zRMRomv2k1LXUB
         M5+omrbMFIJUbGFkWjoPIrhIR84/NmjwqN20Tb/LwyqfyyMcgtgVgxskxsFsKAsLpN1Y
         mEaIxxZNMbe/v4vLDK3/PgWLe/kt5sCRmOKuZdzDw0bzs2nHFmcH6Ut6I8ob4Rr/g1XE
         gQxu4Eg1rInLAlGWPhEllHYwBD+RFK6G8qgl5ts/L/zwotwlgcXXEIDF8QQ7D7UEKMqs
         AwtiZDzohureEFB8gw7CsA2bF74iWu+SVW6Y8OQz7+LtrVMQ/low59JuazQ8VjLGpn5k
         AFVw==
X-Gm-Message-State: AJIora+jRYc3QNSFRItUlfsnjCS4ZHk3qCXcO+42QxDaA1+ymjt1qyaR
        +yLIB3rcPVlBbrTGiikvI1e+sQlrG3jSjSGWn1isi7KBJ/g=
X-Google-Smtp-Source: AGRyM1tH3AvexDZy9/hr1C5OV+En4+P/Qxd4ZgpM5CmvpoKhfrAjgGA7M1YcthQ5CymParxZmaZRUgrw/IE3tk1EsMw=
X-Received: by 2002:a05:620a:c8e:b0:6b5:91da:9b04 with SMTP id
 q14-20020a05620a0c8e00b006b591da9b04mr1817976qki.25.1657710501624; Wed, 13
 Jul 2022 04:08:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220624195112.894916-1-robimarko@gmail.com> <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation> <87czea1i2f.wl-maz@kernel.org>
In-Reply-To: <87czea1i2f.wl-maz@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 13 Jul 2022 13:08:10 +0200
Message-ID: <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
To:     Marc Zyngier <maz@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
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

On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
>
> On Tue, 12 Jul 2022 13:44:45 +0100,
> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
> > > On Fri, 24 Jun 2022 20:51:12 +0100,
> > > Robert Marko <robimarko@gmail.com> wrote:
> > > >
> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> > > > immutable") added a warning to indicate if the gpiolib is altering the
> > > > internals of irqchips.
> > > >
> > > > Following this change the following warning is now observed for the SPMI
> > > > PMIC pinctrl driver:
> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> > > >
> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> > > >
> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > ---
> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > index c3255b0bece4..406ee0933d0b 100644
> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
> > > >   struct regmap   *map;
> > > >   struct pinctrl_dev *ctrl;
> > > >   struct gpio_chip chip;
> > > > - struct irq_chip irq;
> > > >   u8 usid;
> > > >   u8 pid_base;
> > > >  };
> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > > >   return fwspec;
> > > >  }
> > > >
> > > > +static const struct irq_chip spmi_gpio_irq_chip = {
> > > > + .name           = "spmi-gpio",
> > > > + .irq_ack        = irq_chip_ack_parent,
> > > > + .irq_mask       = irq_chip_mask_parent,
> > > > + .irq_unmask     = irq_chip_unmask_parent,
> > >
> > > No, this is wrong. Please look at the documentation to see how you
> > > must now directly call into the gpiolib helpers for these two
> > > callbacks.
> > >
> >
> > IIUC, you are referring to gpiochip_disable_irq() and
> > gpiochip_enable_irq() APIs.
>
> I am indeed.
>
> > These APIs are supposed to let the gpiolib know about that the IRQ
> > usage of these GPIOs. But for the case of hierarchial IRQ domain,
> > isn't the parent is going to do that?
>
> Why would it? The parent has no clue about what sits above it. In a
> hierarchical configuration, each level is responsible for its own
> level, and the GPIO layer should be responsible for its own
> management.
>
> > Please correct me if I'm wrong.
>
> I'm afraid you are, and this patch is a fairly obvious change in
> behaviour, as the callbacks you mention above are not called anymore,
> while they were before.
>
> If they are not necessary (for reasons I can't fathom), then this
> should be clearly explained.

Hi Marc,
I will look at IRQ GPIO docs, but in this case, then we have more
conversions that
are not correct.

Regards,
Robert
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
