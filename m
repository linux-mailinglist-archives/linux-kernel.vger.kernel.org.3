Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E7E54C29B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 09:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbiFOH0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 03:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiFOH0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 03:26:16 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDA4738C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 00:26:15 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2A6651F899;
        Wed, 15 Jun 2022 07:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655277974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3JeAaNVMF2xcanrQW/ZU6P2wx6xjXOxRPoxu/fL7xo=;
        b=CWENStBe3S+ypC1pbgUlWdhbv5lC2N5znwoBetrptGqdKk7kSpc+w8CdeyLvR7YHb11yoM
        Zd6mIxtcoPkiDRbgXiXkDFD1n8UvbefsP0nRUr1G6Qd0MhpHeg7vytyU8mC/7FRr2oC9Un
        qgW5XRpqXMhL4+ssYJCTPPHrQXcMHVU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655277974;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k3JeAaNVMF2xcanrQW/ZU6P2wx6xjXOxRPoxu/fL7xo=;
        b=qWPFWW7LTMeR+CrzetQcyDIjcVJ+5V4M6S69lSahvkWBEpBTHup1JvscXvpLzG4xhcDT13
        bavSiyvbQdHEa+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 043FE139F3;
        Wed, 15 Jun 2022 07:26:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id S0AkAJaJqWICBQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 15 Jun 2022 07:26:14 +0000
Message-ID: <3c899066-d85d-3bd7-5b13-d5228b7aeb93@suse.cz>
Date:   Wed, 15 Jun 2022 09:26:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mm/slub: Simplify __kmem_cache_alias()
Content-Language: en-US
To:     sxwjean@me.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <xiongwei.song@windriver.com>
References: <20220531005550.10613-1-sxwjean@me.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220531005550.10613-1-sxwjean@me.com>
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

On 5/31/22 02:55, sxwjean@me.com wrote:
> From: Xiongwei Song <xiongwei.song@windriver.com>
> 
> There is no need to do anything if sysfs_slab_alias() return nonzero
> value after getting a mergeable cache.
> 
> Signed-off-by: Xiongwei Song <xiongwei.song@windriver.com>

Thanks, added to slab/for-5.20/cleanup

> ---
>  mm/slub.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index d8d5abf49f5f..9444277d669a 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -4861,6 +4861,9 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  
>  	s = find_mergeable(size, align, flags, name, ctor);
>  	if (s) {
> +		if (sysfs_slab_alias(s, name))
> +			return NULL;
> +
>  		s->refcount++;
>  
>  		/*
> @@ -4869,11 +4872,6 @@ __kmem_cache_alias(const char *name, unsigned int size, unsigned int align,
>  		 */
>  		s->object_size = max(s->object_size, size);
>  		s->inuse = max(s->inuse, ALIGN(size, sizeof(void *)));
> -
> -		if (sysfs_slab_alias(s, name)) {
> -			s->refcount--;
> -			s = NULL;
> -		}
>  	}
>  
>  	return s;

