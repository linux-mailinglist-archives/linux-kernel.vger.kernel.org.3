Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9895A87E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbiHaVFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiHaVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:05:17 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44034481DD;
        Wed, 31 Aug 2022 14:05:16 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id w4so11803645qvs.4;
        Wed, 31 Aug 2022 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=+lTGIa6eGb9hONAiLy7EzL9iAjtgjfpY29k3SCr3Lw8=;
        b=iM7AcVcIWutz/Qg74Dp3o1RiGNUjn02FcrCIKgMYx5rUSnEQed0U2SYpcb/iFIPWVu
         sceCKEHtFe9RPX+zQoJx4d5vFSG4jY7rPDMMnvafq9d+UVFbBCnPcNyZOj+cKoJLhoIL
         XJMx7+lZ1Dsc/vXv1k/k4wBG6nVwmI9Iz5ADAfywHUEtZydGLOQqXu8Ua17qvmTPa9sJ
         OOL9icmWoiKVAkA7WTFttpJkg2sNx4c4oL+nR6EoPyxsT1l2+fC3olx+qGnVZDX4qhNv
         OLKYxmRcLwD4NwzjcGnNvmeBNVNrDn6XtGU4Z+nRcVGzZcLCVeWTtM9d7BlcNF8jVHC9
         kHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=+lTGIa6eGb9hONAiLy7EzL9iAjtgjfpY29k3SCr3Lw8=;
        b=WrcTPJCcykSO0ciyhFOTJ2PBx0YbiM7FIruG2sOW2steZux6UGJR5OPtz1syXbOHvr
         PZBeNurtSmuzbJUL+jqe75cLZmho6eKM1VdaOMQu/MQRKq/cwhhIdxdk3aikQuKaUF/d
         vIS2I9ORGr3p8a8xTqxPg/ffjU1rmK4iYPRSxLSCseqis5uyq/ve0Qf9xf1zDQkWSLkB
         887uwQESG5vPiiSZEUgc2XLoaLs4A3xo+tVPdTRE0/37kO+6uwzonwIRtzHrtcYwTvhf
         4Ab4RsTAREy3j4/PtTWrgfqM62dzLT9GEzLnxscFDQV66PjR5mznVYaMBBdpBSvaDEo7
         ddDw==
X-Gm-Message-State: ACgBeo3hNwRy4R6SZgbF6d0qm/hj7RnpM+nfr797yA9G03fzC5h77z5J
        wWPFUJkMaICJl8+eJRP1AriLAnIEzG7UhiAWdtw=
X-Google-Smtp-Source: AA6agR5qQAhLTgxav6dOwBNu1281hzGRPk4FTa0c/tyqw82+8CL4iE6OOOtudGsgpC8BavrAUE9pJg/tv0RT/T5WCjs=
X-Received: by 2002:a05:6214:2022:b0:497:2c03:61 with SMTP id
 2-20020a056214202200b004972c030061mr21792656qvf.11.1661979915969; Wed, 31 Aug
 2022 14:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220815120834.1562544-1-lewis.hanly@microchip.com>
 <20220815120834.1562544-2-lewis.hanly@microchip.com> <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
In-Reply-To: <CACRpkdbk_ZqYnDzXgmbnAxhs+mEe9f2X-y++9HDS-O=UO_tUmg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 1 Sep 2022 00:04:40 +0300
Message-ID: <CAHp75Vc4cMGBdJpOsRMDLWU+6+eYwbsF3-Mz40-KazLGhwkHMA@mail.gmail.com>
Subject: Re: [PATCH v6 1/1] gpio: mpfs: add polarfire soc gpio support
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     lewis.hanly@microchip.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Marc Zyngier <maz@kernel.org>, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com
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

On Mon, Aug 22, 2022 at 2:30 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 15, 2022 at 2:08 PM <lewis.hanly@microchip.com> wrote:

...

> This looks like  textbook example of a driver that can use
> CONFIG_GPIO_GENERIC

> See e.g. drivers/gpio/gpio-ftgpio010.c for an example
> of how to use bgpio_init() to set up the helper library to handle
> the GPIO side of things and combine it with an irqchip.
> You get get/set_multiple() for free with this approach.
> Also see documentation for bgpio_init() in
> drivers/gpio/gpio-mmio.c.

I would also suggest looking at gpio-regmap.c.

-- 
With Best Regards,
Andy Shevchenko
