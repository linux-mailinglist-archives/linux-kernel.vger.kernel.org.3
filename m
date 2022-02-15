Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3C14B7742
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiBORhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:37:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiBORhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:37:22 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1A549FB8;
        Tue, 15 Feb 2022 09:37:10 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id D4A8C1F44CBE;
        Tue, 15 Feb 2022 17:37:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644946629;
        bh=VpNusZYmXQK6qGrjf8z92Hd+sj83I7JkS+WLoKjOZNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B1YSrd/uGp+OJTVYWQm7EHo/2JYu1Vpe62A10UXnm04MVw3sTmcgPdWnBbt4gqeFc
         i01FlJ9swPPPKi837EbZ2XwSnu/je29TINoCxYN4SqZv6rs7w+HLcvy74pfWO3cBuY
         8GzXJMA+DvwUQeLTCl9L0PsbmdsntYR3R+hfVjxJAKZLyW8SIlVygA5MoehxLAzwXw
         S4zFWiTqENxM7l+uyzNzRMekXQ4iuY7CvUCcxLMhr1pHv3EbJXI4ue1bWBu/FJgute
         xBaDCNL1Biu29KlptJsG16m4gfnAyuoqWuOfTTICvMRS08pVFDOCCITFTdEQc6TG56
         wLp+qoz0fcusw==
Date:   Tue, 15 Feb 2022 18:37:05 +0100
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
Message-ID: <20220215183705.574df0c1@collabora.com>
In-Reply-To: <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-6-a-nandan@ti.com>
        <20220103110107.45594e78@collabora.com>
        <bf3ea909-e0a5-eeac-12e9-c8a809685f48@ti.com>
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

Hi Apurva,

On Tue, 15 Feb 2022 21:03:52 +0530
Apurva Nandan <a-nandan@ti.com> wrote:

> Hi Boris,
>=20
> On 03/01/22 15:31, Boris Brezillon wrote:
> > On Sat, 1 Jan 2022 13:12:38 +0530
> > Apurva Nandan <a-nandan@ti.com> wrote:
> > =20
> >> 'ctrl_ops' are op templates for non-page read/write operations,
> >> which are: reset, get_feature, set_feature, write_enable, block_erase,
> >> page_read and program_execute ops. The 'ctrl_ops' struct contains in it
> >> op templates for each of this op, as well as enum spinand_protocol
> >> denoting protocol of all these ops.
> >>
> >> We require these new op templates because of deviation in standard
> >> SPINAND ops by manufacturers and also due to changes when there is a
> >> change in SPI protocol/mode. This prevents the core from live-patching
> >> and vendor-specific adjustments in ops.
> >>
> >> Define 'ctrl_ops', add macros to initialize it and add it in
> >> spinand_device.
> >>
> >> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> >> ---
> >>   include/linux/mtd/spinand.h | 33 +++++++++++++++++++++++++++++++++
> >>   1 file changed, 33 insertions(+)
> >>
> >> diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
> >> index 439d8ce40e1d..e5df6220ec1e 100644
> >> --- a/include/linux/mtd/spinand.h
> >> +++ b/include/linux/mtd/spinand.h
> >> @@ -356,6 +356,35 @@ struct spinand_op_variants {
> >>   			sizeof(struct spi_mem_op),			\
> >>   	}
> >>  =20
> >> +struct spinand_ctrl_ops {
> >> +	const struct {
> >> +		struct spi_mem_op reset;
> >> +		struct spi_mem_op get_feature;
> >> +		struct spi_mem_op set_feature;
> >> +		struct spi_mem_op write_enable;
> >> +		struct spi_mem_op block_erase;
> >> +		struct spi_mem_op page_read;
> >> +		struct spi_mem_op program_execute;
> >> +	} ops;
> >> +	const enum spinand_protocol protocol; =20
> > Do you really need that protocol field?
> > =20
> >> +};
> >> +
> >> +#define SPINAND_CTRL_OPS(__protocol, __reset, __get_feature, __set_fe=
ature,	\
> >> +			 __write_enable, __block_erase, __page_read,		\
> >> +			 __program_execute)					\
> >> +	{									\
> >> +		.ops =3D {							\
> >> +			.reset =3D __reset,					\
> >> +			.get_feature =3D __get_feature,				\
> >> +			.set_feature =3D __set_feature,				\
> >> +			.write_enable =3D __write_enable,				\
> >> +			.block_erase =3D __block_erase,				\
> >> +			.page_read =3D __page_read,				\
> >> +			.program_execute =3D __program_execute,			\
> >> +		},								\
> >> +		.protocol =3D __protocol,						\
> >> +	}
> >> +
> >>   /**
> >>    * spinand_ecc_info - description of the on-die ECC implemented by a=
 SPI NAND
> >>    *		      chip
> >> @@ -468,6 +497,8 @@ struct spinand_dirmap {
> >>    * @data_ops.read_cache: read cache op template
> >>    * @data_ops.write_cache: write cache op template
> >>    * @data_ops.update_cache: update cache op template
> >> + * @ctrl_ops: various SPI mem op templates for handling the flash dev=
ice, i.e.
> >> + *	      non page-read/write ops.
> >>    * @select_target: select a specific target/die. Usually called befo=
re sending
> >>    *		   a command addressing a page or an eraseblock embedded in
> >>    *		   this die. Only required if your chip exposes several dies
> >> @@ -498,6 +529,8 @@ struct spinand_device {
> >>   		const struct spi_mem_op *update_cache;
> >>   	} data_ops;
> >>  =20
> >> +	const struct spinand_ctrl_ops *ctrl_ops;
> >> + =20
> > Okay, I had something slightly different in mind. First, I'd put all
> > templates in a struct:
> >
> > struct spinand_op_templates {
> > 	const struct spi_mem_op *read_cache;
> > 	const struct spi_mem_op *write_cache;
> > 	const struct spi_mem_op *update_cache;
> > 	const struct spi_mem_op *reset;
> > 	const struct spi_mem_op *get_feature;
> > 	const struct spi_mem_op *set_feature;
> > 	const struct spi_mem_op *write_enable;
> > 	const struct spi_mem_op *block_erase;
> > 	const struct spi_mem_op *page_load;
> > 	const struct spi_mem_op *program_execute;
> > };
> >
> > Then, at the spinand level, I'd define an array of templates:
> >
> > enum spinand_protocol {
> > 	SPINAND_1S_1S_1S,
> > 	SPINAND_2S_2S_2S,
> > 	SPINAND_4S_4S_4S,
> > 	SPINAND_8S_8S_8S,
> > 	SPINAND_8D_8D_8D,
> > 	SPINAND_NUM_PROTOCOLS,
> > };
> >
> > struct spinand_device {
> > 	...
> > 	enum spinand_protocol protocol;
> > 	const struct spinand_op_templates *op_templates[SPINAND_NUM_PROTOCOLS];

It should probably be

	struct spinand_op_templates op_templates[SPINAND_NUM_PROTOCOLS];

with the spinand_op_templates struct defined as:

struct spinand_op_templates {
 	struct spi_mem_op read_cache;
 	struct spi_mem_op write_cache;
 	struct spi_mem_op update_cache;
 	struct spi_mem_op reset;
 	struct spi_mem_op get_feature;
 	struct spi_mem_op set_feature;
 	struct spi_mem_op write_enable;
 	struct spi_mem_op block_erase;
 	struct spi_mem_op page_load;
 	struct spi_mem_op program_execute;
};

so the NAND framework can populate these ops.

Or maybe even better, define an enum that contains all the ops:

enum spinand_op_id {
	SPI_NAND_OP_READ_CACHE,
	SPI_NAND_OP_WRITE_CACHE,
	SPI_NAND_OP_UPDATE_CACHE,
	SPI_NAND_OP_RESET,
...
	SPI_NAND_NUM_OPS,
};

struct spinand_device {
	...
 	enum spinand_protocol protocol;
 	struct spi_mem_op op_templates[SPINAND_NUM_PROTOCOLS][SPI_NAND_NUM_OPS];
	...
};

> >
> > This way, you can easily pick the right set of operations based
> > on the protocol/mode you're in:
> >
> > #define spinand_get_op_template(spinand, opname) \
> > 	((spinand)->op_templates[(spinand)->protocol]->opname)
> >
> > static int spinand_read_reg_op(struct spinand_device *spinand, u8 reg, =
u8 *val)
> > {
> > 	struct spi_mem_op op =3D *spinand_get_op_template(spinand, get_feature=
);
> > 	int ret;
> >
> > 	...
> > } =20
>=20
> I find a couple of issues with this=C2=A0 method,
>=20
> 1. read_cache, write_cache, update_cache op templates don't fit well=20
> with the other non-data ops, as
> these data ops are used to create a dirmap, and that can be done only=20
> once at probe time. Hence, there
> is a different mechanism of selecting of data ops and non-data ops.=20

Not sure I see why this is a problem. You can populate data-ops for all
modes, and pick the one that provides the best perfs when you create
the dirmap (which should really be at the end of the probe, if it's not
already).

> Hence, this division in the op templates
> struct as data_ops and ctrl_ops is required. Currently, the core only=20
> supports using a single protocol for
> data ops, chosen at the time of probing.

Again, I don't see why you need to differentiate the control and data
ops when populating this table. Those are just operations the NAND
supports, and the data operations is just a subset.

>=20
> 2. If we use this single op_templates struct, I can't think of any good=20
> way to initialize these in the
> manufacturers driver (winbond.c), refer to 17th patch in this series.=20
> Could you please suggest a macro
> implementation also for winbond.c with the suggested op_templates struct.

First replace the op_variants field by something more generic:

struct spinand_info {
...
	const struct spinand_op_variants **ops_variants;
...
};

#define SPINAND_OP_VARIANTS(_id, ...) \
	[SPI_NAND_OP_ ## _id] =3D { __VA_ARGS__ }

#define SPINAND_OPS_VARIANTS(name, ...)
	const struct spinand_op_variants name[]{
		__VA_ARGS__,
	};

#define SPINAND_INFO_OPS_VARIANTS(defs)
	.ops_variants =3D defs

...

static SPINAND_OPS_VARIANTS(w35n01jw_ops_variants,
		SPINAND_OP_VARIANTS(READ_CACHE,
			SPINAND_PAGE_READ_FROM_CACHE_OCTALIO_DTR_OP(0, 24, NULL, 0),
			SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
			...)),
		SPINAND_OP_VARIANTS(WRITE_CACHE,
			SPINAND_PROG_LOAD_OCTALIO_DTR(true, 0, NULL, 0),
			SPINAND_PROG_LOAD(true, 0, NULL, 0)),
		...
		SPINAND_OP_VARIANTS(RESET,
			SPINAND_RESET_OP_OCTAL_DTR,
			SPINAND_RESET_OP,
		...
		);
...


	SPINAND_INFO("W35N01JW",
		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xdc),
		     NAND_MEMORG(1, 4096, 128, 64, 512, 20, 1, 1, 1),
		     NAND_ECCREQ(1, 512),
		     SPINAND_HAS_OCTAL_DTR_BIT | SPINAND_HAS_CR_FEAT_BIT,
		     SPINAND_ECCINFO(&w35n01jw_ooblayout, NULL),
		     SPINAND_INFO_OPS_VARIANTS(&w35n01jw_ops_variants)),

You also need to adjust spinand_match_and_init() to account for this
new layout and put each template op in the right subset based on
op.cmd.width and op.cmd.dtr.

Regards,

Boris
