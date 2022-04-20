Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF386508ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381312AbiDTRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245568AbiDTRt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:49:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD46346160
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5651F21115;
        Wed, 20 Apr 2022 17:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1650476799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPKj1rP2AQLJCqCkLIk+hRWAp78yyekfr57wPaz0OuY=;
        b=WgXu1WO4DQaQcLt/m6WI0ZwRBQtftWuEk9Ku29SMuhf7mbEwKSeHzNApe03ApLHrL6rVYN
        G+bZ3ZZ1PGggIK9Yp27+6r/yvqD+9OvpiYnCoqjaO/dNYAXClLuSQ6s0oLh3lpvn+Vp2Az
        B/o6PcbEwbWQaoXQ7C9sf8OWsHOZaYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1650476799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tPKj1rP2AQLJCqCkLIk+hRWAp78yyekfr57wPaz0OuY=;
        b=5hbhob32n4hrYjFGAsS1tWcunZrB6GlAXGIbW/JGzO2BN7/UfV+mX9uCBZA1ih0EM485hN
        shfyfZmonLcMv5Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3133313AD5;
        Wed, 20 Apr 2022 17:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id E4guC/9GYGK0awAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 20 Apr 2022 17:46:39 +0000
Message-ID: <97a82c11-128d-94a7-d874-a3fbebcce64c@suse.cz>
Date:   Wed, 20 Apr 2022 19:46:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] mm/slub: remove unneeded return value of slab_pad_check
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Cc:     roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220419120352.37825-1-linmiaohe@huawei.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220419120352.37825-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 14:03, Miaohe Lin wrote:
> The return value of slab_pad_check is never used. So we can make it return
> void now.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Added, thanks.

> ---
>  mm/slub.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 6dc703488d30..1f699ddfff7f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1017,7 +1017,7 @@ static int check_pad_bytes(struct kmem_cache *s, struct slab *slab, u8 *p)
>  }
>  
>  /* Check the pad bytes at the end of a slab page */
> -static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
> +static void slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  {
>  	u8 *start;
>  	u8 *fault;
> @@ -1027,21 +1027,21 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	int remainder;
>  
>  	if (!(s->flags & SLAB_POISON))
> -		return 1;
> +		return;
>  
>  	start = slab_address(slab);
>  	length = slab_size(slab);
>  	end = start + length;
>  	remainder = length % s->size;
>  	if (!remainder)
> -		return 1;
> +		return;
>  
>  	pad = end - remainder;
>  	metadata_access_enable();
>  	fault = memchr_inv(kasan_reset_tag(pad), POISON_INUSE, remainder);
>  	metadata_access_disable();
>  	if (!fault)
> -		return 1;
> +		return;
>  	while (end > fault && end[-1] == POISON_INUSE)
>  		end--;
>  
> @@ -1050,7 +1050,6 @@ static int slab_pad_check(struct kmem_cache *s, struct slab *slab)
>  	print_section(KERN_ERR, "Padding ", pad, remainder);
>  
>  	restore_bytes(s, "slab padding", POISON_INUSE, fault, end);
> -	return 0;
>  }
>  
>  static int check_object(struct kmem_cache *s, struct slab *slab,
> @@ -1642,8 +1641,7 @@ static inline int free_debug_processing(
>  	void *head, void *tail, int bulk_cnt,
>  	unsigned long addr) { return 0; }
>  
> -static inline int slab_pad_check(struct kmem_cache *s, struct slab *slab)
> -			{ return 1; }
> +static inline void slab_pad_check(struct kmem_cache *s, struct slab *slab) {}
>  static inline int check_object(struct kmem_cache *s, struct slab *slab,
>  			void *object, u8 val) { return 1; }
>  static inline void add_full(struct kmem_cache *s, struct kmem_cache_node *n,

