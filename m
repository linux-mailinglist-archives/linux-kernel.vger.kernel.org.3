Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F594F5E56
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiDFMsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiDFMrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:47:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B91560F6
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 02:03:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E32F01F38A;
        Wed,  6 Apr 2022 09:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1649235804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrjnSu7MjHBeqhbgwuRAlgVZcIuW8Y0moN9j8NoG/2Y=;
        b=hK3uk7ZGEbYQ9rMasmKvb/ieiNW3V8pdEqG7wto/Ka98MV5hqlcBOjjzdc4iDGvzs7y9xg
        85Q40e4pWsJt06oN+1jHiFWMw2N9AjcCZWISGJWYBC84oXU5vXpDi5XizENheFcEuWsEQu
        dyqtnbYesQBoXzcTQPvIA7madlvgO4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1649235804;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrjnSu7MjHBeqhbgwuRAlgVZcIuW8Y0moN9j8NoG/2Y=;
        b=fJQD4Pq0hC66czHrzhbWHn2F86x6yzKpfmgdTskQvhKFEiSTcZCQumdQ1JHB4a9Q/UZX6u
        RBUWyQ0efG0HWVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AEE28139F5;
        Wed,  6 Apr 2022 09:03:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xx4BKlxXTWKPeQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 06 Apr 2022 09:03:24 +0000
Message-ID: <b3d4255d-2a63-b2cb-bd1b-dc7812d95fe9@suse.cz>
Date:   Wed, 6 Apr 2022 11:03:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/6] mm/slub: use stackdepot to save stack trace in
 objects
Content-Language: en-US
To:     David Rientjes <rientjes@google.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <20220404164112.18372-1-vbabka@suse.cz>
 <20220404164112.18372-4-vbabka@suse.cz>
 <5f7d33ec-1e73-cdfc-54e5-e93d346ac78@google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <5f7d33ec-1e73-cdfc-54e5-e93d346ac78@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 23:40, David Rientjes wrote:
>> -static void set_track(struct kmem_cache *s, void *object,
>> +static void noinline set_track(struct kmem_cache *s, void *object,
>>  			enum track_item alloc, unsigned long addr)
>>  {
>>  	struct track *p = get_track(s, object, alloc);
>>  
>> -#ifdef CONFIG_STACKTRACE
>> +#ifdef CONFIG_STACKDEPOT
>> +	unsigned long entries[TRACK_ADDRS_COUNT];
>>  	unsigned int nr_entries;
>>  
>> -	metadata_access_enable();
>> -	nr_entries = stack_trace_save(kasan_reset_tag(p->addrs),
>> -				      TRACK_ADDRS_COUNT, 3);
>> -	metadata_access_disable();
>> -
>> -	if (nr_entries < TRACK_ADDRS_COUNT)
>> -		p->addrs[nr_entries] = 0;
>> +	nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
>> +	p->handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> 
> I think this should also have __GFP_NOWARN set since this allocation could 
> easily fail and it would unnecessarily spam the kernel log unless we 
> actually care about the stack trace being printed later (and the patch 
> already indicates the allocation failed in print_track() when it matters).

Good point. But turns out __stack_depot_save() adds it for us already.

> Otherwise:
> 
> Acked-by: David Rientjes <rientjes@google.com>

Thanks!
