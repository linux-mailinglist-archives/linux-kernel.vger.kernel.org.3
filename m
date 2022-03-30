Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6C4EBC68
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 10:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244138AbiC3ILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 04:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbiC3ILw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 04:11:52 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210D81C5;
        Wed, 30 Mar 2022 01:10:02 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7067B1BF209;
        Wed, 30 Mar 2022 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1648627801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QrXANGeblYePSDSjBqnjlhxDn2ylDzea37fL7T4lxpU=;
        b=ROOjh6SGya4ePmk//V50fvCANd7x32XNyJWrG5ha4iYMCrDxOwfrXEaalbEFBbSe4i4kEN
        /1QCIk73V6LQWTiZYbycmp5/NuenzcMK0x4UsIhaTIMzzXIl48ghlkkPMb8Dz1CUgSKKxJ
        qm7+XpSM28re9125Q0NBD2dsRYJNipx9NK7FT6TL36oj6JQ4Q1exz21odxuwe4JmiWnuMz
        mxcwn4kZ0Yvx2K8vPd1VaVmJC4dQbkV0OPcwv+lNIv7YZQ+RNLSvVOxoM47Yjq/Z9ZUx3O
        A561NtdCHUg8BfCb1H3lOhiifECYKcOmmcHDnNbhchxC4n39AzySvKUeWjk+Qw==
Date:   Wed, 30 Mar 2022 10:09:58 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mikhail Zhilkin <csharper2005@gmail.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        NOGUCHI Hiroshi <drvlabo@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Karim <Karimdplay@gmail.com>, M <x1@disroot.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: add support for Sercomm partitions
Message-ID: <20220330100958.57dc4d61@xps13>
In-Reply-To: <20220329122016.4122899-1-csharper2005@gmail.com>
References: <20220329122016.4122899-1-csharper2005@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mikhail,

csharper2005@gmail.com wrote on Tue, 29 Mar 2022 12:20:16 +0000:

> This adds an MTD partition parser for the Sercomm partition table that
> is used in some Beeline, Netgear and Sercomm routers.
>=20
> The Sercomm partition map table contains real partition offsets, which
> may differ from device to device depending on the number and location of
> bad blocks on NAND.
>=20
> Device tree example:
> partitions {
> 	compatible =3D "sercomm,sc-partitions", "fixed-partitions";
> 	#address-cells =3D <1>;
> 	#size-cells =3D <1>;
>=20
> 	partition@0 {
> 		label =3D "u-boot";
> 		reg =3D <0x0 0x100000>;
> 		scpart-id =3D <0>;
> 		read-only;
> 	};
> };

You'll need a DT binding patch and Rob's ack!

>=20
> This is essentially the same code as proposed by NOGUCHI Hiroshi
> <drvlabo@gmail.com> here:

I would credit Hiroshi with a Suggested-by at least

> https://github.com/openwrt/openwrt/pull/1318#issuecomment-420607394

And use a Link: tag for this.

>=20
> Signed-off-by: Mikhail Zhilkin <csharper2005@gmail.com>
> ---


Thanks,
Miqu=C3=A8l
