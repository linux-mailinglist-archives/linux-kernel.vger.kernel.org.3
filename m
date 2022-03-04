Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB2F4CDC79
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 19:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiCDSaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 13:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241692AbiCDSaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 13:30:11 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08221470C7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:29:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DF1AA21124;
        Fri,  4 Mar 2022 18:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646418561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pN3nycF2X6fHWfqQuX6WHc3ZTvBGGIZogfQbyTU9TQY=;
        b=JS8mNsZlZzebTZBrKrjP2ORPoEh4qRDNGWEXsJms7ABTQoo9OSPWXSFXVpqJ40ll438Bfm
        mMM3m7BQAd+lEBzo/IWV3dqyucr3ypAp9dlrR2tS+Wz/dvYPB5lQf0ykyRVxVQECcmiqPm
        BG9gP8wb+mJkphZGA3D+Xlykso64yb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646418561;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pN3nycF2X6fHWfqQuX6WHc3ZTvBGGIZogfQbyTU9TQY=;
        b=+XnwmCPfRIxYQks5Mt/fAUOkUf/w3L2B2pqtJM4o90jAYpm4rbPFQxLb9y3hjEO2xQ9fN5
        JaIBpv1FlR/Z9FDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B21B713B70;
        Fri,  4 Mar 2022 18:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PjvHKoFaImJjAwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 18:29:21 +0000
Message-ID: <a7a7fb5a-6c3b-d85f-e4aa-6027a941760d@suse.cz>
Date:   Fri, 4 Mar 2022 19:29:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/5] mm/sl[auo]b: move definition of __ksize() to
 mm/slab.h
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
References: <20220304063427.372145-1-42.hyeyoo@gmail.com>
 <20220304063427.372145-4-42.hyeyoo@gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220304063427.372145-4-42.hyeyoo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 07:34, Hyeonggon Yoo wrote:
> __ksize() is only called by KASAN. Remove export symbol and move
> definition to mm/slab.h as we don't want to grow its callers.
> 
> [ willy@infradead.org: Move definition to mm/slab.h and reduce comments ]
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -685,6 +685,8 @@ static inline void free_large_kmalloc(struct folio *folio, void *object)
>  }
>  #endif /* CONFIG_SLOB */
>  
> +size_t __ksize(const void *objp);
> +
>  static inline size_t slab_ksize(const struct kmem_cache *s)
>  {
>  #ifndef CONFIG_SLUB
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 1d2f92e871d2..b126fc7247b9 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1247,13 +1247,7 @@ EXPORT_SYMBOL(kfree_sensitive);
>  
>  #ifndef CONFIG_SLOB
>  /**

Maybe just /* so it's not even parsed as a kernel-doc anymore?

> - * __ksize -- Uninstrumented ksize.
> - * @objp: pointer to the object
> - *
> - * Unlike ksize(), __ksize() is uninstrumented, and does not provide the same
> - * safety checks as ksize() with KASAN instrumentation enabled.
> - *
> - * Return: size of the actual memory used by @objp in bytes
> + * __ksize -- Uninstrumented ksize. Only called by KASAN.
>   */
>  size_t __ksize(const void *object)
>  {
> @@ -1269,7 +1263,6 @@ size_t __ksize(const void *object)
>  
>  	return slab_ksize(folio_slab(folio)->slab_cache);
>  }
> -EXPORT_SYMBOL(__ksize);
>  #endif
>  
