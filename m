Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACBF74B8792
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 13:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbiBPM0I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Feb 2022 07:26:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiBPM0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 07:26:05 -0500
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0B027AA10;
        Wed, 16 Feb 2022 04:25:53 -0800 (PST)
Received: by mail-yb1-f173.google.com with SMTP id bt13so5538742ybb.2;
        Wed, 16 Feb 2022 04:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZzgKkF+Qi9uD0PohBja9X66WgBtIRyDp12JGMxNBcpY=;
        b=SmFG6cMNn2WzcalJa27s9eH1YqlUBva1gEkgs99/RkIpoUz6kxJSHUIqIP7IRJx6zM
         2cEsy4f2xS3oirL8EQeh/CI1NAiwXnbQvdfzVfu02n721tJsL2/AuNc1vM7QZ9KWhAMM
         WVoauxya1DfWyx/5DmjnV0NDxwqzmH2YKw2Yf+t6ZUXasSFFCXZg/7BG+1ZKrGzN0umZ
         uZiKTrlruhxGMLpVdVQZOkREYLBpFIp/tUz71rL7dD2XPupu+bXIk//dgX5JMg6Q5/VF
         nRn8ocKmLjm8+2xI1oA4PniZi16eW6h9mhgr9cdwwmrT84vYCT32ceA88etkK8vxNX1n
         zXpw==
X-Gm-Message-State: AOAM531dUfwXvaobtSMX/InoOCL/yhv4RMB/74kpsaF6OhowM7VW9glf
        GHM3ooZHTWYtAdEvXiLHWpd23aAcTie6I4M2hkA=
X-Google-Smtp-Source: ABdhPJzgB2WXDlMNWyEW279no9A0knLc+PLldmsjtAqBW5sJWGuZ+ouM0fPGPUzKV7R9c8p8BV9gaIDPnZPFqeD/pjM=
X-Received: by 2002:a81:f008:0:b0:2d0:cd72:74e5 with SMTP id
 p8-20020a81f008000000b002d0cd7274e5mr2135032ywm.301.1645014353165; Wed, 16
 Feb 2022 04:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20220130233718.21544-1-digetx@gmail.com> <635e8121-fca4-580c-6af5-d9317a2eee1b@gmail.com>
In-Reply-To: <635e8121-fca4-580c-6af5-d9317a2eee1b@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Feb 2022 13:25:39 +0100
Message-ID: <CAJZ5v0g0MrBm2+GwctkB7kUyBEt6HTAexRCFFRmTF1UKDrVQ-g@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Introduce power-off+restart call chain API
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sebastian Reichel <sre@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, alankao@andestech.com,
        "K . C . Kuen-Chern Lin" <kclin@andestech.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 15, 2022 at 11:00 PM Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 31.01.2022 02:36, Dmitry Osipenko пишет:
> > Problem
> > -------
> >
> > SoC devices require power-off call chaining functionality from kernel.
> > We have a widely used restart chaining provided by restart notifier API,
> > but nothing for power-off.
> >
> > Solution
> > --------
> >
> > Introduce new API that provides both restart and power-off call chains.
> >
> > Why combine restart with power-off? Because drivers often do both.
> > More practical to have API that provides both under the same roof.
> >
> > The new API is designed with simplicity and extensibility in mind.
> > It's built upon the existing restart and reboot APIs. The simplicity
> > is in new helper functions that are convenient for drivers. The
> > extensibility is in the design that doesn't hardcode callback
> > arguments, making easy to add new parameters and remove old.
> >
> > This is a third attempt to introduce the new API. First was made by
> > Guenter Roeck back in 2014, second was made by Thierry Reding in 2017.
> > In fact the work didn't stop and recently arm_pm_restart() was removed
> > from v5.14 kernel, which was a part of preparatory work started by
> > Guenter Roeck. I took into account experience and ideas from the
> > previous attempts, extended and polished them.
>
>
> Rafael and all, do you see anything critical that needs to be improved
> in this v6?
>
> Will be great if you could take this patchset via the power tree if it
> looks okay, or give an ack.

I need some more time for this, sorry.

I'm a bit concerned about seeing no response to this set from anyone.

It looks like multiple platforms may be affected by it in principle,
so doesn't anyone care?
