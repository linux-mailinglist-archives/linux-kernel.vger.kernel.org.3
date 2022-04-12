Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3014FD627
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355376AbiDLIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355164AbiDLH1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:27:12 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0A48310;
        Tue, 12 Apr 2022 00:07:07 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id q129so18154845oif.4;
        Tue, 12 Apr 2022 00:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G5mglcYZA42FcZWexfT//Na3N8U+QShWNDx9HhSMVxo=;
        b=kKJ3nUEWMsvrLSEjjffpnmiZNTAKv4on5YariZdK09oUTFOOJbZgu5tA8vQBAtZ18r
         E6+Qe32az2p2EwxkK9oA6ePWtoGjE9TH4px3ydOd0WeV+0op0Bd5IGPncnasrC2wKODI
         XAVk01tIA0D4Nf6u79H0lCf8YKJLt4ka3SqsukAN5aBC6LlNhYZYF8EQNWa2+HxY1EV8
         cyQmoiJUPBvSfAp1f93p+HrJEHl3CPPt/YpcmaEwE8NROh4cxi7nTZYnY2NdvgO4eQBW
         EwBgsDhtUy0/k+Oqkn6ck6Nes7LsIXLcms7SD81Cl41lekQ+RqseMzrcZRKQi3GL7BLY
         UBNA==
X-Gm-Message-State: AOAM532Gum91u170rACXcmlIBzrzy9KmXNpCRz3aU0vGcRwzZEMgiOSG
        z2ER9oFvaFzXpGSJ43yLVTvkqZpwxi9zAxu9
X-Google-Smtp-Source: ABdhPJyY2799smUiwIFdgvJoeCM6WpcXcNi2SOOE90czIXyqPS95bARZpvHXARvzQOeftsWIVQC/BQ==
X-Received: by 2002:a05:6808:bc2:b0:2ec:e1c2:bd3f with SMTP id o2-20020a0568080bc200b002ece1c2bd3fmr1212821oik.161.1649747226236;
        Tue, 12 Apr 2022 00:07:06 -0700 (PDT)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com. [209.85.210.50])
        by smtp.gmail.com with ESMTPSA id p16-20020a05680811d000b002d72ec3a921sm12272220oiv.21.2022.04.12.00.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 00:07:05 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso12828738otd.6;
        Tue, 12 Apr 2022 00:07:05 -0700 (PDT)
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr25945732ybf.6.1649747214062; Tue, 12
 Apr 2022 00:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
In-Reply-To: <20220411233832.391817-1-dmitry.osipenko@collabora.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Apr 2022 09:06:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVfOpGvF5FR6vFD-3a1h-7Kc_yAKQzWV71PD6mDy6BmZw@mail.gmail.com>
Message-ID: <CAMuHMdVfOpGvF5FR6vFD-3a1h-7Kc_yAKQzWV71PD6mDy6BmZw@mail.gmail.com>
Subject: Re: [PATCH v7 00/20] Introduce power-off+restart call chain API
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
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
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Tue, Apr 12, 2022 at 1:38 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
> Problem
> -------
>
> SoC devices require power-off call chaining functionality from kernel.
> We have a widely used restart chaining provided by restart notifier API,
> but nothing for power-off.

> Changelog:
>
> v7: - Rebased on a recent linux-next. Dropped the recently removed
>       NDS32 architecture. Only SH and x86 arches left un-acked.
>
>     - Added acks from Thomas Bogendoerfer and Krzysztof Kozlowski
>       to the MIPS and memory/emif patches respectively.

Looks like you forgot to add the actual acks?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
