Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8194D42C1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbiCJImN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiCJImI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:42:08 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0546136EF9;
        Thu, 10 Mar 2022 00:41:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3E9131F40657;
        Thu, 10 Mar 2022 08:41:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646901664;
        bh=85vN9gn1Lw3CJSZnGfyA8Bn3SkFiBOBdf9hHKsmOVGA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m527BWDAr30hv4G5IwjbwSOAdTl+OrMkJHc6C5Xbow13UR7C4FVUre2sBy6gaXXX7
         XBmblJjkKAdVh/oL2WWY+RI/2+/RqAJ4dmzSQtfMZY2ALVqnCoAEpz38G5R09NWqbR
         /Y0vQUi8fDRjGMsJF30dxTd1kyTTEhHQuZPoesdLz5bhLvbU+Fptn75L3jFQURxTZa
         w4vRy3nxSBrJ0ev4eBnMzzyWVU5wY46sbgJVuVSUqBezJGnTmjmirlycCMj62kyxzo
         SsOcKc4pjleYwMbGMgbztHH3Y6yku67G2JqPMpFSGTTVTX8p5Ob/tISeX/t/5bXKBO
         mINUouXYId3Iw==
Date:   Thu, 10 Mar 2022 09:40:53 +0100
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
Message-ID: <20220310094053.1d86d13a@collabora.com>
In-Reply-To: <12c7a6a6-8b49-1c3e-087f-79c77388b091@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-6-a-nandan@ti.com>
        <20220103110107.45594e78@collabora.com>
        <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
        <20220215183705.574df0c1@collabora.com>
        <12c7a6a6-8b49-1c3e-087f-79c77388b091@ti.com>
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

On Thu, 10 Mar 2022 13:27:06 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> >>> This way, you can easily pick the right set of operations based
> >>> on the protocol/mode you're in:
> >>>
> >>> #define spinand_get_op_template(spinand, opname) \
> >>> 	((spinand)->op_templates[(spinand)->protocol]->opname)
> >>>
> >>> static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg=
, u8 *val)
> >>> {
> >>> 	struct spi_mem_op op =3D *spinand_get_op_template(spinand, get_featu=
re);
> >>> 	int ret;
> >>>
> >>> 	...
> >>> } =20
> >> I find a couple of issues with this=C2=A0 method,
> >>
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
> > 	.ops_variants =3D defs =20
>=20
> If we modify these macros, it would require other spinand vendor drivers=
=20
> to change (toshiba, micron, etc).
> The older macros suit them well, should we go about changing them to=20
> this new macro (will require re-testing all of them),
> or can we keep them unchanged and have new set of macros with different=20
> name (please give suggestion for it) for op variants.

I'd rather have everything converted to the new approach (we don't want
2 ways of describing the same thing), and I'm not sure you can make the
old macros map to the new solution, so I fear you'll have to patch all
vendors. This being said, I'm fine providing simple wrappers if that
helps, but I don't see how they'd make the description simpler/more
compact to be honest.
