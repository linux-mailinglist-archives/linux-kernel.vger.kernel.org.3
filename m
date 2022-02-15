Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8BE44B786C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiBORNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:13:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242316AbiBORNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:13:21 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F228E11ACED
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:13:10 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id s24so21461579oic.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:13:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkNaB6kzC0t6gTi2pQx30aeojCMITTvkle2ZzaYqdBM=;
        b=Tl08YyyCqUz7jPsZpEIFs7dcAC/J3b3HZaMGn2NtoxJdeiQj1zWTIhiXMGBdMH83VQ
         1PghJf9UK1UklkzjUbCFtG0ZVytd3YE5L/JU7Kj9Z9cs0Wvvd+DGV0TXm+DgvCOhGcRs
         VqO1dAL9k6fwlwYV03cAC0TdOdS+Q/ZQe65153sA+YsBU6iS7zg3OCu919enunaT31XZ
         6oWEyPxUX6PDYpqqXRNWTgCxfQoV6e0VL/fBBeLHnuF3Tf+jt5xEugirI7diCJWGCLov
         0y2Sg+P0c8WXjiAhxG6TJ0z3N43nJ9hDxYQULHaF9eUw6VZjJNwxw8XyTyxWSPqnnyu6
         bEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkNaB6kzC0t6gTi2pQx30aeojCMITTvkle2ZzaYqdBM=;
        b=aiOvL/h1mfiO2Ne7K/2qlA5geruegeBON6vJurzl9F63RvsH1udQDl1XUbGV0Xx4sm
         113Pmu9MamO5ID/jLv794Q/2AdH919lKzU++XqXTiqzjN9jjqSn8/Gb61nphpYhN4I3q
         m+OKlvAZz5tgLepFyuD2mnSKMfmcqqqJUpeJb84/WHtSdQ7OpOY/4+1Rr2ROj0BIVr8k
         JQmvdmaJKNqGa4R5Kmc7So85L9pGXo2L9IqVaY/3M+ny5havYObwbK5U5Nb1TnZhyvVW
         wT6i7Yw8wcP6LYJOoCi4WY+obxUzUCm26GRuplyVVV+i9HPzTH2OsYRE5SYCa1MTVM+Y
         oxuw==
X-Gm-Message-State: AOAM532McjiblyzgyFxxSR9tT4SiRB2AKQ0R6fnPNo5xoAvy3QJSN6em
        e7zA0UUdWlxkzGpgk9KyeoEsgJ6thoQnlVC4d7syqQ==
X-Google-Smtp-Source: ABdhPJyF2d6aFudNgPHq5wPVAths+OUdollkoCVet7aNgbJuaRRSllKYLRFDUcSQY12kE4kPlhzrLKhEIuiY531pZK0=
X-Received: by 2002:a05:6808:3021:b0:2d4:40f3:6b30 with SMTP id
 ay33-20020a056808302100b002d440f36b30mr605011oib.31.1644945190003; Tue, 15
 Feb 2022 09:13:10 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
In-Reply-To: <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 15 Feb 2022 18:12:58 +0100
Message-ID: <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Aleksandr Nogikh <nogikh@google.com>,
        linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>, palmer@dabbelt.com,
        syzbot <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
<alexandre.ghiti@canonical.com> wrote:
>
> Hi Aleksandr,
>
> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Hello,
> >
> > syzbot has already not been able to fuzz its RISC-V instance for 97
>
> That's a longtime, I'll take a look more regularly.
>
> > days now because the compiled kernel cannot boot. I bisected the issue
> > to the following commit:
> >
> > commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> > Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > Date:   Fri Oct 29 06:59:27 2021 +0200
> >
> >     riscv: Fix asan-stack clang build
> >
> > Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> > enabled. In the previous message syzbot mentions
> > "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> > Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> > a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> > 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> > For convenience, I also duplicate the .config file from the bot's
> > message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> >
> > Can someone with KASAN and RISC-V expertise please take a look?
>
> I'll take a look at that today.
>
> Thanks for reporting the issue,

Hi Alex,

Do you have any updates on this? This is still blocking syzbot:
https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be

Do you use KASAN with clang or gcc? We can't boot riscv kernel with neither.


> > --
> > Best Regards,
> > Aleksandr
> >
> >
> > On Tue, Jan 18, 2022 at 11:26 AM syzbot
> > <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    f6f7fbb89bf8 riscv: dts: sifive unmatched: Link the tmp451..
> > > git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1095f85bb00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be
> > > compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > userspace arch: riscv64
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com
