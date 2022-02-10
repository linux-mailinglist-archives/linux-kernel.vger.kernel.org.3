Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131684B0878
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237595AbiBJIeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:34:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiBJIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:34:03 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C76E4F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 00:34:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 63A21FF807;
        Thu, 10 Feb 2022 08:34:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644482041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HgitZVATVaYH5V1qanLOVQRl0TQFTmB+LKJYVRUVulU=;
        b=KdXvZxmhx5PkcLFZcpXpmXWPoMY3ds+nmck8VKPrOqfjF2ywuLYlvdZVwFrXX0xZXFDQQV
        4QnGOsAhEsg9rlJQlKpk7sRWCoFsCS1taZGAAjzXRonHsUgg6Rmuvs0gYZCLyJJ1VWsUCj
        zi+pd4iKGqjkK4Ekc/R98hW/ztRUcG6hPvWFUJaAXM4tUhpk8wjRJjtdAu+jhUC6Cjb+UY
        dFUYZF73+biq7T9RM4ivAcLOU65ExDMTHIzDKTmk2CP2NbPwiurZ1uIwAw3Xi5M3I/y2FW
        5OK4Opzzqza0fY5cfW2QYtfs7Lmbd63N9X/mc5QTPidjhu/KqZeU7Hsp0vgKug==
Date:   Thu, 10 Feb 2022 09:33:59 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [mtd:spi-mem-ecc 16/29] drivers/mtd/nand/ecc-mxic.c:652
 mxic_ecc_finish_io_req_external() error: uninitialized symbol 'ret'.
Message-ID: <20220210093359.779eb1dc@xps13>
In-Reply-To: <202202100023.AD5wMMvp-lkp@intel.com>
References: <202202100023.AD5wMMvp-lkp@intel.com>
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

Hi Dan,

dan.carpenter@oracle.com wrote on Wed, 9 Feb 2022 20:58:57 +0300:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git spi=
-mem-ecc
> head:   b556a86810e25b9d5a56da553bc65e5f4dcbedb6
> commit: f46b431b115d2ead7ccf71da53a5d1993f0acfcd [16/29] mtd: nand: mxic-=
ecc: Support SPI pipelined mode
> config: arm64-randconfig-m031-20220209 (https://download.01.org/0day-ci/a=
rchive/20220210/202202100023.AD5wMMvp-lkp@intel.com/config)
> compiler: aarch64-linux-gcc (GCC) 11.2.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> vim +/ret +652 drivers/mtd/nand/ecc-mxic.c
>=20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  611  static int mxic_ecc_finish=
_io_req_external(struct nand_device *nand,
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  612  					   struct nand_page_i=
o_req *req)
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  613  {
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  614  	struct mxic_ecc_engine *m=
xic =3D nand_to_mxic(nand);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  615  	struct mxic_ecc_ctx *ctx =
=3D nand_to_ecc_ctx(nand);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  616  	int nents, step, ret;
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  617 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  618  	if (req->mode =3D=3D MTD_=
OPS_RAW)
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  619  		return 0;
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  620 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  621  	if (req->type =3D=3D NAND=
_PAGE_WRITE) {
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  622  		nand_ecc_restore_req(&ct=
x->req_ctx, req);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  623  		return 0;
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  624  	}
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  625 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  626  	/* Copy the OOB buffer an=
d add room for the ECC engine status bytes */
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  627  	mxic_ecc_add_room_in_oobb=
uf(ctx, ctx->oobwithstat, ctx->req->oobbuf.in);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  628 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  629  	sg_set_buf(&ctx->sg[0], r=
eq->databuf.in, req->datalen);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  630  	sg_set_buf(&ctx->sg[1], c=
tx->oobwithstat,
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  631  		   req->ooblen + (ctx->s=
teps * STAT_BYTES));
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  632  	nents =3D dma_map_sg(mxic=
->dev, ctx->sg, 2, DMA_BIDIRECTIONAL);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  633  	if (!nents)
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  634  		return -EINVAL;
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  635 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  636  	mutex_lock(&mxic->lock);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  637 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  638  	for (step =3D 0; step < c=
tx->steps; step++) {
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  639  		writel(sg_dma_address(&c=
tx->sg[0]) + (step * ctx->data_step_sz),
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  640  		       mxic->regs + SDMA=
_MAIN_ADDR);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  641  		writel(sg_dma_address(&c=
tx->sg[1]) + (step * (ctx->oob_step_sz + STAT_BYTES)),
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  642  		       mxic->regs + SDMA=
_SPARE_ADDR);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  643  		ret =3D mxic_ecc_process=
_data(mxic, ctx->req->type);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  644  		if (ret)
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  645  			break;
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  646  	}
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  647 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  648  	mutex_unlock(&mxic->lock);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  649 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  650  	dma_unmap_sg(mxic->dev, c=
tx->sg, 2, DMA_BIDIRECTIONAL);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  651 =20
> f46b431b115d2ea Miquel Raynal 2021-12-16 @652  	if (!ret) {
>=20
> Hi Miquel,
>=20
> This if statement is reversed.  No !

-___-

I've attempted to do something else, and finally got rid of it, but
left the '!' behind...

> f46b431b115d2ea Miquel Raynal 2021-12-16  653  		nand_ecc_restore_req(&ct=
x->req_ctx, req);
> f46b431b115d2ea Miquel Raynal 2021-12-16  654  		return ret;
> f46b431b115d2ea Miquel Raynal 2021-12-16  655  	}
> f46b431b115d2ea Miquel Raynal 2021-12-16  656 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  657  	/* Extract the status byt=
es and reconstruct the buffer */
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  658  	mxic_ecc_extract_status_b=
ytes(ctx);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  659  	mxic_ecc_reconstruct_oobb=
uf(ctx, ctx->req->oobbuf.in, ctx->oobwithstat);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  660 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  661  	nand_ecc_restore_req(&ctx=
->req_ctx, req);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  662 =20
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  663  	return mxic_ecc_count_bit=
errs(mxic, nand);
> 48e6633a9fa2400 Miquel Raynal 2021-12-16  664  }
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>=20


Thanks,
Miqu=C3=A8l
