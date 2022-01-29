Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5214A2C47
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 08:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348883AbiA2HGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 02:06:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:53786 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243344AbiA2HGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 02:06:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31DEC60B65;
        Sat, 29 Jan 2022 07:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA0AC340E5;
        Sat, 29 Jan 2022 07:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643439981;
        bh=+9orCdx5OHHhlT7WVp0s9rE5tL8RNTogO1+pon4/4lk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHuxg106g2qBs0R/75fdVcw0HV82kniQZKT8AeS0WpsXntUo5uM59UqwswEZfvzHM
         0gItCXlqaRMCXkNfA2hf2n4zzkAkAfzyfV6FX9y8O4tvhdDopl/mp0mfgTOKXGhJsD
         4hI1LzPKaSVENNr/ZccGMXFw19Eyrj/NdYBNsNoc=
Date:   Sat, 29 Jan 2022 08:06:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Zhou Qingyang <zhou1615@umn.edu>, kjlu@umn.edu,
        Alexander Shiyan <shc_work@mail.ru>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: pata_platform: Fix a NULL pointer dereference in
 __pata_platform_probe()
Message-ID: <YfTnatj5sNOswqFk@kroah.com>
References: <20220124164525.53068-1-zhou1615@umn.edu>
 <YfPBb4gHDkr76xPT@kroah.com>
 <3621c7db-0b73-d7eb-f987-45ec59a6c738@opensource.wdc.com>
 <YfQSdJgi4x5hN3Ee@kroah.com>
 <45efc552-999b-c57b-5da1-0818893c031d@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45efc552-999b-c57b-5da1-0818893c031d@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 29, 2022 at 09:12:19AM +0900, Damien Le Moal wrote:
> On 1/29/22 00:57, Greg KH wrote:
> > On Fri, Jan 28, 2022 at 08:50:04PM +0900, Damien Le Moal wrote:
> >> On 1/28/22 19:11, Greg KH wrote:
> >>> On Tue, Jan 25, 2022 at 12:45:25AM +0800, Zhou Qingyang wrote:
> >>>> In __pata_platform_probe(), devm_kzalloc() is assigned to ap->ops and
> >>>> there is a dereference of it right after that, which could introduce a
> >>>> NULL pointer dereference bug.
> >>>>
> >>>> Fix this by adding a NULL check of ap->ops.
> >>>>
> >>>> This bug was found by a static analyzer.
> >>>>
> >>>> Builds with 'make allyesconfig' show no new warnings,
> >>>> and our static analyzer no longer warns about this code.
> >>>>
> >>>> Fixes: f3d5e4f18dba ("ata: pata_of_platform: Allow to use 16-bit wide data transfer")
> >>>> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> >>>> ---
> >>>
> >>> As stated in the past, please do not make contributions to the Linux
> >>> kernel until umn.edu has properly resolved its development issues.
> >>
> >> Aouch. My apologies. I forgot about this. Thank you for the reminder.
> >>
> >>>
> >>>> The analysis employs differential checking to identify inconsistent 
> >>>> security operations (e.g., checks or kfrees) between two code paths 
> >>>> and confirms that the inconsistent operations are not recovered in the
> >>>> current function or the callers, so they constitute bugs. 
> >>>>
> >>>> Note that, as a bug found by static analysis, it can be a false
> >>>> positive or hard to trigger. Multiple researchers have cross-reviewed
> >>>> the bug.
> >>>>
> >>>>  drivers/ata/pata_platform.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/drivers/ata/pata_platform.c b/drivers/ata/pata_platform.c
> >>>> index 028329428b75..021ef9cbcbc1 100644
> >>>> --- a/drivers/ata/pata_platform.c
> >>>> +++ b/drivers/ata/pata_platform.c
> >>>> @@ -128,6 +128,8 @@ int __pata_platform_probe(struct device *dev, struct resource *io_res,
> >>>>  	ap = host->ports[0];
> >>>>  
> >>>>  	ap->ops = devm_kzalloc(dev, sizeof(*ap->ops), GFP_KERNEL);
> >>>> +	if (ap->ops)
> >>>> +		return -ENOMEM;
> >>>
> >>> This change seems to leak memory.  Damien, please revert it.
> >>
> >> I fixed the patch when applying, so there is no leak.
> > 
> > Really?  What happened to the memory that ata_host_alloc() created above
> > this call?  How is that freed?
> > 
> >> This is a genuine (potential) bug fix.
> > 
> > As I tell others, how can kmalloc() ever fail here, so odd of this being
> > a real bugfix are so low it's not funny.  So take these types of
> > cleanups as a last-resort only after you have strongly validated that
> > they are correct.  The current group of people trying to do these fixes
> > have a horrible track-record and are getting things wrong way more than
> > they should be.  And so it is worse having code that "looks" correct vs.
> > something that is "obviously we need to handle this some day".
> 
> I completely agree that this is not fixing any real bug reported in the
> field. And as you say, an error here is more than unlikely. I accepted
> the patch only on the ground of code correctness.
> 
> > 
> >> Must I revert ?
> > 
> > If it's buggy you should, see my above question about ata_host_alloc(),
> > is there a cleanup path somewhere that I am missing?
> 
> The resources allocated by ata_host_alloc() are attached to the device
> (devres and drv_data) so they will be freed by ata_devres_release() when
> the dev is dropped due to the probe error. I think the return that the
> patch introduces is fine as is.
> 
> If I am misunderstanding the devres handling, please let me know.

Where does the data allocated in ata_host_alloc() on this line:
	host = kzalloc(sz, GFP_KERNEL);

Get attached to a devres structure?

It's a kref-managed data structure (see the call to kref_init() a few
lines down), and the memory will be freed if you release the last
reference on the kref, but that has nothing to do with devres.

There's also the ports memory attached to the host structure as well,
that is controlled by the lifetime of the kref, not a devres reference
that I can see.

Or am I missing some link somewhere here?

thanks,

greg k-h
