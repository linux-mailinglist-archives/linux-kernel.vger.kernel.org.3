Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1086F4F1319
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357770AbiDDKae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237099AbiDDKac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 06:30:32 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87332263D;
        Mon,  4 Apr 2022 03:28:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 399F524000B;
        Mon,  4 Apr 2022 10:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649068109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HCsUi7kOI3d6Xo1Mm1jD9G/wtU6d4VrhYaApfm09KZI=;
        b=gbwGaNha7rEyqNkTaxQbeooF06FS+a4ZuW9tSlSN+P/9d25inyojXEX05W4+wQ30vvrXWu
        P5dme+NQYjzbThTQ+GaAKh9EhHFG2eI4w7kYqefsxf5lpvcV8TzTa8UrPfqtfNGkHMFjVc
        ZFGBPby619uiBHPpESgx7+HRU39TAIHjRhReYvti2QHS5rKUtMU5o8mDBnA9AgfBVNU6xL
        Rwzowagr2P1dk76ve5wQz6BBx+b1dma1beoBR5Sghf0UCyQXIwtjBJ+9anfxb0noEA6329
        vqEORxQb7TJ7AFCXOmglRk8d/qbchxUB32ymQ6qiD6I4hcn9hEFI899uDT5qEQ==
Date:   Mon, 4 Apr 2022 12:28:24 +0200
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
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:NAND FLASH SUBSYSTEM" <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 2/5] spi: add driver for MTK SPI NAND Flash Interface
Message-ID: <20220404122824.63a1c857@xps13>
In-Reply-To: <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
References: <20220404040153.1509966-1-gch981213@gmail.com>
        <20220404040153.1509966-3-gch981213@gmail.com>
        <20220404095937.20089db7@xps13>
        <CAJsYDVK6ya7FR90CtAjbpbF-_+c0GVnsKsN=1wYaoBFx=ysUtQ@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
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

Hi Chuanhong,

gch981213@gmail.com wrote on Mon, 4 Apr 2022 17:13:55 +0800:

> Hi!
>=20
> On Mon, Apr 4, 2022 at 3:59 PM Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
> >
> > Hi Chuanhong,
> >
> > gch981213@gmail.com wrote on Mon,  4 Apr 2022 12:01:50 +0800:
> > =20
> > > This driver implements support for the SPI-NAND mode of MTK NAND Flash
> > > Interface as a SPI-MEM controller with piplined ECC capability.
> > >
> > > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> > > ---
> > >
> > > Change since v1:
> > >   fix CI warnings
> > >
> > >  drivers/spi/Kconfig        |   10 +
> > >  drivers/spi/Makefile       |    1 +
> > >  drivers/spi/spi-mtk-snfi.c | 1351 ++++++++++++++++++++++++++++++++++=
++
> > >  3 files changed, 1362 insertions(+)
> > >  create mode 100644 drivers/spi/spi-mtk-snfi.c
> > >
> > > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > > index d2815eb361c0..739eec7d0c15 100644
> > > --- a/drivers/spi/Kconfig
> > > +++ b/drivers/spi/Kconfig
> > > @@ -590,6 +590,16 @@ config SPI_MTK_NOR
> > >         SPI interface as well as several SPI NOR specific instructions
> > >         via SPI MEM interface.
> > >
> > > +config SPI_MTK_SNFI
> > > +     tristate "MediaTek SPI NAND Flash Interface"
> > > +     depends on ARCH_MEDIATEK || COMPILE_TEST
> > > +     depends on MTD_NAND_ECC_MEDIATEK
> > > +     help
> > > +       This enables support for SPI-NAND mode on the MediaTek NAND
> > > +       Flash Interface found on MediaTek ARM SoCs. This controller
> > > +       is implemented as a SPI-MEM controller with pipelined ECC
> > > +       capcability.
> > > +
> > >  config SPI_NPCM_FIU
> > >       tristate "Nuvoton NPCM FLASH Interface Unit"
> > >       depends on ARCH_NPCM || COMPILE_TEST
> > > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > > index 3aa28ed3f761..51541ff17e67 100644
> > > --- a/drivers/spi/Makefile
> > > +++ b/drivers/spi/Makefile
> > > @@ -76,6 +76,7 @@ obj-$(CONFIG_SPI_MPC52xx)           +=3D spi-mpc52x=
x.o
> > >  obj-$(CONFIG_SPI_MT65XX)                +=3D spi-mt65xx.o
> > >  obj-$(CONFIG_SPI_MT7621)             +=3D spi-mt7621.o
> > >  obj-$(CONFIG_SPI_MTK_NOR)            +=3D spi-mtk-nor.o
> > > +obj-$(CONFIG_SPI_MTK_SNFI)           +=3D spi-mtk-snfi.o
> > >  obj-$(CONFIG_SPI_MXIC)                       +=3D spi-mxic.o
> > >  obj-$(CONFIG_SPI_MXS)                        +=3D spi-mxs.o
> > >  obj-$(CONFIG_SPI_NPCM_FIU)           +=3D spi-npcm-fiu.o
> > > diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
> > > new file mode 100644
> > > index 000000000000..e8f8f30bd7ee
> > > --- /dev/null
> > > +++ b/drivers/spi/spi-mtk-snfi.c =20
> >
> > [...]
> > =20
> > > +static struct mtk_snand *nand_to_mtk_snand(struct nand_device *nand)
> > > +{
> > > +     struct nand_ecc_engine *eng =3D nand->ecc.engine;
> > > +
> > > +     return container_of(eng, struct mtk_snand, ecc_eng);
> > > +}
> > > +
> > > +static inline int snand_prepare_bouncebuf(struct mtk_snand *snf, siz=
e_t size)
> > > +{
> > > +     if (snf->buf_len >=3D size)
> > > +             return 0;
> > > +     if (snf->buf)
> > > +             dmam_free_coherent(snf->dev, snf->buf_len, snf->buf,
> > > +                                snf->buf_dma); =20
> >
> > Can't we use a single coherent buffer once for all? =20
>=20
> This only reallocates when the page size changes to a larger one,
> so there's at most two allocations: one during probe and the other
> one in the first call to init_ctx. The other solution is to allocate a
> buffer for the maximum supported page size but I think that's a
> waste of memory.

Ok, fine.

>=20
> > =20
> > > +     snf->buf =3D
> > > +             dmam_alloc_coherent(snf->dev, size, &snf->buf_dma, GFP_=
KERNEL);
> > > +     if (!snf->buf)
> > > +             return -ENOMEM;
> > > +     snf->buf_len =3D size;
> > > +     memset(snf->buf, 0xff, snf->buf_len);
> > > +     return 0;
> > > +}
> > > + =20
> >
> > [...]
> > =20
> > > +static int mtk_snand_ecc_init_ctx(struct nand_device *nand)
> > > +{
> > > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > > +     struct nand_ecc_props *conf =3D &nand->ecc.ctx.conf;
> > > +     struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> > > +     int ret;
> > > +
> > > +     ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> > > +                                   nand->memorg.oobsize);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     mtd_set_ooblayout(mtd, &mtk_snand_ooblayout);
> > > +
> > > +     // This driver ignores any ECC capability configured by user or
> > > +     // requested by the nand chip because the BootROM and MTK bootl=
oader
> > > +     // expects the page format to be the exact one as calculated in
> > > +     // setup_pagefmt. =20
> >
> > I don't like this :)
> >
> > I understand that the boot partition might have specific constraints,
> > but other partitions (or if we don't use the NAND to boot?) should
> > probably be usable with other ECC schemes. =20
>=20
> In this controller, the ECC step size is fixed and it can only change
> ECC strength.

That's fine.

> The calculated ECC correction capability is the max
> possible one supported by the controller.
> I still want the default behavior to match the boot partition
> requirement,

That is okay, but that does not mean you can only support this one.

> because we can't just tell end-users to customize
> their dts by taking apart their device and figure out which flash
> is used.

They don't have to do so. In theory they should not request anything,
the core would take care of all of that. But they can request specific
values by using the DT and you must follow them in the driver.

On his side the core is responsible of telling you which strength
should be used otherwise and the driver is expected to use it.

> I can implement the following:

You should take the user requirements first. If there are no
user inputs, you should in theory look at the device's requirements.

> 1. select the minimum capability exceeding ecc.user_conf
> 2. If that doesn't exist, use the calculated one and warn
>    if it doesn't meet ecc.requirements
> Is this OK?
>=20
> > =20
> > > +     conf->step_size =3D snf->caps->sector_size;
> > > +     conf->strength =3D snf->ecc_cfg.strength;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int mtk_snand_ecc_prepare_io_req(struct nand_device *nand,
> > > +                                     struct nand_page_io_req *req)
> > > +{
> > > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > > +     int ret;
> > > +
> > > +     ret =3D mtk_snand_setup_pagefmt(snf, nand->memorg.pagesize,
> > > +                                   nand->memorg.oobsize);
> > > +     if (ret)
> > > +             return ret;
> > > +     snf->autofmt =3D true;
> > > +     return 0;
> > > +}
> > > +
> > > +static int mtk_snand_ecc_finish_io_req(struct nand_device *nand,
> > > +                                    struct nand_page_io_req *req)
> > > +{
> > > +     struct mtk_snand *snf =3D nand_to_mtk_snand(nand);
> > > +     struct mtd_info *mtd =3D nanddev_to_mtd(nand);
> > > +
> > > +     snf->autofmt =3D false;
> > > +     if ((req->mode =3D=3D MTD_OPS_RAW) || (req->type !=3D NAND_PAGE=
_READ))
> > > +             return 0;
> > > +
> > > +     if (snf->ecc_stats.failed)
> > > +             mtd->ecc_stats.failed +=3D snf->ecc_stats.failed;
> > > +     mtd->ecc_stats.corrected +=3D snf->ecc_stats.corrected;
> > > +     return snf->ecc_stats.failed ? -EBADMSG : snf->ecc_stats.bitfli=
ps; =20
> >
> > Did you verify that nandbiterrs -i succeeds? =20
>=20
> I did a insmod mtd_nandbiterrs.ko dev=3Dx and the reported bitflips in
> kernel log is correct.
>=20
> Is there a userspace tool for this? I'd like to use that instead of a
> kernel module in the future.

Yes, you can give the mtd-utils test suite a try. Almost all the tools
have been migrated there. There even is a Buildroot package.

> > > +}
> > > +
> > > +static struct nand_ecc_engine_ops mtk_snfi_ecc_engine_ops =3D {
> > > +     .init_ctx =3D mtk_snand_ecc_init_ctx,
> > > +     .prepare_io_req =3D mtk_snand_ecc_prepare_io_req,
> > > +     .finish_io_req =3D mtk_snand_ecc_finish_io_req, =20
> >
> > I believe you need to take care of the bounce buffer in the exit path? =
=20
>=20
> No. The buffer should be left there for non-ecc spi-mem operations.

AFAIR you initialize the buffer in the ECC part, so if it must be used
without ECC you should probably allocate it for the SPI controller. In
any way, you need to free that memory at some point (when removing the
driver).

>=20
> > =20
> > > +};
> > > +
> > > +static void mtk_snand_read_fdm(struct mtk_snand *snf, uint8_t *buf)
> > > +{
> > > +     uint32_t vall, valm;
> > > +     uint8_t *oobptr =3D buf;
> > > +     int i, j;
> > > +
> > > +     for (i =3D 0; i < snf->nfi_cfg.nsectors; i++) {
> > > +             vall =3D nfi_read32(snf, NFI_FDML(i));
> > > +             valm =3D nfi_read32(snf, NFI_FDMM(i));
> > > +
> > > +             for (j =3D 0; j < snf->caps->fdm_size; j++)
> > > +                     oobptr[j] =3D (j >=3D 4 ? valm : vall) >> ((j %=
 4) * 8);
> > > +
> > > +             oobptr +=3D snf->caps->fdm_size;
> > > +     }
> > > +} =20
> >
> > Thanks,
> > Miqu=C3=A8l =20
>=20
>=20
>=20
> --
> Regards,
> Chuanhong Guo


Thanks,
Miqu=C3=A8l
