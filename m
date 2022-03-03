Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010024CB79C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 08:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiCCH0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 02:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiCCH0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:26:51 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE2C16A58E;
        Wed,  2 Mar 2022 23:26:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7E16B219A5;
        Thu,  3 Mar 2022 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646292364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAm6aBODLiWVVxzqTP/nBuW3NSWlM2Lr77y8WTZdvaU=;
        b=DnW0ZAcybnZEocRHj1n7cOXGpRLWfnSFOpPjFwAxJ5tg0Syf8NqicRsiWkTPhHwiMDgDTD
        8/eQmzFAxniqnt+UqV9aSokyIwbbZjrh2Bprk3JzDjzmR0ZxrMeABn1UsOPHd8i7L1Cf0t
        +Xh6FjIT3rdw7S94zsFjBAABh6159GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646292364;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAm6aBODLiWVVxzqTP/nBuW3NSWlM2Lr77y8WTZdvaU=;
        b=x/7Tp3GxlfXUJIeaiasdPcvYNfLn+CakiVRjmdMLDIxcPy0zkRlYZUz+CZx71Z3KzYvDvi
        gX1rJQhpDNSUupDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5C2F013AB4;
        Thu,  3 Mar 2022 07:26:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id LiO/EoxtIGJWNQAAMHmgww
        (envelope-from <hare@suse.de>); Thu, 03 Mar 2022 07:26:04 +0000
Message-ID: <51943e86-e05c-8f3c-59de-e75af03a1efe@suse.de>
Date:   Thu, 3 Mar 2022 08:26:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] scsi: libfc: Fix use after free in fc_exch_abts_resp()
Content-Language: en-US
To:     Jianglei Nie <niejianglei2021@163.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220303015115.459778-1-niejianglei2021@163.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20220303015115.459778-1-niejianglei2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/3/22 02:51, Jianglei Nie wrote:
> fc_exch_release(ep) will decrease the ep's reference count. When the
> reference count reaches zero, it is freed. But ep is still used in the
> following code, which will lead to a use after free.
> 
> We should return the function after the call of fc_exch_release() to
> avoid use after free.
> 
> Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
> ---
>   drivers/scsi/libfc/fc_exch.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/scsi/libfc/fc_exch.c b/drivers/scsi/libfc/fc_exch.c
> index 841000445b9a..aa223db4cf53 100644
> --- a/drivers/scsi/libfc/fc_exch.c
> +++ b/drivers/scsi/libfc/fc_exch.c
> @@ -1701,6 +1701,7 @@ static void fc_exch_abts_resp(struct fc_exch *ep, struct fc_frame *fp)
>   	if (cancel_delayed_work_sync(&ep->timeout_work)) {
>   		FC_EXCH_DBG(ep, "Exchange timer canceled due to ABTS response\n");
>   		fc_exch_release(ep);	/* release from pending timer hold */
> +		return;
>   	}
>   
>   	spin_lock_bh(&ep->ex_lock);

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
