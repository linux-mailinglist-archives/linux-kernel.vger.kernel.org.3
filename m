Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67265735C4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 13:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiGMLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiGMLrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 07:47:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B6810292A;
        Wed, 13 Jul 2022 04:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9465B81E41;
        Wed, 13 Jul 2022 11:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C82AC34114;
        Wed, 13 Jul 2022 11:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657712856;
        bh=H8yyXEjn4YC4H+2gvA5SkNb8NVzX5EfAtKup6jSajrc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RMIk7Ni6nJuva8yeare1eE6EoMopz60CUWTkK8tNUxLT+S/+fWzDx4nEOZhNqpqjc
         5Ju1TbIWKwsG6JJOxBRjxMGBnKeSHbca7/foqbcX+pi1wIQFgwj6ZD8rmlS2NJEfki
         xf/SyKhSa1UXENoNxRf8PsXa+D7P+tj1ykbr0ojxHNoC1TCPppR8s1gFrKSPhthfNo
         0Uegi6wV+2F44If+IC/mLIFGGk5dghZCPVDQauX/2TFB9W2FCos8mZROC3BmEYLCkd
         xQ1oQ/fpqecnECxNHmZOjY0JR2WlNDvW0NtYcwpa5xSZUtV5TZVOh7gjUPwmzwH+t3
         F6KT4xuf2ntww==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1oBaq5-007CkN-VZ;
        Wed, 13 Jul 2022 12:47:34 +0100
MIME-Version: 1.0
Date:   Wed, 13 Jul 2022 12:47:33 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Robert Marko <robimarko@gmail.com>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: qcom: spmi-gpio: make the irqchip immutable
In-Reply-To: <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
References: <20220624195112.894916-1-robimarko@gmail.com>
 <87edyq1ujr.wl-maz@kernel.org> <20220712124445.GC21746@workstation>
 <87czea1i2f.wl-maz@kernel.org>
 <CAOX2RU5RX+H=omuKGye2fBy9dOFmfC9HC_3pekeGMxDJuReCUw@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <d8912a0d811b5eb924b8c4136b099f72@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: robimarko@gmail.com, manivannan.sadhasivam@linaro.org, bjorn.andersson@linaro.org, agross@kernel.org, linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-13 12:08, Robert Marko wrote:
> On Tue, 12 Jul 2022 at 17:12, Marc Zyngier <maz@kernel.org> wrote:
>> 
>> On Tue, 12 Jul 2022 13:44:45 +0100,
>> Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
>> >
>> > On Tue, Jul 12, 2022 at 11:42:32AM +0100, Marc Zyngier wrote:
>> > > On Fri, 24 Jun 2022 20:51:12 +0100,
>> > > Robert Marko <robimarko@gmail.com> wrote:
>> > > >
>> > > > Commit 6c846d026d49 ("gpio: Don't fiddle with irqchips marked as
>> > > > immutable") added a warning to indicate if the gpiolib is altering the
>> > > > internals of irqchips.
>> > > >
>> > > > Following this change the following warning is now observed for the SPMI
>> > > > PMIC pinctrl driver:
>> > > > gpio gpiochip1: (200f000.spmi:pmic@0:gpio@c000): not an immutable chip, please consider fixing it!
>> > > >
>> > > > Fix this by making the irqchip in the SPMI PMIC pinctrl driver immutable.
>> > > >
>> > > > Signed-off-by: Robert Marko <robimarko@gmail.com>
>> > > > ---
>> > > >  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 22 ++++++++++++----------
>> > > >  1 file changed, 12 insertions(+), 10 deletions(-)
>> > > >
>> > > > diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> > > > index c3255b0bece4..406ee0933d0b 100644
>> > > > --- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> > > > +++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
>> > > > @@ -171,7 +171,6 @@ struct pmic_gpio_state {
>> > > >   struct regmap   *map;
>> > > >   struct pinctrl_dev *ctrl;
>> > > >   struct gpio_chip chip;
>> > > > - struct irq_chip irq;
>> > > >   u8 usid;
>> > > >   u8 pid_base;
>> > > >  };
>> > > > @@ -988,6 +987,17 @@ static void *pmic_gpio_populate_parent_fwspec(struct gpio_chip *chip,
>> > > >   return fwspec;
>> > > >  }
>> > > >
>> > > > +static const struct irq_chip spmi_gpio_irq_chip = {
>> > > > + .name           = "spmi-gpio",
>> > > > + .irq_ack        = irq_chip_ack_parent,
>> > > > + .irq_mask       = irq_chip_mask_parent,
>> > > > + .irq_unmask     = irq_chip_unmask_parent,
>> > >
>> > > No, this is wrong. Please look at the documentation to see how you
>> > > must now directly call into the gpiolib helpers for these two
>> > > callbacks.
>> > >
>> >
>> > IIUC, you are referring to gpiochip_disable_irq() and
>> > gpiochip_enable_irq() APIs.
>> 
>> I am indeed.
>> 
>> > These APIs are supposed to let the gpiolib know about that the IRQ
>> > usage of these GPIOs. But for the case of hierarchial IRQ domain,
>> > isn't the parent is going to do that?
>> 
>> Why would it? The parent has no clue about what sits above it. In a
>> hierarchical configuration, each level is responsible for its own
>> level, and the GPIO layer should be responsible for its own
>> management.
>> 
>> > Please correct me if I'm wrong.
>> 
>> I'm afraid you are, and this patch is a fairly obvious change in
>> behaviour, as the callbacks you mention above are not called anymore,
>> while they were before.
>> 
>> If they are not necessary (for reasons I can't fathom), then this
>> should be clearly explained.
> 
> Hi Marc,
> I will look at IRQ GPIO docs, but in this case, then we have more
> conversions that
> are not correct.

Then please point them out.

         M.
-- 
Jazz is not dead. It just smells funny...
