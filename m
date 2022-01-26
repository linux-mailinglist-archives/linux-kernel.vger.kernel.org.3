Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A575449C8C2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 12:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240804AbiAZLg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 06:36:29 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:56004 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240790AbiAZLg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 06:36:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33AC4B81CA9;
        Wed, 26 Jan 2022 11:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8ACC340E3;
        Wed, 26 Jan 2022 11:36:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643196986;
        bh=GHeHlsvXCNKkFQP+IuCKOX43wwk37uoc7LzHlpZ8P2s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DxFgKLu9Ms4VLfvBqkUMjxJpdhebgHNZNqLKVZalbrrs9z4tg5ZpwQtq0Jbu0USu1
         bkLw3Xsaw/sTWCcyC+a+sNf4w71gpfLrTTu4tB+hXHiSPNgmjgpdCe+YiPJaQq2p/d
         Ysji4KTQgLYMFZqdnYXoHMJWGP4sKIoniX+F8drO9/Y6tu/tPL8A9sKMZpa+MZibI1
         2lQAZHghHi5CEeBM/gqslCBrXZA88FRYdS5FV/YmN5twT/VfTp2W0om01xEDYFt3PA
         XNOhCBOfI3+Mw8IYju+6hsh4EHcVCgyvT9vy8vA5RBm2q33J1tA4i+aspv+NtvtXMx
         RSiOpqMfM2vrw==
Date:   Wed, 26 Jan 2022 17:06:18 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mdalam@codeaurora.org,
        sricharan@codeaurora.org
Subject: Re: [PATCH] mtd: nand: raw: qcom_nandc: Don't clear_bam_transaction
 on READID
Message-ID: <20220126113618.GB212068@thinkpad>
References: <20220113184427.2259509-1-konrad.dybcio@somainline.org>
 <20220114082718.32a2fc83@xps13>
 <20220126111613.3ab0021e@xps13>
 <20220126103316.GA212068@thinkpad>
 <20220126114200.4cc3c21b@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220126114200.4cc3c21b@xps13>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 11:42:00AM +0100, Miquel Raynal wrote:
> Hi Mani,
> 
> mani@kernel.org wrote on Wed, 26 Jan 2022 16:03:16 +0530:
> 
> > On Wed, Jan 26, 2022 at 11:16:13AM +0100, Miquel Raynal wrote:
> > > Hello,
> > > 
> > > miquel.raynal@bootlin.com wrote on Fri, 14 Jan 2022 08:27:18 +0100:
> > >   
> > > > Hi Konrad,
> > > > 
> > > > konrad.dybcio@somainline.org wrote on Thu, 13 Jan 2022 19:44:26 +0100:
> > > >   
> > > > > While I have absolutely 0 idea why and how, running clear_bam_transaction
> > > > > when READID is issued makes the DMA totally clog up and refuse to function
> > > > > at all on mdm9607. In fact, it is so bad that all the data gets garbled
> > > > > and after a short while in the nand probe flow, the CPU decides that
> > > > > sepuku is the only option.
> > > > > 
> > > > > Removing _READID from the if condition makes it work like a charm, I can
> > > > > read data and mount partitions without a problem.
> > > > > 
> > > > > Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > > > ---
> > > > > This is totally just an observation which took me an inhumane amount of
> > > > > debug prints to find.. perhaps there's a better reason behind this, but
> > > > > I can't seem to find any answers.. Therefore, this is a BIG RFC!    
> > > > 
> > > > I'm adding two people from codeaurora who worked a lot on this driver.
> > > > Hopefully they will have an idea :)  
> > > 
> > > Sadre, I've spent a significant amount of time reviewing your patches,
> > > now it's your turn to not take a month to answer to your peers
> > > proposals.
> > > 
> > > Please help reviewing this patch.
> > >   
> > 
> > Sorry. I was hoping that Qcom folks would chime in as I don't have any idea
> > about the mdm9607 platform. It could be that the mail server migration from
> > codeaurora to quicinc put a barrier here.
> > 
> > Let me ping them internally.
> 
> Oh, ok, I didn't know. Thanks!
> 

Pinged them.

> > > BTW why is this driver still using cmdfund? It should have been
> > > migrated to ->exec_op() a long time ago.  
> > 
> > I'll look into it.
> 
> That would be great, given the number of updates this driver has
> received, it would be nice to tackle the legacy bits there.
> 

Sure! I've added this to my to-do list for the coming weeks.

Thanks,
Mani

> Thanks,
> Miquèl
