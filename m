Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF09488315
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 11:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbiAHKrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 05:47:19 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:38685 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbiAHKrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 05:47:18 -0500
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 208AkoOZ017944;
        Sat, 8 Jan 2022 19:46:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 208AkoOZ017944
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641638811;
        bh=3ycalqzctzTSUeksLXb1B1zcoh1yoLaA2eeGA2udKgE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nxB0dkCAdIKEY3U1R9AMvAFhRbStglwyjRRBjIEKhAj+7opxThVdNfWkizXTEaxtq
         cBwR7RYixkTq1TK3jgSYO20AXDADKAEkbZyvpMi6OI3eE+sISgXRYiJBMp4mP/ecCg
         Ru3UB5jVrCbwus3+oNWdOlQaCFtkZ7G+L3SK0PEzhvSeJGxCnEIwh2Avykq3SJBPpu
         rD0aDkmPu7ZTlpvfpI3Ao5N3u2bWDWDBJe+ZE3vBJ7nFn1SSb79zg/kBZcQe8CLT0f
         e4J4fCIPYdSKsinemPdN05zJ8YzKvrQZLjpBl9hLasG7vPtv9jOu2I/1ju/OBkKjGf
         kFHRDDMIjw0Wg==
X-Nifty-SrcIP: [209.85.215.175]
Received: by mail-pg1-f175.google.com with SMTP id t135so339494pgb.4;
        Sat, 08 Jan 2022 02:46:50 -0800 (PST)
X-Gm-Message-State: AOAM532tZ4KrBZ0ntdXvRSPJG/lGafhdhkbWel/03dpF326b0N3RjCA6
        /lg/Iw0eBZOL8N9dyUjpgDJ0dVpir+YMYgK6ddE=
X-Google-Smtp-Source: ABdhPJz01dludZDhtrS+2CPgi+C09X+bQCFteAIei7qLMuS+NUgvSx7KXHHR9Y7tuvz/mYZKHniY+GL3Ds8t8vJvNn8=
X-Received: by 2002:a05:6a00:1484:b0:4bb:86a:c061 with SMTP id
 v4-20020a056a00148400b004bb086ac061mr67863230pfu.36.1641638809733; Sat, 08
 Jan 2022 02:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20220107171319.0afa619a@canb.auug.org.au> <20220107172206.3fbdd09f@canb.auug.org.au>
 <20220108171424.669e37d6@canb.auug.org.au>
In-Reply-To: <20220108171424.669e37d6@canb.auug.org.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 8 Jan 2022 19:46:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT9c+_pVyfPA_XfhjSFCifDX3P9JNrbsF6-38Yh=1t69g@mail.gmail.com>
Message-ID: <CAK7LNAT9c+_pVyfPA_XfhjSFCifDX3P9JNrbsF6-38Yh=1t69g@mail.gmail.com>
Subject: Re: linux-next: much more building going on
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 8, 2022 at 3:14 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Fri, 7 Jan 2022 17:22:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Fri, 7 Jan 2022 17:13:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Since yesterday, my builds are taking much longer and it seems just
> > > about everything is being rebuilt when there should be very little done.
> > >
> > > One example is after mergeing the clockevents tree, the diffstat looks
> > > like this:
> > >
> > > $ git diff --stat HEAD^..
> > >  .../devicetree/bindings/timer/cdns,ttc.yaml        |   3 +
> > >  .../bindings/timer/mstar,msc313e-timer.yaml        |  46 ++++
> > >  .../devicetree/bindings/timer/nxp,tpm-timer.yaml   |   6 +-
> > >  .../devicetree/bindings/timer/renesas,ostm.yaml    |  20 +-
> > >  .../bindings/timer/rockchip,rk-timer.yaml          |   1 -
> > >  MAINTAINERS                                        |   1 +
> > >  drivers/clocksource/Kconfig                        |  12 +-
> > >  drivers/clocksource/Makefile                       |   1 +
> > >  drivers/clocksource/exynos_mct.c                   |  52 +++--
> > >  drivers/clocksource/renesas-ostm.c                 |  39 +++-
> > >  drivers/clocksource/timer-imx-sysctr.c             |   6 +-
> > >  drivers/clocksource/timer-msc313e.c                | 253 +++++++++++++++++++++
> > >  drivers/clocksource/timer-pistachio.c              |   3 +-
> > >  13 files changed, 411 insertions(+), 32 deletions(-)
> > >
> > > but my powerpc and arm builds rebuilt basically everything.
> > >
> > > This happens for a lot of merges - though some do not rebuild very much
> > > at all.
> > >
> > > Any ideas about what changed yesterday?  (I directed this to the kbuild
> > > tree maintainer since the kbuild tree was updated yesterday - though
> > > that may be a coincidence).
> >
> > OK, it *may* have something to do with Kconfig file updates for example with this diffstat:
> >
> >  .../memory-controllers/synopsys,ddrc-ecc.yaml      |  1 +
> >  drivers/edac/Kconfig                               |  2 +-
> >  drivers/edac/amd64_edac.c                          | 36 ++++++++++++++-
> >  drivers/edac/amd64_edac.h                          |  8 +++-
> >  drivers/edac/edac_mc.c                             |  2 +
> >  drivers/edac/sb_edac.c                             |  2 +-
> >  drivers/edac/sifive_edac.c                         |  2 +-
> >  drivers/edac/synopsys_edac.c                       | 52 ++++++++++++++++++----
> >  drivers/ras/cec.c                                  |  2 +-
> >  include/linux/edac.h                               |  6 +++
> >  10 files changed, 98 insertions(+), 15 deletions(-)
> >
> > And only this Kconfig change:
> >
> > $ git diff HEAD^.. drivers/edac/Kconfig
> > diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> > index 2fc4c3f91fd5..58ab63642e72 100644
> > --- a/drivers/edac/Kconfig
> > +++ b/drivers/edac/Kconfig
> > @@ -484,7 +484,7 @@ config EDAC_ARMADA_XP
> >
> >  config EDAC_SYNOPSYS
> >         tristate "Synopsys DDR Memory Controller"
> > -       depends on ARCH_ZYNQ || ARCH_ZYNQMP
> > +       depends on ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA
> >         help
> >           Support for error detection and correction on the Synopsys DDR
> >           memory controller.
> >
> > I noticed that the following files have changed (timestamp at least) in
> > the object directory:
> >
> > -rw-r--r-- 1 sfr users    46271 Jan  7 17:09 ./include/config/auto.conf.cmd
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_TCP_CONG
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_INIT
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/BUILD_SALT
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_SYSTOHC_DEVICE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_TARGETS
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_IMPLICIT_FALLTHROUGH
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/RTC_HCTOSYS_DEVICE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/EXTRA_FIRMWARE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/DEFAULT_HOSTNAME
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CC_VERSION_TEXT
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MODPROBE_PATH
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LOCALVERSION
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/INITRAMFS_SOURCE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/FAT_DEFAULT_IOCHARSET
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/CMDLINE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/NLS_DEFAULT
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/MAGIC_SYSRQ_SERIAL_SEQUENCE
> > -rw-r--r-- 1 sfr users        0 Jan  7 17:09 ./include/config/LSM
> > -rw-r--r-- 1 sfr users    54294 Jan  7 17:09 ./include/generated/autoconf.h
> > -rw-r--r-- 1 sfr users    39198 Jan  7 17:09 ./include/config/auto.conf
> >
> > then lots more is rebuilt.
>
> Bisection points to commit
>
>   33c1957574b6 ("kbuild: do not quote string values in include/config/auto.conf")
>
> from the kbuild tree and indeed if I revert commits
>
>   ec769168623b ("microblaze: use built-in function to get CPU_{MAJOR,MINOR,REV}")
>   98bb79d61f0c ("certs: move scripts/extract-cert to certs/")
>   33c1957574b6 ("kbuild: do not quote string values in include/config/auto.conf")
>
> from the merge of the kbuild tree into linux-next (up to that point),
> the problem goes away.
>
> My test case is this:
>
> $ rm -rf ../test
> $ mkdir ../test
> $ make ARCH=powerpc O=../test -s ppc64_defconfig
> $ make ARCH=powerpc O=../test -j40 -O init/main.o
> (edit drivers/edac/Kconfig as above)
> $ make ARCH=powerpc O=../test -s ppc64_defconfig
> $ make ARCH=powerpc O=../test -j40 -O init/main.o
>
> In the good case, none of the files in ../test/include/config
> representing CONFIG_ options are changed and init/main.o is not
> rebuilt.  In the bad case some of the files above (in
> ../test/include/config) are touched and init/main.o is rebuilt.
>
> Please see if you can figure out what actually is wrong with
> 33c1957574b6 or else remove those commits from the kbuild tree (or
> revert them).  This extra rebuilding is adding about 7 hours to my day
> :-(


Sorry for the annoyance.
As you noticed, this is a bug of 33c1957574b6.

I fixed it and updated linux-kbuild/for-next.

Hopefully, it should be fine for monday's linux-next.



-- 
Best Regards
Masahiro Yamada
