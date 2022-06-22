Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31E4556E94
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 00:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359733AbiFVWhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 18:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241081AbiFVWhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 18:37:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCD840A33
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 15:37:23 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655937435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8tSupLdVkgmkJxR6XWH1BaGWmi5B6LARumTOlnBjCLU=;
        b=h2dsoGyMgLwZjzVS9szjvLRMkofizn2sHhCAgoKoil5WEmoTfKt5Sv98yHwN1uZtQngl1q
        bHkdqeJ2H5Ld+Vw8Xl4WcZqMqM1ObX/byCfCH7MCKOIcPG/DvDGxH3GeqzDyEHtGlW2xHb
        CiI8wSJuKIXzC1Ve+OEK4GQxdwBdMHE1Cp8ukuW7UApz0g0SiW3v9Xh4hbQfd/icYFzVxF
        NKakt9z2rIMmjHHxJXxd8/DrtogxTSsLjEvxqaEDUq1JoV26ZhL/EBBPhR1dr3EDabFb3d
        xx6PuwQSQRiaYJ8fc3w9YNTAy48otfvkej2CPHfhRCYQYrOIZ4jAxrdVGUUSYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655937435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8tSupLdVkgmkJxR6XWH1BaGWmi5B6LARumTOlnBjCLU=;
        b=E8vgALv5rGfb7cjIr53AYf3otdbEMlM7X8s97Y88959INfA84zSQz6buqDJN519OKO9haJ
        D05jBbsTXnSy3/Aw==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-riscv <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH printk v5 1/1] printk: extend console_lock for
 per-console locking
In-Reply-To: <CAMuHMdWjzH6GGkaZ_5cjeC6stc80u9Ly+5rrBuk8rKMvM7==8w@mail.gmail.com>
References: <20220421212250.565456-1-john.ogness@linutronix.de>
 <20220421212250.565456-15-john.ogness@linutronix.de>
 <878rrs6ft7.fsf@jogness.linutronix.de>
 <CAMuHMdWjzH6GGkaZ_5cjeC6stc80u9Ly+5rrBuk8rKMvM7==8w@mail.gmail.com>
Date:   Thu, 23 Jun 2022 00:43:15 +0206
Message-ID: <87v8ssgw9w.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-22, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> I have bisected another intriguing issue to this commit: on SiPEED
> MAiX BiT (Canaan K210 riscv), it no longer prints the line detecting
> ttySIF0, i.e. the console output changes like:
>
>      spi-nor spi1.0: gd25lq128d (16384 Kbytes)
>      i2c_dev: i2c /dev entries driver
>      k210-fpioa 502b0000.pinmux: K210 FPIOA pin controller
>     -38000000.serial: ttySIF0 at MMIO 0x38000000 (irq = 1, base_baud =
> 115200) is a SiFive UART v0
>      printk: console [ttySIF0] enabled
>      printk: bootconsole [sifive0] disabled
>      printk: console [ttySIF0] printing thread started
>
> As this patch does not make any changes to drivers/tty/, and ttySIF0
> does work (it's the console), I looked in /proc/kmsg, and bingo,
> the missing line is there, so it is generated, but never printed.

What is sifive0? Are you using the earlycon driver to create an early
boot console? Can I see your boot args?

There is a known issue the that earlycon does not synchronize with
normal consoles. A patch was recently posted [0] on LKML.

> I tried taking the port spinlock in sifive_serial_startup(), as
> suggested for the meson driver, but that doesn't make a difference.

It may not have made a difference for you, but it should be there.
sifive_serial_startup() is writing to SIFIVE_SERIAL_IE_OFFS without
taking port->lock. sifive_serial_console_write() also writes to this
register (under port->lock). This could lead to RX watermark interrupts
being disabled for some time. The problem is not as bad as it was with
the meson driver because __ssp_enable_rxwm() is updating the shadow
copy. But still, it is a bug. And anyway we shouldn't have 2 CPUs
writing to a register simultaneously.

John Ogness

[0] https://lore.kernel.org/lkml/20220621090900.GB7891@pathway.suse.cz
