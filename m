Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B074A3FBE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358042AbiAaKBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:01:12 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:49695 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358067AbiAaKAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:00:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B50BA100019;
        Mon, 31 Jan 2022 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643623209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JLypfuu9eD5lR+8vH9zCTJQ0pI816bRIJgTbUz2EOiE=;
        b=aWusl90GN7DxXseo2tb+6gdjHdQYkcud17Zi41tYtKt2Ia2A20U6tDxHhW9eZfkDUpg+2r
        0z/3B8LnDPUfAGuq0OTNQ2SZuBt5YUldajdg9KTzuzeNqdq/7PZsmLmzRScpLuv23lQi2+
        ex31USaA/RJhn9acO8Uos6bj+2/wRmoDSFbzyrRGyrW7r0C2dEqoJyzwZQPKP1ymZYATBl
        VjiWSY3xoOd/Qzk3TfZZbVqW3C6HAYvhMLPGNVdMQLAy6FxnBeV7pw0yhJ0nMynEdFjr0w
        XtgUF3SYArSW7u9WdMs/UdPaCgs/FhqfTYVELnqxsMiMSixFUJg8EFZMRxQB9g==
Date:   Mon, 31 Jan 2022 11:00:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix the size of the header read buffer.
Message-ID: <20220131110003.7aacad70@xps13>
In-Reply-To: <20220128220156.4057446-1-jmeurin@google.com>
References: <20220128220156.4057446-1-jmeurin@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean-Marc,

jmeurin@google.com wrote on Fri, 28 Jan 2022 14:01:56 -0800:

> The read buffer size depends on the MTDOOPS_HEADER_SIZE.
>=20
> Tested: Changed the header size, it doesn't panic, header is still
> read/written correctly.

On what Linux kernel version are you? It looks like we don't share the
same code base, are we?

>=20
> Signed-off-by: Jean-Marc Eurin <jmeurin@google.com>
> ---
>  drivers/mtd/mtdoops.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
> index 227df24387df..09a26747f490 100644
> --- a/drivers/mtd/mtdoops.c
> +++ b/drivers/mtd/mtdoops.c
> @@ -223,7 +223,7 @@ static void find_next_position(struct mtdoops_context=
 *cxt)
>  {
>  	struct mtd_info *mtd =3D cxt->mtd;
>  	int ret, page, maxpos =3D 0;
> -	u32 count[2], maxcount =3D 0xffffffff;
> +	u32 count[MTDOOPS_HEADER_SIZE/sizeof(u32)], maxcount =3D 0xffffffff;
>  	size_t retlen;
> =20
>  	for (page =3D 0; page < cxt->oops_pages; page++) {


Thanks,
Miqu=C3=A8l
