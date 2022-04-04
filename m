Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9F04F1063
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377855AbiDDIBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbiDDIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 04:01:42 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853819C3D;
        Mon,  4 Apr 2022 00:59:44 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E2BB160009;
        Mon,  4 Apr 2022 07:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649059183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZ1ww5HXNp+ThWvmQooIAfZbNKI84/02Z72n3gCX/+A=;
        b=Dj/UQRmOZnhQvTHHwuyEMqDAvvBLiIj26mq6i56UPsGBRJ10uUfBrWCuiAU3TzBjA7Otwi
        d0ZG9aqqmjObGBHttscULCNuRdYc8DXjJ3GUWWOlVwZtTGbCQtZ0o2xZppNgvjbZMzLuzx
        wpuVhL9ZSJ+m9oAPlUqAelMoyy3fs6yqtkgha95k6cguE9/sNh08/P3gljnXCmavvq9q3N
        sHe6bRfqAkCA+03BrhLfqOxCBGycO+89Pq0ve5bU1AjMc7b1SNvx0dTQu23KF+f3hAPxM2
        l0LaYxeUURkPh+xrbJB0tKEDeW0kfsbmRQ6odL8IEju2PejNQae8xM7+723XTA==
Date:   Mon, 4 Apr 2022 09:59:37 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Pratyush Yadav <p.yadav@ti.com>, Yu Kuai <yukuai3@huawei.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list),
        linux-mtd@lists.infradead.org (open list:NAND FLASH SUBSYSTEM)
Subject: Re: [PATCH v2 2/5] spi: add driver for MTK SPI NAND Flash Interface
Message-ID: <20220404095937.20089db7@xps13>
In-Reply-To: <20220404040153.1509966-3-gch981213@gmail.com>
References: <20220404040153.1509966-1-gch981213@gmail.com>
        <20220404040153.1509966-3-gch981213@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Chuanhong,

gch981213@gmail.com wrote on Mon,  4 Apr 2022 12:01:50 +0800:

> This driver implements support for the SPI-NAND mode of MTK NAND Flash
> Interface as a SPI-MEM controller with piplined ECC capability.
>=20
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
>=20
> Change since v1:
>   fix CI warnings
>=20
>  drivers/spi/Kconfig        |   10 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/spi-mtk-snfi.c | 1351 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1362 insertions(+)
>  create mode 100644 drivers/spi/spi-mtk-snfi.c
>=20
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index d2815eb361c0..739eec7d0c15 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -590,6 +590,16 @@ config SPI_MTK_NOR
>  	  SPI interface as well as several SPI NOR specific instructions
>  	  via SPI MEM interface.
> =20
> +config SPI_MTK_SNFI
> +	tristate "MediaTek SPI NAND Flash Interface"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	depends on MTD_NAND_ECC_MEDIATEK
> +	help
> +	  This enables support for SPI-NAND mode on the MediaTek NAND
> +	  Flash Interface found on MediaTek ARM SoCs. This controller
> +	  is implemented as a SPI-MEM controller with pipelined ECC
> +	  capcability.
> +
>  config SPI_NPCM_FIU
>  	tristate "Nuvoton NPCM FLASH Interface Unit"
>  	depends on ARCH_NPCM || COMPILE_TEST
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 3aa28ed3f761..51541ff17e67 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_SPI_MPC52xx)		+=3D spi-mpc52xx.o
>  obj-$(CONFIG_SPI_MT65XX)                +=3D spi-mt65xx.o
>  obj-$(CONFIG_SPI_MT7621)		+=3D spi-mt7621.o
>  obj-$(CONFIG_SPI_MTK_NOR)		+=3D spi-mtk-nor.o
> +obj-$(CONFIG_SPI_MTK_SNFI)		+=3D spi-mtk-snfi.o
>  obj-$(CONFIG_SPI_MXIC)			+=3D spi-mxic.o
>  obj-$(CONFIG_SPI_MXS)			+=3D spi-mxs.o
>  obj-$(CONFIG_SPI_NPCM_FIU)		+=3D spi-npcm-fiu.o
> diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> new file mode 100644
> index 000000000000..e8f8f30bd7ee
> --- /dev/null
> +++ b/drivers/spi/spi-mtk-snfi.c

[...]

> +static struct mtk_snand *nand_to_mtk_snand(struct nand_device *nand)
> +{
> +	struct nand_ecc_engine *eng =3D nand->ecc.engine;
> +
> +	return container_of(eng, struct mtk_snand, ecc_eng);
> +}
> +
> +static inline int snand_prepare_bouncebuf(struct mtk_snand *snf, size_t =
size)
> +{
> +	if (snf->buf_len >=3D size)
> +		return 0;
> +	if (snf->buf)
> +		dmam_free_coherent(snf->dev, snf->buf_len, snf->buf,
> +				   snf->buf_dma);

Can't we use a single coherent buffer once for all?

> +	snf->buf =3D
> +		dmam_alloc_coherent(snf->dev, size, &snf->buf_dma, GFP_KERNEL);
> +	if (!snf->buf)
> +		return -ENOMEM;
> +	snf->buf_len =3D size;
> +	memset(snf->buf, 0xff, snf->buf_len);
> +	return 0;
> +}
> +

[...]

> +static int mtk_snand_ecc_init_ctx(struct nand_device *nand)
> +{
> +	struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> +	struct nand_ecc_props *conf =3D &nand->ecc.ctx.conf;
> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> +	int ret;
> +
> +	ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> +				      nand->memorg.oobsize);
> +	if (ret)
> +		return ret;
> +
> +	mtd_set_ooblayout(mtd, &mtk_snand_ooblayout);
> +
> +	// This driver ignores any ECC capability configured by user or
> +	// requested by the nand chip because the BootROM and MTK bootloader
> +	// expects the page format to be the exact one as calculated in
> +	// setup_pagefmt.

I don't like this :)

I understand that the boot partition might have specific constraints,
but other partitions (or if we don't use the NAND to boot?) should
probably be usable with other ECC schemes.

> +	conf->step_size =3D snf->caps->sector_size;
> +	conf->strength =3D snf->ecc_cfg.strength;
> +
> +	return 0;
> +}
> +
> +static int mtk_snand_ecc_prepare_io_req(struct nand_device *nand,
> +					struct nand_page_io_req *req)
> +{
> +	struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> +	int ret;
> +
> +	ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> +				      nand->memorg.oobsize);
> +	if (ret)
> +		return ret;
> +	snf->autofmt =3D true;
> +	return 0;
> +}
> +
> +static int mtk_snand_ecc_finish_io_req(struct nand_device *nand,
> +				       struct nand_page_io_req *req)
> +{
> +	struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> +	struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> +
> +	snf->autofmt =3D false;
> +	if ((req->mode =3D=3D MTD_OPS_RAW) || (req->type !=3D NAND_PAGE_READ))
> +		return 0;
> +
> +	if (snf->ecc_stats.failed)
> +		mtd->ecc_stats.failed +=3D snf->ecc_stats.failed;
> +	mtd->ecc_stats.corrected +=3D snf->ecc_stats.corrected;
> +	return snf->ecc_stats.failed ? -EBADMSG : snf->ecc_stats.bitflips;

Did you verify that nandbiterrs -i succeeds?

> +}
> +
> +static struct nand_ecc_engine_ops mtk_snfi_ecc_engine_ops =3D {
> +	.init_ctx =3D mtk_snand_ecc_init_ctx,
> +	.prepare_io_req =3D mtk_snand_ecc_prepare_io_req,
> +	.finish_io_req =3D mtk_snand_ecc_finish_io_req,

I believe you need to take care of the bounce buffer in the exit path?

> +};
> +
> +static void mtk_snand_read_fdm(struct mtk_snand *snf, uint8_t *buf)
> +{
> +	uint32_t vall, valm;
> +	uint8_t *oobptr =3D buf;
> +	int i, j;
> +
> +	for (i =3D 0; i < snf->nfi_cfg.nsectors; i++) {
> +		vall =3D nfi_read32(snf, NFI_FDML(i));
> +		valm =3D nfi_read32(snf, NFI_FDMM(i));
> +
> +		for (j =3D 0; j < snf->caps->fdm_size; j++)
> +			oobptr[j] =3D (j >=3D 4 ? valm : vall) >> ((j % 4) * 8);
> +
> +		oobptr +=3D snf->caps->fdm_size;
> +	}
> +}

Thanks,
Miqu=C3=A8l
