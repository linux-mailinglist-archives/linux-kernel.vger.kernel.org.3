Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C96550FFF
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 08:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238030AbiFTGAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 02:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238471AbiFTGAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 02:00:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE47FDFAF;
        Sun, 19 Jun 2022 23:00:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 691DD1FE2A;
        Mon, 20 Jun 2022 06:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655704841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GswUVr0ZhAWodwRFNkoSTolL2HIdc/R2FTFhmKASFXE=;
        b=1qGjAb6Lpm/wjPSHSov0Lv9ErjOeGExLrBJJt6RYv1CXnuaC/rTtuURzhRnlfWCyPv5bjm
        HsVeKJKoKuWoTQQ9lNE8wl4Znx6WBBV4/AnJDcuHX3a5oZDK0gdnfH1hsIKI04cq76XtN3
        OxtH4K5u0Xpl1gpxFUm64ihFZ3cIfl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655704841;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GswUVr0ZhAWodwRFNkoSTolL2HIdc/R2FTFhmKASFXE=;
        b=u0wxVycqdASf0QBVTajlhw34y+xM50j4rnfzFP+P/sKqo0SoZZgyvQBoH6nSri2FjrE9VM
        LWtuQKlOiAz2tHDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA0E913638;
        Mon, 20 Jun 2022 06:00:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9y9bJQgNsGIUYgAAMHmgww
        (envelope-from <hare@suse.de>); Mon, 20 Jun 2022 06:00:40 +0000
Message-ID: <303bbfad-edde-1197-679e-4a09175fb1f3@suse.de>
Date:   Mon, 20 Jun 2022 08:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 3/4] scsi: pm8001: Use non-atomic bitmap ops for tag alloc
 + free
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        damien.lemoal@opensource.wdc.com, Ajish.Koshy@microchip.com
References: <1654879602-33497-1-git-send-email-john.garry@huawei.com>
 <1654879602-33497-4-git-send-email-john.garry@huawei.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <1654879602-33497-4-git-send-email-john.garry@huawei.com>
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

On 6/10/22 18:46, John Garry wrote:
> In pm8001_tag_alloc() we don't require atomic set_bit() as we are already
> in atomic context. In pm8001_tag_free() we should use the same host
> spinlock to protect clearing the tag (and then don't require the atomic
> clear_bit()).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/pm8001/pm8001_sas.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 3a863d776724..8e3f2f9ddaac 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -66,7 +66,11 @@ static int pm8001_find_tag(struct sas_task *task, u32 *tag)
>   void pm8001_tag_free(struct pm8001_hba_info *pm8001_ha, u32 tag)
>   {
>   	void *bitmap = pm8001_ha->tags;
> -	clear_bit(tag, bitmap);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pm8001_ha->bitmap_lock, flags);
> +	__clear_bit(tag, bitmap);
> +	spin_unlock_irqrestore(&pm8001_ha->bitmap_lock, flags);
>   }
>   
This spin lock is pretty much pointless; clear_bit() is always atomic.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
