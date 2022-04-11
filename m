Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3155C4FBC63
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346163AbiDKMtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346065AbiDKMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:49:32 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D66B2C66F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:47:17 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 08CF01BF205;
        Mon, 11 Apr 2022 12:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1649681236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zOhGrupBv5BZo/T0IffoldQiJaqfYTq0n0a0T+OCi+I=;
        b=SHrE47RtGnZTw25wVFb9Z4eZEOtLtknUSNPtLyjVtFAd9YTgJgfRqHC4yFrK81LxXd3BNQ
        eGESDWRhWNrlTRBeB60fXo2BJy+duzJm0EG5g9VeOhu3ElExffzi7ziQvXMsg6Jqg1dmVG
        iRLB6rGtvRwjeaiL5jnPP+Un0F3NLh2Acz+W2vgWTZVdVKueXBc9OjlkkM47EqaJh+pM0Y
        FDQwkCQhrGVtKjD66tMHHNtZOopHPfzuCQjF+cNjVwuvHdoJvJyWnYOl7x/7/tb4ItqjAW
        hXi4VvJKep9C+eKsiS0tLC1JdvM28Kk9GphAE992QLXjY4OIu/72kDUng3yHQQ==
Date:   Mon, 11 Apr 2022 14:47:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: Use managed device resources
Message-ID: <20220411144713.3057dd17@xps13>
In-Reply-To: <20220411112124.3700126-1-zheyuma97@gmail.com>
References: <20220411112124.3700126-1-zheyuma97@gmail.com>
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

Hello,

zheyuma97@gmail.com wrote on Mon, 11 Apr 2022 19:21:24 +0800:

Prefix should be "mtd: rawnand: denali:"

> All of the resources used by this driver has managed interfaces, so use
> them. Otherwise we will get the following splat:
>=20
> [    4.472703] denali-nand-pci 0000:00:05.0: timeout while waiting for ir=
q 0x1000
> [    4.474071] denali-nand-pci: probe of 0000:00:05.0 failed with error -5
> [    4.473538] nand: No NAND device found
> [    4.474068] BUG: unable to handle page fault for address: ffffc9000500=
0410
> [    4.475169] #PF: supervisor write access in kernel mode
> [    4.475579] #PF: error_code(0x0002) - not-present page
> [    4.478362] RIP: 0010:iowrite32+0x9/0x50
> [    4.486068] Call Trace:
> [    4.486269]  <IRQ>
> [    4.486443]  denali_isr+0x15b/0x300 [denali]
> [    4.486788]  ? denali_direct_write+0x50/0x50 [denali]
> [    4.487189]  __handle_irq_event_percpu+0x161/0x3b0
> [    4.487571]  handle_irq_event+0x7d/0x1b0
> [    4.487884]  handle_fasteoi_irq+0x2b0/0x770
> [    4.488219]  __common_interrupt+0xc8/0x1b0
> [    4.488549]  common_interrupt+0x9a/0xc0
>=20
> Fixes: 93db446a424c ("mtd: nand: move raw NAND related code to the raw/ s=
ubdir")
>=20

Extra space

> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>

Otherwise LGTM.

> ---
>  drivers/mtd/nand/raw/denali_pci.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/denali_pci.c b/drivers/mtd/nand/raw/den=
ali_pci.c
> index 20c085a30adc..de7e722d3826 100644
> --- a/drivers/mtd/nand/raw/denali_pci.c
> +++ b/drivers/mtd/nand/raw/denali_pci.c
> @@ -74,22 +74,21 @@ static int denali_pci_probe(struct pci_dev *dev, cons=
t struct pci_device_id *id)
>  		return ret;
>  	}
> =20
> -	denali->reg =3D ioremap(csr_base, csr_len);
> +	denali->reg =3D devm_ioremap(denali->dev, csr_base, csr_len);
>  	if (!denali->reg) {
>  		dev_err(&dev->dev, "Spectra: Unable to remap memory region\n");
>  		return -ENOMEM;
>  	}
> =20
> -	denali->host =3D ioremap(mem_base, mem_len);
> +	denali->host =3D devm_ioremap(denali->dev, mem_base, mem_len);
>  	if (!denali->host) {
>  		dev_err(&dev->dev, "Spectra: ioremap failed!");
> -		ret =3D -ENOMEM;
> -		goto out_unmap_reg;
> +		return -ENOMEM;
>  	}
> =20
>  	ret =3D denali_init(denali);
>  	if (ret)
> -		goto out_unmap_host;
> +		return ret;
> =20
>  	nsels =3D denali->nbanks;
> =20
> @@ -117,10 +116,6 @@ static int denali_pci_probe(struct pci_dev *dev, con=
st struct pci_device_id *id)
> =20
>  out_remove_denali:
>  	denali_remove(denali);
> -out_unmap_host:
> -	iounmap(denali->host);
> -out_unmap_reg:
> -	iounmap(denali->reg);
>  	return ret;
>  }
> =20
> @@ -129,8 +124,6 @@ static void denali_pci_remove(struct pci_dev *dev)
>  	struct denali_controller *denali =3D pci_get_drvdata(dev);
> =20
>  	denali_remove(denali);
> -	iounmap(denali->reg);
> -	iounmap(denali->host);
>  }
> =20
>  static struct pci_driver denali_pci_driver =3D {


Thanks,
Miqu=C3=A8l
