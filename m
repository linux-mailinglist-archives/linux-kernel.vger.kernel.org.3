Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECED147D0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 12:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhLVLZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 06:25:11 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:55025 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbhLVLZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 06:25:10 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MCsLu-1n8pRl0Si8-008oI0; Wed, 22 Dec 2021 12:25:09 +0100
Received: by mail-wr1-f41.google.com with SMTP id d9so4324969wrb.0;
        Wed, 22 Dec 2021 03:25:09 -0800 (PST)
X-Gm-Message-State: AOAM533TFrFWtQgYmBB9y2qJ6LtTAuZ3NGeQpurHRnfoPpynpFxTfx13
        PXadfhYgEFiEmGaf1ZX0OaHBBMwVS5r8USK1l+I=
X-Google-Smtp-Source: ABdhPJyzTQEUJiZGgYouqu/F3g2sBUQ8LPZJZWS9OtjFPbJzgfkwT3GGQ8ezpmjyngodUiRN0dk6hAlvyjeBwblBf7Y=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1784540wru.12.1640172308745;
 Wed, 22 Dec 2021 03:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-2-guoren@kernel.org>
 <CAK8P3a1fC8aro3kHLvGMVDdvVYjaQdxJeGur9ac=11+6=r0Xyg@mail.gmail.com> <CAJF2gTQciNaXk+_am=kS2uSwg6oGM4aJqiw_O5KN-DrHetf8nA@mail.gmail.com>
In-Reply-To: <CAJF2gTQciNaXk+_am=kS2uSwg6oGM4aJqiw_O5KN-DrHetf8nA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 12:24:52 +0100
X-Gmail-Original-Message-ID: <CAK8P3a38C500PhRP3BysRap-ajhU3NJ-KWJQnoGaCH7aV+xoJQ@mail.gmail.com>
Message-ID: <CAK8P3a38C500PhRP3BysRap-ajhU3NJ-KWJQnoGaCH7aV+xoJQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ISlB8l29QTzUd4Gia0neDsfvLh8WJQNxxBbYFzLnQR1lhqoWIgb
 ARfv2qh9eGwjbGpUucJ+jMYhQGpH6l3jw6h2/ixV2/rFSQ6FSbEy9sR/MWxZRrbNgzZQD89
 CVqzfzuDtlZoZlJgodViGR+s/8Tnqnruvq4LWSYMuWRry8yzcXfqcPQfv4cDYa77AKy5qF4
 RzE77m7QH9FK2uPHqLIyw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nx14faxvDBw=:rabZgZ4lWB4WGJpry3rslz
 gGBXJ/yowr6r587Ksn0oZ3W19cU/e+FMf8kuCUefmCLJhPmDfc11Gk576+D+9NZgP9l6SJfcl
 JqddrumDmj+/dQyN9OBA11M2eLVH1NRl6iYmvVXkXl95EDIxn5w/PSyRpyBfhq0upqVh8u9Nh
 QqB0Y+1fqmjJCQ0Lpk780WIfm7Gz2mVISAxz/Bqn5lNfkTqfxLxsgPnja/cWNh4anxtjlJ6Wj
 u/kQfFN6KjAX/aMAUa1e1jADdtMQpSybapjm8vWi9piYYNKlYjl3yNxyaK+AECMEL/aA4eVI1
 zWls/Mx8uCUfgmPFQq86ZBTtB9GtvfrsDgIJ27NFENeUdBYiCM7a0XndYimIa4z9otNvYbfNa
 6zsEKl1Yejcv0FyONC9l2eWsWr/jyTECcH5RofvYdNeEJ4WAiJCMJPopq7CkGNidatU0uLFq1
 CCj/k+GMEWzFjfZlzb/tJdsS/RoIqH1WGVKZI8T5zb0PdSc+NCRAgdq+CJ0BzK2DNGsmk1DKN
 0kKWFJ5oArra5vPtV1D8t6uxRJs6G8+FLvV17BPux3TJI5Czi6GxIufgbsKFIx/1Bs65TI0S7
 QXvZ0JFlNHEdTgijs17Uz3t9aUOVA7p+A6tmeDayz2r+DIWo4L8FlHLMgIDOaBZ4c/t5XKMLo
 AxcjpBQ+0TVptQqGORu+UBKIdhskT6GCBm0a4m52rC/KSOVcMIEo1vU+G5X/8T+DQp6iGr1uM
 Ql4PaZbeGa43O4772mZYldZjU1uazLqhhkc6pc57XCVy++HGmpERNzmFuoONSPMi74sk2FssK
 0ciErfPo/ZjnrzXf9mYiCAMCV5Kuhr+rCNr9GE8oCnKCKv6QL8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 12:16 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > >  /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
> > > -#if __BITS_PER_LONG == 32
> > > +#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
> > >  #define __NR_clock_gettime64 403
> > >  __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
> >
> > This part looks wrong, you expose clock_gettime64 to user space this way, both
> > in asm/unistd.h and in the table.
> >
>
> No, we only define __SYSCALL_COMPAT in compat_syscall_table.c. It
> won't be expose to user space, because there is no __SYSCALL_COMPAT.

Ok, it looks good then. It feels like we should have a macro to wrap this, but
in reality what we should actually do is to convert the entire file to the
more modern syscall.tbl format, so let's just stay with your version.

      Arnd
