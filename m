Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C761495CC1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:22:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379728AbiAUJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 04:22:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41276 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbiAUJWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:22:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FF73B81F86;
        Fri, 21 Jan 2022 09:22:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F944C340E7;
        Fri, 21 Jan 2022 09:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642756954;
        bh=DoEBSYVdhxCk2hRPozcTctknq4n34sTJPxtSYV1nfhs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Rect2n4o+iX3RzSuMqm7blYH7Jp/hn6KvYVHNZi4gBL8iFIvMsCmxh1McTEwDN7si
         Jp36PSgZTxLoEYXNkuZPZHbuOSaCX325CmGEKFE7qdL/bJYrG4zQFtGn5SCOJLFLuv
         L3sc4NOwY7+X2UWdBb2ueG0AClbmiy7IwW458aaaf3XIv3BTv/IAj4XAqFCgdH7ih5
         t6ToBIUrsVsbMOObBDp9gxf4Mq/Pzd4XB1xuRpofrh2pf52fyeSpwwMuzAAf2V+eki
         7yzqCn4T+d70ueboR1lGAMbTJ8dL8zQnETPkZDzy+/H5QLqca4OHltjQ5kVikRSe2h
         DVpmSiH6xAKgg==
Received: by mail-ua1-f46.google.com with SMTP id 2so15760319uax.10;
        Fri, 21 Jan 2022 01:22:34 -0800 (PST)
X-Gm-Message-State: AOAM53196M1cZscAyKE2qAvkrAM3e+mKaqv9NIpY7NsFl6bZ8pNSBJ5p
        JUbWbLwtnhhEob97KdWyPRCy46GVGgmGMTI5Qh8=
X-Google-Smtp-Source: ABdhPJy/0MHzL1Lj83ABpPKlmasRjxPdpSw7edTfCXcU+fXON/ztRB09l8EfH009hsjqC4mDy1GaKsQom5NTP4rqtk4=
X-Received: by 2002:a05:6102:34ec:: with SMTP id bi12mr1057047vsb.51.1642756953041;
 Fri, 21 Jan 2022 01:22:33 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-9-guoren@kernel.org> <CAK8P3a0LxB3we9wHOa4OPmNow6wz5NP49zeYhh7QXNv-MiR8UA@mail.gmail.com>
 <CAJF2gTQVUF4LSO0a6_MV8x-UAiJw32pAFyS1oPNLXhcEaemzqg@mail.gmail.com> <CAK8P3a1sOejkdOyoRUfw4ESS7ewX_8Wj9tQNrZ40OiuDqJnrmw@mail.gmail.com>
In-Reply-To: <CAK8P3a1sOejkdOyoRUfw4ESS7ewX_8Wj9tQNrZ40OiuDqJnrmw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Jan 2022 17:22:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSzMym_PS36JgpWLQUdAO3nq+z7mdDWRT=EzQq+waPSpA@mail.gmail.com>
Message-ID: <CAJF2gTSzMym_PS36JgpWLQUdAO3nq+z7mdDWRT=EzQq+waPSpA@mail.gmail.com>
Subject: Re: [PATCH V3 08/17] riscv: compat: syscall: Add compat_sys_call_table
 implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        inux-parisc@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 4:57 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jan 21, 2022 at 7:25 AM Guo Ren <guoren@kernel.org> wrote:
> > On Thu, Jan 20, 2022 at 10:43 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Thu, Jan 20, 2022 at 8:39 AM <guoren@kernel.org> wrote:
>
> > > Are you sure these are the right calling conventions? According to [1],
> > > I think the 64-bit argument should be in an aligned pair of registers,
> > > which means you need an extra pad argument as in the arm64 version
> > > of these functions. Same for ftruncate64, pread64, pwrite64, and
> > > readahead.
> >
> > [1] has abandoned.
> >
> > See:
> > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/riscv-cc.adoc
>
> Ok, thanks for the reference, I picked the first one that came up in
> a google search and didn't expect this to ever have changed.
>
> > > I still feel like these should be the common implementations next to the
> > > native handlers inside of an #ifdef CONFIG_COMPAT.
> > >
> > > The names clash with the custom versions defined for powerpc and sparc,
> > > but the duplicates look compatible if you can account for the padded
> > > argument and the lo/hi order of the pairs, so could just be removed here
> > > (all other architectures use custom function names instead).
> > I would try it later.
>
> This becomes easier then, as powerpc and sparc already have the non-padded
> calling conventions, so you could just generalize those without looking at
> the other architectures or adding the padding. The powerpc version already
> has the dual-endian version, so using that will work on big-endian sparc and
> on little-endian riscv as well, though we may need to come up with a better name
> for the arg_u32/arg_u64/merge_64 macros in order to put that into a global
> header without namespace collisions.
Sounds good, thanks!

>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
