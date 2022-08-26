Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27665A239B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245556AbiHZIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242518AbiHZIyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:54:22 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F88D5DD1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:54:21 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bj12so1851397ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WalmlB4EN49W8PL0fcaiWMZot+zjYgZWStfQtsL0AgI=;
        b=qwkHN+LuWi6f574jTt2roEdWyygA2QfKiSCTrbp87K7G4JVLFh0lgVm1CRPbtGqYAx
         9nKM+5zJeJjT9k3UnxaN4OJ+5a+3CpddlFNzxa0o5GKFBmI+xbUI3AaErHI/H1nwEXwW
         CsKz/cVEuHZowhCwHv6zBhWpbipqrfwh9Y1l5qlvI1VflxZCkteZf4wHWf2DxOr+trQA
         yZyBu5WWHGbzz0pwWdAEi/ij4SNC5C4lfUiis6LB39sHk9DXV0L/zz9D6WKcGnjRvl2C
         jzl7VQ1yIFwcl0/HgwVMBz5QIUqXkWWBlNJ1K4BC3O0Kwh8g7geFPUGgb04GZum/8bZf
         7azA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WalmlB4EN49W8PL0fcaiWMZot+zjYgZWStfQtsL0AgI=;
        b=e+qBHzX7+rjUHzs6Hf361EYxKQHZvsv/B12/Rd5Ea+ViwVn1/LvGvDc+0ZoSz8opRv
         YG7tS5txeMOKVRebnKBUCxeGcDAl1Tb0T3Dr/U/x+fZvvffy9s5Io3okCj4pI+AQ54A2
         dS3dbkF6Vs101AJ3HDoFHMETxwO/CgLBkYmRIr+o7jbfl8NFEuKPuFlKE5FoFwlWPl+o
         hUmNU8rsG3J3yTcPJvmACKbWgREh8zEzP9h+IlCcUwh3Pyw28vyE9J8AobNIckzplYsB
         W5HFjDlC7LgIYgQGv6Uy6LWfdlSaC3GaF3gAmbI3JIyY2OISv+rQPfYJ2D2LDxHTN+yT
         ZZpA==
X-Gm-Message-State: ACgBeo3jaq1e0EtF1ggUsmbWh4cf56r7APKLJKl22K25hhcaYbgHTnPA
        V1Gqlyf9zcFRj/dVStJfaKvLiMcPM2nIKnEs9Ww1X2GfnZsh0w==
X-Google-Smtp-Source: AA6agR5mY4IzTZnOBmdMG5ApfDuP/zrM1AZzzp4ayXmEtVjtONhAK+SU1czh4Zr9AJXwYjKlSbIxw+414mLWAXkPXlY=
X-Received: by 2002:a17:906:478f:b0:73d:7919:b23 with SMTP id
 cw15-20020a170906478f00b0073d79190b23mr4509164ejc.690.1661504059817; Fri, 26
 Aug 2022 01:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220820095933.20234-1-jeffy.chen@rock-chips.com>
 <20220820095933.20234-2-jeffy.chen@rock-chips.com> <CAD=FV=X0qJ2OC1SrAmhSQ5YeKEwvsSCbfVGPh457YYEuPCbRtg@mail.gmail.com>
 <5cb0a457-b667-76e5-d383-6e93457d5d12@rock-chips.com>
In-Reply-To: <5cb0a457-b667-76e5-d383-6e93457d5d12@rock-chips.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:54:08 +0200
Message-ID: <CACRpkdY1jQH+-o6y84w0WtJT1erRnJzCcg0jjgRHVDUw4q97QQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio/rockchip: Toggle edge trigger mode after acking
To:     Chen Jeffy <jeffy.chen@rock-chips.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 4:50 AM Chen Jeffy <jeffy.chen@rock-chips.com> wrote:

> The thing is, we are currently toggling the trigger mode to make sure it
> matches the current GPIO level (e.g. level low -> rising edge mode),
> than ack it in gpio IRQ handler.

Yes this is an old trick, I don't know if I invented it again for Linux in
commit cc890cd78acd7ab03442907d354b6af34e973cb3
in 2011, surely the trick must be well known.

Back then I did it like this:

+       val = readl(U300_PIN_REG(offset, icr));
+       /* Set mode depending on state */
+       if (u300_gpio_get(&gpio->chip, offset)) {
+               /* High now, let's trigger on falling edge next then */
+               writel(val & ~U300_PIN_BIT(offset), U300_PIN_REG(offset, icr));
+               dev_dbg(gpio->dev, "next IRQ on falling edge on pin %d\n",
+                       offset);
+       } else {
+               /* Low now, let's trigger on rising edge next then */
+               writel(val | U300_PIN_BIT(offset), U300_PIN_REG(offset, icr));
+               dev_dbg(gpio->dev, "next IRQ on rising edge on pin %d\n",
+                       offset);
+       }

Notice that I read the current level of the raw input to decide what the next
trigger should be. The Rockchip driver does not do this, maybe that works
better?

Yours,
Linus Walleij
