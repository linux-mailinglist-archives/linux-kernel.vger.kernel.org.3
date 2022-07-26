Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351EF5808FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237069AbiGZBUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbiGZBUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:20:44 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA86B1D1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:20:43 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id r21so9523999qtn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UKkB3HULRj3pUMmgT7OAFIB5pdUVGm/GcYLhlJ2fbiM=;
        b=ZOPuhM7S6MsLqjdVjiwtnjsXjl6yFboh+slRXuHNgPB//aoSd0w/GAXGC2AYR7E6Ww
         KZbRpBwMS8hOOUPcRAHwax4aiQOqgSq5TyOjDlx72wnBdsbpVJU7ShDIyE0ky6LDWKm8
         a2ebzRMMAXZRf6f1GG8ZH/BchCamLL0Fl7Tvd8AnuNLoyyzSE37PwNn4POWee0MeOeF3
         BUlSOHoWwtqHlZxRodeb+1WR5R2jl9Kus9PvQ1Dv0S5uzOFf9MdIH+5ph6vhADxxjH/R
         uROg486VwASsvEs/jABOqwC3t2SY3WpVAHBBkTPw3r/wK/YzYuE3oL9/wuzhUPBnQ5Mi
         ZbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UKkB3HULRj3pUMmgT7OAFIB5pdUVGm/GcYLhlJ2fbiM=;
        b=t6JVAMhod+CsiA7P3OTdajznKud8l4GcHFijdA7vrPy5bXAzzuR1Jr+yqSNWxxwqxj
         0UvCcXi9zDXOt+Q/GwTB96irBjkf7yNJUch07Urxdx6y+42CKpAtAIg93226faNi7car
         J9XFCqrwxiK8CWJdImQore/sp2UYt5cRXKQko/AFvapMLTttyzdmMiCyCLMJKiUGa6hU
         AIrA5ygNzWB5r9na3b5MvF4a7qGmsMz97ioQwi71NKQuSQovBHGgBqnghrtin900yXEL
         9Hp9DVQE3qXUncn/TErfi9HfwkgjfnQ6TRrjKBj+h3hgy9PvW9CpVMX53I8+naO+1ZJR
         +YkA==
X-Gm-Message-State: AJIora+HAwzbavmuXTji9naQzfLnjiacOk1MgohYXvER4Lg3A0GwhPu6
        GIQUQUNI8WpCQc7hkdAh9iaSgYlBp1lvGGV4dSZWyROJ
X-Google-Smtp-Source: AGRyM1v5Oq6ibNjY9kTVwavxnUasb0PXWn+YuJfZrK5IuhnUR92S0axYiZC5m9zj1RGDh4KvocBDxTsoK75D2XGMhhA=
X-Received: by 2002:a05:622a:100d:b0:31f:25e3:7a45 with SMTP id
 d13-20020a05622a100d00b0031f25e37a45mr12446508qte.365.1658798443069; Mon, 25
 Jul 2022 18:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <CADmoyEiUoULvn76UXcS0DaF2-Us4CTL=SyXf7PWYqfPTF3PTtQ@mail.gmail.com>
In-Reply-To: <CADmoyEiUoULvn76UXcS0DaF2-Us4CTL=SyXf7PWYqfPTF3PTtQ@mail.gmail.com>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Tue, 26 Jul 2022 09:20:29 +0800
Message-ID: <CAEUhbmXSUJNxTtjA5W5x_EtnOHERhMvj6ZZVrT-qx-k9_gHB_w@mail.gmail.com>
Subject: Re: How to read RISC-V mcycle CSR from Linux userspace app?
To:     Maxim Blinov <maxim.blinov@embecosm.com>
Cc:     "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
        "open list:RISC-V" <qemu-riscv@nongnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 12:58 AM Maxim Blinov <maxim.blinov@embecosm.com> wrote:
>
> Hi all, stupid question but I can't for the life of me figure this out
> even with all the docs open.
>
> I need to get an estimate figure for the cyclecount of a busy loop in
> one of my small Linux userspace apps. The app in question is running
> in qemu-system-riscv64. I've compiled QEMU myself, and the full code
> is like this:
>
> #include <unistd.h>
> #include <stdint.h>
> #include <stdlib.h>
> #include <stdio.h>
>
> uint64_t get_mcycle() {
>   uint64_t mcycle = 0;
>
>   asm volatile ("csrr %0,mcycle"   : "=r" (mcycle)  );

Change this to "csrr %0,cycle" and you should be able to run your program.

>
>   return mcycle;
> }
>
> int main(int argc, char **argv) {
>   printf("Hello\n");
>   printf("mcycle is %lu\n", get_mcycle());
>
>   return 0;
> }
>
> Now I get SIGILL when I hit the `csrr` insn, which makes sense.
> According to the "Privileged Architecture Version 1.10", page 32, [1]
> we need to set mcounteren, hcounteren, and scounteren low bits to 1 in
> order to get the mcycle csr to become available in userspace. So I add
> the following function:
>
> void enable_mcount() {
>   /* Enable IR, TM, CY */
>   uint64_t mcounteren = 0x5;
>   asm volatile ("csrw mcounteren,%0" : "=r" (mcounteren));
>   asm volatile ("csrw hcounteren,%0" : "=r" (mcounteren));
>   asm volatile ("csrw scounteren,%0" : "=r" (mcounteren));
> }
>
> And call it before I call get_mcycle(), but this triggers SIGILL
> (unsurprisingly) also, since these CSRs are also privileged. So
> there's a bit of a chicken and egg problem.
>
> Could someone more knowledgeable please suggest what the course of
> action here is? I've got QEMU revision f45fd24c90 checked out, and I'm
> staring at qemu/target/riscv/csr.c:71, which seems to deal with
> whether or not to raise a SIGILL upon access. I can see a condition
> for when we're in 'S' mode, but nothing for 'U' mode. Does that mean
> there is fundamentally no access to these CSR's from 'U' mode? Is it
> possible to just hack it in?

In the user space, you can only read the U-mode CSRs like cycle, but NOT mcycle.

>
> Maxim
>
> [1]: https://riscv.org/wp-content/uploads/2017/05/riscv-privileged-v1.10.pdf
>

Regards,
Bin
