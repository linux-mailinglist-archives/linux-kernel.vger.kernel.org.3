Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1506A4B85F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiBPKiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 05:38:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiBPKh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 05:37:59 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC4C15F368
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:37:48 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id w7so1727619ioj.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 02:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pN9JYDOrzujGng7ZER6xyWI6CgQWXz9WnMXVqwu2nsA=;
        b=hRGOhZEqubA2zsEfdxpguDnmajVfN/3uyhhdGBVRzjaozDyIBwu5lVCqnBv1h+HCv5
         F2SIIdcLfAKqJx5gYKoHxlv/PwwxJH7qA4exu02oEcjBqCYPcEoDVxf9FN1F2AuMrEn2
         zqKMXSAIZ1nW90AYX0nnIOUMza4o1j+brDI8L7DXHMDRRIoopzakZnHHNWE/hgCaSXGz
         WJzdnB/4S8msDUfUweGcT+tjH8K9IhZsLxvopded+LTIE7gl+qXsVcnwgwpQU+7i3Qbr
         83xkaF/pp5JaJ+1uoA8UvBfwmU7e2+z4pwL1r/hWZ9qg6dDtle3Wx4C2UAoDFORlDISN
         rPbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pN9JYDOrzujGng7ZER6xyWI6CgQWXz9WnMXVqwu2nsA=;
        b=EVhYvtmdfQ/RQxq5CJS0C1vxFyA1GfW3IsanB0U+/gK1PNwCDW3C9m/ynkke2TJMba
         4xuzcOMx16UiFen8uv51jOCY1sPf/ctXkrVbfvnDBzRoonUZ1N3vhhIrVG2rXsVQ09Te
         gra+DTvw1uFxA8r/rZAJ7pJp6xt3qN2VbJqo8SWbQa6MbiG8Rse+scd3zkXeejOZ/YnQ
         Ax60ticZnekoWamc/lMse5MZiDUsnH62SJ5cIbvvermikIkOXNHg0oHC0ZO141CnQXVu
         z/f/z8RYFKTG2sOvmNUsgwL7Fj3RW8AV5TZzQZ9YUXolgciFQrAxNXPYgu4iO8nR0t/0
         BALw==
X-Gm-Message-State: AOAM53183DV2PMGuO6kvHY8F/Y8fOqwaJP0+wY4+nLXQTRmGLNzWT1tJ
        b2fbgSISUfZhbR0hMs8MIJ15IxG9wesT1g/cLH2oqGlunJLB89Sy
X-Google-Smtp-Source: ABdhPJwldGUf7FvIQ7rrVP0SPiqSh3RoVrBRg7SghIXsHqFA00zV2YWfeC99XNB6QCSfxyQoDA+WrSW4CcOIetUOwM0=
X-Received: by 2002:a02:6308:0:b0:30e:7e14:848b with SMTP id
 j8-20020a026308000000b0030e7e14848bmr1218612jac.139.1645007867380; Wed, 16
 Feb 2022 02:37:47 -0800 (PST)
MIME-Version: 1.0
References: <00000000000038779505d5d8b372@google.com> <CANp29Y7WjwXwgxPrNq0XXjXPu+wGFqTreh9gry=O6aE7+cKpLQ@mail.gmail.com>
 <CA+zEjCvu76yW7zfM+qJUe+t5y23oPdzR4KDV1mOdqH8bB4GmTw@mail.gmail.com>
 <CACT4Y+arufrRgwmN66wUU+_FGxMy-sTkjMQnRN8U2H2tQuhB7A@mail.gmail.com> <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr>
In-Reply-To: <a0769218-c84a-a1d3-71e7-aefd40bf54fe@ghiti.fr>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Wed, 16 Feb 2022 11:37:36 +0100
Message-ID: <CANp29Y4WMhsE_-VWvNbwq18+qvb1Qc-ES80h_j_G-N_hcAnRAw@mail.gmail.com>
Subject: Re: [syzbot] riscv/fixes boot error: can't ssh into the instance
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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

Hi Alex,

On Wed, Feb 16, 2022 at 5:14 AM Alexandre Ghiti <alex@ghiti.fr> wrote:
>
> Hi Dmitry,
>
> On 2/15/22 18:12, Dmitry Vyukov wrote:
> > On Wed, 2 Feb 2022 at 14:18, Alexandre Ghiti
> > <alexandre.ghiti@canonical.com> wrote:
> >> Hi Aleksandr,
> >>
> >> On Wed, Feb 2, 2022 at 12:08 PM Aleksandr Nogikh <nogikh@google.com> wrote:
> >>> Hello,
> >>>
> >>> syzbot has already not been able to fuzz its RISC-V instance for 97
> >> That's a longtime, I'll take a look more regularly.
> >>
> >>> days now because the compiled kernel cannot boot. I bisected the issue
> >>> to the following commit:
> >>>
> >>> commit 54c5639d8f507ebefa814f574cb6f763033a72a5
> >>> Author: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> >>> Date:   Fri Oct 29 06:59:27 2021 +0200
> >>>
> >>>      riscv: Fix asan-stack clang build
> >>>
> >>> Apparently, the problem appears on GCC-built RISC-V kernels with KASAN
> >>> enabled. In the previous message syzbot mentions
> >>> "riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU
> >>> Binutils for Debian) 2.35.2", but the issue also reproduces finely on
> >>> a newer GCC compiler: "riscv64-linux-gnu-gcc (Debian 11.2.0-10)
> >>> 11.2.0, GNU ld (GNU Binutils for Debian) 2.37".
> >>> For convenience, I also duplicate the .config file from the bot's
> >>> message: https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> >>>
> >>> Can someone with KASAN and RISC-V expertise please take a look?
> >> I'll take a look at that today.
> >>
> >> Thanks for reporting the issue,
> >
>
> I took a quick look, not enough to fix it but I know the issue comes
> from the inline instrumentation, I have no problem with the outline
> instrumentation. I need to find some cycles to work on this, my goal is
> to fix this for 5.17.

Thanks for the update!

Can you please share the .config with which you tested the outline
instrumentation?
I updated the syzbot config to use KASAN_OUTLINE instead of KASAN_INLINE,
but it still does not boot :(

Here's what I used:
https://gist.github.com/a-nogikh/279c85c2d24f47efcc3e865c08844138

--
Best Regards,
Aleksandr

>
> Sorry about the delay,
>
> Alex
>
>
> >
> >
> >>> --
> >>> Best Regards,
> >>> Aleksandr
> >>>
> >>>
> >>> On Tue, Jan 18, 2022 at 11:26 AM syzbot
> >>> <syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com> wrote:
> >>>> Hello,
> >>>>
> >>>> syzbot found the following issue on:
> >>>>
> >>>> HEAD commit:    f6f7fbb89bf8 riscv: dts: sifive unmatched: Link the tmp451..
> >>>> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git fixes
> >>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1095f85bb00000
> >>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=522544a2e0ef2a7d
> >>>> dashboard link: https://syzkaller.appspot.com/bug?extid=330a558d94b58f7601be
> >>>> compiler:       riscv64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> >>>> userspace arch: riscv64
> >>>>
> >>>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >>>> Reported-by: syzbot+330a558d94b58f7601be@syzkaller.appspotmail.com
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/a0769218-c84a-a1d3-71e7-aefd40bf54fe%40ghiti.fr.
