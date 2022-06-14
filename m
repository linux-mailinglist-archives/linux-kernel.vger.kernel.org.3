Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B8254B776
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 19:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbiFNRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 13:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbiFNRRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 13:17:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFD2F2899C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 10:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655227031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kzyH/b641dKMDjbrA4kv9o+fQFTfMOsLdWaLCGIK8WQ=;
        b=Xfzoru5JHGIeiP3FxMwynv9+PK2/kuB0yaBk6lNN7c9o7qd7STMMns8iXyAu/lo2GkvLOF
        M5u0HMu3GOep0Pnak01rAticTvwgguLM9/N2R2luMBkXuBy/6UDLa5FxBSL32EtEltZz8B
        MFW/D3FMFfHNdHD7HwtMPkBsbBWkzAA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-3Kbihn_QN1-4bnlGFtc2pg-1; Tue, 14 Jun 2022 13:17:07 -0400
X-MC-Unique: 3Kbihn_QN1-4bnlGFtc2pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6847485A580;
        Tue, 14 Jun 2022 17:17:07 +0000 (UTC)
Received: from [10.22.33.116] (unknown [10.22.33.116])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27FC02166B26;
        Tue, 14 Jun 2022 17:17:07 +0000 (UTC)
Message-ID: <12d9f13f-18fe-f653-dfaf-49c52b720818@redhat.com>
Date:   Tue, 14 Jun 2022 13:17:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/3] mm/kmemleak: Skip unlikely objects in kmemleak_scan()
 without taking lock
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20220612183301.981616-1-longman@redhat.com>
 <20220612183301.981616-3-longman@redhat.com> <Yqi9SP2HZ4dlQOWG@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yqi9SP2HZ4dlQOWG@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/22 12:54, Catalin Marinas wrote:
> On Sun, Jun 12, 2022 at 02:33:00PM -0400, Waiman Long wrote:
>> With a debug kernel running on a 2-socket 96-thread x86-64 system
>> (HZ=1000), the 2nd and 3rd iteration loops speedup with this patch on
>> the first kmemleak_scan() call after bootup is shown in the table below.
>>
>>                     Before patch                    After patch
>>    Loop #    # of objects  Elapsed time     # of objects  Elapsed time
>>    ------    ------------  ------------     ------------  ------------
>>      2        2,599,850      2.392s          2,596,364       0.266s
>>      3        2,600,176      2.171s          2,597,061       0.260s
>>
>> This patch reduces loop iteration times by about 88%. This will greatly
>> reduce the chance of a soft lockup happening in the 2nd or 3rd iteration
>> loops.
> Nice numbers, thanks for digging into this.
>
> But I'm slightly surprised that the first loop doesn't cause any
> problems.

The first loop is still problematic. It is just a bit faster with the 
same number of objects. The corresponding elapsed time is about 1.7s. 
The heuristics used in this patch cannot be applied to the first loop. 
See patch 3 on how to avoid soft lockup in the first loop.

>
>> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
>> index dad9219c972c..7dd64139a7c7 100644
>> --- a/mm/kmemleak.c
>> +++ b/mm/kmemleak.c
>> @@ -1508,6 +1508,13 @@ static void kmemleak_scan(void)
>>   	 */
>>   	rcu_read_lock();
>>   	list_for_each_entry_rcu(object, &object_list, object_list) {
>> +		/*
>> +		 * This is racy but we can save the overhead of lock/unlock
>> +		 * calls. The missed objects, if any, should be caught in
>> +		 * the next scan.
>> +		 */
>> +		if (!color_white(object))
>> +			continue;
>>   		raw_spin_lock_irq(&object->lock);
>>   		if (color_white(object) && (object->flags & OBJECT_ALLOCATED)
>>   		    && update_checksum(object) && get_object(object)) {
> It's not actually scanning (like tree look-ups) but only updating the
> checksum of the potentially orphan objects. If the problem is caused by
> object->lock, we should have seen it with the first loop as well.

See above. Maybe I should clarify in the patch description that similar 
change cannot be applied to the first loop.

>
> It is possible that some large list is occasionally missed if there are
> concurrent updates and a significant number of objects turn up "white",
> forcing the checksum update. Otherwise this shouldn't be much different
> from the first loop if there are no massive (false) leaks.
>
> I think the race on color_white() can only be with a kmemleak_ignore()
> or kmemleak_not_leak() call, otherwise the object colour shouldn't be
> changed. So such objects can only turn from white to gray or black, so
> the race I think is safe.
>
>> @@ -1535,6 +1542,13 @@ static void kmemleak_scan(void)
>>   	 */
>>   	rcu_read_lock();
>>   	list_for_each_entry_rcu(object, &object_list, object_list) {
>> +		/*
>> +		 * This is racy but we can save the overhead of lock/unlock
>> +		 * calls. The missed objects, if any, should be caught in
>> +		 * the next scan.
>> +		 */
>> +		if (!color_white(object))
>> +			continue;
>>   		raw_spin_lock_irq(&object->lock);
>>   		if (unreferenced_object(object) &&
>>   		    !(object->flags & OBJECT_REPORTED)) {
> Same here.
>
> I did wonder whether it's worth keeping object->lock around, I even have
> a stashed patch lying around from 2019. Instead we'd have the big
> kmemleak_lock held for longer, though released periodically during
> scanning. We can then move the lock outside the loop and traversal would
> be faster but with an increased latency on slab allocation/freeing on
> other CPUs. Right now we take the kmemleak_lock when scanning a single
> block (e.g. object) to protect the rb-tree and rely on object->lock to
> ensure the object isn't freed. Other concurrent allocs/frees would only
> be blocked during single object scanning.
>
> Anyway, I'm not entirely sure it's the lock causing the issue as we
> don't see it with the first loop. I'm more inclined to think it's the
> checksum and the skipping if !color_white() would do the trick.
>
> Unless there's a better idea:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

The lock is a problem because of lockdep. Once I disable lockdep, the 
elapsed time can drop to about 0.7s. However, lockdep is normally 
enabled in a debug kernel. I will try to investigate if there is a way 
to optimize lockdep or such repeated lock/unlock loop.

Thanks,
Longman

>

