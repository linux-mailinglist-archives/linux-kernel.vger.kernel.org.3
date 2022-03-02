Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952BA4CAF53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242399AbiCBUGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiCBUGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:06:37 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FE4CA0FE;
        Wed,  2 Mar 2022 12:05:54 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2FB451F45056;
        Wed,  2 Mar 2022 20:05:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646251552;
        bh=EC3Sx7CTK8chpFEIlSWop6GT/woJveb8eyelTtp0crI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BVCWm5oC6KGgaBo1E8EZsegF4Znj5jYzCLWXjwdV3e7uMKTFIU48r26VCbvHGGjCU
         AtPtx3Kt4edD8Cr4xTBF+CyD8P3WrPBXLlXo/+g8Dv2z0K+XbL/Kdk6HD/d99LQPSl
         jadXzbibKkrNt223YKJAJVqqqH8XYTCfK1JVDSAlNpGbNfDsUTIA7vpENpzDOovIjQ
         U5bMOU7iYM95gEhbr8ftl4M2+zXZBoxcxS3ONe18Zb8190+c69bYu4oxJWQp7OP/rF
         IB2lLRgJ4eHAvITIkCYUZ6+tBSCejtclMCRJ8HJZUsdto1qNo7YsbzLuNYg5PuFfUc
         zbP6wHe/nGjXg==
Date:   Wed, 2 Mar 2022 21:05:46 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <p.yadav@ti.com>
Subject: Re: [PATCH v3 05/17] mtd: spinand: Define ctrl_ops for non-page
 read/write op templates
Message-ID: <20220302210546.486239b4@collabora.com>
In-Reply-To: <259637a6-e63f-56f0-6cdf-6bd21f8e4453@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-6-a-nandan@ti.com>
        <20220103110107.45594e78@collabora.com>
        <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
        <20220215183705.574df0c1@collabora.com>
        <259637a6-e63f-56f0-6cdf-6bd21f8e4453@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022 21:00:55 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> >> 1. read_cache, write_cache, update_cache op templates don't fit well
> >> with the other non-data ops, as
> >> these data ops are used to create a dirmap, and that can be done only
> >> once at probe time. Hence, there
> >> is a different mechanism of selecting of data ops and non-data ops. =20
> > Not sure I see why this is a problem. You can populate data-ops for all
> > modes, and pick the one that provides the best perfs when you create
> > the dirmap (which should really be at the end of the probe, if it's not
> > already).
> > =20
> >> Hence, this division in the op templates
> >> struct as data_ops and ctrl_ops is required. Currently, the core only
> >> supports using a single protocol for
> >> data ops, chosen at the time of probing. =20
> > Again, I don't see why you need to differentiate the control and data
> > ops when populating this table. Those are just operations the NAND
> > supports, and the data operations is just a subset.
> > =20
> >> 2. If we use this single op_templates struct, I can't think of any good
> >> way to initialize these in the
> >> manufacturers driver (winbond.c), refer to 17th patch in this series.
> >> Could you please suggest a macro
> >> implementation also for winbond.c with the suggested op_templates stru=
ct. =20
> > First replace the op_variants field by something more generic:
> >
> > struct spinand_info {
> > ...
> > 	const struct spinand_op_variants **ops_variants;
> > ...
> > };
> >
> > #define SPINAND_OP_VARIANTS(_id, ...) \
> > 	[SPI_NAND_OP_ ## _id] =3D { __VA_ARGS__ }
> >
> > #define SPINAND_OPS_VARIANTS(name, ...)
> > 	const struct spinand_op_variants name[]{
> > 		__VA_ARGS__,
> > 	};
> >
> > #define SPINAND_INFO_OPS_VARIANTS(defs)
> > 	.ops_variants =3D defs
> >
> > ...
> >
> > static SPINAND_OPS_VARIANTS(w35n01jw_ops_variants,
> > 		SPINAND_OP_VARIANTS(READ_CACHE,
> > 			SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(0, 24, NULL, 0),
> > 			SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
> > 			...)),
> > 		SPINAND_OP_VARIANTS(WRITE_CACHE,
> > 			SPINAND_PROG_LOAD_OCTALIO_DTR(true, 0, NULL, 0),
> > 			SPINAND_PROG_LOAD(true, 0, NULL, 0)),
> > 		...
> > 		SPINAND_OP_VARIANTS(RESET,
> > 			SPINAND_RESET_OP_OCTAL_DTR,
> > 			SPINAND_RESET_OP,
> > 		...
> > 		);
> > ... =20
>=20
> I find a issue with this implementation, please give corrective suggestio=
ns:
>=20
> In type of op variant listing, there is no way to specify the protocol=20
> of the op in the variants struct itself.
>  =C2=A0=C2=A0=C2=A0 - This will lead to filtering/sorting/searching of op=
s for finding=20
> the protocols in the spinand core
>  =C2=A0=C2=A0=C2=A0 while in spinand_match_and_init(), which I don't feel=
 is a good way=20
> for protocol based op categorization.

You'll have to go over all those operations to check which ones are
supported by the controller anyway. And it's not like the
classification is complicated since the cmd bus-width+DTR seems to be
the discriminant, and it's stored directly in the operation template.

>  =C2=A0=C2=A0=C2=A0 - This would also lead to complexities in cases of mi=
xed mode=20
> operations.

Not sure what you mean by mixed mode. Are you referring to something
like 1S-8D-8D? IIUC, all we care about is the mode used for the cmd
cycle. I don't think there are commands to switch between stateless
(1S-x[S,D]-x[S,D]) modes (assuming 1S-xD-xD is a thing).

>  =C2=A0=C2=A0=C2=A0 - In addition, we can't simply choose the first suppo=
rted protocol=20
> in each op id, as some ops have
>  =C2=A0=C2=A0=C2=A0 intendependency of protocol with other ops. This is b=
ecause=20
> non-data ops (like reset, block erase..)
>  =C2=A0=C2=A0=C2=A0 cannot be in different protocols at same time, so it =
would make=20
> sense to have some form of protocol
>  =C2=A0=C2=A0=C2=A0 based arrangement while listing them.

I'm not suggesting to choose the first supported operation and use it
unconditionally, but instead choose one operation per stateful mode
(1S, 2S, 4S, ..., 8D) and use the appropriate template depending on
the mode the flash is currently in.

