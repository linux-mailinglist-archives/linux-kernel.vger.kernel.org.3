Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F26B4842CC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 14:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbiADNwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 08:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiADNwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 08:52:50 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4295C061761;
        Tue,  4 Jan 2022 05:52:49 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 0F67392009C; Tue,  4 Jan 2022 14:52:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 0BBB192009B;
        Tue,  4 Jan 2022 13:52:48 +0000 (GMT)
Date:   Tue, 4 Jan 2022 13:52:47 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
cc:     Douglas Gilbert <dgilbert@interlog.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Nix <nix@esperi.org.uk>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] scsi: Set allocation length to 255 for ATA
 Information VPD page
In-Reply-To: <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
Message-ID: <alpine.DEB.2.21.2201032324230.56863@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2201020010540.56863@angie.orcam.me.uk> <alpine.DEB.2.21.2201020030130.56863@angie.orcam.me.uk> <d9eaa1f8-7abb-645b-d624-5069205c6983@interlog.com> <alpine.DEB.2.21.2201032017290.56863@angie.orcam.me.uk>
 <yq1tuek347m.fsf@ca-mkp.ca.oracle.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Martin,

> >  So I do have all the reasons to conclude this value has indeed been 
> > arbitrarily chosen, don't I?
> 
> The SAT spec defines the contents of the first part of the page. The
> trailing 512 bytes are defined in the ATA spec.

 I think that would best be reflected in code somehow as lone `64' doesn't 
say anything really.

> > If you insist that the value of 64 stay, then please come up with a
> > suitable macro name to define along with SCSI_VPD_PG_LEN that reflects
> > the meaning of 64 in this context and I'll be happy to update 3/3
> > accordingly, but please explain why the value of 64 is any better than
> > 255 here and the inconsistency with the buffer size justified.
> 
> Can please you try the following patch?

 I have tried it and it's neutral, that is with 1/3 applied the HBA still 
works and with 1/3 removed it still breaks (2/3 and 3/3 obviously don't 
build anymore).  Unsurprisingly, as it's the call to `scsi_get_vpd_page' 
rather than `scsi_get_vpd_buf' that causes an issue here.

 I think the latter function isn't called in my setup, and it's not clear 
to me anymore after so long why I didn't poke at it.  It looks to me like 
the `retry_pg' code there can be gone now with your update in place as it 
duplicates buffer sizing, and with that included it'll be a nice clean-up.

 NB you'll need to adjust drivers/scsi/mpt3sas/mpt3sas_scsih.c accordingly 
if we are to move forward with this change, as it's another user of the 
SCSI_VPD_PG_LEN macro.

 Given what has been said in the discussion so far would you consider 2/3
and 3/3 unnecessary?  In the course of verifying your change I have looked 
through our code again and found that inline magic numbers are there in 
several though not all places where `scsi_get_vpd_page' gets called, so I 
think it would make sense to get rid of them all at once with a single 
self-contained change.

 Thank you for your input and the extra fix.

  Maciej
