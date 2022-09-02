Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF55AB4E4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiIBPTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236943AbiIBPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:18:49 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8403147EB0;
        Fri,  2 Sep 2022 07:51:52 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jy14so1559103qvb.12;
        Fri, 02 Sep 2022 07:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CtCUtbyEWpfB5jQ909qB3n/ir4ZwsxY4gByY85AERlg=;
        b=gPEEKL/tgOHnlyna/FNpmm347tjxzmF1a1IeVz42B6gF2Ujmh40FnFgpR8lzbZowW9
         phZ5nq5VsyIZ2/mNdOIcqoZSh/WMD7qCfadrBWinnlIjAKGb3meAVAf8jJhQ9IeeH1tI
         BCyP4+jmuWPI0/AiE3Wk+8xyuzuY1i2fhmGMFevw3w1cVGxmgrucmBxg8lLlhLTxW05c
         Cdtga+tU25YiC8g24iGNZ4Iv++3FrpmMxybtKtHrj+//3W1GedmPYACqJYmihpZI2cK7
         +l4PWWotJuCCMZtdXzvT7cSJs7JuWDjAyinnoDgA4R0r2YV0Ez96OC6ey0lJhBDdGwIR
         5yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CtCUtbyEWpfB5jQ909qB3n/ir4ZwsxY4gByY85AERlg=;
        b=PGPmqRflLlaLsyXy2Y1kyiuglR/WHTN8ZTrWYi1UUlgIniciOeTwnX9mTw6F0LnJcg
         xvpDCWME6+j0/eQcWTsGfYhDKhnLllxg6yDQiE4xAV89zGjIqTY+dZ35yCl3Z7MAaJ/m
         vB7/xU8gmmVCCgQ4hWdoz3R112Wnmo68ckqpZqCoRvUZ8DNdrD3pewiQLtEKJRmn24I7
         /UbLYlQMkKmoHKdLacc/lyThFLYIiHm/D6FUoEy7K4cIea+cJ3qT2XtnMlbMg8748lyC
         Iyz84xjmy7xBXEHanbMjFrk5aQudnIIogJqP+Pw6VT7kpgannS7jSofWLj98PiJ03pAr
         TBhw==
X-Gm-Message-State: ACgBeo1WyICsXosJRhoHXptihLuUDo0EW54hE57NBb1VvaEfKsB23MbO
        Mub1y5Em+q255+tcIsO6D9PbRfnxtQFkNyAW6EI=
X-Google-Smtp-Source: AA6agR7nJZO8ZswNlfltRIaeZ+DlNe0yYud3zZb6aTqIBYFpFDbIHe3ZrOAOLBr+6LqOY4mMXWntX61heZvB8ZT1cbg=
X-Received: by 2002:a05:6214:27ca:b0:499:95f:6379 with SMTP id
 ge10-20020a05621427ca00b00499095f6379mr20131343qvb.82.1662130310778; Fri, 02
 Sep 2022 07:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220902124354.630826-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220902124354.630826-1-horatiu.vultur@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 17:51:14 +0300
Message-ID: <CAHp75Ve7EkE3q3_nOvT_KLmpmnXzMw179nbOxYEYzUeLY0QRnw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix interrupt controller
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
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

On Fri, Sep 2, 2022 at 3:40 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:
>
> When an external device generated a level based interrupt then the
> interrupt controller could miss the interrupt. The reason is that the
> interrupt controller can detect only link changes.
>
> In the following example, if there is a PHY that generates an interrupt
> then the following would be happen. The GPIO detected that the interrupt

would happen

> line changed, and then the 'ocelot_irq_handler' will be called. Here it
> detects which GPIO line seen the change and for that will call the
> following:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
>
> And this works fine for simple cases, but if the PHY generates many
> interrupts, for example when doing PTP timestamping, then the following
> could happen. Again the function 'ocelot_irq_handler' will be called
> and then from here the following could happen:
> 1. irq_mask
> 2. phy interrupt routine
> 3. irq_eoi
> 4. irq_unmask
>
> Right before step 3(irq_eoi), the PHY will generate another interrupt.
> Now the interrupt controller will acknowledge the change in the
> interrupt line. So we miss the interrupt.
>
> A solution will be to use 'handle_level_irq' instead of
> 'handle_fasteoi_irq', because for this will change routine order of
> handling the interrupt.
> 1. irq_mask
> 2. irq_ack
> 3. phy interrupt routine
> 4. irq_unmask
>
> And now if the PHY will generate a new interrupt before irq_unmask, the
> interrupt controller will detect this because it already acknowledge the
> change in interrupt line at step 2(irq_ack).
>
> But this is not the full solution because there is another issue. In
> case there are 2 PHYs that shared the interrupt line. For example phy1

share

> generates an interruot, then the following can happen:

interrupt

> 1.irq_mask
> 2.irq_ack
> 3.phy0 interrupt routine
> 4.phy1 interrupt routine
> 5.irq_unmask
>
> In case phy0 will generate an interrupt while clearing the interrupt
> source in phy1, then the interrupt line will be kept down by phy0. So
> the interrupt controller will not see any changes in the interrupt line.
> The solution here is to update 'irq_unmask' such that it can detect if
> the interrupt line is still active or not. And if it is active then call
> again the procedure to clear the interrupts. But we don't want to do it
> every time, only if we know that the interrupt controller have not seen
> already that the interrupt line has changed.
>
> While at this, add support also for IRQ_TYPE_LEVEL_LOW.

...

> +       /*
> +        * It is enough to read only one action because the trigger level is the
> +        * same for all of them.
> +        */

Hmm... this is interesting. How is the hardware supposed to work if
the user asks for two contradictory levels for two different IRQs?

...

> +       /*
> +        * Check if the interrupt controller has seen any changes in the
> +        * interrupt line

Missed period.

> +        */

...

> +       /*
> +        * In case the interrupt line is still active and the interrupt
> +        * controller has not seen any changes in the interrupt line, then it
> +        * means that there happen another interrupt while the line was active.
> +        * So we missed that one, so we need to kick again the interrupt handler
> +        */

Ditto.

...

> +               struct ocelot_irq_work *work = kmalloc(sizeof(*work), GFP_ATOMIC);

It's more visible what's going on if you split this to definition and
assignment and move assignment closer to its first user.

> +               if (!work)
> +                       return;

...

>         type &= IRQ_TYPE_SENSE_MASK;

This seems redundant, see below.


> -       if (!(type & (IRQ_TYPE_EDGE_BOTH | IRQ_TYPE_LEVEL_HIGH)))
> +       if (type == IRQ_TYPE_NONE)
>                 return -EINVAL;

Is it ever possible? IIRC the IRQ chip code, the set->type won't be
called at all in such a case. Also type is already limited to the
sense mask, no?

-- 
With Best Regards,
Andy Shevchenko
