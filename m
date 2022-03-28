Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBD664E9AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 17:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243782AbiC1PNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 11:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244580AbiC1PNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 11:13:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E69331C91F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 08:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648480314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4bc9leYRRtOW/54gUC7hrLdsVm71KWKCliWns2HM+g=;
        b=D6jjAB0tfKaQ36HVeylCcQQfQ9yoEWZtw8iLVL06p1LMyqKoSvWhfqk8g3S0CWGg5HfxRP
        sIXt1KZLT3JjViwgRONqx3VILjZ6YhWpuiKDfzuay+iynTu4XlRi6yiQoA3IOGgOCQrQAC
        G1do+or/JHbNULICJxvWoeetlOrrGu4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-dryIcnp_MXmfefw8afjRwA-1; Mon, 28 Mar 2022 11:11:52 -0400
X-MC-Unique: dryIcnp_MXmfefw8afjRwA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97C2A3817483;
        Mon, 28 Mar 2022 15:11:36 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 51DA14010A02;
        Mon, 28 Mar 2022 15:11:32 +0000 (UTC)
Message-ID: <c4642442-aff8-c287-015f-90f41f09c323@redhat.com>
Date:   Mon, 28 Mar 2022 11:11:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] locking/rwsem: dont wake up wwaiter in case of lock holder
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Hillf Danton <hdanton@sina.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220326134059.4082-1-hdanton@sina.com>
 <02f50037-46ce-ec08-63cb-e855694e69a5@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <02f50037-46ce-ec08-63cb-e855694e69a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 10:18, David Hildenbrand wrote:
> On 26.03.22 14:40, Hillf Danton wrote:
>> In the slowpath of down for write, we bail out in case of signal received and
>> try to wake up any pending waiter but it makes no sense to wake up a write
>> waiter given any lock holder, either write or read.
> But is handling this better really worth additional code and runtime
> checks? IOW, does this happen often enough that we actually care about
> optimizing this? I have no idea :)
>
>> The RFC is do nothing for wwaiter if any lock holder present - they will fill
>> their duty at lock release time.
>>
>> Only for thoughts now.
>>
>> Hillf
>>
>> --- x/kernel/locking/rwsem.c
>> +++ y/kernel/locking/rwsem.c
>> @@ -418,6 +418,8 @@ static void rwsem_mark_wake(struct rw_se
>>   	waiter = rwsem_first_waiter(sem);
>>   
>>   	if (waiter->type == RWSEM_WAITING_FOR_WRITE) {
>> +		if (RWSEM_LOCK_MASK & atomic_long_read(&sem->count))
>> +			return;
>>   		if (wake_type == RWSEM_WAKE_ANY) {
>>   			/*
>>   			 * Mark writer at the front of the queue for wakeup.
>> --

That check isn't good enough. First of all, any reader count in 
sem->count can be transient due to the fact that we do an unconditional 
atomic_long_add() on down_read(). The reader may then remove its reader 
count in the slow path. This patch may cause missed wakeup which is a 
much bigger problem than spending a bit of cpu time to check for lock 
availability and sleep again.

The write lock bit, however, is real. We do support the first writer in 
the wait queue to spin on the lock when the handoff bit is set. So 
waking up a writer when the rwsem is currently write-locked can still be 
useful.

BTW, I didn't see this RFC patch in LKML. Is it only posted on linux-mm 
originally?

Cheers,
Longman

