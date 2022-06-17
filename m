Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C2E54F9B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbiFQO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiFQO5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08BD31C904
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655477844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uniI+7opA4GgaBU7ugVhxnYnlTgmV7mzxs05nkJW+Q8=;
        b=gDiqXMqRCEPnxdjR9jMaG4GgdgzqFTX6pqEKU7km4FZaCaOL1ygtFCdgfzrcWp4iar9lDi
        LKFDeLfLsIDgC7/wLiN+cLQQFidcAhq/KNbreCLh/J7gBQKYTpYXtrSChVrycjac0pxtbA
        UeoQvB5SWKSmR4S4blGJYmL/tcvZOjg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-32-eAIq3FvkNKWyttyitBS9jA-1; Fri, 17 Jun 2022 10:57:23 -0400
X-MC-Unique: eAIq3FvkNKWyttyitBS9jA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 369A41881435;
        Fri, 17 Jun 2022 14:57:12 +0000 (UTC)
Received: from [10.22.18.98] (unknown [10.22.18.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF3F0492CA5;
        Fri, 17 Jun 2022 14:57:11 +0000 (UTC)
Message-ID: <b14e4943-a2b2-6bfc-6530-46bec9eadb9e@redhat.com>
Date:   Fri, 17 Jun 2022 10:57:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] locking/lockdep: Fix lockdep_init_map_*() confusion
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        will@kernel.org, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
References: <YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YqyEDtoan20K0CVD@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/17/22 09:39, Peter Zijlstra wrote:
> Commit dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t") added yet
> another lockdep_init_map_*() variant, but forgot to update all the
> existing users of the most complicated version.
>
> This could lead to a loss of lock_type and hence an incorrect report.
> Given the relative rarity of both local_lock and these annotations,
> this is unlikely to happen in practise, still, best fix things.
>
> Fixes: dfd5e3f5fe27 ("locking/lockdep: Mark local_lock_t")
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   include/linux/lockdep.h  |   30 +++++++++++++++++-------------
>   kernel/locking/lockdep.c |    7 ++++---
>   2 files changed, 21 insertions(+), 16 deletions(-)
>
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -188,7 +188,7 @@ static inline void
>   lockdep_init_map_waits(struct lockdep_map *lock, const char *name,
>   		       struct lock_class_key *key, int subclass, u8 inner, u8 outer)
>   {
> -	lockdep_init_map_type(lock, name, key, subclass, inner, LD_WAIT_INV, LD_LOCK_NORMAL);
> +	lockdep_init_map_type(lock, name, key, subclass, inner, outer, LD_LOCK_NORMAL);
>   }
>   
>   static inline void
> @@ -211,24 +211,28 @@ static inline void lockdep_init_map(stru
>    * or they are too narrow (they suffer from a false class-split):
>    */
>   #define lockdep_set_class(lock, key)				\
> -	lockdep_init_map_waits(&(lock)->dep_map, #key, key, 0,	\
> -			       (lock)->dep_map.wait_type_inner,	\
> -			       (lock)->dep_map.wait_type_outer)
> +	lockdep_init_map_type(&(lock)->dep_map, #key, key, 0,	\
> +			      (lock)->dep_map.wait_type_inner,	\
> +			      (lock)->dep_map.wait_type_outer,	\
> +			      (lock)->dep_map.lock_type)
>   
>   #define lockdep_set_class_and_name(lock, key, name)		\
> -	lockdep_init_map_waits(&(lock)->dep_map, name, key, 0,	\
> -			       (lock)->dep_map.wait_type_inner,	\
> -			       (lock)->dep_map.wait_type_outer)
> +	lockdep_init_map_type(&(lock)->dep_map, name, key, 0,	\
> +			      (lock)->dep_map.wait_type_inner,	\
> +			      (lock)->dep_map.wait_type_outer,	\
> +			      (lock)->dep_map.lock_type)
>   
>   #define lockdep_set_class_and_subclass(lock, key, sub)		\
> -	lockdep_init_map_waits(&(lock)->dep_map, #key, key, sub,\
> -			       (lock)->dep_map.wait_type_inner,	\
> -			       (lock)->dep_map.wait_type_outer)
> +	lockdep_init_map_type(&(lock)->dep_map, #key, key, sub,	\
> +			      (lock)->dep_map.wait_type_inner,	\
> +			      (lock)->dep_map.wait_type_outer,	\
> +			      (lock)->dep_map.lock_type)
>   
>   #define lockdep_set_subclass(lock, sub)					\
> -	lockdep_init_map_waits(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
> -			       (lock)->dep_map.wait_type_inner,		\
> -			       (lock)->dep_map.wait_type_outer)
> +	lockdep_init_map_type(&(lock)->dep_map, #lock, (lock)->dep_map.key, sub,\
> +			      (lock)->dep_map.wait_type_inner,		\
> +			      (lock)->dep_map.wait_type_outer,		\
> +			      (lock)->dep_map.lock_type)
>   
>   #define lockdep_set_novalidate_class(lock) \
>   	lockdep_set_class_and_name(lock, &__lockdep_no_validate__, #lock)
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -5238,9 +5238,10 @@ __lock_set_class(struct lockdep_map *loc
>   		return 0;
>   	}
>   
> -	lockdep_init_map_waits(lock, name, key, 0,
> -			       lock->wait_type_inner,
> -			       lock->wait_type_outer);
> +	lockdep_init_map_type(lock, name, key, 0,
> +			      lock->wait_type_inner,
> +			      lock->wait_type_outer,
> +			      lock->lock_type);
>   	class = register_lock_class(lock, subclass, 0);
>   	hlock->class_idx = class - lock_classes;
>   
>
You have almost eliminated all usage of lockdep_init_map_waits() except 
in lockdep_init_map_wait(). Should we just kill lockdep_init_map_waits() 
and make lockdep_init_map_wait() call lockdep_init_map_type() directly?

Cheers,
Longman

