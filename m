Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29499466A65
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376904AbhLBT1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376796AbhLBT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C873C06175C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:28 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 133so696307pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wHXIIvuoYAHZrBVWauQEqPWbcxtgWE/NXQOKZMGBwXU=;
        b=ngfmJbU+ZekCv1aLGMmEoKgODpS7TbPHwSiYGNktfucik37Qtr8kru//RXnU59lszW
         3G9D0rJDetlaOfsxYkFrOeFdnJTiQLImHj2wyHMy5ViRpG+lYYPFcHmarAlUpH2lA9Il
         kD5ElmOrab9qAOdqf9qmVRjqCdN03lmE8dqqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wHXIIvuoYAHZrBVWauQEqPWbcxtgWE/NXQOKZMGBwXU=;
        b=fCEC5FhDdApNRHZ/52hFxLp5/hNy7MaAiMBe0+Q6Xoi4Wq2qvSq8+xstZ7Bb7Moz5J
         9Gro3hdTGprdimPfG6By9bD+a3MuB2yr/j9ljb9QrXWm5JtmU/jVXe/+XKka+z7zkKTF
         U0Qd36Tocr9YeLPmNtDJChVEXkES+gFxRef8Wpd+ME34HDEZDviPhouaCmU531IiPUaY
         WFKdOnoXeRg4AkfMpYyOVFl7QlkTJko2HdqJdU2J/Sf+YxtpCpmkc7f3IDzgM53rV9mC
         fe//n3LcsexixiAWxeCqlW0471bzAzXvq532Rbn7NJk30v97HH4bBfpIXjNHkdWSkWHe
         YOQg==
X-Gm-Message-State: AOAM532j5BLyjQQAqzDjAkigx0sJuWDATWROHwQ8xyWpUjUX4pjrU1GT
        wX7EZxWEy0IjiXDI6FcDj++T5g==
X-Google-Smtp-Source: ABdhPJyIkoe0j9eMC19m5ws5v8Pf44+FFaH/FvbVfneo2Zw9LO0Kc6ebuM3i6LkIHUQlqxR1VFOUIQ==
X-Received: by 2002:a63:f43:: with SMTP id 3mr883306pgp.33.1638473007610;
        Thu, 02 Dec 2021 11:23:27 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm592254pfv.65.2021.12.02.11.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:27 -0800 (PST)
Date:   Thu, 2 Dec 2021 11:23:26 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Steffen Maier <maier@linux.ibm.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
Message-ID: <202112021113.D71F11B70@keescook>
References: <20211105091102.GA126301@embeddedor>
 <22139a80-3f64-1f21-6b5c-65d250bafe09@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22139a80-3f64-1f21-6b5c-65d250bafe09@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2021 at 12:24:13PM +0100, Steffen Maier wrote:
> On 11/5/21 10:11, Gustavo A. R. Silva wrote:
> > Use flexible-array members in struct fc_fdmi_attr_entry and
> > fs_fdmi_attrs instead of one-element arrays, and refactor the
> > code accordingly.
> > 
> > Also, turn the one-element array _port_ in struct fc_fdmi_rpl
> > into a simple object of type struct fc_fdmi_port_name, as it
> > seems there is no more than just one port expected:
> > 
> > $ git grep -nw numport drivers/scsi/
> > drivers/scsi/csiostor/csio_lnode.c:447: reg_pl->numport = htonl(1);
> > drivers/scsi/libfc/fc_encode.h:232:             put_unaligned_be32(1, &ct->payload.rhba.port.numport);
> > 
> > Also, this helps with the ongoing efforts to globally enable
> > -Warray-bounds and get us closer to being able to tighten the
> > FORTIFY_SOURCE routines on memcpy().
> > 
> > https://github.com/KSPP/linux/issues/79
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >   drivers/scsi/csiostor/csio_lnode.c | 2 +-
> >   drivers/scsi/libfc/fc_encode.h     | 4 ++--
> >   include/scsi/fc/fc_ms.h            | 6 +++---
> >   3 files changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
> > index d5ac93897023..cf9dd79ee488 100644
> > --- a/drivers/scsi/csiostor/csio_lnode.c
> > +++ b/drivers/scsi/csiostor/csio_lnode.c
> > @@ -445,7 +445,7 @@ csio_ln_fdmi_dprt_cbfn(struct csio_hw *hw, struct csio_ioreq *fdmi_req)
> >   	/* Register one port per hba */
> >   	reg_pl = (struct fc_fdmi_rpl *)pld;
> >   	reg_pl->numport = htonl(1);
> > -	memcpy(&reg_pl->port[0].portname, csio_ln_wwpn(ln), 8);
> > +	memcpy(&reg_pl->port.portname, csio_ln_wwpn(ln), 8);
> >   	pld += sizeof(*reg_pl);
> > 
> >   	/* Start appending HBA attributes hba */
> > diff --git a/drivers/scsi/libfc/fc_encode.h b/drivers/scsi/libfc/fc_encode.h
> > index 74ae7fd15d8d..5806f99e4061 100644
> > --- a/drivers/scsi/libfc/fc_encode.h
> > +++ b/drivers/scsi/libfc/fc_encode.h
> > @@ -232,7 +232,7 @@ static inline int fc_ct_ms_fill(struct fc_lport *lport,
> >   		put_unaligned_be32(1, &ct->payload.rhba.port.numport);
> >   		/* Port Name */
> >   		put_unaligned_be64(lport->wwpn,
> > -				   &ct->payload.rhba.port.port[0].portname);
> > +				   &ct->payload.rhba.port.port.portname);
> > 
> >   		/* HBA Attributes */
> >   		put_unaligned_be32(numattrs,
> 
> > diff --git a/include/scsi/fc/fc_ms.h b/include/scsi/fc/fc_ms.h
> > index 00191695233a..44fbe84fa664 100644
> > --- a/include/scsi/fc/fc_ms.h
> > +++ b/include/scsi/fc/fc_ms.h
> 
> > @@ -174,7 +174,7 @@ struct fs_fdmi_attrs {
> 
> /*
>  * Registered Port List
> 
> >    */
> >   struct fc_fdmi_rpl {
> >   	__be32				numport;
> > -	struct fc_fdmi_port_name	port[1];
> > +	struct fc_fdmi_port_name	port;
> >   } __attribute__((__packed__));
> 
> While I'm not affected by the change, it feels to me as if these are
> protocol definitions originating in a T11 Fibre Channel standard FC-GS. It's
> a port *list*. Can you "modify" the standard here?
> 
> The fact, that currently existing code users only ever seem to use one
> single port in the list, would be an independent thing to me.

There are three changes made here, and I suspect it might make sense to
split them up.

In a quick look, I see "struct fc_fdmi_attr_entry" has a sizeof() call
against it, so it's not clear if it's safe to switch it to a flexible
array without other changes.

The change to struct fs_fdmi_attrs looks okay, since it appears to be
used only in casts, but it might make sense to use diffoscope on the
changed .o files to validate nothing weird has happened.

For struct fc_dmi_rpl, as long as "numport" is always set/validated to
1, I think this change is fine.

-- 
Kees Cook
