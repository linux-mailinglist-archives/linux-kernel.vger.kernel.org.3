Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63A64BBDDC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 17:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238102AbiBRQzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 11:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233766AbiBRQzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 11:55:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A102325AE5C;
        Fri, 18 Feb 2022 08:55:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BBBE61F8C;
        Fri, 18 Feb 2022 16:55:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741F8C340E9;
        Fri, 18 Feb 2022 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645203333;
        bh=pgtgOnne91mf4WHIxfyxxseb+GRrxggNdUTSH1ecoF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fjmDpwx3KX51Tf/RvOAb12EKpUwIMNXjB/UYZjlnld6dk09xc/LeVBYB6/9wA/haz
         pfcyWNt4MsrLMmQ/J5BRlphjdXXoNyHTAi55X+htLcINZ17ljv0xSYEOom2oGOb+Kc
         l/R7S9FuzK6nNdCyXEkrujOAwhwrJwzJtIJtLbABuP0U1NyG0X4YST3CeNkKVIXMEW
         Ff9eDZiRSJip0DqVDwQCKAK7QF3yjup1xs6QTNC7K2VmiaiRke5HT4QWRxncmp78FC
         yRIb9FhmCqGcM/4udWbl1dvBE2hQA43br9qD7boxr3PpZczi2wjV8fs2guWRC08wFc
         MINTnaJxZJnAA==
Received: by pali.im (Postfix)
        id DDE6F2BAE; Fri, 18 Feb 2022 17:55:30 +0100 (CET)
Date:   Fri, 18 Feb 2022 17:55:30 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Increase PCIe IO size
 from 64 KiB to 1 MiB
Message-ID: <20220218165530.j62nafuofe342sfi@pali>
References: <20220113170755.11856-1-pali@kernel.org>
 <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=mdEy+OA84Vx6FVCQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 February 2022 17:43:04 Arnd Bergmann wrote:
> On Thu, Jan 13, 2022 at 6:07 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > Commit 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM
> > space") increased size of PCIe MEM to 127 MiB, which is the maximal
> > possible size for allocated 128 MiB PCIe window. PCIe IO size in that
> > commit was unchanged.
> >
> > Armada 3720 PCIe controller supports 32-bit IO space mapping so it is
> > possible to assign more than 64 KiB if address space for IO.
> >
> > Currently controller has assigned 127 MiB + 64 KiB memory and therefore
> > there is 960 KiB of unused memory. So assign it to IO space by increasing
> > IO window from 64 KiB to 1 MiB.
> >
> > DTS file armada-3720-turris-mox.dts already uses whole 128 MiB space, so
> > only update comment about 32-bit IO space mapping.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Fixes: 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM space")
> 
> I just saw this is the fixes pull request, and it seems very odd. Does this
> fix an actual bug?

Do you mean this patch or commit 514ef1e62d65?

> Note that Linux normally doesn't map more than 64KB
> of I/O space per PCI domain, so it should not make a difference to us.

Last time I looked into ARM code, it can allocate more than 64 kB for IO.

> Also, note that having a high bus address for the I/O space (0xefff0000,
> as as the CPU physical address here) means that a lot of the older
> devices that actually require I/O space won't work, because they need a
> low bus address in the first few KB.
> 
> Is this mapping a requirement from a broken bootloader, or can you change
> the mapping of the I/O port window in the physical space to the usual
> bus address 0?

At physical address 0x0 it is not possible as at this address is mapped
DDR.

ARM Trusted-Firmware sets PCIe space to range [0xe8000000-0xf0000000].
This (default) configuration is specified in DTS file. Which parts of
this range is used for IO and which MEM is up to the a3720 PCIe kernel
driver and currently it configures it based on how sub-ranges are
specified in DT.

In some cases (e.g. when board has 4 GB of RAM), TF-A relocates this
PCIe range to different location (otherwise it cannot activate more than
2 GB of RAM) and U-Boot during loading of kernel DTB file, is patching
it.

It could be possible to change TF-A code to move PCIe space to different
location (from [0xe8000000-0xf0000000]) but not to 0x0. But changing it
means to move other parts and invent mapping in which most of RAM can be
mapped to...

> 
>         Arnd
