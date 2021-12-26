Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427B347F76D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 16:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbhLZPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 10:33:50 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60340 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbhLZPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 10:33:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E685460E2D;
        Sun, 26 Dec 2021 15:33:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBDCC36AEB;
        Sun, 26 Dec 2021 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640532828;
        bh=qXjCXDpcPsPTyQ6ukQoQTfDzaUiRrYwz51aMcieYhNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZD5yjJFSDFtV7GuuoWbWXv7pNHjN0oL/6U0n9XbGilI1ftdEsbLQwhXaq+KT2Ov33
         s/thjAD/g2s++3W7TXHJD5zVXxLFZJdU62TrUnGu624ct/YMRvo+Er/aN/oLulbUYK
         Nxj7R1/+G0hyCTl4Ls7J2s1B3/+q4kAqNl89ovKcoC6DQ7vVBDLxduKygzqGemVT38
         mP2717ahX/Jz+ui4KUWWibX8DekCghLY/xT3LCPBO5CaEYJRJeIlwyU2+rwmZ6YQdT
         ecTh8X20GL/jXtLOQyo7KIKwFVr80x9A19wsNB5wjbZGD9vePsCCcTOu4L+v1hOTdI
         c4Qk1bylrAM1w==
Received: by mail-ua1-f45.google.com with SMTP id r15so23209973uao.3;
        Sun, 26 Dec 2021 07:33:48 -0800 (PST)
X-Gm-Message-State: AOAM531VDvh2hrVaxSFp+6Wnd70iKTDAXnmovyyIHgFPJT5sIPUGbrrY
        tICTs0X0Q02DoSmljdRaEQVuEV2R3sUgBKHiavY=
X-Google-Smtp-Source: ABdhPJwyuGNHWPvWYsjivYwMgG2HNt6BpGFerAtNGcDQ5CFKT21wG/23KX6tdhStjNSAJxjyUtFcKM8wYL9/Nj6YrCc=
X-Received: by 2002:ab0:1e4a:: with SMTP id n10mr2054361uak.66.1640532827315;
 Sun, 26 Dec 2021 07:33:47 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-4-guoren@kernel.org>
 <CAK8P3a3navO2Z2F5zxisby5EBNDo8rwQ6hxSuyniFgFxrQ5qXQ@mail.gmail.com>
 <CAJF2gTSssufQOQTXqzRjY8h_JjAmMs8jC6R+6d09K728=4fOOA@mail.gmail.com> <CAK8P3a19n3pa+hRfC-ToTPhH2hvgYY=mXo_u6ZWkbbSSY5_JAA@mail.gmail.com>
In-Reply-To: <CAK8P3a19n3pa+hRfC-ToTPhH2hvgYY=mXo_u6ZWkbbSSY5_JAA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 26 Dec 2021 23:33:36 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTcafkH5zDYbw=6UhXaHT+SdGskt-+6E==6f08nFj33Gw@mail.gmail.com>
Message-ID: <CAJF2gTTcafkH5zDYbw=6UhXaHT+SdGskt-+6E==6f08nFj33Gw@mail.gmail.com>
Subject: Re: [PATCH 03/13] riscv: compat: Add basic compat date type implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
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
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 8:47 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Dec 22, 2021 at 1:03 PM Guo Ren <guoren@kernel.org> wrote:
> > On Wed, Dec 22, 2021 at 1:13 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > >
> > > > +struct compat_stat {
> > > > +       compat_ulong_t  st_dev;
> > > > +       compat_ulong_t  st_ino;
> > > > +       compat_uint_t   st_mode;
> > > > +       compat_uint_t   st_nlink;
> > >
> > > You should not need a compat_stat, because native rv32 does not have a
> > > stat() syscall.
> > We need it:
> >
> > $ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-
> > EXTRA_CFLAGS+=-g O=../build-riscv/ Image -j > /dev/null
> > /home/guoren/source/kernel/riscv-linux/fs/stat.c: In function 'cp_compat_stat':
> > /home/guoren/source/kernel/riscv-linux/fs/stat.c:645:21: error:
> > storage size of 'tmp' isn't known
> >   645 |  struct compat_stat tmp;
>
> I think that's just a bug in fs/stat.c. Every other architecture so
> far needed it,
> just not riscv, so we should add an appropriate #ifdef here. I would replace
> #ifdef CONFIG_COMPAT around these with __ARCH_WANT_COMPAT_STAT
> and then change all other compat architectures to define that depending
> on the configuration.
Agree, but I would keep compat_stat in the next version. You could add
__ARCH_WANT_COMPAT_STAT next.

>
>         Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
