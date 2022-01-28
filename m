Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCA149F711
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347812AbiA1KR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347610AbiA1KRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:17:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3287CC061756;
        Fri, 28 Jan 2022 02:17:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92B461E4F;
        Fri, 28 Jan 2022 10:17:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2BAC340E0;
        Fri, 28 Jan 2022 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643365059;
        bh=NE9moxEkJQLOuFoFCkGyzfpGPfq0T+wDe/4lZ96J4t4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qFf+FYfJMnCn86TObANWG9rHETju2gy4tZZMxJMn19jnh+F0DfgXzDmYUTxNcqXda
         BiZZV56BBmx210+vV4PvVL2+Z/xfnQ/1YC5fk0iri4J6yRLOrTxBRS7pIJy33UC9h8
         W0ugVoHIM7kYXbp3R9tGKljFahCPdCM+D5ZQo8uY=
Date:   Fri, 28 Jan 2022 11:17:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Nagalakshmi Nandigama <Nagalakshmi.Nandigama@lsi.com>,
        James Bottomley <JBottomley@parallels.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: mpt3sas: FIx a NULL pointer dereference bug in
 mpt3sas_transport_port_add()
Message-ID: <YfPCukoJF3e3cqyu@kroah.com>
References: <20220124172120.62828-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124172120.62828-1-zhou1615@umn.edu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:21:20AM +0800, Zhou Qingyang wrote:
> In mpt3sas_transport_port_add(), sas_end_device_alloc() is assigned to rphy
> and there is a dereference of it. sas_end_device_alloc() could return NULL
> on failure of allocation, which could introduce a NULL pointer dereference
> bug.
> 
> The same as sas_expander_alloc().
> 
> Fix this bug by adding a NULL check of rphy.
> 
> This bug was found by a static analyzer.
> 
> Builds with 'make allyesconfig' show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: f92363d12359 ("mpt3sas: add new driver supporting 12GB SAS")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent 
> security operations (e.g., checks or kfrees) between two code paths 
> and confirms that the inconsistent operations are not recovered in the
> current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/scsi/mpt3sas/mpt3sas_transport.c b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> index 0681daee6c14..1caa929cf8bc 100644
> --- a/drivers/scsi/mpt3sas/mpt3sas_transport.c
> +++ b/drivers/scsi/mpt3sas/mpt3sas_transport.c
> @@ -823,6 +823,11 @@ mpt3sas_transport_port_add(struct MPT3SAS_ADAPTER *ioc, u16 handle,
>  			hba_port->sas_address =
>  			    mpt3sas_port->remote_identify.sas_address;
>  	}
> +	if (!rphy) {
> +		ioc_err(ioc, "failure at %s:%d/%s()!\n",
> +			__FILE__, __LINE__, __func__);
> +		goto out_fail;
> +	}
>  
>  	rphy->identify = mpt3sas_port->remote_identify;
>  
> -- 
> 2.25.1
> 

As stated before, umn.edu is still not allowed to contribute to the
Linux kernel.  Please work with your administration to resolve this
issue.

