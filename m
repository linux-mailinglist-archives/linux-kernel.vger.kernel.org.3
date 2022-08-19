Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E14599567
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346345AbiHSGer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346304AbiHSGeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:34:44 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468E3D293E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:34:42 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p9so2444879pfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=4OLuDfjKcOo1vMBTKXZ3hrMvywIQsdm2SXucSyDEwJ0=;
        b=qIBBWdyc4Zgce24Pj7nTw/NYLTLvXN6i1Dp4zvVlMa6QTgwi3kdb+/mBK5Tz8NQhbi
         XSa3Au07vX5LoOLydU6PTeTmPe5IE6UVDoHaoY59iEhH/+FzjLB8xKVw5kb2sb0+vryb
         NKy4ByHcELlLotIBBiVVocMbkki9oZ2gBzfs0EH8aUyOOEL9CuYLXtZPYokUTMvEtgim
         jyrn/CB0044oza7Jr+yzSqtj4IsJzmaQxiyoNQDl97WMRn10icvTVzaJZQn87HgzAbnR
         L1Eltf4Cfij1qJHmYvs0cf/kj1GqiiIcBIYptDnOO3zBPw0UCv3F4bJiSOm/vMuPHqDg
         D4uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=4OLuDfjKcOo1vMBTKXZ3hrMvywIQsdm2SXucSyDEwJ0=;
        b=zfBrvhRi5pxlmCcx27yPxSFndAUcp5Up9mWUVUTWFZHWk4hvUEgY6BvpF9GSWlV6i6
         ETqV+42YU5VW0a+TdfFQbFJw38ckw46hTVdqo4H7/uU41QjrjPMvfi7z77SMvbMNh7q/
         BhhFRClFnRyfZDTus4ObDcAODW5XesrDQI2Cf1szH3HYBGto02Oam6ZFSpRAVAKiYXG8
         5CJ4iQSdIVW97rooi8Yw190ctK/p0hrpgltYiBMI/WletHBdQnJ2+7PExBIdeWN4xNMn
         Etv3k/z3DSa5HCAHNhkEvLN1DnM8vgtcn1s6jDSwEiy5sXqeRb55YmOKFSmLTsdrxJL/
         eodQ==
X-Gm-Message-State: ACgBeo0F8hJbFqiX899EuTHzNL3R0X1Yir9hH2d5F76MX4REVY9i3bM/
        XXbaVSMu59a2v5Rok3Tq+Abv
X-Google-Smtp-Source: AA6agR53iYZO5eiuz8XH08JqN2NWzz4IwA61evU0H7MnN+3Vf1XfvYFNaf/JA7p6i55e95TstPIW4w==
X-Received: by 2002:aa7:8096:0:b0:52d:d5f6:2ea6 with SMTP id v22-20020aa78096000000b0052dd5f62ea6mr6573057pff.0.1660890881699;
        Thu, 18 Aug 2022 23:34:41 -0700 (PDT)
Received: from thinkpad ([117.193.212.74])
        by smtp.gmail.com with ESMTPSA id z16-20020a170903019000b001729bd62297sm2447929plg.3.2022.08.18.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:34:41 -0700 (PDT)
Date:   Fri, 19 Aug 2022 12:04:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
Message-ID: <20220819063433.GA215264@thinkpad>
References: <20220624195112.894916-1-robimarko@gmail.com>
 <87edyq1ujr.wl-maz@kernel.org>
 <20220712124445.GC21746@workstation>
 <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
 <d8912a0d811b5eb924b8c4136b099f72@kernel.org>
 <CAOX2RU4MpyEQ0RtcrZ07VXRbB+SWWU=1zWfYUXhQFtvh=MCiDw@mail.gmail.com>
 <20220719074751.GA25065@thinkpad>
 <CAOX2RU525OYLBb+Nek==84KA4a42ZTz89tgdMcgBCu=K8VzL9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOX2RU525OYLBb+Nek==84KA4a42ZTz89tgdMcgBCu=K8VzL9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 02:45:07PM +0200, Robert Marko wrote:
> On Tue, 19 Jul 2022 at 09:47, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Wed, Jul 13, 2022 at 02:33:32PM +0200, Robert Marko wrote:
> > > On Wed, 13 Jul 2022 at 13:47, Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > On 2022-07-13 12:08, Robert Marko wrote:
> > > > > On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
> > > > >>
> > > > >> On Tue, 12 Jul 2022 13:44:45 +0100,
> > > > >> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > > > >> >
> > > > >> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
> > > > >> > > On Fri, 24 Jun 2022 20:51:12 +0100,
> > > > >> > > Robert Marko <robimarko@gmail.com> wrote:
> > > > >> > > >
> > > > >> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
> > > > >> > > > immutable") added a warning to indicate if the gpiolib is altering the
> > > > >> > > > internals of irqchips.
> > > > >> > > >
> > > > >> > > > Following this change the following warning is now observed for the SPMI
> > > > >> > > > PMIC pinctrl driver:
> > > > >> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
> > > > >> > > >
> > > > >> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
> > > > >> > > >
> > > > >> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > > >> > > > ---
> > > > >> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
> > > > >> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
> > > > >> > > >
> > > > >> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > >> > > > index c3255b0bece4..406ee0933d0b 100644
> > > > >> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > >> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
> > > > >> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
> > > > >> > > >   struct regmap   *map;
> > > > >> > > >   struct pinctrl_dev *ctrl;
> > > > >> > > >   struct gpio_chip chip;
> > > > >> > > > - struct irq_chip irq;
> > > > >> > > >   u8 usid;
> > > > >> > > >   u8 pid_base;
> > > > >> > > >  };
> > > > >> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
> > > > >> > > >   return fwspec;
> > > > >> > > >  }
> > > > >> > > >
> > > > >> > > > +static const struct irq_chip spmi_gpio_irq_chip = {
> > > > >> > > > + .name           = "spmi-gpio",
> > > > >> > > > + .irq_ack        = irq_chip_ack_parent,
> > > > >> > > > + .irq_mask       = irq_chip_mask_parent,
> > > > >> > > > + .irq_unmask     = irq_chip_unmask_parent,
> > > > >> > >
> > > > >> > > No, this is wrong. Please look at the documentation to see how you
> > > > >> > > must now directly call into the gpiolib helpers for these two
> > > > >> > > callbacks.
> > > > >> > >
> > > > >> >
> > > > >> > IIUC, you are referring to gpiochip_disable_irq() and
> > > > >> > gpiochip_enable_irq() APIs.
> > > > >>
> > > > >> I am indeed.
> > > > >>
> > > > >> > These APIs are supposed to let the gpiolib know about that the IRQ
> > > > >> > usage of these GPIOs. But for the case of hierarchial IRQ domain,
> > > > >> > isn't the parent is going to do that?
> > > > >>
> > > > >> Why would it? The parent has no clue about what sits above it. In a
> > > > >> hierarchical configuration, each level is responsible for its own
> > > > >> level, and the GPIO layer should be responsible for its own
> > > > >> management.
> > > > >>
> > > > >> > Please correct me if I'm wrong.
> > > > >>
> > > > >> I'm afraid you are, and this patch is a fairly obvious change in
> > > > >> behaviour, as the callbacks you mention above are not called anymore,
> > > > >> while they were before.
> > > > >>
> > > > >> If they are not necessary (for reasons I can't fathom), then this
> > > > >> should be clearly explained.
> > > > >
> > > > > Hi Marc,
> > > > > I will look at IRQ GPIO docs, but in this case, then we have more
> > > > > conversions that
> > > > > are not correct.
> > > >
> > > > Then please point them out.
> > >
> > > Oh, now I get the issue, I was misunderstanding it completely.
> > > gpiochip_enable_irq and gpiochip_disable_irq are not being called
> > > at all.
> > >
> > > However, I dont see them being called before the conversion as well.
> > > I am not really familiar with the PMIC IRQ-s, looked like an easy conversion
> > > to get rid of the warning.
> > >
> > > Manivannan can you shed some light on this?
> > >
> >
> > I hope you got the answer by now. When I looked into the conversion I saw that
> > there were missing calls to gpiochip_{enable/disable}_irq APIs. But at that
> > time I blindly assumed (yeah very bad of myself) that the parent irqchip will
> > handle that :(
> >
> > Anyway, you should call these helpers from the mask/unmask callbacks as a part
> > of the conversion patch. Let me know if you are onto it or not!
> 
> Hi, I completely missed your reply.
> Currently, I am pretty swamped with other work so I dont know when
> will I be able
> to look into this again.
> 

No worries! I will handle it.

Thanks,
Mani

> Regards,
> Robert
> >
> > Thanks,
> > Mani
> >
> > > Regards,
> > > Robert
> > >
> > >
> > >
> > >
> > >
> > > >
> > > >          M.
> > > > --
> > > > Jazz is not dead. It just smells funny...
> >
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
