Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F84BE4E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377479AbiBUOQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 09:16:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377473AbiBUOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:16:40 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3241EACF;
        Mon, 21 Feb 2022 06:16:16 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3A8F420011;
        Mon, 21 Feb 2022 14:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1645452975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ODvyZvZqdacklZ9aM1iSEKqfNp5Cqiwau4V4K6DcxSs=;
        b=oJZZIw4nkZZWnxKikQFHjyWZwwa72kZ4pi7IZkfVWTGtxEfjPzQzznHFxx0FbDWFyn5mg/
        ZYfjr337cqAbq8xdt/wnmZifvFrrRqTVLb2jSIXhC6qul1XaHfX6IglEVANvJNpWxnv+Yn
        2/FleAKKgzYHkZjiBoiVpjqthS+QXjobIJ4fm/OEa4NpFYbXoYweoidME0tvC7/R8VWAK5
        ScipJ13S/lp80hemQw+1ZdGskmjzYZDGI7+hSOOsOn5SGEU7Z3yS7bZe8K6dCG8YpAMxLJ
        Ubm+iDleiWcBLkf/qBcfMPvMkQB8RlwNXfQmVGR6j6dH4X2DpwouOnuFL6uFcg==
Date:   Mon, 21 Feb 2022 15:16:12 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     broonie@kernel.org
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the nand tree with the mtd tree
Message-ID: <20220221151612.67a2dfbc@xps13>
In-Reply-To: <20220221135552.2196160-1-broonie@kernel.org>
References: <20220221135552.2196160-1-broonie@kernel.org>
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

Hello,

broonie@kernel.org wrote on Mon, 21 Feb 2022 13:55:52 +0000:

> Hi all,
>=20
> Today's linux-next merge of the nand tree got a conflict in:
>=20
>   Documentation/devicetree/bindings/mtd/nand-controller.yaml
>=20
> between commit:
>=20
>   751f204a6fe6f ("dt-bindings: mtd: nand-chip: Create a NAND chip descrip=
tion")
>=20
> from the mtd tree and commit:
>=20
>   cb57fae479be4 ("dt-binding: mtd: nand: Document the wp-gpios property")
>=20
> from the nand tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for fixing it up in -next. We will anyway merge the NAND tree
into the MTD tree before sending a unique PR so Linus won't have to
handle it.

>=20
> diff --cc Documentation/devicetree/bindings/mtd/nand-controller.yaml
> index 33855eb48a795,53b21aed0ac5f..0000000000000
> --- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
> @@@ -116,6 -154,20 +116,13 @@@ patternProperties
>             Ready/Busy pins. Active state refers to the NAND ready state =
and
>             should be set to GPIOD_ACTIVE_HIGH unless the signal is inver=
ted.
>  =20
> +       wp-gpios:
> +         description:
> +           Contains one GPIO descriptor for the Write Protect pin.
> +           Active state refers to the NAND Write Protect state and shoul=
d be
> +           set to GPIOD_ACTIVE_LOW unless the signal is inverted.
> +         maxItems: 1
> +=20
>  -      secure-regions:
>  -        $ref: /schemas/types.yaml#/definitions/uint64-matrix
>  -        description:
>  -          Regions in the NAND chip which are protected using a secure e=
lement
>  -          like Trustzone. This property contains the start address and =
size of
>  -          the secure regions present.
>  -
>       required:
>         - reg
>  =20


Thanks,
Miqu=C3=A8l
