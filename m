Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26F75127DD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiD1AAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiD1AAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:00:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F5295C665
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651103815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZtQqXodwAxDOFyBsncQ3VIj2vv1xD7e9kF/rrL5I4pE=;
        b=RIGsrZGEP3B21vLpR5jdEiyv7x62tbM3vx0yldWgMsits5LFQ9Yu3P9JaJwgsxnkYKT378
        IH6Ax0Ji708XPOsZKnZrG1IWlzadAaThimCc+scjhKQyZC39AELMnIDOxwrWkeHSpRlsgL
        s8PiWFmtMRG15dI96Zmm0wYQ7Q50LW0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-NwFBWKeEM-2DUNa-kYU-gQ-1; Wed, 27 Apr 2022 19:56:52 -0400
X-MC-Unique: NwFBWKeEM-2DUNa-kYU-gQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 82CA9811E75;
        Wed, 27 Apr 2022 23:56:51 +0000 (UTC)
Received: from [10.22.11.251] (unknown [10.22.11.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDA5A14152FB;
        Wed, 27 Apr 2022 23:56:50 +0000 (UTC)
Message-ID: <eb02c830-e4ff-c1a3-f23a-0ff7b8854acb@redhat.com>
Date:   Wed, 27 Apr 2022 19:56:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] locking/rwsem: Allow slowpath writer to ignore handoff
 bit if not set by first waiter
Content-Language: en-US
To:     John Donnelly <John.p.donnelly@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>
References: <20220427173124.1428050-1-longman@redhat.com>
 <cd1da3e3-9024-2c97-3343-2569f74018be@oracle.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <cd1da3e3-9024-2c97-3343-2569f74018be@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 19:16, John Donnelly wrote:
> On 4/27/22 12:31 PM, Waiman Long wrote:
>> With commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
>> consistent"), the writer that sets the handoff bit can be interrupted
>> out without clearing the bit if the wait queue isn't empty. This 
>> disables
>> reader and writer optimistic lock spinning and stealing.
>>
>> Now if a non-first writer in the queue is somehow woken up or first
>> entering the waiting loop, it can't acquire the lock.  This is not
>> the case before that commit as the writer that set the handoff bit
>> will clear it when exiting out via the out_nolock path. This is less
>> efficient as the busy rwsem stays in an unlock state for a longer time.
>>
>> This patch allows a non-first writer to ignore the handoff bit if it
>> is not originally set or initiated by the first waiter.
>>
>> Fixes: d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more 
>> consistent")
>
> Hi Waiman,
>
> 1. You likely need :
>
> Cc: <stable@vger.kernel.org>
>
> Since d257cc8cb8d5 has been migrated to other LTS threads (5.15.y for 
> sure) .

Since the commit has a fixes tag, the stable will automatically pick it up.

>
> 2. I had posted this earlier:
>
> [PATCH 5.15 1/1] Revert "locking/rwsem: Make handoff bit handling more 
> consistent"
>
> That is likely not needed now.
Right. The patch was created to fix a problem reported by another user. 
So reverting it may not the right move.
>
>
> 3. Please add :
>
> Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
>
> We can likely test this, but I can't give a ETA when that will happen.
>
>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>
> Acked-by: John Donnelly <john.p.donnelly@oracle.com>

Will add the that when I send out the next version.

Cheers,
Longman

