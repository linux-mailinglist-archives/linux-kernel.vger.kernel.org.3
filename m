Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D94557788
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiFWKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiFWKK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:10:26 -0400
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE2C49F2B
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:10:14 -0700 (PDT)
Received: by mail-qv1-f50.google.com with SMTP id cu16so28590610qvb.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:10:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDiN2XUMXdbXoOyZ4jtMq+b+hmbHQgPzlqj2YdQ+bNg=;
        b=Bpc2wGhh/uS0rcnNSrRHYpt+ZGtk9opJNY3Aw+6d3Bhax0EgTNnfis7N9gb4EFUITQ
         uDHU+jDB65r2jELrYCTNI/tSSg7e12lBLO/xIvYtTZgZjXJ0jD5/1oIH+NFu8b31qVJo
         OC16JVKrosWHKqBI9qNV0cuZCILAIPj6nW1XZWfjfzf5Ys7qpKcJG2v/LGce72tH/pRN
         sVCZO+TW1/UDNsEs9/vSZsLQp1AWd4Mca5GGiYalDGzuDOuAMF4Qerii0OW2gFlF7pyW
         g0t41Nhs0DTwYAFNwEKjuUDvPiXqbO0OeLHYVlg1/tc2pd4PgN15weWBeLwPc4fsCy+6
         1gKw==
X-Gm-Message-State: AJIora/q8qquGZl3ZbeFuwDhFLqpv1vRdYHn2gsyWpBEtrIkTFhU8bSX
        SrnNrvDsYXSs+M9mUr9tOyWntt+AZIpVsg==
X-Google-Smtp-Source: AGRyM1tn6N19u8dFC1wXkBwhh4ojpIdPDJZZa9vuRAwTD9SJwLB+AtBkql+5y3BEiAGloCwlCsNVow==
X-Received: by 2002:a05:6214:3006:b0:46e:6be4:2b7d with SMTP id ke6-20020a056214300600b0046e6be42b7dmr31457859qvb.84.1655979013605;
        Thu, 23 Jun 2022 03:10:13 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05620a179f00b006a7137330e2sm17064786qkb.132.2022.06.23.03.10.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:10:12 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31780ad7535so162793367b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:10:12 -0700 (PDT)
X-Received: by 2002:a0d:f801:0:b0:30f:f716:2950 with SMTP id
 i1-20020a0df801000000b0030ff7162950mr9852993ywf.358.1655979012327; Thu, 23
 Jun 2022 03:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de> <878rrs6ft7.fsf@jogness.linutronix.de>
 <CAMuHMdWjzH6GGkaZ_5cjeC6stc80u9Ly+5rrBuk8rKMvM7==8w@mail.gmail.com> <87v8ssgw9w.fsf@jogness.linutronix.de>
In-Reply-To: <87v8ssgw9w.fsf@jogness.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Jun 2022 12:10:00 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV7trsRg0x9w8ZfHp0UHZ8PE+EoddAzf9nmtjGrO4YfPw@mail.gmail.com>
Message-ID: <CAMuHMdV7trsRg0x9w8ZfHp0UHZ8PE+EoddAzf9nmtjGrO4YfPw@mail.gmail.com>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for per-console locking
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
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

Hi John,

On Thu, Jun 23, 2022 at 12:37 AM John Ogness <john.ogness@linutronix.de> wrote:
> On 2022-06-22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > I have bisected another intriguing issue to this commit: on SiPEED
> > MAiX BiT (Canaan K210 riscv), it no longer prints the line detecting
> > ttySIF0, i.e. the console output changes like:
> >
> >      spi-nor spi1.0: gd25lq128d (16384 Kbytes)
> >      i2c_dev: i2c /dev entries driver
> >      k210-fpioa 502b0000.pinmux: K210 FPIOA pin controller
> >     -38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1, base_baud =
> > 115200) is a SiFive UART v0
> >      printk: console [ttySIF0] enabled
> >      printk: bootconsole [sifive0] disabled
> >      printk: console [ttySIF0] printing thread started
> >
> > As this patch does not make any changes to drivers/tty/, and ttySIF0
> > does work (it's the console), I looked in /proc/kmsg, and bingo,
> > the missing line is there, so it is generated, but never printed.
>
> What is sifive0? Are you using the earlycon driver to create an early
> boot console? Can I see your boot args?

earlycon: sifive0 at MMIO 0x0000000038000000 (options '115200n8')
printk: bootconsole [sifive0] enabled
Kernel command line: earlycon console=ttySIF0 rootdelay=2 root=/dev/mmcblk0p1 ro

> There is a known issue the that earlycon does not synchronize with
> normal consoles. A patch was recently posted [0] on LKML.

> [0] https://lore.kernel.org/lkml/20220621090900.GB7891@pathway.suse.cz

Thank you, that did the trick!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
