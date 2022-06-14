Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76FF54B899
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbiFNS3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344513AbiFNS27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:28:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DBB046152
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655231338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jzGDnMjiVMPl8LoDK9/jjZ3s6cfGJvhDYM+qlDxnnck=;
        b=ft1RO45ZUt+3fqWlo+7qS6Y1G9v+mb7BtqcH4zqz9KusrtnoC3yofSybu5DaTNSCpDVQ3F
        XlzlAuZOC1crXMm4LKwZ+0TGFXGlMfkOSZpOcPVNVGCOM1OvK6lXCeu4XjxPmw/c+LzbLH
        +67Aew282Wg7rO0GJPIWO00ayPb2rrU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-1-ZFBhL40jPHCo3tCVEsDiJg-1; Tue, 14 Jun 2022 14:28:54 -0400
X-MC-Unique: ZFBhL40jPHCo3tCVEsDiJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A9E6101AA45;
        Tue, 14 Jun 2022 18:28:54 +0000 (UTC)
Received: from [10.22.33.116] (unknown [10.22.33.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330832026D64;
        Tue, 14 Jun 2022 18:28:54 +0000 (UTC)
Message-ID: <c20294e1-b926-efa3-95fd-d30601d44a5d@redhat.com>
Date:   Tue, 14 Jun 2022 14:28:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/3] mm/kmemleak: Prevent soft lockup in first object
 iteration loop of kmemleak_scan()
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-4-longman@redhat.com> <YqjCGWmM2cGG1OOF@arm.com>
 <YqjFHOMT+rDgz3EK@arm.com> <325768cd-19bd-71ae-83d6-1ca5e84f7462@redhat.com>
In-Reply-To: <325768cd-19bd-71ae-83d6-1ca5e84f7462@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/22 14:22, Waiman Long wrote:
> On 6/14/22 13:27, Catalin Marinas wrote:
>
>>>> raw_spin_unlock_irq(&object->lock);
>>>> +
>>>> +        /*
>>>> +         * With object pinned by a positive reference count, it
>>>> +         * won't go away and we can safely release the RCU read
>>>> +         * lock and do a cond_resched() to avoid soft lockup every
>>>> +         * 64k objects.
>>>> +         */
>>>> +        if (object_pinned && !(gray_list_cnt & 0xffff)) {
>>>> +            rcu_read_unlock();
>>>> +            cond_resched();
>>>> +            rcu_read_lock();
>>>> +        }
>>> I'm not sure this gains much. There should be very few gray objects
>>> initially (those passed to kmemleak_not_leak() for example). The
>>> majority should be white objects.
>>>
>>> If we drop the fine-grained object->lock, we could instead take
>>> kmemleak_lock outside the loop with a cond_resched_lock(&kmemleak_lock)
>>> within the loop. I think we can get away with not having an
>>> rcu_read_lock() at all for list traversal with the big lock outside the
>>> loop.
>> Actually this doesn't work is the current object in the iteration is
>> freed. Does list_for_each_rcu_safe() help?
>
> list_for_each_rcu_safe() helps if we are worrying about object being 
> freed. However, it won't help if object->next is freed instead.
>
> How about something like:
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 7dd64139a7c7..fd836e43cb16 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1417,12 +1417,16 @@ static void kmemleak_scan(void)
>         struct zone *zone;
>         int __maybe_unused i;
>         int new_leaks = 0;
> +       int loop1_cnt = 0;
>
>         jiffies_last_scan = jiffies;
>
>         /* prepare the kmemleak_object's */
>         rcu_read_lock();
>         list_for_each_entry_rcu(object, &object_list, object_list) {
> +               bool obj_pinned = false;
> +
> +               loop1_cnt++;
>                 raw_spin_lock_irq(&object->lock);
>  #ifdef DEBUG
>                 /*
> @@ -1437,10 +1441,32 @@ static void kmemleak_scan(void)
>  #endif
>                 /* reset the reference count (whiten the object) */
>                 object->count = 0;
> -               if (color_gray(object) && get_object(object))
> +               if (color_gray(object) && get_object(object)) {
>                         list_add_tail(&object->gray_list, &gray_list);
> +                       obj_pinned = true;
> +               }
>
>                 raw_spin_unlock_irq(&object->lock);
> +
> +               /*
> +                * Do a cond_resched() to avoid soft lockup every 64k 
> objects.
> +                * Make sure a reference has been taken so that the 
> object
> +                * won't go away without RCU read lock.
> +                */
> +               if (loop1_cnt & 0xffff) {


Sorry, should be "(!(loop1_cnt & 0xffff))".

> + if (!obj_pinned && !get_object(object)) {
> +                               /* Try the next object instead */
> +                               loop1_cnt--;
> +                               continue;
> +                       }
> +
> +                       rcu_read_unlock();
> +                       cond_resched();
> +                       rcu_read_lock();
> +
> +                       if (!obj_pinned)
> +                               put_object(object);
> +               }
>         }
>         rcu_read_unlock();
>
Cheers,
Longman

