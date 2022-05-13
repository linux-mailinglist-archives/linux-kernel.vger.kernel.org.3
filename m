Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986C2525E00
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378487AbiEMIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378502AbiEMIoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 04:44:11 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918AC2AC0E9;
        Fri, 13 May 2022 01:44:06 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id g6so14899913ejw.1;
        Fri, 13 May 2022 01:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iZuFOu7mi3R6oaoaxmRQI9ZUruMPyMLHtg+6pEfGbWE=;
        b=QYRK3klwC97qKC35SuJKJwR3ljh55QviJszDrOQTatoqR3xNXMtv7y2tvL4oQ4/62i
         bStx1dSMmwYPsweHMouSZ6m5taR7WQzEu4YiXV4kG4shELh1Ig+35kxhhXG61u6AKgdc
         pR61dzxoH6r/PYTiXE54q8E3yCNMWAMevaU2PXapNsGNmJc1ml+5L1Q6Tjs9N5s+JT6q
         rYQdkbioGf8769je7PEU73DViMl73nUYqx0s50EQ1tqJRvqGOqGUz1G97vxB8p4MZG7x
         OxETS/BRxq/yxN3NaDWXol9IcY2gYO5HUGyfVJuJsd437aNM2RCZxQnR2QOufjV10Ygz
         s4Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iZuFOu7mi3R6oaoaxmRQI9ZUruMPyMLHtg+6pEfGbWE=;
        b=zVY8YQJhxoea1hxBQci07SzzKWd+ZZC5U0c6eN/314GCaOsVhK9kZBjpDQPgCt7a1I
         ouLJmefim5iYRK0zr+hKjO1oO1PfqZ+OD3kjD2mRAobYr+LQhnjqFh/avyb/htS2Yapr
         8Ys8Zy3ZI/PYWbyAo9nqj2jtbHQaJgHaL2n1NvN08MpiwEyZSIsj8U+hYfideCzNQorF
         ccTzcSqLrWyk99cEBmbjiwhad3kNBimyxK/PD6Mutvio0OfOXWWQ3T6Wmup7Gd13uUve
         fcRe3oQnL3wIxE5p2VjZBgEVykuRGdrqLpcGJ6+R74lQ1ayLZzBR8GMEsM51WQvsshC6
         wdRA==
X-Gm-Message-State: AOAM530F2tu80uAjDmRXDzcM4CRGQ3NI3KomxnUE9hiUcDBQxUZYYArg
        FFil6TCZuerdw1TpjXucWquTV6T1FHqujrzfCt4=
X-Google-Smtp-Source: ABdhPJwPYgn9qjZuHBlcNiKfKy33XVPFV4ohp7JOvTJYAgY2JqdWz2SullZNfUvaf3cvYaAWXCITaYTI8Ji7in/u2hk=
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id
 do13-20020a170906c10d00b006f4a770846emr3263286ejc.497.1652431444879; Fri, 13
 May 2022 01:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220419141846.598305-1-maz@kernel.org> <Yn0/DIl3+i/heRH6@smile.fi.intel.com>
 <Yn1Fe4WPp3ZaUERj@smile.fi.intel.com> <87tu9umm3k.wl-maz@kernel.org>
In-Reply-To: <87tu9umm3k.wl-maz@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 13 May 2022 10:43:29 +0200
Message-ID: <CAHp75VfKMEcr1U=YQFfDRCpU=2LE78c76fSsAOFTWZHaswdiwg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] gpiolib: Handle immutable irq_chip structures
To:     Marc Zyngier <maz@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
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
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        Android Kernel Team <kernel-team@android.com>
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

On Fri, May 13, 2022 at 12:18 AM Marc Zyngier <maz@kernel.org> wrote:
> On Thu, 12 May 2022 18:35:55 +0100,
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Thu, May 12, 2022 at 08:08:28PM +0300, Andy Shevchenko wrote:
> > > On Tue, Apr 19, 2022 at 03:18:36PM +0100, Marc Zyngier wrote:
> > > > This is a followup from [2].
> > > >
> > > > I recently realised that the gpiolib play ugly tricks on the
> > > > unsuspecting irq_chip structures by patching the callbacks.
> > > >
> > > > Not only this breaks when an irq_chip structure is made const (which
> > > > really should be the default case), but it also forces this structure
> > > > to be copied at nauseam for each instance of the GPIO block, which is
> > > > a waste of memory.
> > >
> > > Is this brings us to the issue with IRQ chip name?
> > >
> > > The use case in my mind is the following:
> > > 1) we have two or more GPIO chips that supports IRQ;
> > > 2) the user registers two IRQs of the same (by number) pin on different chips;
> > > 3) cat /proc/interrupt will show 'my_gpio_chip XX', where XX is the number.
> > >
> > > So, do I understand correct current state of affairs?
> > >
> > > If so, we have to fix this to have any kind of ID added to the chip name that
> > > we can map /proc/interrupts output correctly.
> >
> > Hmm... Some drivers are using static names, some -- dynamically
> > prepared (one way or another). Either way I think the ID is good to
> > have if we still miss it.
>
> No, this is a terrible idea. /proc/interrupts gives you a hint of
> which driver/subsystem deals with the interrupt. This isn't a source
> of topological information. /sys/kernel/debug/irq has all the
> information you can dream of, and much more. Just make use of it.

Okay, so IIUC the mapping is that: I got a vIRQ number from
/proc/interrupts, but then I have to mount debugfs and look into it
for a detailed answer of which chip/domain this vIRQ belongs to. Also
/sys/kernel/irq rings a bell, but not sure if it's related.

-- 
With Best Regards,
Andy Shevchenko
