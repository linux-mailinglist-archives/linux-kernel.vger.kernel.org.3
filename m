Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11151B529
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbiEEBVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiEEBVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:21:46 -0400
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 18:18:08 PDT
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3ABD254F8C
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 18:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651713483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hjXZjoXRwWi27O+yncPytNpTaOYs3QPDkObrlrwm7sg=;
        b=afyM6DfHula07uikirOgZfUYYWoovBX3OZ3TV7UqgMZr1KjIMrYYkZVQLTLRedQKqv9apT
        FVL9ZFkVSEAzQtQxGkkRVk1NdZycEStHP0YzvqSetuS4RBTj2hfHw2c8hnyoByzB0BGoDA
        UTjitouSiriuiDJrsfx0muIfUSCahOo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-u3D2452pOgiHzviR_wT0RQ-1; Wed, 04 May 2022 21:11:50 -0400
X-MC-Unique: u3D2452pOgiHzviR_wT0RQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14EF485A5BC;
        Thu,  5 May 2022 01:11:50 +0000 (UTC)
Received: from [10.22.16.87] (unknown [10.22.16.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7D5743E779;
        Thu,  5 May 2022 01:11:49 +0000 (UTC)
Message-ID: <cc3a8d8b-50fa-1058-554e-113eb96fba70@redhat.com>
Date:   Wed, 4 May 2022 21:11:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: Wait for mutex to become unlocked
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
References: <YnLzrGlBNCmCPLmS@casper.infradead.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YnLzrGlBNCmCPLmS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/22 17:44, Matthew Wilcox wrote:
> Paul, Liam and I were talking about some code we intend to write soon
> and realised there's a missing function in the mutex & rwsem API.
> We're intending to use it for an rwsem, but I think it applies equally
> to mutexes.
>
> The customer has a low priority task which wants to read /proc/pid/smaps
> of a higher priority task.  Today, everything is awful; smaps acquires
> mmap_sem read-only, is preempted, then the high-pri task calls mmap()
> and the down_write(mmap_sem) blocks on the low-pri task.  Then all the
> other threads in the high-pri task block on the mmap_sem as they take
> page faults because we don't want writers to starve.
>
> The approach we're looking at is to allow RCU lookup of VMAs, and then
> take a per-VMA rwsem for read.  Because we're under RCU protection,
> that looks a bit like this:
>
> 	rcu_read_lock();
> 	vma = vma_lookup();
> 	if (down_read_trylock(&vma->sem)) {
> 		rcu_read_unlock();
> 	} else {
> 		rcu_read_unlock();
> 		down_read(&mm->mmap_sem);
> 		vma = vma_lookup();
> 		down_read(&vma->sem);
> 		up_read(&mm->mmap_sem);
> 	}
>
> (for clarity, I've skipped the !vma checks; don't take this too literally)
>
> So this is Good.  For the vast majority of cases, we avoid taking the
> mmap read lock and the problem will appear much less often.  But we can
> do Better with a new API.  You see, for this case, we don't actually
> want to acquire the mmap_sem; we're happy to spin a bit, but there's no
> point in spinning waiting for the writer to finish when we can sleep.
> I'd like to write this code:
>
> again:
> 	rcu_read_lock();
> 	vma = vma_lookup();
> 	if (down_read_trylock(&vma->sem)) {
> 		rcu_read_unlock();
> 	} else {
> 		rcu_read_unlock();
> 		rwsem_wait_read(&mm->mmap_sem);
> 		goto again;
> 	}
>
> That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
> and wakes it up without giving it the lock.  Now this thread will never
> be able to block any thread that tries to acquire mmap_sem for write.

I suppose that a writer that needs to take a write lock on vma->sem will 
have to take a write lock on mmap_sem first, then it makes sense to me 
that you want to wait for all the vma->sem writers to finish by waiting 
on the wait queue of mmap_sem. By the time the waiting task is being 
woken up, there is no active write lock on the vma->sem and hopefully by 
the time the waiting process wakes up and do a down_read_trylock(), it 
will succeed. However, the time gap in the wakeup process may have 
another writer coming in taking the vma->sem write lock. It improves the 
chance of a successful trylock but it is not guaranteed. So you will 
need a retry count and revert back to a direct down_read() when there 
are too many retries.

Since the waiting process isn't taking any lock, the name 
rwsem_wait_read() may be somewhat misleading. I think a better name may 
be rwsem_flush_waiters(). So do you want to flush the waiters at the 
point this API is called or you want to wait until the wait queue is empty?

Cheers,
Longman

