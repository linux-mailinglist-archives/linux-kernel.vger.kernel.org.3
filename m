Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8191447F9A0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 02:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhL0BQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 20:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhL0BQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 20:16:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2302C06173E;
        Sun, 26 Dec 2021 17:16:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E310B80E66;
        Mon, 27 Dec 2021 01:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E993AC36AF6;
        Mon, 27 Dec 2021 01:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640567772;
        bh=/z7kme4bAiwTLDdXUCZwIBJQhAMqQrAiPXS4+K/K59I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KQtMqOjbQ/OdSkeUH4PBiKSq7gjg3i+63PKzbqlFEos0Z0Q4cZxxwB+NsdbDrp0E1
         GjCYdqcMVEUBLPeEpOp3Kctg/KAci4YC8HJ6Kc/Tw3r754wphyVOE/grAEHJqeqDBy
         +zmgvx8r+joB8av4xPPkuJOlekE/MHRCuTPbBRJBJDrdYS8vtHI0z4aUI2agrNXj7X
         qV6heQfcBVXMTyP6FV5v/AuEfn7HiBLd+d8xYFX3ww8ZK0gssr2ud9WBlaveKeWsYL
         DJlUvkVeS9t7NWjzqzyVfIZHEEGirsTqbdZmiHPAM334NqdL7PEQZG/8PxjXSLDbBI
         /nzF9SGXyQCmg==
Received: by mail-ua1-f46.google.com with SMTP id u6so17236416uaq.0;
        Sun, 26 Dec 2021 17:16:12 -0800 (PST)
X-Gm-Message-State: AOAM532Hf43SntiIPpUjoXnO/40/xEGoG1nISNLiRDl23uu9Pu+QZb1P
        1N+g6JuVwHMNwuFX0fHw5Ko1Q0thP+92CeIr364=
X-Google-Smtp-Source: ABdhPJwCZOVhpDI9dtpcpVNVGGROplltq8Ye3VEk3SxSC9+3ldiUZ6rezfBGzESvhn3WsG4SgZ6YkH+M5aBUejD1p70=
X-Received: by 2002:a05:6102:a83:: with SMTP id n3mr4298119vsg.2.1640567771713;
 Sun, 26 Dec 2021 17:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <CAK8P3a37+0=CCE7283VQ4QZ1tZqcU+A2POUGXtvdM46ZMHx-gw@mail.gmail.com>
 <CAJF2gTRAxX0qEcNmw+5N=3jZcJw9YF75oRjT7Y5FUMUkHoSz4Q@mail.gmail.com>
 <20211226162223.795f9417@xhacker> <CAJF2gTRHND1F_-5+Euzy-UdRRdg2oAXDY4dt8_5p9JxsHDSe6Q@mail.gmail.com>
 <CAK8P3a08kawHpz6RsLZsvNNn0_WKaFWRU-7M4fJ3e7i7J+GQcA@mail.gmail.com>
In-Reply-To: <CAK8P3a08kawHpz6RsLZsvNNn0_WKaFWRU-7M4fJ3e7i7J+GQcA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Dec 2021 09:16:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ04utyOc9=q9Tu92togGuyygKgq3tWwfPBCuyTfLh2SQ@mail.gmail.com>
Message-ID: <CAJF2gTQ04utyOc9=q9Tu92togGuyygKgq3tWwfPBCuyTfLh2SQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jisheng Zhang <jszhang3@mail.ustc.edu.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
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

On Mon, Dec 27, 2021 at 4:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Sun, Dec 26, 2021 at 7:38 AM Guo Ren <guoren@kernel.org> wrote:
> > On Sun, Dec 26, 2021 at 4:36 PM Jisheng Zhang <jszhang3@mail.ustc.edu.cn> wrote:
> > > On Wed, 22 Dec 2021 20:59:30 +0800 Guo Ren <guoren@kernel.org> wrote:
> > > > On Wed, Dec 22, 2021 at 2:10 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > >
> > > What about adding RV64 ILP32 support instead? This don't need HW side
> > > modifications so can benefit all RV64.
> >
> > ILP32 is another topic in C Language Data Type Models and it couldn't
> > replace the standard rv32 ecosystem.
> > COMPAT is a common framework in Linux (7 arches have been supported),
> > so let rv64 support COMPAT mode is considerable.
> >
> > Customers would choose ILP32 / RV32-compat by themself and that
> > depends on which one has a better ecosystem.
>
> From a kernel perspective, supporting both is not much more work than
> supporting either of them. We had the same debate for Arm64, and ended
> up never merging the ILP32 patches despite them being well written
> and maintainable, to limit the number of supported user space ABIs
> as well as the possible attack vectors when there is an exploitable
> bug that is specific to an ABI.
>
> arm64 does support big-endian mode, which is a similar niche, but it
> can't easily be removed after it's already supported. Supporting normal
> compat mode is the easiest here because it doesn't add another user
> space ABI, but I'd strongly recommend not to add any other ones.

@Palmer Dabbelt How do you think about supporting ILP32 & COMPAT both
in rv64? And let users vote by foot which is better.

>
>        Arnd



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
