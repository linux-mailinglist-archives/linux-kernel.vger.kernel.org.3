Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0327347D28B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 13:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245091AbhLVM7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 07:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240607AbhLVM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 07:59:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E26C061574;
        Wed, 22 Dec 2021 04:59:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36A9F61A7C;
        Wed, 22 Dec 2021 12:59:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EF7C36AF0;
        Wed, 22 Dec 2021 12:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640177982;
        bh=yUSezh8Ez/4HnaaaU0t9sScXTKUzFtDICzw9rplOwh0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=teDDEUsCwvex4tZ2ZwW3mE3BDbioJzh6ah9QQqpJPQv41CnQfcZLSO4mR9ADrYSZi
         ywiW0eJE7onT76oEV1r0fbfbVBk6wT6U+LfCqCkAxl1ht5oLxzpoHQjBOd6ndI22tv
         dOs1Ux8E342t3H5L4D5E2PdoEulbF53NNKuX/9GWJdqQcpcbg7uUpHI9EGIqvRazQH
         G0JtLaj/utYbh+vONZJtGNQrCRQu0ODOdBP8sFcom9qi1eq7iaz6O1RxFoq46sO8HO
         RNlEqxnRN3hOlbScuipxCHUQUEIo0JlJlubUDb3c6fcx608RkfO5hdpSNVs3RBmP4T
         OVKOs8eeMQ6Xw==
Received: by mail-ua1-f53.google.com with SMTP id r15so4258002uao.3;
        Wed, 22 Dec 2021 04:59:42 -0800 (PST)
X-Gm-Message-State: AOAM531ioeSqmRunOpHsaCWSUGqxZfzXrO4ESCj4oY7x1v25oRaHGm5u
        ja2CLKVPMnPtCJKuNzWorA/C6dLYLjXBY3Yoq4I=
X-Google-Smtp-Source: ABdhPJyvA90AYgsDJpACv4jKWJAgkxalQ5p2v7+W5kBRXr/Xc9BYymsguHUx4AuTbEdXG1Bmqk1TknlK03LuwOJei2s=
X-Received: by 2002:a67:f94b:: with SMTP id u11mr858030vsq.51.1640177981532;
 Wed, 22 Dec 2021 04:59:41 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
In-Reply-To: <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 20:59:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
Message-ID: <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
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

On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> >
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> > s390, mips, sparc) have supported COMPAT mode. But they all have
> > history issues and can't use standard linux unistd.h. RISC-V would
> > be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> > /unistd.h.
> >
> > The patchset are based on v5.16-rc6, you can compare rv64-compat32
> > v.s. rv32-whole in qemu with following step:
>
> Looks good overall, see my individual replies for minor comments I had.
Thx for the review :)

>
> I think there is a bigger question to answer though, which is whether this is
> actually a useful feature for rv64. In general, there are two reasons for
> wanting compat mode:
>
> a) compatibility with existing binaries and distros
>
> b) reducing the memory footprint of user space in a memory constrained
> environment, either deeply embedded or in a container.
>
> For the other architectures, a) is clearly the main driver, but equally so
> this is not the case on riscv, which does not have any legacy 32-bit
> code. Without that, adding compat mode would mainly introduce a
> second ABI to a lot of environments that at the moment only need to
> support one, and that adds complexity to the implementation and
> the extra attack surface of the second syscall ABI when an exploit
> may be possible only in compat mode.
>
> There is still some benefit in b), but it would need to be weighed
> against the downsides above. Can you explain in more detail what
> use cases you have in mind, and which CPU cores actually support
> this mode?
The most reason is about b), see our customer's product:
https://www.cnx-software.com/2021/10/25/allwinner-d1s-f133-risc-v-processor-64mb-ddr2/

So I think all our next generation rv64 cores should support
compat-mode. Compare to releasing rv32-full core, rv64 compat-mode is
very cheap for our CPU design.

You would get the answer when our new generation CPU is announced and it's soon.

Currently, only qemu supports rv64 compact mode, that is my colleague
(LIU Zhi Wei) contributed.

>
>          Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
