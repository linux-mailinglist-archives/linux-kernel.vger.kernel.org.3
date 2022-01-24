Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5CD49790B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 07:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiAXGtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 01:49:09 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:57110 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiAXGtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 01:49:08 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 535FC1F380;
        Mon, 24 Jan 2022 06:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643006947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJg+IkXmgmP8g2ybnmPsLzGXCdIpMZLvBP0eNdIIUPI=;
        b=hSZmjxvgFvGZOYQllLY4BjoLLu/r1S+gdrnJntoFQz+JB1A4h/JEe4Gp3htth1MJgfLUEi
        qiMs5Z6LvDr2GFpByStxqMOALM6vWNbelgLzRJbMQjM987Dw+Ex7VsNIBXIzU7aaVfFqeM
        XJfqN68u3ZWKhZIJM35dTCgxN2HCMRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643006947;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJg+IkXmgmP8g2ybnmPsLzGXCdIpMZLvBP0eNdIIUPI=;
        b=Z7O58UE1FYqMKgeUCSKcmZD+5ch1dGpVqnv62l6kvEmPkVuq0U5k4wdyTKaG3MFgrwZCJs
        IXtYUM0uOF8aaiDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 134E71332F;
        Mon, 24 Jan 2022 06:49:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SKX+AeNL7mFWegAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 24 Jan 2022 06:49:07 +0000
Message-ID: <b41aa99d-baf2-0fef-6d01-454a3b8213d2@suse.de>
Date:   Mon, 24 Jan 2022 07:49:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1] scsi: myrs: fix crash on error case
Content-Language: en-US
To:     Tong Zhang <ztong0001@gmail.com>,
        Hannes Reinecke <hare@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220123225717.1069538-1-ztong0001@gmail.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220123225717.1069538-1-ztong0001@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/22 23:57, Tong Zhang wrote:
> In myrs_detect(), cs->disable_intr is NULL when privdata->hw_init() fail
> with non-zero. In this case, myrs_cleanup(cs) will call a NULL ptr and
> crash kernel.
> 
> [    1.105606] myrs 0000:00:03.0: Unknown Initialization Error 5A
> [    1.105872] myrs 0000:00:03.0: Failed to initialize Controller
> [    1.106082] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [    1.110774] Call Trace:
> [    1.110950]  myrs_cleanup+0xe4/0x150 [myrs]
> [    1.111135]  myrs_probe.cold+0x91/0x56a [myrs]
> [    1.111302]  ? DAC960_GEM_intr_handler+0x1f0/0x1f0 [myrs]
> [    1.111500]  local_pci_probe+0x48/0x90
> 
> Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> ---
>   drivers/scsi/myrs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/myrs.c b/drivers/scsi/myrs.c
> index 253ceca54a84..7eb8c39da366 100644
> --- a/drivers/scsi/myrs.c
> +++ b/drivers/scsi/myrs.c
> @@ -2267,7 +2267,8 @@ static void myrs_cleanup(struct myrs_hba *cs)
>   	myrs_unmap(cs);
>   
>   	if (cs->mmio_base) {
> -		cs->disable_intr(cs);
> +		if (cs->disable_intr)
> +			cs->disable_intr(cs);
>   		iounmap(cs->mmio_base);
>   		cs->mmio_base = NULL;
>   	}
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
