Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF5F4A81AD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349782AbiBCJrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbiBCJrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:47:00 -0500
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AE4C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:47:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3923C200018;
        Thu,  3 Feb 2022 09:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643881618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5Jk2Zg/jlnzRSMuz3x0o8u6pgBwywiIWqNlylIDzik=;
        b=FJP4qh95Kbu7zw26XluYKyrhAzkUwwlYyfNwTNiNcTTqTP8F/XXU35UWacDuPTJjweoYEL
        GiYjvWHc3hP69mR6Nd8Y0X0WY1MhVMAE0YigfhdKbkDTFm6Yu3ty06aWvtNuFAP7d/DjX7
        07kNGOCCR7yu9HNPPsuBlqObJA+bm99wZDIvMY+LYOn7+NsuVHHfCklCayId2CpF6Y4Z7q
        CyRux8QYr/Z54JvD/4L9g9CK7j7Dvj1objxwbKHwaSMbZC9vELYTo7Un6BxICoGvKpQ3//
        pVIe7usTj7Dk0FeyvXGdhXTmYPjK4+X/EGYWZzhO1tyN32ChRI3QEgTDofZlSg==
Date:   Thu, 3 Feb 2022 10:46:54 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
Message-ID: <20220203104654.6cb43ea3@xps13>
In-Reply-To: <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
References: <20220125104822.8420-1-kernel@kempniu.pl>
        <20220125104822.8420-5-kernel@kempniu.pl>
        <1173246756.12597.1643879936765.JavaMail.zimbra@nod.at>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

richard@nod.at wrote on Thu, 3 Feb 2022 10:18:56 +0100 (CET):

> Micha=C5=82,
>=20
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Micha=C5=82 K=C4=99pie=C5=84" <kernel@kempniu.pl>
> > An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod=
.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> > CC: "Boris Brezillon" <boris.brezillon@collabora.com>, "linux-mtd" <lin=
ux-mtd@lists.infradead.org>, "linux-kernel"
> > <linux-kernel@vger.kernel.org>
> > Gesendet: Dienstag, 25. Januar 2022 11:48:22
> > Betreff: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl =20
>=20
> > +	if (req.start + req.len > mtd->size) { =20
>=20
> I think this can overflow since both req.start and req.len are u64.
> So an evil-doer might bypass this check.
>=20
> > +		ret =3D -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	datbuf_len =3D min_t(size_t, req.len, mtd->erasesize);
> > +	if (datbuf_len > 0) {
> > +		datbuf =3D kmalloc(datbuf_len, GFP_KERNEL); =20
>=20
> If mtd->erasesize is large (which is not uncommon these days) you might
> request more from kmalloc() than it can serve.
> Maybe kvmalloc() makes more sense?

Mmmh, I would really like these buffers dma-able.

I just discovered mtd_kmalloc_up_to(). Would this work?

>=20
> > +		if (!datbuf) {
> > +			ret =3D -ENOMEM;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	oobbuf_len =3D min_t(size_t, req.ooblen, mtd->erasesize);
> > +	if (oobbuf_len > 0) {
> > +		oobbuf =3D kmalloc(oobbuf_len, GFP_KERNEL); =20
>=20
> Same.
>=20
> Thanks,
> //richard


Thanks,
Miqu=C3=A8l
