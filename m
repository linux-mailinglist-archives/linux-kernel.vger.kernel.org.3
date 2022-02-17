Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEA84BA69F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 18:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243532AbiBQRCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 12:02:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiBQRCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 12:02:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A581C559B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 09:02:25 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E404D210EA;
        Thu, 17 Feb 2022 17:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1645117343; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiWVcgKMRF4oGwbYjT6sKnv4e98q38gC3DQhU6hDsqE=;
        b=aADwiDuoqE3JwbEaVcrqjlcwdosq/AWmzOj0NGiC+00SeKmIoQ7NYwVRLNCcpUF3kGcOeG
        uhGw1zcJUYYGQjsPfH5B+lMgTKFGXPIouWmolbQkaVQsd4PcQRLc5grwazcWXkdsukOmfb
        BRPUQ96ALr8Ah+8KcxGD1dUUdSs/VQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1645117343;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiWVcgKMRF4oGwbYjT6sKnv4e98q38gC3DQhU6hDsqE=;
        b=ChP5ULLJBPE0xpkMyYdRm/KZr6LwigNcJu+hmzPe3OOLO2h0ZRdUMiQUb3IEKK7UKNPUhi
        8T4f1L8FjRP+iUBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C361013C23;
        Thu, 17 Feb 2022 17:02:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Lo/OLp9/DmKWDQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 17 Feb 2022 17:02:23 +0000
Message-ID: <1d615078-1417-500d-0521-5d8424da7212@suse.cz>
Date:   Thu, 17 Feb 2022 18:02:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] mm/slob: make kmem_cache_boot static
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220217085842.29032-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220217085842.29032-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 09:58, Miaohe Lin wrote:
> kmem_cache_boot is never accessed outside slob.c. Make it static.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks, adding to slab tree.

> ---
>  mm/slob.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/slob.c b/mm/slob.c
> index 60c5842215f1..1179bcad2df8 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -708,7 +708,7 @@ int __kmem_cache_shrink(struct kmem_cache *d)
>  	return 0;
>  }
>  
> -struct kmem_cache kmem_cache_boot = {
> +static struct kmem_cache kmem_cache_boot = {
>  	.name = "kmem_cache",
>  	.size = sizeof(struct kmem_cache),
>  	.flags = SLAB_PANIC,

