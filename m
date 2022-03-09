Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135644D2E11
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbiCILcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 06:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiCILcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 06:32:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A47170D5F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 03:31:31 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 44F721F381;
        Wed,  9 Mar 2022 11:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646825490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/mG7FVN+CfQanteTVX950RtdIdYr+omod/t3Qb0PBc=;
        b=UDZWYsThQjgNLTF389lYj6DmeqinJ2jJTtkXo/kBraeF8tEff7NCD6eqyBDchRx2qYdQwe
        2hIHXE8F9jt41cG8a8MG5/xL3wyniKIJTONsRHH9wsyG272mwkfULohQJXDayOnPtNLtsR
        Mk5xluBuFZ8MuN4eO3FgOhEgItizdZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646825490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c/mG7FVN+CfQanteTVX950RtdIdYr+omod/t3Qb0PBc=;
        b=21LSMdrFKMcgWskLwwMjMSqkRf6bIc2kbP2t97CmWVX6tisFvZH6Fpw1pvVIoNuXSpE+ep
        zt1OvQdGs5zsU4BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1EDA013B71;
        Wed,  9 Mar 2022 11:31:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bT/rBhKQKGJmZgAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 09 Mar 2022 11:31:30 +0000
Message-ID: <ca7c2dcb-3cf8-3cd3-a4c6-3fb7116ca6c8@suse.cz>
Date:   Wed, 9 Mar 2022 12:31:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] mm/slub: remove forced_order parameter in calculate_sizes
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220309092036.50844-1-linmiaohe@huawei.com>
 <20220309095522.GA1091946@odroid>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20220309095522.GA1091946@odroid>
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

On 3/9/22 10:55, Hyeonggon Yoo wrote:
> On Wed, Mar 09, 2022 at 05:20:36PM +0800, Miaohe Lin wrote:
>> Since commit 32a6f409b693 ("mm, slub: remove runtime allocation order
>> changes"), forced_order is always -1. Remove this unneeded parameter
>> to simplify the code.
>> 
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/slub.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>> 
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 180354d7e741..7f09901ae6b2 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -4038,7 +4038,7 @@ static void set_cpu_partial(struct kmem_cache *s)
>>   * calculate_sizes() determines the order and the distribution of data within
>>   * a slab object.
>>   */
>> -static int calculate_sizes(struct kmem_cache *s, int forced_order)
>> +static int calculate_sizes(struct kmem_cache *s)
>>  {
>>  	slab_flags_t flags = s->flags;
>>  	unsigned int size = s->object_size;
>> @@ -4142,10 +4142,7 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>>  	size = ALIGN(size, s->align);
>>  	s->size = size;
>>  	s->reciprocal_size = reciprocal_value(size);
>> -	if (forced_order >= 0)
>> -		order = forced_order;
>> -	else
>> -		order = calculate_order(size);
>> +	order = calculate_order(size);
>>  
>>  	if ((int)order < 0)
>>  		return 0;
>> @@ -4181,7 +4178,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  	s->random = get_random_long();
>>  #endif
>>  
>> -	if (!calculate_sizes(s, -1))
>> +	if (!calculate_sizes(s))
>>  		goto error;
>>  	if (disable_higher_order_debug) {
>>  		/*
>> @@ -4191,7 +4188,7 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>>  		if (get_order(s->size) > get_order(s->object_size)) {
>>  			s->flags &= ~DEBUG_METADATA_FLAGS;
>>  			s->offset = 0;
>> -			if (!calculate_sizes(s, -1))
>> +			if (!calculate_sizes(s))
>>  				goto error;
>>  		}
>>  	}
> 
> Looks good to me.
> 
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks both, added to slab-next

> Thanks!
> 
>> -- 
>> 2.23.0
> 
> --
> Thank you, You are awesome!
> Hyeonggon :-)

