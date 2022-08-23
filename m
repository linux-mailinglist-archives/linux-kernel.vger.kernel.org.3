Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75B659E8C8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343924AbiHWRIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345997AbiHWRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:06:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1779D4F61
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 07:04:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E7152224A5;
        Tue, 23 Aug 2022 14:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661263490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CD2l+I4MjMw0C0NBz+C57caAVjEFsSwQ3UTNjf+/spY=;
        b=sKLpVxYTCFCzey+bXYirzI2nbMxT0IYTquNrqguhNiiE6MT21Ae+d+HsWWNZu6elEZkXd5
        /75ZgG1c6s7Y3j1dOsPksjTdxygCq4oj0sEzepx6bEGbUA1yiURVubdNzeOvlGcViwiCFN
        /ivpUxhpDntQFz2WfKrZfL1EfHMmM5Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661263490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CD2l+I4MjMw0C0NBz+C57caAVjEFsSwQ3UTNjf+/spY=;
        b=gp14rMbaORLZCoNIRXyN7Ael/iuuDMsMhhsT/RaYpp7/I4NIGO9V8QEXN3msc0rvONKwNG
        yMyXbNMdZvY//gDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AB0BF13AB7;
        Tue, 23 Aug 2022 14:04:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Tl8tKILeBGPhdQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 23 Aug 2022 14:04:50 +0000
Message-ID: <04adfdfd-8907-fd26-06cd-bb03f39eeed8@suse.cz>
Date:   Tue, 23 Aug 2022 16:04:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH linux-next] mm/slab_common: Remove the unneeded result
 variable
Content-Language: en-US
To:     cgel.zte@gmail.com, 42.hyeyoo@gmail.com
Cc:     cl@linux.com, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20220823075241.209009-1-ye.xingchen@zte.com.cn>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220823075241.209009-1-ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/22 09:52, cgel.zte@gmail.com wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Return the value from __kmem_cache_shrink() directly instead of storing it
>  in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Thanks, added to slab.git for-6.1/trivial

> ---
>  mm/slab_common.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 17996649cfe3..0dfa3cfb6be5 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -495,13 +495,9 @@ EXPORT_SYMBOL(kmem_cache_destroy);
>   */
>  int kmem_cache_shrink(struct kmem_cache *cachep)
>  {
> -	int ret;
> -
> -
>  	kasan_cache_shrink(cachep);
> -	ret = __kmem_cache_shrink(cachep);
>  
> -	return ret;
> +	return __kmem_cache_shrink(cachep);
>  }
>  EXPORT_SYMBOL(kmem_cache_shrink);
>  

