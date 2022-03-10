Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298C24D486A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242179AbiCJNxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242611AbiCJNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:52:56 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB1A14FBD4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:51:54 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AC287240008;
        Thu, 10 Mar 2022 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646920313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+Pwuvr+KT1sPXpC8mj8b2XwOM5OlpDST+eXmtdbpQuY=;
        b=W3AdK7m0xBr3JaJGiutph+HpGKohghqhEfZgD9aBQ2RM8YJfOYgFdhbRtKIy72cMU/WY9f
        p7XdB4TpoEucMZGcQjn0Lfhul9zYySMYh2wJrO6HbXlOFNU+ZfLWPxNT213cX8sSVvesZU
        NmtqNrpn0TCKy3YKkZ9NVsWOMOhTAicGKtdj9nG+JfNvrLn+1OXkXw3DLJI2DEoQWg2Ic3
        A3YMIpBVGXKoBBl7Q3HuiVr4YsPjI85j4MGXPRMuY03G206UeT+cR1dbOSKvO6uJ3U7QUD
        Wbr5I7nPjH5ZAxCvxtLHfrhjNtq0wXX/OcMg56/l0kaOAw7SeYCeecGDRDqUzw==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: marvell: armada-37xx: Remap IO space to
 bus address 0x0
In-Reply-To: <20220310103923.24847-1-pali@kernel.org>
References: <20220218212526.16021-1-pali@kernel.org>
 <20220310103923.24847-1-pali@kernel.org>
Date:   Thu, 10 Mar 2022 14:51:47 +0100
Message-ID: <87ee39j4p8.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Legacy and old PCI I/O based cards do not support 32-bit I/O addressing.
>
> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> 'ranges' DT property") kernel can set different PCIe address on CPU and
> different on the bus for the one A37xx address mapping without any firmwa=
re
> support in case the bus address does not conflict with other A37xx mappin=
g.
>
> So remap I/O space to the bus address 0x0 to enable support for old legacy
> I/O port based cards which have hardcoded I/O ports in low address space.
>
> Note that DDR on A37xx is mapped to bus address 0x0. And mapping of I/O
> space can be set to address 0x0 too because MEM space and I/O space are
> separate and so do not conflict.
>
> Remapping IO space on Turris Mox to different address is not possible to
> due bootloader bug.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support for =
Armada 3700")
> Cc: stable@vger.kernel.org # 64f160e19e92 ("PCI: aardvark: Configure PCIe=
 resources from 'ranges' DT property")
> Cc: stable@vger.kernel.org # 514ef1e62d65 ("arm64: dts: marvell: armada-3=
7xx: Extend PCIe MEM space")
>
> ---
> Changes in v3:
> * Rebase on v5.17-rc1
>
> Changes in v2:
> * Do not remap IO space on Turris Mox

Now it's OK !

Applied on mvebu/fixes

Thanks,

Gregory


> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 7 ++++++-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 04da07ae4420..4b377fe807e0 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -136,19 +136,24 @@
>  	status =3D "okay";
>  	reset-gpios =3D <&gpiosb 3 GPIO_ACTIVE_LOW>;
>  	/*
>  	 * U-Boot port for Turris Mox has a bug which always expects that "rang=
es" DT property
>  	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent) a=
ddress cells and
> -	 * 2 size cells and also expects that the second range starts at 16 MB =
offset. If these
> +	 * 2 size cells and also expects that the second range starts at 16 MB =
offset. Also it
> +	 * expects that first range uses same address for PCI (child) and CPU (=
parent) cells (so
> +	 * no remapping) and that this address is the lowest from all specified=
 ranges. If these
>  	 * conditions are not met then U-Boot crashes during loading kernel DTB=
 file. PCIe address
>  	 * space is 128 MB long, so the best split between MEM and IO is to use=
 fixed 16 MB window
>  	 * for IO and the rest 112 MB (64+32+16) for MEM, despite that maximal =
IO size is just 64 kB.
>  	 * This bug is not present in U-Boot ports for other Armada 3700 device=
s and is fixed in
>  	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one co=
ntains fix):
>  	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6d8f=
4ff49089dfe580f5d7
>  	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb3846297a=
d7391fc6df8ecd73bf
>  	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081fc13=
2a591ebd99ba02ee33
> +	 * Bug related to requirement of same child and parent addresses for fi=
rst range is fixed
> +	 * in U-Boot version 2022.04 by following commit:
> +	 * https://source.denx.de/u-boot/u-boot/-/commit/1fd54253bca7d43d046bba=
4853fe5fafd034bc17
>  	 */
>  	#address-cells =3D <3>;
>  	#size-cells =3D <2>;
>  	ranges =3D <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* =
Port 0 IO */
>  		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 ME=
M */
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index 673f4906eef9..fb78ef613b29 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -497,11 +497,11 @@
>  			 * with size a power of two. Use one 64 KiB window for
>  			 * IO at the end and the remaining seven windows
>  			 * (totaling 127 MiB) for MEM.
>  			 */
>  			ranges =3D <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /=
* Port 0 MEM */
> -				  0x81000000 0 0xefff0000   0 0xefff0000   0 0x00010000>; /* Port 0 =
IO */
> +				  0x81000000 0 0x00000000   0 0xefff0000   0 0x00010000>; /* Port 0 =
IO */
>  			interrupt-map-mask =3D <0 0 0 7>;
>  			interrupt-map =3D <0 0 0 1 &pcie_intc 0>,
>  					<0 0 0 2 &pcie_intc 1>,
>  					<0 0 0 3 &pcie_intc 2>,
>  					<0 0 0 4 &pcie_intc 3>;
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
