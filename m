Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960D34AED0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242150AbiBIIrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:47:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242695AbiBIIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:46:10 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442D0C05CB9A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:46:04 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0A0C860007;
        Wed,  9 Feb 2022 08:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644396333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eCf04aUMDzP5dSbNLCBJfjmY08skBN+UT9q7TRW7Z6U=;
        b=X4/IP4fpfr3pUIvDYIj6Gz8WuWo8QqRUbVER41vFST4SQr5kNYVY1bgX5nqiPeMDZ3JdKF
        T1fYEr1b4IuIxhcs9Db1nvGMT9AibTVusTu7kTxHRqmz9YYoYzKpeepMV7WjZn0pyE2/us
        z3wpU10BBIvzb9VWnR8s+cUgKCRwS3WBNC2JENUP7yAknEYe5it6UiXscD4rrju8wN6xBy
        OyPjppUIl3u/Dyc20vJp1nRxErgRXEC5ZMr+1owOEZ6H8QZlqsgpaZRiIMJpYsvy3ZDNZU
        Aj8zVXnU+1Iu2bW3uX2gomaApo+Fb8H8Rio5i62T/krExBAwzG1VLGTC6uyadQ==
Date:   Wed, 9 Feb 2022 09:45:30 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 14/29] drivers/mtd/nand/ecc-mxic.c:548
 mxic_ecc_prepare_io_req_external() error: uninitialized symbol 'ret'.
Message-ID: <20220209094530.27c26f36@xps13>
In-Reply-To: <202202090415.SS8TwwHj-lkp@intel.com>
References: <202202090415.SS8TwwHj-lkp@intel.com>
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

Hi Dan,

dan.carpenter@oracle.com wrote on Wed, 9 Feb 2022 10:22:04 +0300:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi=
-mem-ecc
> head:   d6986e74ec6ee6a48ce9ee1d8051b2988d747558
> commit: cfe5cf69e97267e9d1de65cc894b7a2310644a15 [14/29] mtd: nand: mxic-=
ecc: Add Macronix external ECC engine support
> config: x86_64-randconfig-m001-20220207 (https://download.01.org/0day-ci/=
archive/20220209/202202090415.SS8TwwHj-lkp@intel.com/config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> drivers/mtd/nand/ecc-mxic.c:548 mxic_ecc_prepare_io_req_external() error:=
 uninitialized symbol 'ret'.
>=20
> vim +/ret +548 drivers/mtd/nand/ecc-mxic.c
>=20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  494  static int mxic_ecc_prepare=
_io_req_external(struct nand_device *nand,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  495  					    struct nand_page_i=
o_req *req)
> cfe5cf69e97267 Miquel Raynal 2021-12-16  496  {
> cfe5cf69e97267 Miquel Raynal 2021-12-16  497  	struct mxic_ecc_engine *mx=
ic =3D nand_to_mxic(nand);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  498  	struct mxic_ecc_ctx *ctx =
=3D nand_to_ecc_ctx(nand);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  499  	struct mtd_info *mtd =3D n=
anddev_to_mtd(nand);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  500  	int offset, nents, step, r=
et;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  501 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  502  	if (req->mode =3D=3D MTD_O=
PS_RAW)
> cfe5cf69e97267 Miquel Raynal 2021-12-16  503  		return 0;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  504 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  505  	nand_ecc_tweak_req(&ctx->r=
eq_ctx, req);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  506  	ctx->req =3D req;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  507 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  508  	if (req->type =3D=3D NAND_=
PAGE_READ)
> cfe5cf69e97267 Miquel Raynal 2021-12-16  509  		return 0;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  510 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  511  	mxic_ecc_add_room_in_oobbu=
f(ctx, ctx->oobwithstat,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  512  				    ctx->req->oobbuf.ou=
t);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  513 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  514  	sg_set_buf(&ctx->sg[0], re=
q->databuf.out, req->datalen);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  515  	sg_set_buf(&ctx->sg[1], ct=
x->oobwithstat,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  516  		   req->ooblen + (ctx->st=
eps * STAT_BYTES));
> cfe5cf69e97267 Miquel Raynal 2021-12-16  517 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  518  	nents =3D dma_map_sg(mxic-=
>dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  519  	if (!nents)
> cfe5cf69e97267 Miquel Raynal 2021-12-16  520  		return -EINVAL;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  521 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  522  	mutex_lock(&mxic->lock);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  523 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  524  	for (step =3D 0; step < ct=
x->steps; step++) {
> cfe5cf69e97267 Miquel Raynal 2021-12-16  525  		writel(sg_dma_address(&ct=
x->sg[0]) + (step * ctx->data_step_sz),
> cfe5cf69e97267 Miquel Raynal 2021-12-16  526  		       mxic->regs + SDMA_=
MAIN_ADDR);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  527  		writel(sg_dma_address(&ct=
x->sg[1]) + (step * (ctx->oob_step_sz + STAT_BYTES)),
> cfe5cf69e97267 Miquel Raynal 2021-12-16  528  		       mxic->regs + SDMA_=
SPARE_ADDR);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  529  		ret =3D mxic_ecc_process_=
data(mxic, ctx->req->type);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  530  		if (ret)
> cfe5cf69e97267 Miquel Raynal 2021-12-16  531  			break;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  532  	}
> cfe5cf69e97267 Miquel Raynal 2021-12-16  533 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  534  	mutex_unlock(&mxic->lock);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  535 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16  536  	dma_unmap_sg(mxic->dev, ct=
x->sg, 2, DMA_BIDIRECTIONAL);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  537 =20
>=20
> Smatch is complaining that ctx->steps might be zero.  I should probably
> try to silence that kind of warning if the cross function DB has not
> been built.  It tends to have false positives.

I'm sorry I don't know what you mean by "if the cross function DB has
not been built"?

Both ->prepare() and ->finish() hooks cannot be called if ->init_ctx()
failed (the core enforces that). In the init implementation, there is
this:

conf->step_size =3D SZ_1K;
steps =3D mtd->writesize / conf->step_size;
ctx->steps =3D steps;

Also, mtd->writesize =3D=3D 0 is impossible here because:
in drivers/mtd/nand/core.c:nanddev_init():
we check that memorg->pagesize !=3D 0 and then we assign mtd->writesize
to memorg->pagesize.

nanddev_init() is called by the raw NAND core and SPI NAND core, which
are the only two possible users of this driver.

So I would say this is a false positive that you can silence.

> But shouldn't we have an if (ret) return ret; after this dma_unmap_sg()?
> Can we really retrieve the calculated ECC bytes when processing the data
> failed?

Well yeah, that's right, I'll fix it inline, thanks for catching that.

> cfe5cf69e97267 Miquel Raynal 2021-12-16  538  	/* Retrieve the calculated=
 ECC bytes */
> cfe5cf69e97267 Miquel Raynal 2021-12-16  539  	for (step =3D 0; step < ct=
x->steps; step++) {
> cfe5cf69e97267 Miquel Raynal 2021-12-16  540  		offset =3D ctx->meta_sz +=
 (step * ctx->oob_step_sz);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  541  		mtd_ooblayout_get_eccbyte=
s(mtd,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  542  					   (u8 *)ctx->req->oob=
buf.out + offset,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  543  					   ctx->oobwithstat + =
(step * STAT_BYTES),
> cfe5cf69e97267 Miquel Raynal 2021-12-16  544  					   step * ctx->parity_=
sz,
> cfe5cf69e97267 Miquel Raynal 2021-12-16  545  					   ctx->parity_sz);
> cfe5cf69e97267 Miquel Raynal 2021-12-16  546  	}
> cfe5cf69e97267 Miquel Raynal 2021-12-16  547 =20
> cfe5cf69e97267 Miquel Raynal 2021-12-16 @548  	return ret;
> cfe5cf69e97267 Miquel Raynal 2021-12-16  549  }
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20


Thanks,
Miqu=C3=A8l
