Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7434C70E3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231742AbiB1Plz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237608AbiB1Ply (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:41:54 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6994C7EB23
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 07:41:13 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C14271BF215;
        Mon, 28 Feb 2022 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646062869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8tsZThgKft3qP4HSBatGAgCaNYLDfrbq75zRz5W1SA=;
        b=kLvkovtrQ4QLgwOf4DxCC4CISYznEeyG1gMt4QPzLOB8QAgQqBN5nzSLTdu+iH4z6Hijwr
        E6TMLlNU4quO/5zrcje2BvmU9d1hcIc7eMEGq9ZH5e0QT2boAe1ribA5PZoaxDujlaHu9y
        O4kkYnB32k7xsZzsq0QOu3Km//48yu+t2wDlyv6+6DAnDYaL/Q4pRfUtIupupcd/B6AAK5
        nGTqeyRMleiWKOXSb0cNgSXnzpIRhllYw5IB3Bp3vVdaWbeEaXAlQwiDY4H15YT/mBTBWf
        0a73ifR65GcOVV48f3lBTuqfIwivNWV4vUxrtaNgiRt+gMu1Q2y2LqxvLwyqJQ==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
In-Reply-To: <20220218212526.16021-1-pali@kernel.org>
References: <20220218212526.16021-1-pali@kernel.org>
Date:   Mon, 28 Feb 2022 16:41:06 +0100
Message-ID: <87o82r0zjh.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Pali,

> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
> device-tree in order to support legacy I/O port based cards which have
> hardcoded I/O ports in low address space.
>
> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
>
> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
> 'ranges' DT property") this driver can work with I/O windows which
> have

Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
resources from 'ranges' DT property")" tag ?

Gregory

> a different address for CPU than for PCI bus (unless there is some
> conflict with other A37xx mapping), without needing additional support
> for this in the firmware.
>
> Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
> I/O space can be set to address 0x0 too because MEM space and I/O space
> are separate and so they do not conflict.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arc=
h/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> index 6581092c2c90..7d1b9153a901 100644
> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
> @@ -163,7 +163,7 @@
>  	 */
>  	#address-cells =3D <3>;
>  	#size-cells =3D <2>;
> -	ranges =3D <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /* =
Port 0 IO */
> +	ranges =3D <0x81000000 0 0x00000000   0 0xe8000000   0 0x01000000   /* =
Port 0 IO */
>  		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 ME=
M */
>=20=20
>  	/* enabled by U-Boot if PCIe module is present */
> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/bo=
ot/dts/marvell/armada-37xx.dtsi
> index 549c3f7c5b27..a099b7787429 100644
> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
> @@ -515,7 +515,7 @@
>  			 * (totaling 127 MiB) for MEM.
>  			 */
>  			ranges =3D <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   /=
* Port 0 MEM */
> -				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0 =
IO*/
> +				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0 =
IO */
>  			interrupt-map-mask =3D <0 0 0 7>;
>  			interrupt-map =3D <0 0 0 1 &pcie_intc 0>,
>  					<0 0 0 2 &pcie_intc 1>,
> --=20
> 2.20.1
>

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
