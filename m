Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65B75693A2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 22:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiGFUwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 16:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbiGFUwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 16:52:31 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00701DA5E;
        Wed,  6 Jul 2022 13:52:29 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so29060716eja.8;
        Wed, 06 Jul 2022 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:from:to:cc:subject:in-reply-to:date:message-id
         :mime-version;
        bh=0oY4gap3TRwLTtcF3gSbbfZZEWWnO/s07oBC4LBZLoI=;
        b=bdO+++3upnx+oi3mTBDx64vJsbxbunSAVJ72P1Wg9Ls5kg1jyw90zYb9fUyks7rGAq
         hfe4rh0kVzbYa50kA+D1CbuzAp+Uk1/TRCDt/9R9vYfAOlzzjvAKhkh9LN1OrcqTSHPk
         KOZsHGgTTN0uWgWG7NwrWMIdchOn7g82ENW36yzFwooCgJ0cNeECU4ijALbSW9iJ5NPe
         OCQARHJ9XobsakLfbWAfH70x5sk2d7/UGIt6uR/0daP9WxluMOIQ2yy2rcptqbouwxh0
         wQmHZqocdgf99hNSgM1iDG8+jvfdDZFq2eYEZkS4eqET/dIw0mIAsEoKBB8U2IvLk0EQ
         cYSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=0oY4gap3TRwLTtcF3gSbbfZZEWWnO/s07oBC4LBZLoI=;
        b=JMiM7bo5gy9Pa8J5G2np5kYFsWfzkQcpItwYXG8ulLW5enu6rdsrn1o76PtIVzddKy
         IcsufNJR583XN4mefX7YL33Q4b+r8RNdHaf4X9RB7tyiej0qhDiNTKlAwum7tTaeV1mi
         CmEW1dtrEfmsKKbsvZiq3OyCV6EARBrb0NQulJTBPsIyDOukBULey43iy3/M2zngGna3
         LszGbfubYwYfOaEAxBqk8uMCkTLnoV2A/iv2zXfvU0K8mhh+AcLJijNmTytM+5DdK4jB
         TzD91CErL5qSjiQdv66xop6rcqRM0mU+1WjVRJR0+LyKSjVLUlgECCTKJ13ig9bJOhdc
         tBug==
X-Gm-Message-State: AJIora96NOal26H1axyYs6597z2tHVnB/vGwTXl0nvhsApQceDGqaz0b
        hlfDjG4zc0oWtYB5kL7HeDk=
X-Google-Smtp-Source: AGRyM1tLUh67ZeMeuui0Z/nGcNVm7oENy27fJUrmht9yXGN16ZynddjFjllrPUaVYjEQcSZhxD2MGQ==
X-Received: by 2002:a17:906:8d6:b0:723:42c3:657 with SMTP id o22-20020a17090608d600b0072342c30657mr39613070eje.657.1657140748472;
        Wed, 06 Jul 2022 13:52:28 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906500f00b00722dceb3f8bsm17877565ejj.151.2022.07.06.13.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 13:52:28 -0700 (PDT)
References: <20220703111057.23246-1-aidanmacdonald.0x0@gmail.com>
 <20220703111057.23246-4-aidanmacdonald.0x0@gmail.com>
 <CACRpkdamknwRPGEeGGQGQPtKw=dPXa79GAJy+E6y+03NakN=cA@mail.gmail.com>
 <GrX3yDSwNOGIBcWmKqusaJ3dDqNGLr3Y@localhost>
 <CAHp75Vd9P3Mf75TcXeWB3QE4n_rn7QcWz6g5fDYpPiLVOMsAig@mail.gmail.com>
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] gpio: regmap: Support a custom ->to_irq() hook
In-reply-to: <CAHp75Vd9P3Mf75TcXeWB3QE4n_rn7QcWz6g5fDYpPiLVOMsAig@mail.gmail.com>
Date:   Wed, 06 Jul 2022 21:53:36 +0100
Message-ID: <7EciRXW2jHHdJoybh7lao4eux9khP3Sc@localhost>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Tue, Jul 5, 2022 at 1:22 PM Aidan MacDonald
> <aidanmacdonald.0x0@gmail.com> wrote:
>
> ...
>
>> Is that really better than simply using ->to_irq()?
>
> We have Intel PMIC drivers (that are in MFD) and they have respective
> GPIO drivers, none of them is using ->to_irq() and all of them provide
> IRQ functionality. Can it be taken as an example or is it something
> quite different to your hardware?

In the Intel PMICs the MFD irqchip has a single interrupt for all GPIOs.
The GPIO driver then has its own irqchip and it looks at other registers
to find out which GPIO interrupt fired. It's a typical cascaded setup.

In my case the MFD irqchip has one interrupt per GPIO. The GPIO driver
does not need its own irqchip; everything is handled by the MFD irqchip.
Existing examples include wm831x, wm8994, da9052, and tps6586x.
