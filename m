Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F9FF570B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiGKUCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKUC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:02:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B072422EC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657569747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8sdN/dE5SqV8XkLj/6o+J/yunhZmP7J+Ef0oD4L9K/0=;
        b=Jt2rp0Siy4QIndrDJWls26rxHXWjRvPQBJ3WckUBwLQRNcV9kyrS+ITo4PSOGZGqiX0g5T
        eGUMiBnZkQFRq/8i4jP9l1WKsq5qCFN/gjG52XkXxNGeSaKk4iy6RCMiVDvvRppB8Zm0Ba
        NnV+eRnYACtP0vBbMEUBD7WIom3wjX0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-z899xEvuMeW0c9CR6BfGGw-1; Mon, 11 Jul 2022 16:02:24 -0400
X-MC-Unique: z899xEvuMeW0c9CR6BfGGw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F59829ABA21;
        Mon, 11 Jul 2022 20:02:19 +0000 (UTC)
Received: from [10.18.17.215] (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BC5A1415120;
        Mon, 11 Jul 2022 20:02:19 +0000 (UTC)
Message-ID: <e0724ba0-a8f6-b36b-0c09-fff48c4282ad@redhat.com>
Date:   Mon, 11 Jul 2022 16:02:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220706135916.980580-1-longman@redhat.com>
 <YsvuwfeY/dSngl8c@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YsvuwfeY/dSngl8c@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 05:34, Peter Zijlstra wrote:
> On Wed, Jul 06, 2022 at 09:59:16AM -0400, Waiman Long wrote:
>> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
>> stealing") allows unlimited number of lock stealing's for non-RT
>> tasks. That can lead to lock starvation of non-RT top waiter tasks if
>> there is a constant incoming stream of non-RT lockers. This can cause
>> rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
>> For example,
>>
>> [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
>> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
>>
>> Avoiding this problem and ensuring forward progress by limiting the
>> number of times that a lock can be stolen from each waiter. This patch
>> sets a threshold of 32. That number is arbitrary and can be changed
>> if needed.
>>
> Why not do the same thing we do for regular mutexes?
>
The mutex way is another possible alternative. So we can set a flag to 
disable lock stealing if the current top waiter wake up and the rtmutex 
has been stolen. I will need to run some tests to find out how many time 
lock stealing can happen before it is blocked. I would like to allow 
sufficient number of lock stealing to minimize the performance impact of 
this change.

Cheers,
Longman

