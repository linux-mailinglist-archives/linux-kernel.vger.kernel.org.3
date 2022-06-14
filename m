Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DE054B221
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244024AbiFNNQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbiFNNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:16:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB0236B5F
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:15:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9988621B3F;
        Tue, 14 Jun 2022 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655212558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unBJziFr/l1u7Dc63FxxSI68un+DPyciUX2nsqLKcvI=;
        b=xiMYiLSKDPKrXKkLsQRw5h5hZd8eUxotBwUhO7FxWlUlFpYYSlwp4eiXYg1JlL1m8HdUn8
        E0QxS33JxpYuAFpWNhOgBTt+GKYtfX8u2sPUUymBX/yuuAZqt4+2drJvSicJzyilf6LOwS
        zhp7G/1LDjiirekyXhg+dCFq0vcAYPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655212558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unBJziFr/l1u7Dc63FxxSI68un+DPyciUX2nsqLKcvI=;
        b=yaIwPI80V/kxo7ivvJUeBLns588XBNOAwy1F6qgcEP/ydxKPSfj+JkyEhYRzlIPZUrAORz
        aIyF2avHgiO+X5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6BBAE1361C;
        Tue, 14 Jun 2022 13:15:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DGwDGQ6KqGKSIwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 14 Jun 2022 13:15:58 +0000
Message-ID: <4df0e708-166a-53dc-12c0-a1281d988d61@suse.cz>
Date:   Tue, 14 Jun 2022 15:15:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm, slab: fix bad alignments
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, cl@linux.com
Cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220609040132.89192-1-jiapeng.chong@linux.alibaba.com>
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

On 6/9/22 06:01, Jiapeng Chong wrote:
> As reported by coccicheck:
> 
> ./mm/slab.c:3253:2-59: code aligned with following code on line 3255.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks, added to slab/for-5.20/trivial

> ---
>  mm/slab.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index 47151fb2b2d2..c359c0f2c897 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -3223,7 +3223,7 @@ slab_alloc_node(struct kmem_cache *cachep, gfp_t flags, int nodeid, size_t orig_
>  	}
>  	/* ___cache_alloc_node can fall back to other nodes */
>  	ptr = ____cache_alloc_node(cachep, flags, nodeid);
> -  out:
> +out:
>  	local_irq_restore(save_flags);
>  	ptr = cache_alloc_debugcheck_after(cachep, flags, ptr, caller);
>  	init = slab_want_init_on_alloc(flags, cachep);
> @@ -3252,7 +3252,7 @@ __do_cache_alloc(struct kmem_cache *cache, gfp_t flags)
>  	if (!objp)
>  		objp = ____cache_alloc_node(cache, flags, numa_mem_id());
>  
> -  out:
> +out:
>  	return objp;
>  }
>  #else

