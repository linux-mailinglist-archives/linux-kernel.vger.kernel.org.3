Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39AE1472428
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhLMJec convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Dec 2021 04:34:32 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:58895 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhLMJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:33:54 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 81BBBFF808;
        Mon, 13 Dec 2021 09:33:51 +0000 (UTC)
Date:   Mon, 13 Dec 2021 10:33:50 +0100
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
Message-ID: <20211213103350.22590c13@xps13>
In-Reply-To: <20211213102801.569b50b1@collabora.com>
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
        <20211213102801.569b50b1@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

boris.brezillon@collabora.com wrote on Mon, 13 Dec 2021 10:28:01 +0100:

> On Mon, 13 Dec 2021 10:10:25 +0100
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Sean,
> > 
> > sean@geanix.com wrote on Fri, 10 Dec 2021 14:25:35 +0100:
> >   
> > > On Thu, Dec 09, 2021 at 03:28:11PM +0100, Miquel Raynal wrote:    
> > > > Hi Sean,
> > > > 
> > > > sean@geanix.com wrote on Thu, 9 Dec 2021 15:07:21 +0100:
> > > >       
> > > > > On Fri, Dec 03, 2021 at 02:39:58PM +0100, Miquel Raynal wrote:      
> > > > > > Hello,
> > > > > >         
> > > > > > > > Fine by me, lets drop this series.        
> > > > > > 
> > > > > > FYI I've dropped the entire series from mtd/next. I'm waiting for the
> > > > > > fix discussed below (without abusing the chip mutex ;-) ).        
> > > > > 
> > > > > Cool, looking forward to test a patch series :)      
> > > > 
> > > > Test? You mean "write"? :)
> > > > 
> > > > Cheers,
> > > > Miquèl      
> > > 
> > > Hi Miquel,
> > > 
> > > Should we us a atomic for the suspended variable?    
> > 
> > I haven't thought about it extensively, an atomic variable sound fine
> > but I am definitely not a locking expert...  
> 
> No need to use an atomic if the variable is already protected by a lock
> when accessed, and this seems to be case.

Maybe there was a confusion about this lock: I think Boris just do not
want the core to take any lock during a suspend operation. But you can
still use locks, as long as you release them before suspending.

And also, that chip lock might not be the one you want to take because
it's been introduced for another purpose.

> 
> >   
> > > 
> > > /Sean
> > > 
> > > diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> > > index b3a9bc08b4bb..eb4ec9a42d49 100644
> > > --- a/drivers/mtd/nand/raw/nand_base.c
> > > +++ b/drivers/mtd/nand/raw/nand_base.c
> > > @@ -338,16 +338,19 @@ static int nand_isbad_bbm(struct nand_chip *chip, loff_t ofs)
> > >   *
> > >   * Return: -EBUSY if the chip has been suspended, 0 otherwise  
> 
> You need to fix the documentation and make it clear that the caller
> will be blocked if the chip is suspended.
> 
> > >   */
> > > -static int nand_get_device(struct nand_chip *chip)
> > > +static void nand_get_device(struct nand_chip *chip)
> > >  {
> > > -	mutex_lock(&chip->lock);
> > > -	if (chip->suspended) {
> > > +	/* Wait until the device is resumed. */
> > > +	while (1) {
> > > +		mutex_lock(&chip->lock);
> > > +		if (!chip->suspended) {
> > > +			mutex_lock(&chip->controller->lock);
> > > +			return;
> > > +		}
> > >  		mutex_unlock(&chip->lock);
> > > -		return -EBUSY;
> > > -	}
> > > -	mutex_lock(&chip->controller->lock);
> > >  
> > > -	return 0;
> > > +		wait_event(chip->resume_wq, !chip->suspended);
> > > +	}
> > >  }
> > >  
> > >  /**
> > > @@ -576,9 +579,7 @@ static int nand_block_markbad_lowlevel(struct nand_chip *chip, loff_t ofs)
> > >  		nand_erase_nand(chip, &einfo, 0);
> > >  
> > >  		/* Write bad block marker to OOB */
> > > -		ret = nand_get_device(chip);
> > > -		if (ret)
> > > -			return ret;
> > > +		nand_get_device(chip);
> > >  
> > >  		ret = nand_markbad_bbm(chip, ofs);
> > >  		nand_release_device(chip);
> > > @@ -3759,9 +3760,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
> > >  	    ops->mode != MTD_OPS_RAW)
> > >  		return -ENOTSUPP;
> > >  
> > > -	ret = nand_get_device(chip);
> > > -	if (ret)
> > > -		return ret;
> > > +	nand_get_device(chip);
> > >  
> > >  	if (!ops->datbuf)
> > >  		ret = nand_do_read_oob(chip, from, ops);
> > > @@ -4352,9 +4351,7 @@ static int nand_write_oob(struct mtd_info *mtd, loff_t to,
> > >  
> > >  	ops->retlen = 0;
> > >  
> > > -	ret = nand_get_device(chip);
> > > -	if (ret)
> > > -		return ret;
> > > +	nand_get_device(chip);
> > >  
> > >  	switch (ops->mode) {
> > >  	case MTD_OPS_PLACE_OOB:
> > > @@ -4414,9 +4411,7 @@ int nand_erase_nand(struct nand_chip *chip, struct erase_info *instr,
> > >  		return -EIO;
> > >  
> > >  	/* Grab the lock and see if the device is available */
> > > -	ret = nand_get_device(chip);
> > > -	if (ret)
> > > -		return ret;
> > > +	nand_get_device(chip);
> > >  
> > >  	/* Shift to get first page */
> > >  	page = (int)(instr->addr >> chip->page_shift);
> > > @@ -4503,7 +4498,7 @@ static void nand_sync(struct mtd_info *mtd)
> > >  	pr_debug("%s: called\n", __func__);
> > >  
> > >  	/* Grab the lock and see if the device is available */
> > > -	WARN_ON(nand_get_device(chip));
> > > +	nand_get_device(chip);
> > >  	/* Release it and go back */
> > >  	nand_release_device(chip);
> > >  }
> > > @@ -4520,9 +4515,7 @@ static int nand_block_isbad(struct mtd_info *mtd, loff_t offs)
> > >  	int ret;
> > >  
> > >  	/* Select the NAND device */
> > > -	ret = nand_get_device(chip);
> > > -	if (ret)
> > > -		return ret;
> > > +	nand_get_device(chip);
> > >  
> > >  	nand_select_target(chip, chipnr);
> > >  
> > > @@ -4593,6 +4586,8 @@ static void nand_resume(struct mtd_info *mtd)
> > >  			__func__);
> > >  	}
> > >  	mutex_unlock(&chip->lock);
> > > +
> > > +	wake_up_all(&chip->resume_wq);
> > >  }
> > >  
> > >  /**
> > > @@ -5370,6 +5365,7 @@ static int nand_scan_ident(struct nand_chip *chip, unsigned int maxchips,
> > >  	chip->cur_cs = -1;
> > >  
> > >  	mutex_init(&chip->lock);
> > > +	init_waitqueue_head(&chip->resume_wq);
> > >  
> > >  	/* Enforce the right timings for reset/detection */
> > >  	chip->current_interface_config = nand_get_reset_interface_config();
> > > diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> > > index b2f9dd3cbd69..248054560581 100644
> > > --- a/include/linux/mtd/rawnand.h
> > > +++ b/include/linux/mtd/rawnand.h
> > > @@ -1294,6 +1294,7 @@ struct nand_chip {
> > >  	/* Internals */
> > >  	struct mutex lock;
> > >  	unsigned int suspended : 1;
> > > +	wait_queue_head_t resume_wq;
> > >  	int cur_cs;
> > >  	int read_retries;
> > >  	struct nand_secure_region *secure_regions;    
> > 
> > 
> > Thanks,
> > Miquèl  
> 


Thanks,
Miquèl
