Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403CD494EE4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbiATN1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiATN1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:27:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA07C061574;
        Thu, 20 Jan 2022 05:27:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12A87B81D06;
        Thu, 20 Jan 2022 13:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3590C340F4;
        Thu, 20 Jan 2022 13:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642685240;
        bh=nij2NveTxD7AFS+dy/E2mbGaK4KnuKanTl6xzPnPkQc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FV+LquNrcNIM4IyWdRQJ+RvURALdqn9xfCmH3u+EPyPxG/8iNUaCslKvqNdupslBw
         QBRP2q+FNxO6+wSFKXMyFDUNcAy6V3evf7SWZUwB8rE9gCJk0lFv2usPRlA4tmXnjW
         vRGqr4TSyisCJv6r/7+ohMVsNxAxtBY3zte/1y5zEGDFC5uZXE7MNp3XDVrgmwwKCy
         AGAIguEIxRllBb8wrI5vQZ0cZFle3X27KHhHktX3rhu2eQxIiCHXn4K2loU116xQoc
         RLuRjDVXG8TasUHF/D9VQs3KiylNZRmOC3843iD+ztRTmijocFRzUI+MmuAOojOLAW
         /CrONDsZ7cwvg==
Received: by mail-vk1-f177.google.com with SMTP id l196so679518vki.5;
        Thu, 20 Jan 2022 05:27:20 -0800 (PST)
X-Gm-Message-State: AOAM532JXnA8i+RIAeGNMzXTWOrSyrejCuLKQPEOAk9zlegcPUoQxHlF
        gHjMRn7MGAMyTUNMX9y7T5SsQ6lbygGA4FLnIz8=
X-Google-Smtp-Source: ABdhPJwXq7rWM9TR2/dX3Ce8RNnGwk7ErUknPTqNCDOUbla5Lz39Gh+9ETVvKbMYpePGn1XdP3gT3y8Rtd9l9zviaqA=
X-Received: by 2002:ac5:cbc8:: with SMTP id h8mr12691275vkn.8.1642685239536;
 Thu, 20 Jan 2022 05:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20220120073911.99857-8-guoren@kernel.org> <CAK8P3a1UvqsS-D7cVXBkp4KCRWDfquQ6QTkvrQ=FqLxhsAi7Rw@mail.gmail.com>
 <f16cf10425a14c2e8183d5c90667ce72@AcuMS.aculab.com>
In-Reply-To: <f16cf10425a14c2e8183d5c90667ce72@AcuMS.aculab.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Jan 2022 21:27:08 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRwh40xDBkoRJWZEUketKFDAy7_z=-WW7E=T46yH4zPvw@mail.gmail.com>
Message-ID: <CAJF2gTRwh40xDBkoRJWZEUketKFDAy7_z=-WW7E=T46yH4zPvw@mail.gmail.com>
Subject: Re: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
To:     David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup@brainfault.org>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "inux-parisc@vger.kernel.org" <inux-parisc@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 8:53 PM David Laight <David.Laight@aculab.com> wrote:
>
> > > Limit 32-bit compatible process in 0-2GB virtual address range
> > > (which is enough for real scenarios), because it could avoid
> > > address sign extend problem when 32-bit enter 64-bit and ease
> > > software design.
>
> Eh?
> I thought nearly all the other 32bit unix ports (of any flavour)
> put the user-kernel boundary at 3GB.
No, riscv32 is about 2.4G, csky is 2G/2.5G.

> (Apart from some very old sparc ones that use 3.5GB.)
>
> 2GB is used by Windows.
>
> I think the x86-64 32bit compat code even puts the boundary at 4GB.
Yes, we could give rv32 compat for 4GB with some effort. But it's unnecessary.

There are no history issues for rv32, we use compat mode to reduce
memory footprint. eg: only 64MB memory available.

At end compat for 4GB is another topic, let's give the initial compat
for 2GB support to riscv.

>
>         David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
