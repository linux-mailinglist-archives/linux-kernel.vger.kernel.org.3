Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B9500DC8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243467AbiDNMpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiDNMpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:45:08 -0400
X-Greylist: delayed 16041 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Apr 2022 05:42:42 PDT
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C2485666;
        Thu, 14 Apr 2022 05:42:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1B73A20000B;
        Thu, 14 Apr 2022 12:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649940159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IzxE2WvL9rq7v5BifF1RggWJF7SATt0ADL+xVaYyURo=;
        b=Pn2BOdfWHgxWi3QIBOn//sLlklO3nKb1PAGVtKVz+Xm0UQUILQSkukh/5WRoila/GK+A0n
        b4XlxAxvNEzCtPGLytY1SEbqs8IJdmPzJFGPIe8PwBhMzlhr3FRr6j4NIIygXRaMVr/4L8
        N9kp8cgmteWqeyY7mRhvzttmOndYMAL1qHoYa+mbHUHb30+KYsnl7H3sSJTKsqOixFFMUG
        eDtct6stRbGSQEAznr99qBw8co+3a0QBZjlFrckLRpo079CPSoRpaXX7Q1LgMIPF3TnZkL
        oU1lA3Y9euUpdncqLL9UjE898BpWL1Z2r+RXeRSJdhS+TYZyCpQBPYiQ14G9jw==
Date:   Thu, 14 Apr 2022 14:42:36 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Md Sadre Alam <quic_mdalam@quicinc.com>
Cc:     <mani@kernel.org>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <quic_srichara@quicinc.com>
Subject: Re: [PATCH] mtd: rawnand: qcom: fix memory corruption that causes
 panic
Message-ID: <20220414144236.4ea54e20@xps13>
In-Reply-To: <2697e757-f446-9cdb-95e0-ea01a642e6d4@quicinc.com>
References: <1649914773-22434-1-git-send-email-quic_mdalam@quicinc.com>
        <20220414101517.7bbc5e9d@xps13>
        <DM6PR02MB580382FA47C4884AFC1A98D0FAEF9@DM6PR02MB5803.namprd02.prod.outlook.com>
        <2697e757-f446-9cdb-95e0-ea01a642e6d4@quicinc.com>
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

quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 17:50:48 +0530:

> > Hi Md,
> >
> > quic_mdalam@quicinc.com wrote on Thu, 14 Apr 2022 11:09:33 +0530:
> > =20
> >> This patch fixes a memory corruption that occurred in the
> >> nand_scan() path for Hynix nand device.
> >>
> >> On boot, for Hynix nand device will panic at a weird place:
> >> | Unable to handle kernel NULL pointer dereference at virtual
> >>    address 00000070
> >> | [00000070] *pgd=3D00000000
> >> | Internal error: Oops: 5 [#1] PREEMPT SMP ARM Modules linked in:
> >> | CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.17.0-01473-g13ae1769cfb0
> >>    #38
> >> | Hardware name: Generic DT based system PC is at
> >> | nandc_set_reg+0x8/0x1c LR is at qcom_nandc_command+0x20c/0x5d0
> >> | pc : [<c088b74c>]    lr : [<c088d9c8>]    psr: 00000113
> >> | sp : c14adc50  ip : c14ee208  fp : c0cc970c
> >> | r10: 000000a3  r9 : 00000000  r8 : 00000040
> >> | r7 : c16f6a00  r6 : 00000090  r5 : 00000004  r4 :c14ee040
> >> | r3 : 00000000  r2 : 0000000b  r1 : 00000000  r0 :c14ee040
> >> | Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM Segment none
> >> | Control: 10c5387d  Table: 8020406a  DAC: 00000051 Register r0
> >> | information: slab kmalloc-2k start c14ee000 pointer offset
> >>    64 size 2048
> >> | Process swapper/0 (pid: 1, stack limit =3D 0x(ptrval)) nandc_set_reg
> >> | from qcom_nandc_command+0x20c/0x5d0 qcom_nandc_command from
> >> | nand_readid_op+0x198/0x1e8 nand_readid_op from
> >> | hynix_nand_has_valid_jedecid+0x30/0x78
> >> | hynix_nand_has_valid_jedecid from hynix_nand_init+0xb8/0x454
> >> | hynix_nand_init from nand_scan_with_ids+0xa30/0x14a8
> >> | nand_scan_with_ids from qcom_nandc_probe+0x648/0x7b0
> >> | qcom_nandc_probe from platform_probe+0x58/0xac
> >>
> >> The problem is that the nand_scan()'s qcom_nand_attach_chip callback
> >> is updating the nandc->max_cwperpage from 1 to 4.This causes the
> >> sg_init_table of clear_bam_transaction() in the driver's
> >> qcom_nandc_command() to memset much more than what was initially
> >> allocated by alloc_bam_transaction(). =20
> > Thanks for investigating!
> > =20
> >> This patch will update nandc->max_cwperpage 1 to 4 after nand_scan()
> >> returns, and remove updating nandc->max_cwperpage from
> >> qcom_nand_attach_chip call back. =20
> > The fix does not look right, as far as I understand, this should be pro=
perly handled during the attach phase. That is where we have all informatio=
n about the chip and do the configuration for this chip.
> >
> > If you update max_cwperpage there you should probably update other inte=
rnal variables that depend on it as well. =20
>=20
>  =C2=A0=C2=A0 Currently we are updating max_cwperpage=C2=A0 in qcom_nand_=
attach_chip(), but we are seeing issue for Hynix nand device since nand_sca=
n_tail() is getting called after nand_attach() and in nand_attach() we are =
updating max_cwperpage to 4 or 8 based on page size.
>=20
>  =C2=A0=C2=A0=C2=A0 From nand_scan_tail() there is a call for nand_manufa=
cturer_init() , specific to Hynix nand read_id is getting called that's why=
 we are seeing this issue only for Hynix nand device. Read id sequence as b=
elow
>=20
>  =C2=A0=C2=A0 hynix_nand_has_valid_jedecid()
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
>=20
>  =C2=A0=C2=A0 nand_readid_op()
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
>=20
>  =C2=A0qcom_nandc_command()
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> pre_command()
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
>=20
> clear_bam_transaction()=C2=A0=C2=A0 --> In this call we are doing sg_init=
_table() which is calling memset() based on max_cwperpage.Since initially w=
e have allocated bam transaction as per max_cwperpage =3D1 and , since nand=
_chip_attach() updated max_cwperpage,=C2=A0 now we are doing memset as per =
max_cwperpage =3D 4 or 8.
>=20
>=20
> So anyway we have to updated max_cwperpage after nand_scan() call only.=
=C2=A0 Since there is no other dependency on max_cwperpage in nand_attach_c=
hip() and we are using this in bam_alloc() and bam_clear().

Why don't you update the sg table after increasing max_cwperpage?

>=20
> > =20
> >> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> >> Signed-off-by: Sricharan R <quic_srichara@quicinc.com>
> >> ---
> >>   drivers/mtd/nand/raw/qcom_nandc.c | 8 ++++----
> >>   1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c
> >> b/drivers/mtd/nand/raw/qcom_nandc.c
> >> index 1a77542..aa3ec45 100644
> >> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> >> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> >> @@ -2652,9 +2652,6 @@ static int qcom_nand_attach_chip(struct
> >> nand_chip *chip)
> >>
> >>        mtd_set_ooblayout(mtd, &qcom_nand_ooblayout_ops);
> >>
> >> -     nandc->max_cwperpage =3D max_t(unsigned int, nandc->max_cwperpag=
e,
> >> -                                  cwperpage);
> >> -
> >>        /*
> >>         * DATA_UD_BYTES varies based on whether the read/write command=
 protects
> >>         * spare data with ECC too. We protect spare data by default, so
> >> we set @@ -2909,7 +2906,7 @@ static int qcom_nand_host_init_and_regist=
er(struct qcom_nand_controller *nandc,
> >>        struct nand_chip *chip =3D &host->chip;
> >>        struct mtd_info *mtd =3D nand_to_mtd(chip);
> >>        struct device *dev =3D nandc->dev;
> >> -     int ret;
> >> +     int ret, cwperpage;
> >>
> >>        ret =3D of_property_read_u32(dn, "reg", &host->cs);
> >>        if (ret) {
> >> @@ -2955,6 +2952,9 @@ static int qcom_nand_host_init_and_register(stru=
ct qcom_nand_controller *nandc,
> >>        if (ret)
> >>                return ret;
> >>
> >> +     cwperpage =3D mtd->writesize / NANDC_STEP_SIZE;
> >> +     nandc->max_cwperpage =3D max_t(unsigned int, nandc->max_cwperpag=
e,
> >> +                                  cwperpage);
> >>        if (nandc->props->is_bam) {
> >>                free_bam_transaction(nandc);
> >>                nandc->bam_txn =3D alloc_bam_transaction(nandc); =20
> >
> > Thanks,
> > Miqu=C3=A8l =20


Thanks,
Miqu=C3=A8l
