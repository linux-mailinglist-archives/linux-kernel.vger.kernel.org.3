Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD0466A86
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376989AbhLBTi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376978AbhLBTiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:38:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41061C06174A;
        Thu,  2 Dec 2021 11:35:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08378B82484;
        Thu,  2 Dec 2021 19:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CBCC00446;
        Thu,  2 Dec 2021 19:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638473698;
        bh=FK+eCTetTN0+lRiupU50oP7xqu/bxbKrZZJL/xjtz4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S/m/KCCp52qzR2Rbfu5DHz+J1HT6puKyeMvPN0SLpgdzYW9ILoqbiNAi7H36rkQLP
         KtK+0Svm7LICJE/Oofz0MjPfGyXRF8roi3jWV6uswPAmoQLZfJcOYVUoD1tj7gBftP
         RDVXPe2U19MRI23yD8sku4MMn2NPIyD/RgLA2UcAS85cqYp380Va4x3PdolluOFgsR
         pMljSC5Ei0VhhpU9hgOEDlP2KihWpVhBme8odJVbWoivQROYUAxFIAOD4Xc9t7lNy5
         4glgzoP5HLBEPUsuBID7LbziY3qWkdi3P+KB5O88XBJV30bTTEi7DnIgkrX5xhZ2Gp
         Iu+Fg5oZpGKQg==
Date:   Thu, 2 Dec 2021 13:40:20 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Steffen Maier <maier@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Javed Hasan <jhasan@marvell.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Neerav Parikh <neerav.parikh@intel.com>,
        Ross Brattain <ross.b.brattain@intel.com>,
        Robert Love <robert.w.love@intel.com>
Subject: Re: [PATCH][next] scsi: Replace one-element arrays with
 flexible-array members
Message-ID: <20211202194020.GA13288@embeddedor>
References: <20211105091102.GA126301@embeddedor>
 <22139a80-3f64-1f21-6b5c-65d250bafe09@linux.ibm.com>
 <202112021113.D71F11B70@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112021113.D71F11B70@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:23:26AM -0800, Kees Cook wrote:
> On Fri, Nov 05, 2021 at 12:24:13PM +0100, Steffen Maier wrote:
> > On 11/5/21 10:11, Gustavo A. R. Silva wrote:
> > > Use flexible-array members in struct fc_fdmi_attr_entry and
> > > fs_fdmi_attrs instead of one-element arrays, and refactor the
> > > code accordingly.
> > > 
> > > Also, turn the one-element array _port_ in struct fc_fdmi_rpl
> > > into a simple object of type struct fc_fdmi_port_name, as it
> > > seems there is no more than just one port expected:
> > > 
> > > $ git grep -nw numport drivers/scsi/
> > > drivers/scsi/csiostor/csio_lnode.c:447: reg_pl->numport = htonl(1);
> > > drivers/scsi/libfc/fc_encode.h:232:             put_unaligned_be32(1, &ct->payload.rhba.port.numport);
> > > 
> > > Also, this helps with the ongoing efforts to globally enable
> > > -Warray-bounds and get us closer to being able to tighten the
> > > FORTIFY_SOURCE routines on memcpy().
> > > 
> > > https://github.com/KSPP/linux/issues/79
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   drivers/scsi/csiostor/csio_lnode.c | 2 +-
> > >   drivers/scsi/libfc/fc_encode.h     | 4 ++--
> > >   include/scsi/fc/fc_ms.h            | 6 +++---
> > >   3 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
> > > index d5ac93897023..cf9dd79ee488 100644
> > > --- a/drivers/scsi/csiostor/csio_lnode.c
> > > +++ b/drivers/scsi/csiostor/csio_lnode.c
> > > @@ -445,7 +445,7 @@ csio_ln_fdmi_dprt_cbfn(struct csio_hw *hw, struct csio_ioreq *fdmi_req)
> > >   	/* Register one port per hba */
> > >   	reg_pl = (struct fc_fdmi_rpl *)pld;
> > >   	reg_pl->numport = htonl(1);
> > > -	memcpy(&reg_pl->port[0].portname, csio_ln_wwpn(ln), 8);
> > > +	memcpy(&reg_pl->port.portname, csio_ln_wwpn(ln), 8);
> > >   	pld += sizeof(*reg_pl);
> > > 
> > >   	/* Start appending HBA attributes hba */
> > > diff --git a/drivers/scsi/libfc/fc_encode.h b/drivers/scsi/libfc/fc_encode.h
> > > index 74ae7fd15d8d..5806f99e4061 100644
> > > --- a/drivers/scsi/libfc/fc_encode.h
> > > +++ b/drivers/scsi/libfc/fc_encode.h
> > > @@ -232,7 +232,7 @@ static inline int fc_ct_ms_fill(struct fc_lport *lport,
> > >   		put_unaligned_be32(1, &ct->payload.rhba.port.numport);
> > >   		/* Port Name */
> > >   		put_unaligned_be64(lport->wwpn,
> > > -				   &ct->payload.rhba.port.port[0].portname);
> > > +				   &ct->payload.rhba.port.port.portname);
> > > 
> > >   		/* HBA Attributes */
> > >   		put_unaligned_be32(numattrs,
> > 
> > > diff --git a/include/scsi/fc/fc_ms.h b/include/scsi/fc/fc_ms.h
> > > index 00191695233a..44fbe84fa664 100644
> > > --- a/include/scsi/fc/fc_ms.h
> > > +++ b/include/scsi/fc/fc_ms.h
> > 
> > > @@ -174,7 +174,7 @@ struct fs_fdmi_attrs {
> > 
> > /*
> >  * Registered Port List
> > 
> > >    */
> > >   struct fc_fdmi_rpl {
> > >   	__be32				numport;
> > > -	struct fc_fdmi_port_name	port[1];
> > > +	struct fc_fdmi_port_name	port;
> > >   } __attribute__((__packed__));
> > 
> > While I'm not affected by the change, it feels to me as if these are
> > protocol definitions originating in a T11 Fibre Channel standard FC-GS. It's
> > a port *list*. Can you "modify" the standard here?
> > 
> > The fact, that currently existing code users only ever seem to use one
> > single port in the list, would be an independent thing to me.
> 
> There are three changes made here, and I suspect it might make sense to
> split them up.
> 
> In a quick look, I see "struct fc_fdmi_attr_entry" has a sizeof() call
> against it, so it's not clear if it's safe to switch it to a flexible
> array without other changes.

I'll take a look.

> The change to struct fs_fdmi_attrs looks okay, since it appears to be
> used only in casts, but it might make sense to use diffoscope on the
> changed .o files to validate nothing weird has happened.

OK. 

> For struct fc_dmi_rpl, as long as "numport" is always set/validated to
> 1, I think this change is fine.

OK. I'll split this up into a small series and keep

	struct fc_fdmi_port_name	port[1];

as a one-element array.

Thanks
--
Gustavo
