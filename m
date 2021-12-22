Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E72C47D26A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241041AbhLVMrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:47:06 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:50637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240938AbhLVMrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:47:05 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M3UhQ-1mzSmz4946-000bDP; Wed, 22 Dec 2021 13:47:04 +0100
Received: by mail-wr1-f50.google.com with SMTP id s1so4736324wrg.1;
        Wed, 22 Dec 2021 04:47:03 -0800 (PST)
X-Gm-Message-State: AOAM532PQMcTNLUhPLl4QvD6CI87/wOZU0ZRQWuVOxACl6Airr0NMogB
        79Ld7KcfVx/dWrDeYPRtvB4A3eIlAOwlpCLEVE0=
X-Google-Smtp-Source: ABdhPJzGHS+0FSFJawmPN4qrozHG2jZvyHLpVVATumqQCoz0M2O4wCbSVKWRKxMVEP1zq7AFGcfzbsz2Xb2ui4JNRRk=
X-Received: by 2002:adf:a352:: with SMTP id d18mr2002955wrb.317.1640177223561;
 Wed, 22 Dec 2021 04:47:03 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-4-guoren@kernel.org>
 <CAK8P3a3navO2Z2F5zxisby5EBNDo8rwQ6hxSuyniFgFxrQ5qXQ@mail.gmail.com> <CAJF2gTSssufQOQTXqzRjY8h_JjAmMs8jC6R+6d09K728=4fOOA@mail.gmail.com>
In-Reply-To: <CAJF2gTSssufQOQTXqzRjY8h_JjAmMs8jC6R+6d09K728=4fOOA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 13:46:47 +0100
X-Gmail-Original-Message-ID: <CAK8P3a19n3pa+hRfC-ToTPhH2hvgYY=mXo_u6ZWkbbSSY5_JAA@mail.gmail.com>
Message-ID: <CAK8P3a19n3pa+hRfC-ToTPhH2hvgYY=mXo_u6ZWkbbSSY5_JAA@mail.gmail.com>
Subject: Re: [PATCH 03/13] riscv: compat: Add basic compat date type implementation
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
X-Provags-ID: V03:K1:okWP2cEJQb5j3qXWuw0s51Vq8YIqRuxL2xCho+ILaiSGTbU5PXV
 ZBr6OlAX1BAujwV+sxJmx92t7JctDrKiht5sqnXcPIyMSsc34ovAxC2EDu0SccqNFK6govE
 1tQMKO+NuqMxO3sW3YcHuzjBntmdoBiMwVn+4KedBR2VgqMTdEQrVgQygR6wXbTGy5yWrIH
 jDcHFXtnrPNrXkNIzrhfA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WH3rUV9UEek=:w0ylpz7RyCxCJxPfrMy7sv
 s7GhtHxCO2o7TuA36k4D0pHk2m/29LWQMlyyxQkP9NpSpkE8Y/GmE9HoOfRdu2ll+F8OqtHfa
 RJff5mC2obPPCferRiSk6/bET9xS1QE6lox1L/9BcXGc16VwYVHyUfD3GURHhDUCfUjW1Koxq
 5IJVTlMiN5AHzTj1tUyo9GRWpc2vALkz1Q0G8+Y4ejjcXsjDA0bAH01wSOsmmkspcERyK5CN8
 2p1fko2Y2h3GcKSX55wvip1sEWa9+Eaz+YD5lm6KF9c7eU9FNbdlx7o0uPad6XzRVneUPYax0
 81bwU8UFn6zs+RCMD+1mSS/6ZXnhnJu8Yt6AQDOEGZULBavvx0UJVzDpWXVw3m29TOkWUC5cr
 XDrrssnzH7vZXetMxnIGOcQJPdO+kwIJvo2GilJrLhqXck8NieS4Jv/qlFQc1rYMzTKcpZ2a/
 N/dMZytTHNvtFXebIo3MNTQS2U58qzUpTgokRuuDrd3yd5nb6Sym7P/qyglZW3zPL77yyIRAY
 SElJzD+1FOm5s1oC68Oiy6eUyS0Brsqd/r4YmtpdDG+Jr8OYL9BaU1ClzVrdDgZJ1NMnpdngh
 j8MacWuZklwUAy8ouHfZuE7FHeLIRRgW4PBie6lr/j/pupIpW0zAmdUMQ9VNJk8CKCCPtndpm
 F79GfxI9mAhVSj0rY85B5Y6fvhLS4B+6LJMrMV+DevCO9hu0SVhphm+87fnpB/5ivXP9RsQt5
 o3Mh+5nuiFdtbQ07GQ7OwojCJ+rT9HBAH0y9KSjoek/P+IK02xri1rJYVyYSRlXWfi0mQDFTg
 4Bp2y0OJI1bFrY9VCZMUCyVMyMD84ls4ioHVIYEdjmr4m9WLSM=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 1:03 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 1:13 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> >
> > > +struct compat_stat {
> > > +       compat_ulong_t  st_dev;
> > > +       compat_ulong_t  st_ino;
> > > +       compat_uint_t   st_mode;
> > > +       compat_uint_t   st_nlink;
> >
> > You should not need a compat_stat, because native rv32 does not have a
> > stat() syscall.
> We need it:
>
> $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-
> EXTRA_CFLAGS+=-g O=../build-riscv/ Image -j > /dev/null
> /home/guoren/source/kernel/riscv-linux/fs/stat.c: In function 'cp_compat_stat':
> /home/guoren/source/kernel/riscv-linux/fs/stat.c:645:21: error:
> storage size of 'tmp' isn't known
>   645 |  struct compat_stat tmp;

I think that's just a bug in fs/stat.c. Every other architecture so
far needed it,
just not riscv, so we should add an appropriate #ifdef here. I would replace
#ifdef CONFIG_COMPAT around these with __ARCH_WANT_COMPAT_STAT
and then change all other compat architectures to define that depending
on the configuration.

        Arnd
