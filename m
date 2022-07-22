Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C59557DA37
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiGVGXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiGVGXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:23:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A34237F6;
        Thu, 21 Jul 2022 23:23:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D84501FB6C;
        Fri, 22 Jul 2022 06:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658470993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bwvU2jM2541NokEqgrmZxlu5UK7D/HJkt3nQDJv4Fw=;
        b=bi0TEJUehKEs/BQndASOxEna8UgaWt3GzsKoevhxbM3Vgjfq+0QkseUW2gKjvHiWpO1JJ2
        DeHNuzQkXmWcblQJQ5W24ZAr8SP1VDiBGXu3mQ1vCFgxTmtV1vG9OtN/NGo5Wz3e6V9Rcy
        Yt+FGDQfTA2KHPT1I+Ts7sR+gXnfv4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658470993;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bwvU2jM2541NokEqgrmZxlu5UK7D/HJkt3nQDJv4Fw=;
        b=TZnzrJZJs9lEZo+/BvONd61roCDEKPwqax1IkizqN54MbNhuuwr09zWOnnS7GrgcpaTwwx
        IR4/IRI4MrqV1XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF42113ABC;
        Fri, 22 Jul 2022 06:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HDbFLVFC2mLZFAAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 22 Jul 2022 06:23:13 +0000
Message-ID: <dfb1060c-d5fb-c375-848a-e9bcd2492f31@suse.de>
Date:   Fri, 22 Jul 2022 08:23:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme-auth: Uninitialized variable in
 nvme_auth_transform_key()
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <YtU/tS/E2W9m+aau@kili>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <YtU/tS/E2W9m+aau@kili>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/22 13:10, Dan Carpenter wrote:
> A couple of the early error gotos call kfree_sensitive(transformed_key);
> before "transformed_key" has been initialized.
> 
> Fixes: a476416bb57b ("nvme: implement In-Band authentication")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> I wrote this several times in different ways, and kept on doing it
> wrong so in the end I wrote it this way.  It's a bigger diff, but I
> think it's the clearest way to write it.
> 
>   drivers/nvme/common/auth.c | 25 ++++++++++++++++---------
>   1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index bfb16fec0aed..1890193c7333 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -278,26 +278,33 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
>   	shash->tfm = key_tfm;
>   	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
>   	if (ret < 0)
> -		goto out_free_shash;
> +		goto out_free_transformed_key;
>   	ret = crypto_shash_init(shash);
>   	if (ret < 0)
> -		goto out_free_shash;
> +		goto out_free_transformed_key;
>   	ret = crypto_shash_update(shash, nqn, strlen(nqn));
>   	if (ret < 0)
> -		goto out_free_shash;
> +		goto out_free_transformed_key;
>   	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
>   	if (ret < 0)
> -		goto out_free_shash;
> +		goto out_free_transformed_key;
>   	ret = crypto_shash_final(shash, transformed_key);
> +	if (ret < 0)
> +		goto out_free_transformed_key;
> +
> +	kfree(shash);
> +	crypto_free_shash(key_tfm);
> +
> +	return transformed_key;
> +
> +out_free_transformed_key:
> +	kfree_sensitive(transformed_key);
>   out_free_shash:
>   	kfree(shash);
>   out_free_key:
>   	crypto_free_shash(key_tfm);
> -	if (ret < 0) {
> -		kfree_sensitive(transformed_key);
> -		return ERR_PTR(ret);
> -	}
> -	return transformed_key;
> +
> +	return ERR_PTR(ret);
>   }
>   EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
>   
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Ivo Totev, Andrew
Myers, Andrew McDonald, Martje Boudien Moerman
