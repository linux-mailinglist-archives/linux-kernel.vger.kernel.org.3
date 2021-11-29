Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4CCD461ADF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346339AbhK2Pb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbhK2P3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:29:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B97C052914
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 05:40:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8205614DC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 13:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD6AC004E1;
        Mon, 29 Nov 2021 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638193238;
        bh=1mPhNQdmaAP5oOzTHlTQd9ACQe9dnZDwnV1997OZe8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=q003J9f7UTAZEw+i85oNjhmzhJs+gbK0svlKqeOGk/fQJ9Dkzn/dRhTo7Ggc9EV6B
         oLvfCOVqyxEaaP0Dzh4tiTtU8ag0AXpuV5C/E53AoyxAitfiyi2tUeZSuzqr0tA7D8
         hLgVIDR1IE1bTOqUoq+2CpjdqQFm91ANAl37jlGQOIEKWR/p6gsVVVRIJbOhohqXb9
         8R5EFw1qcVyk6XhbvvG7pOODgvhKiUr+7IfbCGMJ5S6JChRCAiYbGJT/rmrpH+HL6D
         aSws62t4VMx1rTeIdbW/LUmYJLr+1IuQl+dn5WxTg/DsOxYqjAuomYqARDYHCCa8nU
         3vhAjcoXcEpGg==
Date:   Mon, 29 Nov 2021 21:33:18 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     wefu@redhat.com
Cc:     anup.patel@wdc.com, atishp04@gmail.com, palmer@dabbelt.com,
        guoren@kernel.org, christoph.muellner@vrull.eu,
        philipp.tomsich@vrull.eu, hch@lst.de, liush@allwinnertech.com,
        lazyparser@gmail.com, drew@beagleboard.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        taiten.peng@canonical.com, aniket.ponkshe@canonical.com,
        heinrich.schuchardt@canonical.com, gordan.markus@canonical.com,
        guoren@linux.alibaba.com, arnd@arndb.de, wens@csie.org,
        maxime@cerno.tech, dlustig@nvidia.com, gfavor@ventanamicro.com,
        andrea.mondelli@huawei.com, behrensj@mit.edu, xinhaoqu@huawei.com,
        huffman@cadence.com, mick@ics.forth.gr,
        allen.baum@esperantotech.com, jscheid@ventanamicro.com,
        rtrauben@gmail.com
Subject: Re: [PATCH V4 0/2] riscv: add RISC-V Svpbmt Standard Extension
 supports
Message-ID: <20211129213309.40673113@xhacker>
In-Reply-To: <20211129014007.286478-1-wefu@redhat.com>
References: <20211129014007.286478-1-wefu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Nov 2021 09:40:05 +0800
wefu@redhat.com wrote:

> From: Fu Wei <wefu@redhat.com>
>=20
> This patch follows the  RISC-V standard Svpbmt extension in=20
> privilege spec to solve the non-coherent SOC DMA synchronization
> issues.
>=20
> The svpbmt PTE format:
> | 63 | 62-61 | 60-8 | 7 | 6 | 5 | 4 | 3 | 2 | 1 | 0
>   N     MT     RSW    D   A   G   U   X   W   R   V
>         ^
>=20
> Of the Reserved bits [63:54] in a leaf PTE, the bits [62:61] are used as
> the MT (aka MemType) field. This field specifies one of three memory types
> as shown in the following table=EF=BC=9A
> MemType     RISC-V Description
> ----------  ------------------------------------------------
> 00 - PMA    Normal Cacheable, No change to implied PMA memory type
> 01 - NC     Non-cacheable, idempotent, weakly-ordered Main Memory
> 10 - IO     Non-cacheable, non-idempotent, strongly-ordered I/O memory
> 11 - Rsvd   Reserved for future standard use
>=20
> The standard protection_map[] needn't be modified because the "PMA"
> type keeps the highest bits zero.
> And the whole modification is limited in the arch/riscv/* and using
> a global variable(__svpbmt) as _PAGE_MASK/IO/NOCACHE for pgprot_noncached
> (&writecombine) in pgtable.h. We also add _PAGE_CHG_MASK to filter
> PFN than before.
>=20
> Enable it in devicetree - (Add "riscv,svpbmt" in the mmu of cpu node)
>  - mmu:
>      riscv,svpmbt
>=20

I noticed that this series goes up to v4 but changes history is missing.
Will you add it?


> Wei Fu (2):
>   dt-bindings: riscv: add MMU Standard Extensions support for Svpbmt
>   riscv: add RISC-V Svpbmt extension supports
>=20
>  .../devicetree/bindings/riscv/cpus.yaml       | 10 +++++
>  arch/riscv/include/asm/fixmap.h               |  2 +-
>  arch/riscv/include/asm/pgtable-64.h           | 21 ++++++++--
>  arch/riscv/include/asm/pgtable-bits.h         | 39 ++++++++++++++++++-
>  arch/riscv/include/asm/pgtable.h              | 39 ++++++++++++++-----
>  arch/riscv/kernel/cpufeature.c                | 35 +++++++++++++++++
>  arch/riscv/mm/init.c                          |  5 +++
>  7 files changed, 136 insertions(+), 15 deletions(-)
>=20

