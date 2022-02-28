Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9704C71DB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237980AbiB1Qms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235440AbiB1Qmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:42:46 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D8F85BC6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:42:07 -0800 (PST)
Received: (Authenticated sender: gregory.clement@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 12600240004;
        Mon, 28 Feb 2022 16:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1646066524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEyyWd0b4CiKZYdLj1BA1aEWDvj7Y+W6tE6Cp0OtRdQ=;
        b=XuMlFI0qkm54lAsljGRqzNJteZWG9aohys0TrFRdH4+QGv8yO0hkDMfhVtx+MObRbA2QBj
        qNNgRqC8DIoLuSknnAerBdMCxmjiL5glqOj0nT9zvM0v8sSux4A9Y14cgnzQkhohUALeVc
        4g1glrOmq5QS/dguC8iYGNnXZnoh+RmY08/PXzr9sJ4/Ilna5I+15+QuIWOXfU0JUOPrwd
        BwwwAyU+fSDwWcXIir1Ndn53//fGB+FZZiDwhYSNxsC/3ibEBjER7L9Gvw3kZlAQkHAnNh
        4V9Y6DhWKgh45l33apqUmuSM1wNO9CpRw49XL0xckL+uLz5YTGTZHFJf+u/ErA==
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?Q?Beh=C3=BAn?= <kabel@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-37xx: Remap IO space to bus
 address 0x0
In-Reply-To: <87o82r0zjh.fsf@BL-laptop>
References: <20220218212526.16021-1-pali@kernel.org> <87o82r0zjh.fsf@BL-laptop>
Date:   Mon, 28 Feb 2022 17:42:03 +0100
Message-ID: <875yoz0wpw.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Hello Pali,
>
>> Remap PCI I/O space to the bus address 0x0 in the Armada 37xx
>> device-tree in order to support legacy I/O port based cards which have
>> hardcoded I/O ports in low address space.
>>
>> Some legacy PCI I/O based cards do not support 32-bit I/O addressing.
>>
>> Since commit 64f160e19e92 ("PCI: aardvark: Configure PCIe resources from
>> 'ranges' DT property") this driver can work with I/O windows which
>> have
>
> Should we add a "Fixes: 64f160e19e92 ("PCI: aardvark: Configure PCIe
> resources from 'ranges' DT property")" tag ?

Waiting for your confirmation I tried to applied it but it failed.

Did you base this patch on v5.17-rc1 ?

Gregory

>
> Gregory
>
>> a different address for CPU than for PCI bus (unless there is some
>> conflict with other A37xx mapping), without needing additional support
>> for this in the firmware.
>>
>> Note that DDR on A37xx is mapped to bus address 0x0 and that mapping of
>> I/O space can be set to address 0x0 too because MEM space and I/O space
>> are separate and so they do not conflict.
>>
>> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 +-
>>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/ar=
ch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> index 6581092c2c90..7d1b9153a901 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> +++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
>> @@ -163,7 +163,7 @@
>>  	 */
>>  	#address-cells =3D <3>;
>>  	#size-cells =3D <2>;
>> -	ranges =3D <0x81000000 0 0xe8000000   0 0xe8000000   0 0x01000000   /*=
 Port 0 IO */
>> +	ranges =3D <0x81000000 0 0x00000000   0 0xe8000000   0 0x01000000   /*=
 Port 0 IO */
>>  		  0x82000000 0 0xe9000000   0 0xe9000000   0 0x07000000>; /* Port 0 M=
EM */
>>=20=20
>>  	/* enabled by U-Boot if PCIe module is present */
>> diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/b=
oot/dts/marvell/armada-37xx.dtsi
>> index 549c3f7c5b27..a099b7787429 100644
>> --- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> +++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
>> @@ -515,7 +515,7 @@
>>  			 * (totaling 127 MiB) for MEM.
>>  			 */
>>  			ranges =3D <0x82000000 0 0xe8000000   0 0xe8000000   0 0x07f00000   =
/* Port 0 MEM */
>> -				  0x81000000 0 0xeff00000   0 0xeff00000   0 0x00100000>; /* Port 0=
 IO*/
>> +				  0x81000000 0 0x00000000   0 0xeff00000   0 0x00100000>; /* Port 0=
 IO */
>>  			interrupt-map-mask =3D <0 0 0 7>;
>>  			interrupt-map =3D <0 0 0 1 &pcie_intc 0>,
>>  					<0 0 0 2 &pcie_intc 1>,
>> --=20
>> 2.20.1
>>
>
> --=20
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
