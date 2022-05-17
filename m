Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C76F52A1A8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346104AbiEQMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiEQMhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:37:25 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B984A3D5;
        Tue, 17 May 2022 05:37:20 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CE49DC000A;
        Tue, 17 May 2022 12:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652791039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CNk04l4NOC/ZJltN0oDjVZ65rbHSyBSEB0Mh7KZb4cs=;
        b=OKixoUAzBr0gjNgzwuuG4zDfpZTtIoGcuyz32KgTQOL5Mfi1xjZ3bxpVMYENvIMfEWjIow
        DuMjb7DygiJTTAKOtK1OZ2Uq97GgnHKuRqV0sHmvATc1wocToGkA7df1t79N2f/Pm45YUh
        Oreu5M87LqSYIjJwhEsON/UF/1iWRVrqxIPfUGzPLbFwFF3OE/SefLKxQsPz2y5fYHMRoO
        ev5RYWF495gBDLTRZnJdXRGA0UKZ7s6oQ5CfYlxlWZfMvfB0S3Z3VuxhpQVfur7qxNFskI
        k5asL+EjpMo2FEvhuDOr+BSajbrGL/n5qOkypWHkEEhBpBbqVXnkuOAJzlwB8Q==
Date:   Tue, 17 May 2022 14:37:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc:     Pratyush Yadav <p.yadav@ti.com>, Mark Brown <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <andrew@aj.id.au>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <richard@nod.at>,
        <joel@jms.id.au>, <tudor.ambarus@microchip.com>,
        <chin-ting_kuo@aspeedtech.com>, <linux-aspeed@lists.ozlabs.org>,
        <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>
Subject: Re: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC
 driver to spi-mem
Message-ID: <20220517143713.47676b4c@xps-13>
In-Reply-To: <a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org>
References: <20220509175616.1089346-1-clg@kaod.org>
        <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
        <20220517110509.2e6xbwot63yl6a3c@ti.com>
        <a17b2446-f5a6-d606-8ef4-3931b8bc94da@kaod.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi C=C3=A9dric,

clg@kaod.org wrote on Tue, 17 May 2022 14:03:02 +0200:

> Pratyush,
>=20
> On 5/17/22 13:05, Pratyush Yadav wrote:
> > Hi Cedric,
> >=20
> > On 16/05/22 07:39PM, Mark Brown wrote: =20
> >> On Mon, 9 May 2022 19:56:05 +0200, C=C3=A9dric Le Goater wrote: =20
> >>> This series adds a new SPI driver using the spi-mem interface for the
> >>> Aspeed static memory controllers of the AST2600, AST2500 and AST2400
> >>> SoCs.
> >>>
> >>>   * AST2600 Firmware SPI Memory Controller (FMC)
> >>>   * AST2600 SPI Flash Controller (SPI1 and SPI2)
> >>>   * AST2500 Firmware SPI Memory Controller (FMC)
> >>>   * AST2500 SPI Flash Controller (SPI1 and SPI2)
> >>>   * AST2400 New Static Memory Controller (also referred as FMC)
> >>>   * AST2400 SPI Flash Controller (SPI)
> >>>
> >>> [...] =20
> >>
> >> Applied to
> >>
> >>     https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git fo=
r-next
> >>
> >> Thanks!
> >>
> >> [02/11] dt-bindings: spi: Convert the Aspeed SMC controllers device tr=
ee binding
> >>          commit: ce9858ea499da025684a7a5f19823c2c3f14bdce
> >> [03/11] spi: spi-mem: Convert Aspeed SMC driver to spi-mem
> >>          commit: 9c63b846e6df43e5b3d31263f7db545f32deeda3
> >> [04/11] spi: aspeed: Add support for direct mapping
> >>          commit: 9da06d7bdec7dad8018c23b180e410ef2e7a4367
> >> [05/11] spi: aspeed: Adjust direct mapping to device size
> >>          commit: bb084f94e1bca4a5c4f689d7aa9b410220c1ed71
> >> [06/11] spi: aspeed: Workaround AST2500 limitations
> >>          commit: 5785eedee42c34cfec496199a80fa8ec9ddcf7fe
> >> [07/11] spi: aspeed: Add support for the AST2400 SPI controller
> >>          commit: 53526ab27d9c256504f267713aea60db7af18fb0
> >> [08/11] spi: aspeed: Calibrate read timings
> >>          commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4 =20
> >=20
> > I have repeatedly objected to this patch [0][1][2] and you have
> > repeatedly decided to not address my objections.  =20
> That's a very harsh way of saying things. I did not decide anything
> or ignore your comments. I answered your questions and acknowledged
> that indeed the read training was done under the dirmap handler but
> this was not a concern today since we had all the required information
> from spimem.
>=20
> We waited _together_, 5 or 6 weeks, for more inputs on how to address
> the concerns you raised regarding the sustainability of this method.
>=20
> > I won't spend any more time fighting it.  =20
> This is not a fight. I don't know why you interpret it that way.
>=20
> Now, since you object so explicitly, and since this patchset has
> not reached the Linux kernel yet, we should consider dropping it.
> I rather do that than push crap in mainline. But then, please,
> provide solutions and not only objections !
>=20
> > But I will say that you should not expect any
> > guarantees that SPI NOR or SPI NAND will not break your calibration in
> > the future if they decide to move the dirmap_create() call around. =20
>=20
> If that's the case one day, we have multiple solutions :
>=20
>    - stop doing the training

Not really an option, isn't it?

>    - move the training to the appropriate handler if it exists

Sorry for jumping in so late, but why not using this solution already
if there are concerns about the current location? It does not look like
a complex solution to implement, but I might be overlooking something.

This can also be done for the next kernel release.

>    - use a default value
>   >> [11/11] mtd: spi-nor: aspeed: set the decoding size to at least 2MB =
for AST2600
> >>          commit: 73ae97e3cabb580639f02f12a192324a53c4bebb
> >> =20
> >=20
> > [0] https://patchwork.kernel.org/project/spi-devel-general/patch/202203=
25100849.2019209-9-clg@kaod.org/
> > [1] https://patchwork.kernel.org/project/spi-devel-general/patch/202202=
14094231.3753686-9-clg@kaod.org/
> > [2] https://lore.kernel.org/all/20220208190636.h6dubktkmuosvdxo@ti.com/=
 =20
>=20
> Regards,
>=20
> C=C3=A9dric.


Thanks,
Miqu=C3=A8l
