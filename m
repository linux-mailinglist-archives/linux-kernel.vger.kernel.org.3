Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146334723CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbhLMJ2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:28:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbhLMJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:28:45 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F4C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:28:44 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B7F761F44957;
        Mon, 13 Dec 2021 09:28:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639387722; bh=s/3YHODxTsyDf2kILZMedX/lcHccoNYLXp6/+n9Sn3c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a5gtmajzup2dEW7fOaa5NxSgBLHYzOrhC1yCLvBWWgV6X+BTUmga4EoBwq1ZdXiUp
         ITBwu01QtwM6N4mZJIJgv28Kjl6pvFkl7rf01klHyk4ctcBfns/9kCw9zcqQVbEBio
         IBJr6KjpTbBtNpxofpBnJkgJnxZgK/z7FjhuSh2YNS/nmaTXTonmJmBGyHKVkJQor+
         ITXRcYliyID9P0vIFvWPQeLWAlbrTPsLWzdd4P4MjAs45Bu58qHJ3WMRJm82wL3vHR
         Z+qto7WGDt1dnbR9OFpvl2P7Trf72vfbS7VRVeeBnVRmUdObKgDuZTPxFCKhrHBiZB
         APMWWI2YcEIOA==
Date:   Mon, 13 Dec 2021 10:28:01 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211213102801.569b50b1@collabora.com>
In-Reply-To: <20211213101025.42c27b43@xps13>
References: <20211129101908.6f1aa715@xps13>
        <20211129094129.xn364czofrgtvfb4@skn-laptop>
        <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
        <20211130124131.6pgu7enjgk6y536m@skn-laptop>
        <20211130141551.400331c8@collabora.com>
        <20211130132912.v6v45boce2zbnoy3@skn-laptop>
        <20211130143705.5d0404aa@collabora.com>
        <20211203143958.40645506@xps13>
        <20211209140721.6ki7gznvxwyn3cze@skn-laptop.hinnerup>
        <20211209152811.318bdf17@xps13>
        <20211210132535.gy7rqj5zblqlnz5y@skn-laptop.hadsten>
        <20211213101025.42c27b43@xps13>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 10:10:25 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Sean,
>=20
> sean@geanix.com wrote on Fri, 10 Dec 2021 14:25:35 +0100:
>=20
> > On Thu, Dec 09, 2021 at 03:28:11PM +0100, Miquel Raynal wrote: =20
> > > Hi Sean,
> > >=20
> > > sean@geanix.com wrote on Thu, 9 Dec 2021 15:07:21 +0100:
> > >    =20
> > > > On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wrote:   =20
> > > > > Hello,
> > > > >      =20
> > > > > > > Fine by me, lets drop this series.     =20
> > > > >=20
> > > > > FYI I've dropped the entire series from mtd/next. I'm waiting for=
 the
> > > > > fix discussed below (without abusing the chip mutex ;-) ).     =20
> > > >=20
> > > > Cool, looking forward to test a patch series :)   =20
> > >=20
> > > Test? You mean "write"? :)
> > >=20
> > > Cheers,
> > > Miqu=C3=A8l   =20
> >=20
> > Hi Miquel,
> >=20
> > Should we us a atomic for the suspended variable? =20
>=20
> I haven't thought about it extensively, an atomic variable sound fine
> but I am definitely not a locking expert...

No need to use an atomic if the variable is already protected by a lock
when accessed, and this seems to be case.

>=20
> >=20
> > /Sean
> >=20
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/na=
nd_base.c
> > index b3a9bc08b4bb..eb4ec9a42d49 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -338,16 +338,19 @@ static int nand_isbad_bbm(struct nand_chip *chip,=
 loff_t ofs)
> >   *
> >   * Return: -EBUSY if the chip has been suspended, 0 otherwise

You need to fix the documentation and make it clear that the caller
will be blocked if the chip is suspended.

> >   */
> > -static int nand_get_device(struct nand_chip *chip)
> > +static void nand_get_device(struct nand_chip *chip)
> >  {
> > -	mutex_lock(&chip->lock);
> > -	if (chip->suspended) {
> > +	/* Wait until the device is resumed. */
> > +	while (1) {
> > +		mutex_lock(&chip->lock);
> > +		if (!chip->suspended) {
> > +			mutex_lock(&chip->controller->lock);
> > +			return;
> > +		}
> >  		mutex_unlock(&chip->lock);
> > -		return -EBUSY;
> > -	}
> > -	mutex_lock(&chip->controller->lock);
> > =20
> > -	return 0;
> > +		wait_event(chip->resume_wq, !chip->suspended);
> > +	}
> >  }
> > =20
> >  /**
> > @@ -576,9 +579,7 @@ static int nand_block_markbad_lowlevel(struct nand_=
chip *chip, loff_t ofs)
> >  		nand_erase_nand(chip, &einfo, 0);
> > =20
> >  		/* Write bad block marker to OOB */
> > -		ret =3D nand_get_device(chip);
> > -		if (ret)
> > -			return ret;
> > +		nand_get_device(chip);
> > =20
> >  		ret =3D nand_markbad_bbm(chip, ofs);
> >  		nand_release_device(chip);
> > @@ -3759,9 +3760,7 @@ static int nand_read_oob(struct mtd_info *mtd, lo=
ff_t from,
> >  	    ops->mode !=3D MTD_OPS_RAW)
> >  		return -ENOTSUPP;
> > =20
> > -	ret =3D nand_get_device(chip);
> > -	if (ret)
> > -		return ret;
> > +	nand_get_device(chip);
> > =20
> >  	if (!ops->datbuf)
> >  		ret =3D nand_do_read_oob(chip, from, ops);
> > @@ -4352,9 +4351,7 @@ static int nand_write_oob(struct mtd_info *mtd, l=
off_t to,
> > =20
> >  	ops->retlen =3D 0;
> > =20
> > -	ret =3D nand_get_device(chip);
> > -	if (ret)
> > -		return ret;
> > +	nand_get_device(chip);
> > =20
> >  	switch (ops->mode) {
> >  	case MTD_OPS_PLACE_OOB:
> > @@ -4414,9 +4411,7 @@ int nand_erase_nand(struct nand_chip *chip, struc=
t erase_info *instr,
> >  		return -EIO;
> > =20
> >  	/* Grab the lock and see if the device is available */
> > -	ret =3D nand_get_device(chip);
> > -	if (ret)
> > -		return ret;
> > +	nand_get_device(chip);
> > =20
> >  	/* Shift to get first page */
> >  	page =3D (int)(instr->addr >> chip->page_shift);
> > @@ -4503,7 +4498,7 @@ static void nand_sync(struct mtd_info *mtd)
> >  	pr_debug("%s: called\n", __func__);
> > =20
> >  	/* Grab the lock and see if the device is available */
> > -	WARN_ON(nand_get_device(chip));
> > +	nand_get_device(chip);
> >  	/* Release it and go back */
> >  	nand_release_device(chip);
> >  }
> > @@ -4520,9 +4515,7 @@ static int nand_block_isbad(struct mtd_info *mtd,=
 loff_t offs)
> >  	int ret;
> > =20
> >  	/* Select the NAND device */
> > -	ret =3D nand_get_device(chip);
> > -	if (ret)
> > -		return ret;
> > +	nand_get_device(chip);
> > =20
> >  	nand_select_target(chip, chipnr);
> > =20
> > @@ -4593,6 +4586,8 @@ static void nand_resume(struct mtd_info *mtd)
> >  			__func__);
> >  	}
> >  	mutex_unlock(&chip->lock);
> > +
> > +	wake_up_all(&chip->resume_wq);
> >  }
> > =20
> >  /**
> > @@ -5370,6 +5365,7 @@ static int nand_scan_ident(struct nand_chip *chip=
, unsigned int maxchips,
> >  	chip->cur_cs =3D -1;
> > =20
> >  	mutex_init(&chip->lock);
> > +	init_waitqueue_head(&chip->resume_wq);
> > =20
> >  	/* Enforce the right timings for reset/detection */
> >  	chip->current_interface_config =3D nand_get_reset_interface_config();
> > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > index b2f9dd3cbd69..248054560581 100644
> > --- a/include/linux/mtd/rawnand.h
> > +++ b/include/linux/mtd/rawnand.h
> > @@ -1294,6 +1294,7 @@ struct nand_chip {
> >  	/* Internals */
> >  	struct mutex lock;
> >  	unsigned int suspended : 1;
> > +	wait_queue_head_t resume_wq;
> >  	int cur_cs;
> >  	int read_retries;
> >  	struct nand_secure_region *secure_regions; =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

