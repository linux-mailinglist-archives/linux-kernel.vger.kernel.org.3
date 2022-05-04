Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A4451B060
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237786AbiEDVZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiEDVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:25:40 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A9964DF75
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:22:03 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso29790017b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 14:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tx3mYhVLEABySlfxpbH37Ic7LnqQbPKrBTTlaZOMkPc=;
        b=G1OpEkn1BESEXlXxdMXC13Qnm60u5Uwth9X0JfnzP05QCviFzpL2dEIAwOPhBFTBGu
         QzH9jtW1H4xyIwtfrt+wLLOsaDg3pqvDmwwpBD99h4VYqO91HS+yYY1UJl2A7zV6QAxE
         D3RHXAsBqChJHeyJEcmKERWZDs7UemA1RqJnt0Hvs49iPa2sQlMXNOPI2Ws0UAemENIC
         pFyCE20wljRiW1UBlpYCXcuN3qV3BK9EQjwtHVC+rko2X42WfBhbDbIlt5OwYZyf7sIG
         t5Nf16FEFI+Vgwr50JZFUFOFib15101a2sfcCF4oqpseiej3c3Ty5DzIUbdGgRWRBwWX
         QUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tx3mYhVLEABySlfxpbH37Ic7LnqQbPKrBTTlaZOMkPc=;
        b=dNBczrBNpBou7Owjz1MG/PLzcq6zwL+NgDK01x1X0zWgIbp35kbrGzceGz8XoWHphN
         XuXcUX2AaY+I2a9sTb+modeWnHVJvJ3wF6Un0na3V4NX0DxhACCzcJR1UPtsfGLOZJ1c
         S/WMUOBdPHYjYRHeFN0ic+/j+jOFlLi3tXIy2dh1WtnWzUAycwh1C54nqWzW29M+7LVg
         H6NBnljpPwSCEpe9hU0SMx2rlbkN3+I+JmfKsfhtNgIXTX1/QDeA2eLywCnat0Jcf/Cz
         9J3JBsg2CQxV/MN5ab9xQs0R3/LiHAUn7DwLaxAhYQfWVKn35eXL6robad7mZA6N6uc0
         tIpA==
X-Gm-Message-State: AOAM530P+A6Uit6S80yVV3CYi+ycJW9sF3L/pWn0cYIv10dOOnCU7hqt
        wDQJipptSZeuQP5GhlmbwTqLN7Fcy1oDlLrL8HN++Q==
X-Google-Smtp-Source: ABdhPJy9GQmBn09i2jD7Kpuz51ZHerGYLe0ZaUG6+YCgtLjqcq581mHgtYfCJS9Ait9lKNH808GM1rsVRxkBaX0KK/U=
X-Received: by 2002:a0d:e5c6:0:b0:2f8:c866:7af9 with SMTP id
 o189-20020a0de5c6000000b002f8c8667af9mr21645142ywe.268.1651699322764; Wed, 04
 May 2022 14:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141846.598305-1-maz@kernel.org> <CACRpkda3L_itpqcnPq6xDoJtNHt8NuvE1MZk1bCNR+u2KKUpBA@mail.gmail.com>
 <874k2kccse.wl-maz@kernel.org>
In-Reply-To: <874k2kccse.wl-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 4 May 2022 23:21:51 +0200
Message-ID: <CACRpkdb32NuJ8jdsk6ox7ViVjK=9WWWavS=aYcoWTCbaO3WkTg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
To:     Marc Zyngier <maz@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, kernel-team@android.com
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

On Sat, Apr 23, 2022 at 12:30 PM Marc Zyngier <maz@kernel.org> wrote:

> > Bartosz: if you're happy with this can you apply it to an immutable branch
> > from v5.18-rc1 and merge that into the GPIO for-next and then I can also
> > pull that into pinctrl?
>
> For what it is worth, I've pushed this branch into irqchip-next.
>
> You can pick it up from:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/gpio-immutable

Bartosz are you pulling this? Most of the changes are in GPIO.
Patches have started to arrive that go on top of these changes
so would be nice to have it in both GPIO and pin control as a
baseline.

Yours,
Linus Walleij
