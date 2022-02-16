Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 636BE4B8734
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 12:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiBPL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 06:56:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiBPL4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 06:56:30 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC77267257
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:56:17 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id r18-20020a05683001d200b005ac516aa180so1358884ota.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 03:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fhNx+q9flxByCxUrkRhgBlwV1E/I95+1uqa0YFgkq6g=;
        b=iT2AEWwx2kmQ/iEeYiUslVDYol+IJWHOCYAu/EndEGVOjCfpvlr0+SBUUSbi8FTybM
         ViaOLETa4pUXEQQKqZRHMBUEdJHHhYoHeZsbhXrrdxh6UPjfJUyqjINuilJFbR3+8+hd
         kV1wldLn71EV40AfChJgJykO8eqA0bD0K5q2aHvqQ1KFxyMz8sDtBDq4Fj63YMRrvGrz
         tCDIgChVCL+KleGxb4+j70F/J4XkfNF4Jq0WBS88H/chcvOCf988pr7hxkkmNknOydGB
         Q1WdtqRfSwb1teC1XM/RmGtWDnm9tu1SPlC13uBHMtvpFGwc3TjXBh4gdD8igcbC8SiN
         4CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fhNx+q9flxByCxUrkRhgBlwV1E/I95+1uqa0YFgkq6g=;
        b=v0/rnn/SnZKM/Q0TrgR7kB6Oov+mOUuIr04GOjdRg1uvDQZvn3pjYAPLjLg3ojEdNr
         T5QcKoWdw6Rc8MSJggzySwV1KsHAWxas56n9E/SPKSqST2E+E3Joh3jQdhlchZMGazor
         aslxeEf06nLB6CoT8TtF0WRAWWFH3juTMqG72wK+bXp/4w0VigFU2JOFOBjjIavto+7k
         /AdMangcmnyhTVicnSVMzjcXZhm90+aOjDFmKt0WYZV6XkbI/RzMY97jk5EPILWSwxFN
         KVBfdyMEyzkhES6s0zne8hx5iWl2NzjtQ0UBOUCtLecUQg5QA0GZ36LsoK5HaXHcQeRg
         TRgQ==
X-Gm-Message-State: AOAM5314H8PzeKFTCTjyB0leDS8eckg+o2bp2Qd1NcFEGMo2BRImLNaQ
        iGddh65dQx4+LL750Mf6cEfXrEyIeBtnek6SjYx0Tg==
X-Google-Smtp-Source: ABdhPJyHxoWNJ8kHTb9HsShfXiM/sbl3u6sXG3pFrQ4s5tBqgytJ6UL3fDX+1Fxn0D9kShi/CTJGTdCVX8sBSaMocVg=
X-Received: by 2002:a9d:77c4:0:b0:5a3:326f:9236 with SMTP id
 w4-20020a9d77c4000000b005a3326f9236mr676453otl.196.1645012577018; Wed, 16 Feb
 2022 03:56:17 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
 <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com>
 <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr> <CANp29Y4WMhsE_-VWvNbwq18+qvb1Qc-ES80h_j_G-N_hcAnRAw@mail.gmail.com>
 <CANp29Y4ujmz901aE9oiBDx9dYWHti4-Jw=6Ewtotm6ck6MN9FQ@mail.gmail.com>
In-Reply-To: <CANp29Y4ujmz901aE9oiBDx9dYWHti4-Jw=6Ewtotm6ck6MN9FQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 16 Feb 2022 12:56:06 +0100
Message-ID: <CACT4Y+ZvStiHLYBOcPDoAJnk8hquXwm9BgjQTv=APwh7AvgEUQ@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        linux-riscv@lists.infradead.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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

On Wed, 16 Feb 2022 at 12:47, Aleksandr Nogikh <nogikh@google.com> wrote:
>
> On Wed, Feb 16, 2022 at 11:37 AM Aleksandr Nogikh <nogikh@google.com> wrote:
> >
> > Hi Alex,
> >
> > On Wed, Feb 16, 2022 at 5:14 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On 2/15/22 18:12, Dmitry Vyukov wrote:
> > > > On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
> > > > <alexandre.ghiti@canonical.com> wrote:
> > > >> Hi Aleksandr,
> > > >>
> > > >> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> > > >>> Hello,
> > > >>>
> > > >>> syzbot has already not been able to fuzz its RISC-V instance for 97
> > > >> That's a longtime, I'll take a look more regularly.
> > > >>
> > > >>> days now because the compiled kernel cannot boot. I bisected the issue
> > > >>> to the following commit:
> > > >>>
> > > >>> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> > > >>> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> > > >>> Date:   Fri Oct 29 06:59:27 2021 +0200
> > > >>>
> > > >>>      riscv: Fix asan-stack clang build
> > > >>>
> > > >>> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> > > >>> enabled. In the previous message syzbot mentions
> > > >>> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> > > >>> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> > > >>> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> > > >>> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> > > >>> For convenience, I also duplicate the .config file from the bot's
> > > >>> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> > > >>>
> > > >>> Can someone with KASAN and RISC-V expertise please take a look?
> > > >> I'll take a look at that today.
> > > >>
> > > >> Thanks for reporting the issue,
> > > >
> > >
> > > I took a quick look, not enough to fix it but I know the issue comes
> > > from the inline instrumentation, I have no problem with the outline
> > > instrumentation. I need to find some cycles to work on this, my goal is
> > > to fix this for 5.17.
> >
> > Thanks for the update!
> >
> > Can you please share the .config with which you tested the outline
> > instrumentation?
> > I updated the syzbot config to use KASAN_OUTLINE instead of KASAN_INLINE,
> > but it still does not boot :(
> >
> > Here's what I used:
> > https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138
>
> Update: it doesn't boot with that big config, but boots if I generate
> a simple one with KASAN_OUTLINE:
>
> make defconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
> ./scripts/config -e KASAN -e KASAN_OUTLINE
> make olddefconfig ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu-
>
> And it indeed doesn't work if I use KASAN_INLINE.

It may be an issue with code size. Full syzbot config + KASAN + KCOV
produce hugely massive .text. It may be hitting some limitation in the
bootloader/kernel bootstrap code.
