Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0878584FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiG2Lu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbiG2Lux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:50:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BC2165B7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 04:50:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id BE5FD20DF8;
        Fri, 29 Jul 2022 11:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659095450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eI2PNmEUTHvyF7K2xumYQSpCfUFhWAfxz5uFA0UMNOU=;
        b=N5oMKKaHayNYtAu2F8Q8Xo7Ht8i12r4Z0DonJ3Z0E6RT7a/9tSznb6MojEel+8BgUmgNe3
        5pVQDzxij0D1MC984ybztLMv4dD012kYQ8jrjeNM2dmN3tTIGozNlYxOkYOPmxfqQtWaAT
        sWf26yqTRYynzI8TWOrrsUivTAgvjJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659095450;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eI2PNmEUTHvyF7K2xumYQSpCfUFhWAfxz5uFA0UMNOU=;
        b=0YVDli1nFygU9eU3lQqNrdfkPpGSd80F3/YOB7XONAMyxMy/etQV8zBPEfFLi1pCK+0W7x
        5nzyMlJFqFmD/6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 927D213A1B;
        Fri, 29 Jul 2022 11:50:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id norpIprJ42JoIgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 29 Jul 2022 11:50:50 +0000
Message-ID: <a8af7915-3c86-866c-3b35-bb42174a25b6@suse.cz>
Date:   Fri, 29 Jul 2022 13:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 16/16] mm/sl[au]b: check if large object is valid in
 __ksize()
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joe Perches <joe@perches.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        Matthew WilCox <willy@infradead.org>,
        Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220712133946.307181-1-42.hyeyoo@gmail.com>
 <20220712133946.307181-17-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220712133946.307181-17-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/22 15:39, Hyeonggon Yoo wrote:
> __ksize() returns size of objects allocated from slab allocator.
> When invalid object is passed to __ksize(), returning zero
> prevents further memory corruption and makes caller be able to
> check if there is an error.
> 
> If address of large object is not beginning of folio or size of
> the folio is too small, it must be invalid. Return zero in such cases.
> 
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

If you want to change it to BUG() I won't object, no strong opinion.

> ---
>  mm/slab_common.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1f8db7959366..0d6cbe9d7ad0 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1013,8 +1013,12 @@ size_t __ksize(const void *object)
>  
>  	folio = virt_to_folio(object);
>  
> -	if (unlikely(!folio_test_slab(folio)))
> +	if (unlikely(!folio_test_slab(folio))) {
> +		if (WARN_ON(object != folio_address(folio) ||
> +				folio_size(folio) <= KMALLOC_MAX_CACHE_SIZE))
> +			return 0;
>  		return folio_size(folio);
> +	}
>  
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }

