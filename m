Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CFA57DA34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiGVGWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:22:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA4E47B87;
        Thu, 21 Jul 2022 23:22:09 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 718901F99C;
        Fri, 22 Jul 2022 06:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658470927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VKRxjbe8Ws5L3Gl51lGCcQOzguBHdCK09NDRA9lFWs=;
        b=UkHjnO+efyLg4Jx3PLuusrTBC/tFXCxyn4TQ0v/8SBgNdjoZ/A70OIyjw8+03SH1uXAvb2
        W0WVrmUsKYkglOabPKMg2mTcLBbjxobDsoTjHsXlMTsy1boKVrvikWsjp8pJFLBtygmtvG
        hcstwZdlABClWdSjTRsCV+pQThYell4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658470927;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1VKRxjbe8Ws5L3Gl51lGCcQOzguBHdCK09NDRA9lFWs=;
        b=41icutbnFGwkyKNns+yXkLwy343HkTA8RzgVZko6k3heYn2C2m8XfaPj3V38KT+3zclrC1
        7NjI/Dm15Wr6o+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5659113ABC;
        Fri, 22 Jul 2022 06:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EvwjFA9C2mJ1FAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 22 Jul 2022 06:22:07 +0000
Message-ID: <10c59d89-2bbd-ae7c-d1cf-97d5c58c7330@suse.de>
Date:   Fri, 22 Jul 2022 08:22:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] nvme-auth: Fix off by one checks
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <YtU/bFMYRCrx6tgp@kili>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YtU/bFMYRCrx6tgp@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 13:09, Dan Carpenter wrote:
> The > ARRAY_SIZE() checks need to be >= ARRAY_SIZE() to prevent reading
> one element beyond the end of the arrays.
> 
> Fixes: a476416bb57b ("nvme: implement In-Band authentication")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The MAINTAINERS file needs to be updated for this new code.
> 
>   drivers/nvme/common/auth.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 0c86ebce59d2..bfb16fec0aed 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -55,7 +55,7 @@ static struct nvme_auth_dhgroup_map {
>   
>   const char *nvme_auth_dhgroup_name(u8 dhgroup_id)
>   {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>   	    !dhgroup_map[dhgroup_id].name ||
>   	    !strlen(dhgroup_map[dhgroup_id].name))
>   		return NULL;
> @@ -65,7 +65,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_dhgroup_name);
>   
>   const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id)
>   {
> -	if ((dhgroup_id > ARRAY_SIZE(dhgroup_map)) ||
> +	if ((dhgroup_id >= ARRAY_SIZE(dhgroup_map)) ||
>   	    !dhgroup_map[dhgroup_id].kpp ||
>   	    !strlen(dhgroup_map[dhgroup_id].kpp))
>   		return NULL;
> @@ -113,7 +113,7 @@ static struct nvme_dhchap_hash_map {
>   
>   const char *nvme_auth_hmac_name(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].hmac ||
>   	    !strlen(hash_map[hmac_id].hmac))
>   		return NULL;
> @@ -123,7 +123,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_name);
>   
>   const char *nvme_auth_digest_name(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].digest ||
>   	    !strlen(hash_map[hmac_id].digest))
>   		return NULL;
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_id);
>   
>   size_t nvme_auth_hmac_hash_len(u8 hmac_id)
>   {
> -	if ((hmac_id > ARRAY_SIZE(hash_map)) ||
> +	if ((hmac_id >= ARRAY_SIZE(hash_map)) ||
>   	    !hash_map[hmac_id].hmac ||
>   	    !strlen(hash_map[hmac_id].hmac))
>   		return 0;

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
