Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D34678A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381220AbhLCNo7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Dec 2021 08:44:59 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:32895 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381211AbhLCNow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:44:52 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 4F7CC240011;
        Fri,  3 Dec 2021 13:41:24 +0000 (UTC)
Date:   Fri, 3 Dec 2021 14:41:23 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        sean@geanix.com, Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Daniel =?UTF-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: [next] WARNING: CPU: 2 PID: 66 at kernel/locking/rwsem.c:1298
 __up_read
Message-ID: <20211203144123.16c49eb4@xps13>
In-Reply-To: <20211202141958.638f224b@collabora.com>
References: <CA+G9fYuupqqemLbgoVL2kYL4d2AtZLBo1xcshWWae7gX5Ln-iA@mail.gmail.com>
        <CADYN=9KeKhZ-OSbx1QHKYfXu+p-nXVjubbay1sXd_g75LLSZRg@mail.gmail.com>
        <20211202141958.638f224b@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

boris.brezillon@collabora.com wrote on Thu, 2 Dec 2021 14:19:58 +0100:

> On Thu, 2 Dec 2021 13:28:46 +0100
> Anders Roxell <anders.roxell@linaro.org> wrote:
> 
> > On Tue, 30 Nov 2021 at 18:01, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:  
> > >
> > > [Please ignore this email if it is already reported]
> > >
> > > Regression found on qemu_arm64.
> > > Following kernel warnings reported on Linux next-20211130 while booting.    
> > 
> > I bisected down to 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT")
> > 
> > and when I reverted 1ebe2e5f9d68 ("block: remove GENHD_FL_EXT_DEVT") and the
> > 3 releated patches so patch 1ebe2e5f9d68 was reverted cleanly I
> > managed to boot without
> > a warning.
> > 
> > Related patches from next-20211130:
> > 9f18db572c97 ("block: don't set GENHD_FL_NO_PART for hidden gendisks")
> > 430cc5d3ab4d ("block: cleanup the GENHD_FL_* definitions")
> > a4561f9fccc5 ("sr: set GENHD_FL_REMOVABLE earlier")
> > 
> > With this said, if I revert 9d6abd489e70 ("mtd: core: protect access
> > to MTD devices while in suspend")
> > I didn't see the warning either.  
> 
> I think 9d6abd489e70 ("mtd: core: protect access to MTD devices while
> in suspend") is at fault here. Miquel, would you mind
> reverting/dropping the "mtd: core: protect access to mtd devices while
> in  suspend" series?

FYI I've just dropped the entire series. The change will probably be
effective in linux-next starting from next Monday.

> 
> > 
> > Any idea what can be wrong here or what a fix could be?
> > 
> > Only apply this patch from Geert
> > https://lore.kernel.org/lkml/c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be/
> > makes the warning go away too.
> > 
> > Cheers,
> > Anders  
> 


Thanks,
Miquèl
