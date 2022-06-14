Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F005B54AC86
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242334AbiFNItu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242440AbiFNItX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:49:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7191825C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 01:48:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2D1E81F912;
        Tue, 14 Jun 2022 08:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655196523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRzsb+awEOHYFKjt3mE5gpf5ido2LM1NkdZFLfpaEQk=;
        b=dsUn+lRVuRLA8O6klB2mHKbYa+5gMXCG6uMk/6JsYd2jD3DccV2Wgco1VPtgniJdTWyxgb
        QrTCprF4RiQF0pugULngVTBbvKyOu1OktQBUBg1DY9Wep3qGqOGevoyS16S/key7y9DMOY
        wsM2nfZm1ExLk4fi6Ifh6lHFbXS/EAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655196523;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zRzsb+awEOHYFKjt3mE5gpf5ido2LM1NkdZFLfpaEQk=;
        b=khzxj90wasL7hXFh+KDYQNF+T3xe/BLtY+TmDIvy5suQEp7WFCMzftja8vO6lcBPOxPXfS
        Vz/bCei2ctto00Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F025B1361C;
        Tue, 14 Jun 2022 08:48:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AzkEOmpLqGIHKAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Jun 2022 08:48:42 +0000
Message-ID: <bb8d41fc-bd13-9563-7c54-2850f131e835@suse.cz>
Date:   Tue, 14 Jun 2022 10:48:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: check the function kmalloc_slab return value
Content-Language: en-US
To:     Ren Yu <renyu@nfschina.com>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, liqiong@nfschina.com,
        qixu@nfschina.com, hukun@nfschina.com, yuzhe@nfschina.com
References: <20220613102438.27723-1-renyu@nfschina.com>
 <20220614083939.13508-1-renyu@nfschina.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220614083939.13508-1-renyu@nfschina.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 10:39, Ren Yu wrote:
> As the possible failure of the kmalloc_slab,
> it should be better to check it.

AFAIK failure is not possible, kmalloc_slab() is not an allocation function,
it just returns a member of kmalloc_caches array, which is initialized
elsewhere and shouldn't contain NULLs. So the patch seems unnecessary to me.

> Signed-off-by: Ren Yu <renyu@nfschina.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
> v2:
> - fix build waring integer from pointer without a cast
> ---
> ---
>  mm/slab.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index f8cd00f4ba13..72135e555827 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2064,6 +2064,8 @@ int __kmem_cache_create(struct kmem_cache *cachep, slab_flags_t flags)
>  	if (OFF_SLAB(cachep)) {
>  		cachep->freelist_cache =
>  			kmalloc_slab(cachep->freelist_size, 0u);
> +		if (unlikely(ZERO_OR_NULL_PTR(cachep->freelist_cache)))

The usual way is "if (!cachep->freelist_cache)". Not sure why check for ZERO.

> +			return cachep->freelist_cache;

So in case of NULL this would return NULL, thus 0, but __kmem_cache_create()
return 0 on success, so it's wrong. You would have to return e.g. -ENOMEM.

>  	}
>  
>  	err = setup_cpu_cache(cachep, gfp);

