Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2343A4CD40F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 13:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiCDMLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 07:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiCDMLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 07:11:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543D51A6F8B
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 04:10:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F1155212BC;
        Fri,  4 Mar 2022 12:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646395829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiHKQkRYUt668ercIEOIMDOIj6Aaki3wrBz805lW9wU=;
        b=bubmxdrTkThh3Xcu7VWDBjTiB1svqmTTR/PXOFKc6ONscNWGzbOmyuvQrhJImThaIcNwL6
        5AvQanRlSJGYKtnIJvJmhm9hEO8EnZTHFx+cklrEJMKN3SQQUSxHsx07KtJHDQuSgVtHGd
        JTLxjDvs9Ix1wn1gqD+s6JLE8VaVhwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646395829;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XiHKQkRYUt668ercIEOIMDOIj6Aaki3wrBz805lW9wU=;
        b=EEMfwwevcGPjlsBCBvmqRvOv0SDLp7+tYMLRnivI6SXYIT7IquCj53DYBC5M1mn4xwYXE6
        nAAAoxTUla3TMHDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8288132D4;
        Fri,  4 Mar 2022 12:10:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id z6YsLLQBImJQTwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 04 Mar 2022 12:10:28 +0000
Message-ID: <a4811cfa-8178-1b0b-866d-141221144c79@suse.cz>
Date:   Fri, 4 Mar 2022 13:10:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 3/6] mm/slub: use stackdepot to save stack trace in
 objects
Content-Language: en-US
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        Oliver Glitta <glittao@gmail.com>,
        Faiyaz Mohammed <faiyazm@codeaurora.org>,
        Marco Elver <elver@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Imran Khan <imran.f.khan@oracle.com>
References: <20220302173122.11939-1-vbabka@suse.cz>
 <20220302173122.11939-4-vbabka@suse.cz>
 <YiH3QAsrnBFc1Nrj@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <YiH3QAsrnBFc1Nrj@ip-172-31-19-208.ap-northeast-1.compute.internal>
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

On 3/4/22 12:25, Hyeonggon Yoo wrote:
> On Wed, Mar 02, 2022 at 06:31:19PM +0100, Vlastimil Babka wrote:
>> From: Oliver Glitta <glittao@gmail.com>
>> 
>> Many stack traces are similar so there are many similar arrays.
>> Stackdepot saves each unique stack only once.
>> 
>> Replace field addrs in struct track with depot_stack_handle_t handle.  Use
>> stackdepot to save stack trace.
>> 
>> The benefits are smaller memory overhead and possibility to aggregate
>> per-cache statistics in the following patch using the stackdepot handle
>> instead of matching stacks manually.
>> 
>> [ vbabka@suse.cz: rebase to 5.17-rc1 and adjust accordingly ]
>> 
>> This was initially merged as commit 788691464c29 and reverted by commit
>> ae14c63a9f20 due to several issues, that should now be fixed.
>> The problem of unconditional memory overhead by stackdepot has been
>> addressed by commit 2dba5eb1c73b ("lib/stackdepot: allow optional init
>> and stack_table allocation by kvmalloc()"), so the dependency on
>> stackdepot will result in extra memory usage only when a slab cache
>> tracking is actually enabled, and not for all CONFIG_SLUB_DEBUG builds.
>> The build failures on some architectures were also addressed, and the
>> reported issue with xfs/433 test did not reproduce on 5.17-rc1 with this
>> patch.
>> 
>> Signed-off-by: Oliver Glitta <glittao@gmail.com>
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> Cc: David Rientjes <rientjes@google.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> Cc: Pekka Enberg <penberg@kernel.org>
>> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>

...

>> @@ -314,9 +315,13 @@ kmem_cache_create_usercopy(const char *name,
>>  	 * If no slub_debug was enabled globally, the static key is not yet
>>  	 * enabled by setup_slub_debug(). Enable it if the cache is being
>>  	 * created with any of the debugging flags passed explicitly.
>> +	 * It's also possible that this is the first cache created with
>> +	 * SLAB_STORE_USER and we should init stack_depot for it.
>>  	 */
>>  	if (flags & SLAB_DEBUG_FLAGS)
>>  		static_branch_enable(&slub_debug_enabled);
>> +	if (flags & SLAB_STORE_USER && IS_ENABLED(CONFIG_STACKDEPOT))
>> +		stack_depot_init();
>>  #endif
> 
> Is this comment and code still valid in v3?

The comment is still valid, as there can be a kmem_cache_create() call with
SLAB_STORE_USER (in fact there's one in kernel/rcu/rcutorture.c) that's not
covered by the slub_debug parsing.
The code in v3 is just without IS_ENABLED(CONFIG_STACKDEPOT).

>>  	mutex_lock(&slab_mutex);
>> diff --git a/mm/slub.c b/mm/slub.c
>> index 1fc451f4fe62..42cb79af70a0 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/cpuset.h>
>>  #include <linux/mempolicy.h>
>>  #include <linux/ctype.h>
>> +#include <linux/stackdepot.h>
>>  #include <linux/debugobjects.h>
>>  #include <linux/kallsyms.h>
>>  #include <linux/kfence.h>
>> @@ -264,8 +265,8 @@ static inline bool kmem_cache_has_cpu_partial(struct kmem_cache *s)
>>  #define TRACK_ADDRS_COUNT 16
>>  struct track {
>>  	unsigned long addr;	/* Called from address */
>> -#ifdef CONFIG_STACKTRACE
>> -	unsigned long addrs[TRACK_ADDRS_COUNT];	/* Called from address */
>> +#ifdef CONFIG_STACKDEPOT
>> +	depot_stack_handle_t handle;
>>  #endif
>>  	int cpu;		/* Was running on cpu */
>>  	int pid;		/* Pid context */
>> @@ -724,22 +725,19 @@ static struct track *get_track(struct kmem_cache *s, void *object,
>>  	return kasan_reset_tag(p + alloc);
>>  }
>>  
>> -static void set_track(struct kmem_cache *s, void *object,
>> +static void noinline set_track(struct kmem_cache *s, void *object,
>>  			enum track_item alloc, unsigned long addr)
>>  {
> 
> noinline for debugging purpose?
> I think it's okay. just a question.

These noinlines make sure that the amount of stack entries are stable and
not subject to inline decisions of compiler...

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

... so that here '3' removes the correct count of 'internal' stack trace
entries that are not interesting for us.

>> +	p->handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
>>  #endif
>> +
>>  	p->addr = addr;
>>  	p->cpu = smp_processor_id();
>>  	p->pid = current->pid;
>> @@ -759,20 +757,19 @@ static void init_tracking(struct kmem_cache *s, void *object)
>>  
>>  static void print_track(const char *s, struct track *t, unsigned long pr_time)
>>  {
>> +	depot_stack_handle_t handle __maybe_unused;
>> +
>>  	if (!t->addr)
>>  		return;
>>  
>>  	pr_err("%s in %pS age=%lu cpu=%u pid=%d\n",
>>  	       s, (void *)t->addr, pr_time - t->when, t->cpu, t->pid);
>> -#ifdef CONFIG_STACKTRACE
>> -	{
>> -		int i;
>> -		for (i = 0; i < TRACK_ADDRS_COUNT; i++)
>> -			if (t->addrs[i])
>> -				pr_err("\t%pS\n", (void *)t->addrs[i]);
>> -			else
>> -				break;
>> -	}
>> +#ifdef CONFIG_STACKDEPOT
>> +	handle = READ_ONCE(t->handle);
>> +	if (handle)
>> +		stack_depot_print(handle);
>> +	else
>> +		pr_err("object allocation/free stack trace missing\n");
>>  #endif
>>  }
>>  
>> @@ -1532,6 +1529,8 @@ static int __init setup_slub_debug(char *str)
>>  			global_slub_debug_changed = true;
>>  		} else {
>>  			slab_list_specified = true;
>> +			if (flags & SLAB_STORE_USER)
>> +				stack_depot_want_early_init = true;
> 
> This is updated to stack_depot_want_early_init() in v3.

Yes.

>>  		}
>>  	}
>>  
>> @@ -1549,6 +1548,8 @@ static int __init setup_slub_debug(char *str)
>>  	}
>>  out:
>>  	slub_debug = global_flags;
>> +	if (slub_debug & SLAB_STORE_USER)
>> +		stack_depot_want_early_init = true;
> 
> This too.

Yes.

>>  	if (slub_debug != 0 || slub_debug_string)
>>  		static_branch_enable(&slub_debug_enabled);
>>  	else
>> @@ -4352,18 +4353,26 @@ void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
>>  	objp = fixup_red_left(s, objp);
>>  	trackp = get_track(s, objp, TRACK_ALLOC);
>>  	kpp->kp_ret = (void *)trackp->addr;
>> -#ifdef CONFIG_STACKTRACE
>> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
>> -		kpp->kp_stack[i] = (void *)trackp->addrs[i];
>> -		if (!kpp->kp_stack[i])
>> -			break;
>> -	}
>> +#ifdef CONFIG_STACKDEPOT
>> +	{
>> +		depot_stack_handle_t handle;
>> +		unsigned long *entries;
>> +		unsigned int nr_entries;
>> +
>> +		handle = READ_ONCE(trackp->handle);
>> +		if (handle) {
>> +			nr_entries = stack_depot_fetch(handle, &entries);
>> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
>> +				kpp->kp_stack[i] = (void *)entries[i];
>> +		}
>>  
>> -	trackp = get_track(s, objp, TRACK_FREE);
>> -	for (i = 0; i < KS_ADDRS_COUNT && i < TRACK_ADDRS_COUNT; i++) {
>> -		kpp->kp_free_stack[i] = (void *)trackp->addrs[i];
>> -		if (!kpp->kp_free_stack[i])
>> -			break;
>> +		trackp = get_track(s, objp, TRACK_FREE);
>> +		handle = READ_ONCE(trackp->handle);
>> +		if (handle) {
>> +			nr_entries = stack_depot_fetch(handle, &entries);
>> +			for (i = 0; i < KS_ADDRS_COUNT && i < nr_entries; i++)
>> +				kpp->kp_free_stack[i] = (void *)entries[i];
>> +		}
>>  	}
>>  #endif
>>  #endif
>> -- 
>> 2.35.1
> 
> Otherwise looks good.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> kmem_dump_obj() and slab error report functionality works fine.
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

