Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAEE554726
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355259AbiFVJDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354748AbiFVJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:03:18 -0400
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BC1EC6A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:03:17 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id n15so20174965qvh.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:03:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65BoBdNEPD+hhMSIaXkfwRdYUnoeWO1j5CRjqrWAPjs=;
        b=aTunQcWOYBohEMk2rfcWAVqA8svysFpCKsGyXd3adruV8ENKcNW3lpP/4ZL3L/RWwI
         V60msb5f+wkQ6E2CwwXOnSyDtWCZzt8Y81ef7Edi5Ygb2TCk6j99Brfv/yrsQaqD8q5d
         P3ynw2tkhNnPrhvQezxnJ9QuIzjJZq0+XzfdI7J/S9+9X8oR85dISZNZWm7pjJHhwbNg
         ui+pcAxW96dFoRiRqmsPmkY8xvrU4RA+8tPVxdcbFnKIDPTcrQbFvAuR5MyxHFgz5aLf
         F3Mm/BQNs8VQOOy/QH8GyjBVOIDYNK/y4FZo5KA02a1EaBhfmFMkUXcSCKqAunfcTGM9
         oa8Q==
X-Gm-Message-State: AJIora9AkTvshuRh0weUFT/QR3vNK4zf11QHVcE5BcUcy4bVyOSP3T5X
        hw1Mhs9CF1HvHKfdfEUNXxDhyD7wIyWk9w==
X-Google-Smtp-Source: AGRyM1ulQWNa4yJCruqI5dgF0U1dV7MjHErqLZ9Gc0Hm/Dbq9XBa+gVDm2/9FZ4tDzBivQV8cZD2Xg==
X-Received: by 2002:a05:622a:14c8:b0:306:69cb:edbc with SMTP id u8-20020a05622a14c800b0030669cbedbcmr1882279qtx.376.1655888596151;
        Wed, 22 Jun 2022 02:03:16 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id bs26-20020ac86f1a000000b00304fd1f6b4csm13773519qtb.77.2022.06.22.02.03.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 02:03:15 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-317710edb9dso156280987b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:03:15 -0700 (PDT)
X-Received: by 2002:a81:7c1:0:b0:317:897d:ea90 with SMTP id
 184-20020a8107c1000000b00317897dea90mr2828900ywh.283.1655888595308; Wed, 22
 Jun 2022 02:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de> <878rrs6ft7.fsf@jogness.linutronix.de>
In-Reply-To: <878rrs6ft7.fsf@jogness.linutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 22 Jun 2022 11:03:03 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWjzH6GGkaZ_5cjeC6stc80u9Ly+5rrBuk8rKMvM7==8w@mail.gmail.com>
Message-ID: <CAMuHMdWjzH6GGkaZ_5cjeC6stc80u9Ly+5rrBuk8rKMvM7==8w@mail.gmail.com>
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

On Tue, Apr 26, 2022 at 10:50 AM John Ogness <john.ogness@linutronix.de> wrote:
> Currently threaded console printers synchronize against each
> other using console_lock(). However, different console drivers
> are unrelated and do not require any synchronization between
> each other. Removing the synchronization between the threaded
> console printers will allow each console to print at its own
> speed.

[...]

> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for your patch, which is now commit 8e274732115f63c1
("printk: extend console_lock for per-console locking") in
v5.19-rc1.

I have bisected another intriguing issue to this commit: on SiPEED
MAiX BiT (Canaan K210 riscv), it no longer prints the line detecting
ttySIF0, i.e. the console output changes like:

     spi-nor spi1.0: gd25lq128d (16384 Kbytes)
     i2c_dev: i2c /dev entries driver
     k210-fpioa 502b0000.pinmux: K210 FPIOA pin controller
    -38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1, base_baud =
115200) is a SiFive UART v0
     printk: console [ttySIF0] enabled
     printk: bootconsole [sifive0] disabled
     printk: console [ttySIF0] printing thread started

As this patch does not make any changes to drivers/tty/, and ttySIF0
does work (it's the console), I looked in /proc/kmsg, and bingo,
the missing line is there, so it is generated, but never printed.

I tried taking the port spinlock in sifive_serial_startup(), as
suggested for the meson driver, but that doesn't make a difference.

Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
