Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A705E52D76F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240902AbiESPZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbiESPZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 11:25:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8C3EC319
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 08:25:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4F56E2000A;
        Thu, 19 May 2022 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1652973910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwMzpgQWrXEdEURpnR4VPKCE8aiZ8cfHgenGG21Ic8s=;
        b=fhShDjCMPwY0vAfSm/1jYDoLbnlUCWpKXve2Nt8slJ8ZQvnRDWkSjHTyblTTZVGSeN6hvm
        4uLEG3QMQPbA/ScYXhpVo9pCDvx1uti7fKdWcRZ0BbPOplKx/wlEQin9kGkcSIzDY0P/TS
        //KJDJV20lJ5KtmZddt9j5VQyebooDDlGSTvrXnAPZqsKwwGsrGdOP36MJSdxt9l9M18W6
        Y26YbjjKmnlHjzXRYi+wDr51QsEaH5LpjTSyDuy2ERQg+7Vo7sBOsJM8oouMgmEBzgKsB3
        vv0md1cLibwLvQub8w43mBy6c5gcXN7hNOuQ7ShQhuD18PhqLN8kwTB45DvfGQ==
Date:   Thu, 19 May 2022 17:25:07 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Peng Wu <wupeng58@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <christophe.jaillet@wanadoo.fr>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <liwei391@huawei.com>
Subject: Re: [PATCH] mtd: rawnand: fix drivers probe/remove methods
Message-ID: <20220519172507.4d9872c3@xps-13>
In-Reply-To: <20220517060753.26710-1-wupeng58@huawei.com>
References: <20220517060753.26710-1-wupeng58@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
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

Hi,

wupeng58@huawei.com wrote on Tue, 17 May 2022 06:07:53 +0000:

> Driver should call pci_disable_device() if it returns from
> cafe_nand_probe() with error.
>=20
> Meanwhile, the driver calls pci_enable_device() in
> cafe_nand_probe(), but never calls pci_disable_device()
> during removal.

Please fix the subject prefix, it should be "mtd: ranwnand: cafe:"

Also Fixes/Cc: stable tags might be useful.

> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> ---
>  drivers/mtd/nand/raw/cafe_nand.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/cafe_nand.c b/drivers/mtd/nand/raw/cafe=
_nand.c
> index 9dbf031716a6..af119e376352 100644
> --- a/drivers/mtd/nand/raw/cafe_nand.c
> +++ b/drivers/mtd/nand/raw/cafe_nand.c
> @@ -679,8 +679,10 @@ static int cafe_nand_probe(struct pci_dev *pdev,
>  	pci_set_master(pdev);
> =20
>  	cafe =3D kzalloc(sizeof(*cafe), GFP_KERNEL);
> -	if (!cafe)
> -		return  -ENOMEM;
> +	if (!cafe) {
> +		err =3D -ENOMEM;
> +		goto out_disable_device;
> +	}
> =20
>  	mtd =3D nand_to_mtd(&cafe->nand);
>  	mtd->dev.parent =3D &pdev->dev;
> @@ -801,6 +803,8 @@ static int cafe_nand_probe(struct pci_dev *pdev,
>  	pci_iounmap(pdev, cafe->mmio);
>   out_free_mtd:
>  	kfree(cafe);
> + out_disable_device:
> +	pci_disable_device(pdev);
>   out:
>  	return err;
>  }
> @@ -822,6 +826,7 @@ static void cafe_nand_remove(struct pci_dev *pdev)
>  	pci_iounmap(pdev, cafe->mmio);
>  	dma_free_coherent(&cafe->pdev->dev, 2112, cafe->dmabuf, cafe->dmaaddr);
>  	kfree(cafe);
> +	pci_disable_device(pdev);
>  }
> =20
>  static const struct pci_device_id cafe_nand_tbl[] =3D {


Thanks,
Miqu=C3=A8l
