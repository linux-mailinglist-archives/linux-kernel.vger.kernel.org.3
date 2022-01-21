Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCA1495C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 10:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379053AbiAUJCy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Jan 2022 04:02:54 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:49807 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349019AbiAUJCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 04:02:39 -0500
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1F28AE000C;
        Fri, 21 Jan 2022 09:02:33 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Increase PCIe IO size
 from 64 KiB to 1 MiB
In-Reply-To: <20220113170755.11856-1-pali@kernel.org>
References: <20220113170755.11856-1-pali@kernel.org>
Date:   Fri, 21 Jan 2022 10:02:33 +0100
Message-ID: <878rv95umu.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Rohár <pali@kernel.org> writes:

> Commit 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe MEM
> space") increased size of PCIe MEM to 127 MiB, which is the maximal
> possible size for allocated 128 MiB PCIe window. PCIe IO size in that
> commit was unchanged.
>
> Armada 3720 PCIe controller supports 32-bit IO space mapping so it is
> possible to assign more than 64 KiB if address space for IO.
>
> Currently controller has assigned 127 MiB + 64 KiB memory and therefore
> there is 960 KiB of unused memory. So assign it to IO space by increasing
> IO window from 64 KiB to 1 MiB.
>
> DTS file armada-3720-turris-mox.dts already uses whole 128 MiB space, so
> only update comment about 32-bit IO space mapping.
>
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Fixes: 514ef1e62d65 ("arm64: dts: marvell: armada-37xx: Extend PCIe
> MEM space")

Applied on mvebu/fixes

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index dd01409d4bb7..23e1b07c060a 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -153,7 +153,7 @@
>  	 * 2 size cells and also expects that the second range starts at 16 MB offset. If these
>  	 * conditions are not met then U-Boot crashes during loading kernel DTB file. PCIe address
>  	 * space is 128 MB long, so the best split between MEM and IO is to use fixed 16 MB window
> -	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal IO size is just 64 kB.
> +	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller supports 32-bit IO mapping.
>  	 * This bug is not present in U-Boot ports for other Armada 3700 devices and is fixed in
>  	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one contains fix):
>  	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f4ff49089dfe580f5d7
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> index 1c74f02535c6..8d59eabadce6 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -508,12 +508,12 @@
>  			/*
>  			 * The 128 MiB address range [0xe8000000-0xf0000000] is
>  			 * dedicated for PCIe and can be assigned to 8 windows
> -			 * with size a power of two. Use one 64 KiB window for
> +			 * with size a power of two. Use one 1 MiB window for
>  			 * IO at the end and the remaining seven windows
>  			 * (totaling 127 MiB) for MEM.
>  			 */
>  			ranges = <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /* Port 0 MEM */
> -				  0x81000000 0 0xefff0000   0 0xefff0000   0 0x00010000>; /* Port 0 IO */
> +				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0 IO*/
>  			interrupt-map-mask = <0 0 0 7>;
>  			interrupt-map = <0 0 0 1 &pcie_intc 0>,
>  					<0 0 0 2 &pcie_intc 1>,
> -- 
> 2.20.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
