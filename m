Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEC55A121
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiFXSpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbiFXSpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:45:21 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348162710
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:45:19 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 230D4E0005;
        Fri, 24 Jun 2022 18:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1656096318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OhwUa7ULOa0HAkoYaCvaKGKl4CXee0Jr1SRlZBCA6GU=;
        b=AqLIBi7e553nSlKsJL7LILVqrVlIa0qqg1GGa5OutRkE84hL56a88oOzLGAzb3NedYUTXi
        LwWUHUTp+ZsxZdp0yoCPs3BNJpl+CyuWR++uhRujWHfRG/fTKibTvFj6ZZwFXsCsI99qFm
        oaDIFzgh7qI/9HydonetIdIGRAaWwQQIqM0kgvrmPs0mELz1kh0EuUAgDxLOLvA0dZwNyv
        n57yH6xRonDqkbIwqO6bEUeJHm2HAXE69dgUK6ETXLgil3CnpV1XwV4EJ0LJmGnIcOPwlJ
        aK0ihwhDK6UACef5BLSieKWh4NUs3CPZx34P0zLub+IVEhyTljp5qCHXycT8vg==
Date:   Fri, 24 Jun 2022 20:45:15 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
Cc:     <vigneshr@ti.com>, <git@amd.com>, <boris.brezillon@collabora.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <amit.kumar-mahapatra@amd.com>, <akumarma@amd.com>
Subject: Re: [PATCH v2 1/2] mtd: rawnand: arasan: Update NAND bus clock
 instead of system clock
Message-ID: <20220624204515.6b003ef9@xps-13>
In-Reply-To: <20220621085500.1005-2-amit.kumar-mahapatra@xilinx.com>
References: <20220621085500.1005-1-amit.kumar-mahapatra@xilinx.com>
        <20220621085500.1005-2-amit.kumar-mahapatra@xilinx.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi Amit,

amit.kumar-mahapatra@xilinx.com wrote on Tue, 21 Jun 2022 14:24:59
+0530:

> In current implementation the Arasan NAND driver is updating the
> system clock(i.e., anand->clk) in accordance to the timing modes
> (i.e., SDR or NVDDR). But as per the Arasan NAND controller spec the
> flash clock or the NAND bus clock(i.e., nfc->bus_clk), need to be
> updated instead. This patch keeps the system clock unchanged and updates
> the NAND bus clock as per the timing modes.

This is not what you do below. If the clock that is changed is the
wrong one, then just change the clock used in the clk_set_rate call
instead of calling clk_set_rate twice at the wrong location.
->set_interface is done once per chip, if you have two different chips
on the same system you must change the clock when you switch from one
chip to the other. Your current implementation disrespects that,
unfortunately.

>=20
> Fixes: 197b88fecc50 ("mtd: rawnand: arasan: Add new Arasan NAND controlle=
r")

Requires a Cc: stable tag

> Signed-off-by: Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>
> ---
>  drivers/mtd/nand/raw/arasan-nand-controller.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/arasan-nand-controller.c b/drivers/mtd/=
nand/raw/arasan-nand-controller.c
> index 53bd10738418..4f6da82dd2b1 100644
> --- a/drivers/mtd/nand/raw/arasan-nand-controller.c
> +++ b/drivers/mtd/nand/raw/arasan-nand-controller.c
> @@ -968,6 +968,7 @@ static int anfc_setup_interface(struct nand_chip *chi=
p, int target,
>  	const struct nand_sdr_timings *sdr;
>  	const struct nand_nvddr_timings *nvddr;
>  	unsigned int tccs_min, dqs_mode, fast_tcad;
> +	int ret;
> =20
>  	if (nand_interface_is_nvddr(conf)) {
>  		nvddr =3D nand_get_nvddr_timings(conf);
> @@ -1043,7 +1044,11 @@ static int anfc_setup_interface(struct nand_chip *=
chip, int target,
>  				 DQS_BUFF_SEL_OUT(dqs_mode);
>  	}
> =20
> -	anand->clk =3D ANFC_XLNX_SDR_DFLT_CORE_CLK;
> +	ret =3D clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_DFLT_CORE_CLK);
> +	if (ret) {
> +		dev_err(nfc->dev, "Failed to change bus clock rate\n");
> +		return ret;
> +	}
> =20
>  	/*
>  	 * Due to a hardware bug in the ZynqMP SoC, SDR timing modes 0-1 work
> @@ -1052,8 +1057,13 @@ static int anfc_setup_interface(struct nand_chip *=
chip, int target,
>  	 * 80MHz when using SDR modes 2-5 with this SoC.
>  	 */
>  	if (of_device_is_compatible(np, "xlnx,zynqmp-nand-controller") &&
> -	    nand_interface_is_sdr(conf) && conf->timings.mode >=3D 2)
> -		anand->clk =3D ANFC_XLNX_SDR_HS_CORE_CLK;
> +	    nand_interface_is_sdr(conf) && conf->timings.mode >=3D 2) {
> +		ret =3D clk_set_rate(nfc->bus_clk, ANFC_XLNX_SDR_HS_CORE_CLK);
> +		if (ret) {
> +			dev_err(nfc->dev, "Failed to change bus clock rate\n");
> +			return ret;
> +		}
> +	}
> =20
>  	return 0;
>  }


Thanks,
Miqu=C3=A8l
