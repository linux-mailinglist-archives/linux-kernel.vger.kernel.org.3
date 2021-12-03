Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5378F46789C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381192AbhLCNn1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Dec 2021 08:43:27 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:54619 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381196AbhLCNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:43:26 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id D6B7A200005;
        Fri,  3 Dec 2021 13:39:59 +0000 (UTC)
Date:   Fri, 3 Dec 2021 14:39:58 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v5 3/4] mtd: core: protect access to MTD devices while
 in suspend
Message-ID: <20211203143958.40645506@xps13>
In-Reply-To: <20211130143705.5d0404aa@collabora.com>
References: <20211102110204.3334609-4-sean@geanix.com>
        <CGME20211123120353eucas1p2fb2561b7cfddd8d6e7decaef8b504f4c@eucas1p2.samsung.com>
        <21092c0f-e11b-ac16-ab96-2a0556c0e30a@samsung.com>
        <20211123125012.ibzqu44ixmykbhkt@skn-laptop>
        <20211123140715.280b2f70@collabora.com>
        <20211129101908.6f1aa715@xps13>
        <20211129094129.xn364czofrgtvfb4@skn-laptop>
        <63be9121-18c3-1ef2-c448-f99fb861490f@samsung.com>
        <20211130124131.6pgu7enjgk6y536m@skn-laptop>
        <20211130141551.400331c8@collabora.com>
        <20211130132912.v6v45boce2zbnoy3@skn-laptop>
        <20211130143705.5d0404aa@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > Fine by me, lets drop this series.

FYI I've dropped the entire series from mtd/next. I'm waiting for the
fix discussed below (without abusing the chip mutex ;-) ).

Cheers,
Miquèl

> > We have +10.000 devices that runs with this patch:
> > 
> > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > index 1f0d542d5923..58d48c3070fa 100644
> > --- a/drivers/mtd/nand/raw/nand_base.c
> > +++ b/drivers/mtd/nand/raw/nand_base.c
> > @@ -4337,7 +4337,6 @@ static int nand_suspend(struct mtd_info *mtd)
> >  		ret = chip->ops.suspend(chip);
> >  	if (!ret)
> >  		chip->suspended = 1;
> > -	mutex_unlock(&chip->lock);
> >  
> >  	return ret;
> >  }
> > @@ -4350,7 +4349,6 @@ static void nand_resume(struct mtd_info *mtd)
> >  {
> >  	struct nand_chip *chip = mtd_to_nand(mtd);
> >  
> > -	mutex_lock(&chip->lock);
> >  	if (chip->suspended) {
> >  		if (chip->ops.resume)
> >  			chip->ops.resume(chip);
> >   
> 
> But it's abusing the chip lock... Use a wait queue as we did at the MTD
> level, and make nand_get_device() wait on this wait queue when the
> device is suspended.
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
