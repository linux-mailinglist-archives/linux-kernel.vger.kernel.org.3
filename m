Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542E94CACDA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbiCBSDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244391AbiCBSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:03:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FC140D4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:02:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 527EB219A4;
        Wed,  2 Mar 2022 18:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646244167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpMptBy5lxZ47L5SBeGEkeqxAZo0oAQChaOv5FoBpiw=;
        b=F5lxpvm83w0+vlkK7b/3x6pW90wnl5tSoOnIfxbbb4V6gZfWHvKFKoKQ2imhgkkRpxrfxz
        p+qRianx0W07C1n6bPeKbmnziPErBiiR0CabMzAkLEcKLQkoZ06bwFRoHsA6lmUSLDZnCo
        frxb241/Ks3lgJQzM5LlyzEyKnhDH1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646244167;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpMptBy5lxZ47L5SBeGEkeqxAZo0oAQChaOv5FoBpiw=;
        b=gidx7uA+kXEptJVJQUeBYgOAv+YnCZNX4dm9gjpVMttm9pGRe+GttTeXM22ewd93+WLk9n
        uFO7oxCZKBapiYBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 189C713A98;
        Wed,  2 Mar 2022 18:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pddGBUexH2ICWAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 02 Mar 2022 18:02:47 +0000
Message-ID: <4a1c1470-30d0-2a21-0c03-64ffa2fc54c5@suse.cz>
Date:   Wed, 2 Mar 2022 19:02:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <20220302173122.11939-1-vbabka@suse.cz>
 <20220302173122.11939-2-vbabka@suse.cz> <Yh+tmJT0ov8uwC6/@elver.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 1/6] lib/stackdepot: allow requesting early
 initialization dynamically
In-Reply-To: <Yh+tmJT0ov8uwC6/@elver.google.com>
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

On 3/2/22 18:47, Marco Elver wrote:
> On Wed, Mar 02, 2022 at 06:31PM +0100, Vlastimil Babka wrote:
>> In a later patch we want to add stackdepot support for object owner
>> tracking in slub caches, which is enabled by slub_debug boot parameter.
>> This creates a bootstrap problem as some caches are created early in
>> boot when slab_is_available() is false and thus stack_depot_init()
>> tries to use memblock. But, as reported by Hyeonggon Yoo [1] we are
>> already beyond memblock_free_all(). Ideally memblock allocation should
>> fail, yet it succeeds, but later the system crashes, which is a
>> separately handled issue.
>> 
>> To resolve this boostrap issue in a robust way, this patch adds another
>> way to request stack_depot_early_init(), which happens at a well-defined
>> point of time. In addition to build-time CONFIG_STACKDEPOT_ALWAYS_INIT,
>> code that's e.g. processing boot parmeters (which happens early enough)
>> can set a new variable stack_depot_want_early_init as true.
> 
> Agree, I think this is the best solution.

Thanks.

>> In this patch we also convert page_owner to this approach. While it
>> doesn't have the bootstrap issue as slub, it's also a functionality
>> enabled by a boot param and can thus request stack_depot_early_init()
>> with memblock allocation instead of later initialization with
>> kvmalloc().
>> 
>> [1] https://lore.kernel.org/all/YhnUcqyeMgCrWZbd@ip-172-31-19-208.ap-northeast-1.compute.internal/
>> 
>> Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> ---
>>  include/linux/stackdepot.h | 16 ++++++++++++++--
>>  lib/stackdepot.c           |  2 ++
>>  mm/page_owner.c            |  9 ++++++---
>>  3 files changed, 22 insertions(+), 5 deletions(-)
>> 
>> diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
>> index 17f992fe6355..1217ba2b636e 100644
>> --- a/include/linux/stackdepot.h
>> +++ b/include/linux/stackdepot.h
>> @@ -15,6 +15,8 @@
>>  
>>  typedef u32 depot_stack_handle_t;
>>  
>> +extern bool stack_depot_want_early_init;
>> +
>>  depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>>  					unsigned int nr_entries,
>>  					gfp_t gfp_flags, bool can_alloc);
>> @@ -26,11 +28,21 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>>   * The alternative is to select STACKDEPOT_ALWAYS_INIT to have stack depot
>>   * enabled as part of mm_init(), for subsystems where it's known at compile time
>>   * that stack depot will be used.
>> + *
>> + * Another alternative is to set stack_depot_want_early_init as true, when the
>> + * decision to use stack depot is taken e.g. when evaluating kernel boot
>> + * parameters, which precedes the call to stack_depot_want_early_init().
>>   */
>>  int stack_depot_init(void);
> 
> I think for stack_depot_init() it might now be convenient to provide a
> no-op version automatically if !STACKDEPOT, which would avoid
> some 'if (.. && IS_ENABLED(CONFIG_STACKDEPOT))' in a later patch.
> 
> Similarly, for stack_depot_want_early_init, where instead you could
> simply provide stack_depot_want_early_init() as a function, which simply
> sets a boolean __stack_depot_want_early_init. If !STACKDEPOT, it'll also
> just be a no-op function.

Yeah, makes sense. I guess I have patch 3/6 wrong now anyway as with
!STACKDEPOT it should fail linking due to missing stack_depot_want_early_init...

>>  
>> -#ifdef CONFIG_STACKDEPOT_ALWAYS_INIT
>> -static inline int stack_depot_early_init(void)	{ return stack_depot_init(); }
>> +#ifdef CONFIG_STACKDEPOT
>> +static inline int stack_depot_early_init(void)
>> +{
>> +	if (IS_ENABLED(CONFIG_STACKDEPOT_ALWAYS_INIT)
>> +	    || stack_depot_want_early_init)
>> +		return stack_depot_init();
>> +	return 0;
>> +}
>>  #else
>>  static inline int stack_depot_early_init(void)	{ return 0; }
>>  #endif
>> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
>> index bf5ba9af0500..02e2b5fcbf3b 100644
>> --- a/lib/stackdepot.c
>> +++ b/lib/stackdepot.c
>> @@ -66,6 +66,8 @@ struct stack_record {
>>  	unsigned long entries[];	/* Variable-sized array of entries. */
>>  };
>>  
>> +bool stack_depot_want_early_init = false;
>> +
> 
> This can be __initdata, right?
 
I initially thought so too, but in include/linux/init.h found
 * Don't forget to initialize data not at file scope, i.e. within a function,
 * as gcc otherwise puts the data into the bss section and not into the init
 * section.
But maybe that's just outdated as everyone seems to init them at file scope.

>>  static void *stack_slabs[STACK_ALLOC_MAX_SLABS];
>>  
>>  static int depot_index;
>> diff --git a/mm/page_owner.c b/mm/page_owner.c
>> index 99e360df9465..40dce2b81d13 100644
>> --- a/mm/page_owner.c
>> +++ b/mm/page_owner.c
>> @@ -42,7 +42,12 @@ static void init_early_allocated_pages(void);
>>  
>>  static int __init early_page_owner_param(char *buf)
>>  {
>> -	return kstrtobool(buf, &page_owner_enabled);
>> +	int ret = kstrtobool(buf, &page_owner_enabled);
>> +
>> +	if (page_owner_enabled)
>> +		stack_depot_want_early_init = true;
>> +
>> +	return ret;
>>  }
>>  early_param("page_owner", early_page_owner_param);
>>  
>> @@ -80,8 +85,6 @@ static __init void init_page_owner(void)
>>  	if (!page_owner_enabled)
>>  		return;
>>  
>> -	stack_depot_init();
>> -
>>  	register_dummy_stack();
>>  	register_failure_stack();
>>  	register_early_stack();
>> -- 
>> 2.35.1
>> 

