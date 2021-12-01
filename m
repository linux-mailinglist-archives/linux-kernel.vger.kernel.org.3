Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7267346474F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 07:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347012AbhLAGo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 01:44:57 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:39992 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347042AbhLAGon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:43 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A2D9C1FD5A;
        Wed,  1 Dec 2021 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638340881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n45iNofc+uMM52HFRm7p8XyGy0n9uJvF4roFGkoD8A4=;
        b=C7aShPDec+19JLcAn871zoHn7DY/NN+1JPQUHHP7icGt5seT2QlxgvUQL+CctDQehHxx4b
        T2ITnEFFc/NRHgUxf6Ljs+uedO7Gvn3fNDu67djmMSjSZHQb0pxFp7/Amy56rO//55fNtS
        k9P2gH4JLakcsiqz3yT31pGsVhNJswc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638340881;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n45iNofc+uMM52HFRm7p8XyGy0n9uJvF4roFGkoD8A4=;
        b=ilwXmOksLQJoNONY1Iohbro5PWhC6YdWeTaTsql6xWNyzRIkm/qUeh8CLeSHThz9WRDnev
        grAEdhTHDtqN+TDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72FD713425;
        Wed,  1 Dec 2021 06:41:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WJ/uGhEZp2EnBwAAMHmgww
        (envelope-from <hare@suse.de>); Wed, 01 Dec 2021 06:41:21 +0000
Subject: Re: [PATCH] scsi: libfc: Fix a NULL pointer dereference in
 fc_lport_ptp_setup()
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211130171049.199111-1-zhou1615@umn.edu>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <427c8138-b2bc-80db-2c01-24211633b0cf@suse.de>
Date:   Wed, 1 Dec 2021 07:41:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20211130171049.199111-1-zhou1615@umn.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/21 6:10 PM, Zhou Qingyang wrote:
> In fc_lport_ptp_setup(), fc_rport_create() is assigned to
> lport->ptp_rdata and there is a dereference of in fc_lport_ptp_setup(),
> which could lead to a NULL pointer dereference on failure of
> fc_rport_create().
> 
> Fix this bug by adding a check of fc_rport_create().
> 
> This bug was found by a static analyzer. The analysis employs
> differential checking to identify inconsistent security operations
> (e.g., checks or kfrees) between two code paths and confirms that the
> inconsistent operations are not recovered in the current function or
> the callers, so they constitute bugs.
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
> Builds with CONFIG_LIBFC=m show no new warnings,
> and our static analyzer no longer warns about this code.
> 
> Fixes: 2580064b5ec6 ("scsi: libfc: Replace ->rport_create callback with function call")
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
>   drivers/scsi/libfc/fc_lport.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/libfc/fc_lport.c b/drivers/scsi/libfc/fc_lport.c
> index 19cd4a95d354..5cd716afb711 100644
> --- a/drivers/scsi/libfc/fc_lport.c
> +++ b/drivers/scsi/libfc/fc_lport.c
> @@ -241,6 +241,13 @@ static void fc_lport_ptp_setup(struct fc_lport *lport,
>   	}
>   	mutex_lock(&lport->disc.disc_mutex);
>   	lport->ptp_rdata = fc_rport_create(lport, remote_fid);
> +	if (!lport->ptp_rdata) {
> +		mutex_unlock(&lport->disc.disc_mutex);
> +		printk(KERN_WARNING "libfc: Failed to allocate for the port (%6.6x)\n",
> +				remote_fid);
> +		return;
> +	}
> +
>   	kref_get(&lport->ptp_rdata->kref);
>   	lport->ptp_rdata->ids.port_name = remote_wwpn;
>   	lport->ptp_rdata->ids.node_name = remote_wwnn;
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
