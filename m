Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61A4A715F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344296AbiBBNSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:18:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:41580
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233464AbiBBNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:18:50 -0500
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 57C593F1F0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643807929;
        bh=snnqrCI4qkz8Hro6Gqsu3aM3hUykyWW5o1MMGnMsu4c=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=BMuX1U50NYei+gExcEJCwUPseP/qvVfvdviixjVLhklBL9h1ksUyYHk2qJ4D9yGGr
         o3T3bpjSS7nUJFgbFS6wuUfO5Be914irJivSc8Bpyfi3crLJHUhC7QN6g+RN7knLkg
         ex0onBLxNzSdy9tYGUpEyjA84u0/FyVgZAlPqnYqb5Emf5FNRXL7kZwKzI9yf3iaHH
         CG0VODGcJh7ACIiJSwkygsi2dvaonv8PcDD3HQYdgyXrxlFPKY26LPRTPCXWvJpYbE
         wWIEY1YHR6YTtWKz1Cm/ZRKMAM6jxLZrIn4cMODmyGqcew2xWqlMWA5izJmxHf0qKd
         G9GpjXiikPRGA==
Received: by mail-ej1-f71.google.com with SMTP id i21-20020a1709063c5500b006b4c7308c19so8107967ejg.14
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:18:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=snnqrCI4qkz8Hro6Gqsu3aM3hUykyWW5o1MMGnMsu4c=;
        b=P5VVzkrnwFhnL8VEFbC8OY9kfDs1xUUmm9PqYXEg9kmNI4IRSl3EPq4rMvuGePQ2sM
         xKExOIA16zlFQYXygUefOjzi4n3bGmXq4Q094q2HYI/D9uzWI5BxhA9f5kVo7riuJ/U4
         BIWYh65HUNT5a1KIql7Dd5kW3LrDU1blca0fzqZFZPByHJSb8gKnf7M6TPFevRguaIY3
         7iwq/qBY2u4CBA0Uoz1G8I68kzgZfWdhPQryDVclLfPNlbFJy/nuwcuxSfwdVlfZZtgZ
         ik2W4KgrXv+zbEnU/rJmlsAgDd269A0824Ysp6pbbjB+BjbGD5l3bhIWHbz3XqD11hdY
         Uu5g==
X-Gm-Message-State: AOAM532pduEClowBW0zv37ulsBXLQtlDoXH90P0BYWuak70STmLbquvJ
        sO2sGQ4/3Xr2Eku5esf8c9zMqYAmaPG79gfniWaF1LbsFrsdsSoUwmEsixd41GcIp+BqXWH7pqo
        ta7Sr2ydHCz5aDBSpzw+EZTllEZ/+etIyTgz+2d9NqKM8nPuqS3qAL5aYeQ==
X-Received: by 2002:aa7:cd0b:: with SMTP id b11mr29885620edw.412.1643807928850;
        Wed, 02 Feb 2022 05:18:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1dzhipSUYTihxVVzQkkaZnzEIXAFJlJAmh3uo9RR5PEKeTLa1FlnwjQssXcKFJZ5pmuz11A7eZFDgrYYhlPY=
X-Received: by 2002:aa7:cd0b:: with SMTP id b11mr29885596edw.412.1643807928661;
 Wed, 02 Feb 2022 05:18:48 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
In-Reply-To: <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
Date:   Wed, 2 Feb 2022 14:18:36 +0100
Message-ID: <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>, palmer@dabbelt.com,
        syzbot <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksandr,

On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
>
> Hello,
>
> syzbot has already not been able to fuzz its RISC-V instance for 97

That's a longtime, I'll take a look more regularly.

> days now because the compiled kernel cannot boot. I bisected the issue
> to the following commit:
>
> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> Date:   Fri Oct 29 06:59:27 2021 +0200
>
>     riscv: Fix asan-stack clang build
>
> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> enabled. In the previous message syzbot mentions
> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> For convenience, I also duplicate the .config file from the bot's
> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
>
> Can someone with KASAN and RISC-V expertise please take a look?

I'll take a look at that today.

Thanks for reporting the issue,

Alex

>
> --
> Best Regards,
> Aleksandr
>
>
> On Tue, Jan 18, 2022 at 11:26 AM syzbot
> <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    f6f7fbb89bf8 riscv: dts: sifive unmatched: Link the tmp451..
> > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1095f85bb00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> > dashboard link: https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be
> > compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > userspace arch: riscv64
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com
> >
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/00000000000038779505d5d8b372%40google.com.
