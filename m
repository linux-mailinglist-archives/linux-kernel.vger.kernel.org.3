Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5886C500814
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiDNISB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240952AbiDNIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:17:46 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BD347398
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 01:15:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CB6C1FF816;
        Thu, 14 Apr 2022 08:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649924120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nWm9bZunBtm2q1dNTg2vdZaOIRSEGlUFwF3f06as1a8=;
        b=Jgwn6TbX910FliwV1PHbs5lOv5Ghiyr41L5OupnYamnqmBbGbFvnCVCD2WZB0AHnXJiWhx
        cHybwrETldtG0BJG6BlqgfP57Ue3CwehdTARFOh777K7sPWnJ7uagMlX14YcBIG/EzOh8C
        /9c8NuMOHW6xSutXQ87Bou6L2tdk8HE0C1Tb1OlhimWosPi4buyeAkpvywQmHy06eMfGdc
        p0UKKz0Lk+77VbE4rMWHJdyzsbJVREsOLh5dby4YrMVE+cBvehztPZA3snCVVS3BRxYB85
        lcq9EVNxhWS1pNFUp54zjxlH+5oWljKw+UQqVZr6R3yXNKlghJuWCfnClkrMHw==
Date:   Thu, 14 Apr 2022 10:15:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     mani@kernel.org, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, konrad.dybcio@somainline.org,
        quic_srichara@quicinc.com
Subject: Re: [PATCH] mtd: rawnand: qcom: fix memory corruption that causes
 panic
Message-ID: <20220414101517.7bbc5e9d@xps13>
In-Reply-To: <1649914773-22434-1-git-send-email-quic_mdalam@quicinc.com>
References: <1649914773-22434-1-git-send-email-quic_mdalam@quicinc.com>
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

Hi Md,

quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 11:09:33 +0530:

> This patch fixes a memory corruption that occurred in the
> nand_scan() path for Hynix nand device.
>=20
> On boot, for Hynix nand device will panic at a weird place:
> | Unable to handle kernel NULL pointer dereference at virtual
>   address 00000070
> | [00000070] *pgd=3D00000000
> | Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> | Modules linked in:
> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-01473-g13ae1769cfb0
>   #38
> | Hardware name: Generic DT based system
> | PC is at nandc_set_reg+0x8/0x1c
> | LR is at qcom_nandc_command+0x20c/0x5d0
> | pc : [<c088b74c>]    lr : [<c088d9c8>]    psr: 00000113
> | sp : c14adc50  ip : c14ee208  fp : c0cc970c
> | r10: 000000a3  r9 : 00000000  r8 : 00000040
> | r7 : c16f6a00  r6 : 00000090  r5 : 00000004  r4 :c14ee040
> | r3 : 00000000  r2 : 0000000b  r1 : 00000000  r0 :c14ee040
> | Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
> | Control: 10c5387d  Table: 8020406a  DAC: 00000051
> | Register r0 information: slab kmalloc-2k start c14ee000 pointer offset
>   64 size 2048
> | Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval))
> | nandc_set_reg from qcom_nandc_command+0x20c/0x5d0
> | qcom_nandc_command from nand_readid_op+0x198/0x1e8
> | nand_readid_op from hynix_nand_has_valid_jedecid+0x30/0x78
> | hynix_nand_has_valid_jedecid from hynix_nand_init+0xb8/0x454
> | hynix_nand_init from nand_scan_with_ids+0xa30/0x14a8
> | nand_scan_with_ids from qcom_nandc_probe+0x648/0x7b0
> | qcom_nandc_probe from platform_probe+0x58/0xac
>=20
> The problem is that the nand_scan()'s qcom_nand_attach_chip callback
> is updating the nandc->max_cwperpage from 1 to 4.This causes the
> sg_init_table of clear_bam_transaction() in the driver's
> qcom_nandc_command() to memset much more than what was initially
> allocated by alloc_bam_transaction().

Thanks for investigating!

> This patch will update nandc->max_cwperpage 1 to 4 after nand_scan()
> returns, and remove updating nandc->max_cwperpage from
> qcom_nand_attach_chip call back.

The fix does not look right, as far as I understand, this should be
properly handled during the attach phase. That is where we have all
information about the chip and do the configuration for this chip.

If you update max_cwperpage there you should probably update other
internal variables that depend on it as well.

> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> ---
>  drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qco=
m_nandc.c
> index 1a77542..aa3ec45 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2652,9 +2652,6 @@ static int qcom_nand_attach_chip(struct nand_chip *=
chip)
> =20
>  	mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
> =20
> -	nandc->max_cwperpage =3D max_t(unsigned int, nandc->max_cwperpage,
> -				     cwperpage);
> -
>  	/*
>  	 * DATA_UD_BYTES varies based on whether the read/write command protects
>  	 * spare data with ECC too. We protect spare data by default, so we set
> @@ -2909,7 +2906,7 @@ static int qcom_nand_host_init_and_register(struct =
qcom_nand_controller *nandc,
>  	struct nand_chip *chip =3D &host->chip;
>  	struct mtd_info *mtd =3D nand_to_mtd(chip);
>  	struct device *dev =3D nandc->dev;
> -	int ret;
> +	int ret, cwperpage;
> =20
>  	ret =3D of_property_read_u32(dn, "reg", &host->cs);
>  	if (ret) {
> @@ -2955,6 +2952,9 @@ static int qcom_nand_host_init_and_register(struct =
qcom_nand_controller *nandc,
>  	if (ret)
>  		return ret;
> =20
> +	cwperpage =3D mtd->writesize / NANDC_STEP_SIZE;
> +	nandc->max_cwperpage =3D max_t(unsigned int, nandc->max_cwperpage,
> +				     cwperpage);
>  	if (nandc->props->is_bam) {
>  		free_bam_transaction(nandc);
>  		nandc->bam_txn =3D alloc_bam_transaction(nandc);


Thanks,
Miqu=C3=A8l
