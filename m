Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC56655CBB0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343960AbiF1IfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbiF1IfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:35:05 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BF12872B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:35:03 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-317741c86fdso109204787b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=synmmJZnLm8aL3NMaA4e9ZWQLnsLjsBBEEt8zQsVKJQ=;
        b=G4z4zRLq1xsw40QPegly4S6z82j4rzBgTc8W3E1wt9VI1WdYEJnh+Cvhz93jh6eJrs
         8fTddQPYL9Cpd/9RueHGKQybtak14IsU+2+YRJfubFD7VvI0pTuKGRKomNPzpplzUm+s
         LnQLJuWXKAUZz9AzbpaW1BDXfeFa3FPEhLNRwXpsUOwMCcsGn+81bI7szulf6L8k4JHb
         lhZluPGrQpWpHibVdSqf//xFrPSXegHaY7M0ekWTf1/NDYDwSj0Zs89OG4QL5AMnZCiV
         ypvLkQHXtQT8YxiXEQFrWSbJnd6YJIHrlOSJJHlG/2DWd2PaAXkYZPE2/rSE2HIjIHYf
         hTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=synmmJZnLm8aL3NMaA4e9ZWQLnsLjsBBEEt8zQsVKJQ=;
        b=seJP398oYrXlcwETHWxO6LS7nzUYf6dD4NZnkDNZEXu2OBMxNqRJ9/q2hQ82l3Hna6
         A/qf4r9w9QppWGncExsGmXaPOUtOkgP96laCB2IuFG1f222wBrBDiTASzNbuW5D8DFF1
         3KCYj78PXYxjSPU8AaOOedk7e/voEkvmbWbvh+up3m/CKBIgT4rB1A9hnERD8w7zZ+2T
         4mJnMqzHPuM2xthdlKXClRjAch4na9lJbb0yZHTMbftlqefRFhMNLQKV8tGNq2k6Fjv4
         GBB+kZrrwooiaoKWmlXBpLUIfWH0dzbjnm4ZSc9DcjzQkVGFh60Q9cyuSw4we70ee/LI
         i0wA==
X-Gm-Message-State: AJIora+VgoLMuU+4kz2cAi5VAYlYdG9SiBFfqQOaW8wiP0G/sJPTllZq
        Yu0EnvVuEJv6AuOkK3tjxx2L9Ie9fbCrPaI+Y41IAt5vIyBg9A==
X-Google-Smtp-Source: AGRyM1vioLStF/7QPQqw066tomXCgIbdPSQGPMBs/cu3Hu3OcZxF2Ojzq/6qJXQ9Rf8HsdIxPG6sSNiHc6Bzi9Km+Uk=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr20657589ywe.448.1656405302575; Tue, 28
 Jun 2022 01:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220316023356.120595-1-victor@allwinnertech.com>
 <CACRpkdabVpD8fQYowCFibdc-r7of6JQnUJAeo0Quqg=cCuOjAQ@mail.gmail.com>
 <0fa192d1-b6cc-4a8a-c319-36471cba79e8@allwinnertech.com> <ecabcfa6-7408-d10b-7d88-b1a202b2a90d@allwinnertech.com>
In-Reply-To: <ecabcfa6-7408-d10b-7d88-b1a202b2a90d@allwinnertech.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 10:34:49 +0200
Message-ID: <CACRpkdYt=_i+OqBmJOPxu70d1hRghx4XUWf45qY0zoG0AdtqnA@mail.gmail.com>
Subject: Re: [PATCH] ARM: mmu: fix access to illegal address when using
 earlycon & memblock=debug
To:     Victor Hassan <victor@allwinnertech.com>
Cc:     linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
        yanfei.xu@windriver.com, ardb@kernel.org, tglx@linutronix.de,
        mirq-linux@rere.qmqm.pl, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Fri, Jun 17, 2022 at 3:31 PM Victor Hassan <victor@allwinnertech.com> wrote:
> On 4/18/2022 11:08 PM, Victor Hassan wrote:
> > On 18/04/2022 07:21, Linus Walleij wrote:
> >> On Wed, Mar 16, 2022 at 3:33 AM Victor Hassan
> >> <victor@allwinnertech.com> wrote:
> >>
> >>> earlycon uses fixmap to create a memory map,
> >>> So we need to close earlycon before closing fixmap,
> >>> otherwise printk will access illegal addresses.
> >>> After creating a new memory map, we open earlycon again.
> >>>
> >>> Signed-off-by: Victor Hassan <victor@allwinnertech.com>
> >>
> >> I think noone really noticed this because everyone on Arm systems
> >> use CONFIG_DEBUG_LL, and that makes printascii hammer out
> >> stuff on the console very early, it even accounts for whether we have
> >> MMU on or not.
> >>
> > Hi Linus,
> > Thank you for the reply. I used earlycon, in early_fixmap_shutdown, the
> > base address of earlycon is in the critical stage of release and
> > reassignment, so early_fixmap_shutdown -> create_mapping should not call
> > earlycon in this process, and create_mapping has a lot of conditions
> > that trigger print, memblock=debug just makes it easier to expose problems.
> >
> >> How are you using this on Arm even? What system and what serial
> >> driver?
> > I'm using serial driver 8250 on arm32, with cmdline: memblock=debug.
> > CONFIG_SERIAL_8250=y
> > CONFIG_SERIAL_8520_CONSOLE=y
> >>
> >> That said, it looks correct.
> >> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> Hi Linus,
> Sorry to disturb. Is there any question about this issue? Thank you :)

No, I understand the problem, I provided my ACK.

Maybe you wanna add the patch to Russell's patch tracker so
he can apply it?
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
