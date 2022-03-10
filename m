Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC094D446C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 11:23:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241178AbiCJKYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 05:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiCJKYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 05:24:38 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D209AEDF25
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 02:23:34 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A546E24000D;
        Thu, 10 Mar 2022 10:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646907813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5QlkG0Yk6rlOSIS9fyw+RpNZ0vcoYZG+oYxg92O6ZcU=;
        b=XGcWQfkJ+iTF9exGdtsYJ3vgGz6AtM7oL6mDLCg0ezqySnzV3E7896d99zAVW0ZXk8VLGw
        WezI84Tl3X7L85zfsFwkBq3ZTl7gVxlXbZHIqnLuDKXpM57ZS1PvaD+pCLB8zEyPYdXfkc
        FasLA3bfaaVxdPQWaI99uvgH/JyFUHfrO5GXBGphYxQ1Y89c+ndAPbLml7n4qocxfqD2oF
        e4+5n/NGN34Fj7qkGxjW6fKfYqoBahA0oDVy1YFn+5bCVcQSazWCeTpN76nBtnaV/ZEkVn
        NBmCKNndXQxb6XJzd2cKO1AJBLXnNt+tiYhLgJUC1HZqI9PiBQzN/m2mG01bbA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: marvell: armada-37xx: Remap IO space to
 bus address 0x0
In-Reply-To: <20220310100943.m33wsynnvexw7dts@pali>
References: <20220218212526.16021-1-pali@kernel.org>
 <20220304163027.29357-1-pali@kernel.org> <87k0d2i0mr.fsf@BL-laptop>
 <20220310100943.m33wsynnvexw7dts@pali>
Date:   Thu, 10 Mar 2022 11:23:26 +0100
Message-ID: <87h786hzs1.fsf@BL-laptop>
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

Pali Roh=C3=A1r <pali@kernel.org> writes:

> On Thursday 10 March 2022 11:05:00 Gregory CLEMENT wrote:
>> Hello Pali,
>>=20
>> > Legacy and old PCI I/O based cards do not support 32-bit I/O addressin=
g.
>> >
>> > Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources fr=
om
>> > 'ranges' DT property") kernel can set different PCIe address on CPU and
>> > different on the bus for the one A37xx address mapping without any fir=
mware
>> > support in case the bus address does not conflict with other A37xx map=
ping.
>> >
>> > So remap I/O space to the bus address 0x0 to enable support for old le=
gacy
>> > I/O port based cards which have hardcoded I/O ports in low address spa=
ce.
>> >
>> > Note that DDR on A37xx is mapped to bus address 0x0. And mapping of I/O
>> > space can be set to address 0x0 too because MEM space and I/O space are
>> > separate and so do not conflict.
>> >
>> > Remapping IO space on Turris Mox to different address is not possible =
to
>> > due bootloader bug.
>> >
>> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>> > Fixes: 76f6386b25cc ("arm64: dts: marvell: Add Aardvark PCIe support f=
or Armada 3700")
>> > Cc: stable@vger.kernel.org # 64f160e19e92 ("PCI: aardvark: Configure P=
CIe resources from 'ranges' DT property")
>> > Cc: stable@vger.kernel.org # 514ef1e62d65 ("arm64: dts: marvell: armad=
a-37xx: Extend PCIe MEM space")
>> >
>> Cc: stable@vger.kernel.org # ???????????? ("arm64: dts: marvell: armada-=
37xx: Increase PCIe IO size from 64 KiB to 1 MiB")
>>=20
>> This patch has been refused by Arnd so I removed it from the mvebu/fixes
>> branch so you should not apply anything on top of it.
>
> Ok, so what is wrong with a change which increase size of IO space to 1 M=
B?

https://lore.kernel.org/linux-arm-kernel/CAK8P3a2D8Yv+KpM4NJyP9mosieqbhHh08=
=3DmdEy+OA84Vx6FVCQ@mail.gmail.com/

>
>> Actually I still try to first apply the old patch and then this one but
>> it still fail. And it is also failed when I applied this one on a
>> v5.17-rc1, so I wondered on which did create this patch.
>
> Ok, at which branch / commit should I rebase it?

Please create only one single patch on top of v5.17-rc1.

Thanks!

Gregory

>
>> Gr=C3=A9gory
>>=20
>> > ---
>> > Changes in v2:
>> > * Do not remap IO space on Turris Mox
>> > ---
>> >  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 7 ++++++-
>> >  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
>> >  2 files changed, 7 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/=
arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> > index 6581092c2c90..2838e3f65ada 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> > +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> > @@ -150,17 +150,22 @@
>> >  	slot-power-limit =3D <10000>;
>> >  	/*
>> >  	 * U-Boot port for Turris Mox has a bug which always expects that "r=
anges" DT property
>> >  	 * contains exactly 2 ranges with 3 (child) address cells, 2 (parent=
) address cells and
>> > -	 * 2 size cells and also expects that the second range starts at 16 =
MB offset. If these
>> > +	 * 2 size cells and also expects that the second range starts at 16 =
MB offset. Also it
>> > +	 * expects that first range uses same address for PCI (child) and CP=
U (parent) cells (so
>> > +	 * no remapping) and that this address is the lowest from all specif=
ied ranges. If these
>> >  	 * conditions are not met then U-Boot crashes during loading kernel =
DTB file. PCIe address
>> >  	 * space is 128 MB long, so the best split between MEM and IO is to =
use fixed 16 MB window
>> >  	 * for IO and the rest 112 MB (64+32+16) for MEM. Controller support=
s 32-bit IO mapping.
>> >  	 * This bug is not present in U-Boot ports for other Armada 3700 dev=
ices and is fixed in
>> >  	 * U-Boot version 2021.07. See relevant U-Boot commits (the last one=
 contains fix):
>> >  	 * https://source.denx.de/u-boot/u-boot/-/commit/cb2ddb291ee6fcbddd6=
d8f4ff49089dfe580f5d7
>> >  	 * https://source.denx.de/u-boot/u-boot/-/commit/c64ac3b3185aeb38462=
97ad7391fc6df8ecd73bf
>> >  	 * https://source.denx.de/u-boot/u-boot/-/commit/4a82fca8e330157081f=
c132a591ebd99ba02ee33
>> > +	 * Bug related to requirement of same child and parent addresses for=
 first range is fixed
>> > +	 * in U-Boot version 2022.04 by following commit:
>> > +	 * https://source.denx.de/u-boot/u-boot/-/commit/1fd54253bca7d43d046=
bba4853fe5fafd034bc17
>> >  	 */
>> >  	#address-cells =3D <3>;
>> >  	#size-cells =3D <2>;
>> >  	ranges =3D <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   =
/* Port 0 IO */
>> > diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64=
/boot/dts/marvell/armada-37xx.dtsi
>> > index 549c3f7c5b27..a099b7787429 100644
>> > --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> > +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> > @@ -514,9 +514,9 @@
>> >  			 * IO at the end and the remaining seven windows
>> >  			 * (totaling 127 MiB) for MEM.
>> >  			 */
>> >  			ranges =3D <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000 =
  /* Port 0 MEM */
>> > -				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port=
 0 IO*/
>> > +				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port=
 0 IO */
>> >  			interrupt-map-mask =3D <0 0 0 7>;
>> >  			interrupt-map =3D <0 0 0 1 &pcie_intc 0>,
>> >  					<0 0 0 2 &pcie_intc 1>,
>> >  					<0 0 0 3 &pcie_intc 2>,
>> > --=20
>> > 2.20.1
>> >
>>=20
>> --=20
>> Gregory Clement, Bootlin
>> Embedded Linux and Kernel engineering
>> http://bootlin.com

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
