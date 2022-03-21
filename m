Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0C4E2B58
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349728AbiCUO6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 10:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349714AbiCUO6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 10:58:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 102B38A6E5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 07:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647874635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CElFwPDf4VmXQPWGB4S9XO8tIg3wbUAt/pQqZI/DcD8=;
        b=NvMg8IEGPFzvugeg7a4v74Glz/K4AKKahVyp3aYgUe4eueB9E6gngfZLnHLyB3Bweet08k
        seUKMAyh9YTjfi6Lws3yyq9X09V/Gylx+9UG7DJavcO5Fc3jP3vb1GK6AQcVsYzquCDfNP
        C2a6pUKFIDaFXzvFwRz1JRDMKwA0xJs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-ODypAR4fNhi-hkCeEq7s9A-1; Mon, 21 Mar 2022 10:57:14 -0400
X-MC-Unique: ODypAR4fNhi-hkCeEq7s9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F31C23C19840;
        Mon, 21 Mar 2022 14:57:13 +0000 (UTC)
Received: from [10.22.34.188] (unknown [10.22.34.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F7A540CF8FB;
        Mon, 21 Mar 2022 14:57:13 +0000 (UTC)
Message-ID: <dda57284-ea2e-f2ab-73c2-dacc0a796ebf@redhat.com>
Date:   Mon, 21 Mar 2022 10:57:13 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] locking/rwsem: Wake readers in a reader-owned rwsem
 if first waiter is a reader
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220318161609.1939957-1-longman@redhat.com>
 <20220318161609.1939957-3-longman@redhat.com>
 <Yjh1CC1EBBxsD+PK@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <Yjh1CC1EBBxsD+PK@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/22 08:52, Peter Zijlstra wrote:
> On Fri, Mar 18, 2022 at 12:16:09PM -0400, Waiman Long wrote:
>> In an analysis of a recent vmcore, a reader-owned rwsem was found with
>> 385 readers but no writer in the wait queue. That is kind of unusual
>> but it may be caused by some race conditions that we have not fully
>> understood yet. In such a case, all the readers in the wait queue should
>> join the other reader-owners and acquire the read lock.
>>
>> In rwsem_down_write_slowpath(), an incoming writer will try to wake
>> up the front readers under such circumstance. That is not the case for
>> rwsem_down_read_slowpath(), modify the code to do this. This includes the
>> original supported case where the wait queue is empty and the incoming
>> reader is going to wake up itself.
>>
>> With CONFIG_LOCK_EVENT_COUNTS enabled, the newly added rwsem_rlock_rwake
>> event counter had 13 hits right after the bootup of a 2-socket system. So
>> the condition that a reader-owned rwsem has readers at the front of
>> the wait queue does happen pretty frequently. This patch will help to
>> speed thing up in such cases.
> Urgh.. this so reads like a band-aid.

Yes, you may consider this a band-aid. On the other hand, the down_write 
slowpath is doing that and this patch modifies the down_read slowpath to 
do the same thing. I do agree that we need to do further investigation 
on what race conditions can cause this condition.


>
> Anyway; it appears to me the out_nolock case of down_read doesn't
> feature a wakeup, can we create a scenario with that?

I have consider adding extra wakeup in down_read out_nolock case. Unlike 
a writer that can block other readers later in the wait queue from 
getting the read lock, a reader earlier in the queue won't other readers 
later in the queue. So it is less useful from my point of view. For 
consistency, however, you are right that maybe we should do that too.


> Anyway, I think I much prefer you sitting down writing the rules for
> queueing and wakeup and then varifying them against the code rather than
> adding extra wakeups just cause.

Will rework the patch to apply the same rules for both readers and 
writers for consistency.

Cheers,
Longman

