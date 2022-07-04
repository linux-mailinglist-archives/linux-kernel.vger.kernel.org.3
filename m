Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F375565F94
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiGDXFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiGDXFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:05:34 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37E99DEBE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 16:05:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i7so18954848ybe.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 16:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XycWTMWtIwricire+FFIRRMgzV1gWh/SUQexd6DnnYc=;
        b=U6zGQBjdWzmnVw/QKpLpnpUYTxQGzObW1o/Zl132xkUurDx9PsOVRnWQ6K9MQyEPBQ
         6vOzYWcNejk4zkkvS4sGH5QhpfuOJTcyS+gpXgRUJ3fsg1nGC5sV8GrUoF2GHYIkP2GN
         SrSesILXEWvnDMIi2x/KHqeBCjm/l6awVAe/ohkuQaUT7GgrygtKLMcYiGMiwcUqvp6A
         BE+XkuYrXfj2RKTuvGPammVj7P3/WhUzpGjqveRU4pmotZNzUBPZSQB+WCCbXwf+yIjt
         6PbSJWYIQf4cbiBJCpZem8uursmIQ5g9Yt9rQw5BZt613nQHFss3QcGnNOXTXa+Lm9G1
         H0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XycWTMWtIwricire+FFIRRMgzV1gWh/SUQexd6DnnYc=;
        b=wVGArT+/BD0QZ8EDTAtLIc2LfDio+IH+/h6Pyr43a298I6Cf5KZAC0ioaOd3OScxqD
         mT8eI+TvbzILN0kf2/DDUDLbtdw0cxg6CQAsQP5mPMaZ5oZXPSGz9XDDrKyDUHluvJxM
         tnuyNF6Q7pRLFeqRl9zQ9BQBhxPdftghDT1Va2g3VKre1Pm/UY15YjVwH9lplzTj/VRA
         4z8ZEcDe5tuBEMPUFAH2o4mzfsnYmY6Z255J68/xKr253EmA+ekCbgBrJKAeiYrFwWT9
         RIpgkfOQwvCUb6+Tn6cj3AZVrjq9Mjgri8jOdI4iGdaXr4a69NwuzDaO25+oeeUfviY2
         av8w==
X-Gm-Message-State: AJIora+ERRlzy6ikeTeL11ukw4rDwx0UEa60CakJHTkdUoITWldi2lpQ
        9sdwx5unXXxI7Bg5vKGRI//SwSETjBgi8wfaXFEG3Q==
X-Google-Smtp-Source: AGRyM1urReHFGRpDt4228+rssCI9u4xNZb5KZUtgIg0y+Uw7HPx2keXEsdL3wNgYwiwKCidfhIJbuZH0U01zBCLbxts=
X-Received: by 2002:a25:d07:0:b0:66e:6c0e:a2d1 with SMTP id
 7-20020a250d07000000b0066e6c0ea2d1mr882331ybn.369.1656975932454; Mon, 04 Jul
 2022 16:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com> <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jul 2022 01:05:20 +0200
Message-ID: <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     michael@walle.cc, brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 3, 2022 at 1:10 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:

> Some GPIO chips require a custom to_irq() callback for mapping
> their IRQs, eg. because their interrupts come from a parent IRQ
> chip where the GPIO offset doesn't map 1-to-1 with hwirq number.
>
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>

What is the usecase for this?

Since GPIO chips and IRQ chips are orthogonal there is absolutely
no guarantee that ->to_irq() is called before a driver start to use
an IRQ from the irqchip side:

(quoting Documentation/driver-api/gpio/driver.rst)

 It is legal for any IRQ consumer to request an IRQ from any irqchip even if it
 is a combined GPIO+IRQ driver. The basic premise is that gpio_chip and
 irq_chip are orthogonal, and offering their services independent of each
 other.

 gpiod_to_irq() is just a convenience function to figure out the IRQ for a
 certain GPIO line and should not be relied upon to have been called before
 the IRQ is used.

 Always prepare the hardware and make it ready for action in respective
 callbacks from the GPIO and irq_chip APIs. Do not rely on gpiod_to_irq() having
 been called first.

(end quote)

Using ->to_irq() makes sense in a few cases such as when
a GPIO key that can also poll for state want to get hold of an
IRQ to react to edges.

Now: if a consumer requests IRQ nr 3 from your driver say from ACPI or
from a device tree, and as you say GPIOs and IRQs are not 1-to-1 mapped,
so IRQ nr 3 may be coming from GPIO 314, isn't this going to be really
messy for users? One local numberspace for GPIO and another local
numberspace for IRQs?

To me it seems like the reasoning is something like

- I only use GPIO line numbers like <&gpio 3>;
- Then I call gpiod_to_irq() on that number so I do not need to
  deal with looking up the IRQ some other way
- request_irq();
- Profit.

There is no guarantee that the API will be used like that at all, actually
it is uncommon.

Yours,
Linus Walleij
