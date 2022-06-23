Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5ED557DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 16:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbiFWOl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 10:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiFWOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:41:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEA5145AC3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655995281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SraIdLWRv06GMoMmKgbS8PufkzalRVLr236WwWYc8aU=;
        b=D4cYI2rzbhTNCCBmSEU5BNM/RqDi2Xny3nvYLdexuyrPfORAH92Gb29LFbMFjFjKv1mT8k
        JYyocOFL/BgJPeJUB7sysSF8M72lLcHFWps9UYLsj1m18r6hm+i582eIir6xqFeQOT3KAd
        NcCUxd9iuMMX7l93UjeZyN2rMi2LSUQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-163-UzXsHW3KP22zUZYaytu0Qg-1; Thu, 23 Jun 2022 10:41:18 -0400
X-MC-Unique: UzXsHW3KP22zUZYaytu0Qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5238A3C1172D;
        Thu, 23 Jun 2022 14:41:18 +0000 (UTC)
Received: from [10.22.9.91] (unknown [10.22.9.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6CB8C44AE3;
        Thu, 23 Jun 2022 14:41:17 +0000 (UTC)
Message-ID: <be4db8af-7855-1f54-c2f2-947577b71f94@redhat.com>
Date:   Thu, 23 Jun 2022 10:41:17 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220621193641.609712-1-longman@redhat.com>
 <YrRriHsAdxPwEnWW@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YrRriHsAdxPwEnWW@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/23/22 09:32, Sebastian Andrzej Siewior wrote:
> On 2022-06-21 15:36:41 [-0400], Waiman Long wrote:
>> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
>> stealing") allows unlimited number of lock stealing's for non-RT
>> tasks. That can lead to lock starvation of non-RT top waiter tasks if
>> there is a constant incoming stream of non-RT lockers. This can cause
>> task lockup in PREEMPT_RT kernel. For example,
>>
>> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
>> [ 1872.984225] INFO: task kworker/6:4:63401 blocked for more than 622 seconds.
>>
>> Avoiding this problem and ensuring forward progress by limiting the
>> number of times that a lock can be stolen from each waiter. This patch
>> sets a threshold of 10. That number is arbitrary and can be changed
>> if needed.
>>
>> With that change, the task lockups previously observed when running
>> stressful workloads on PREEMPT_RT kernel disappeared.
> Do you have more insight on how this was tested/ created? Based on that,
> systemd and a random kworker waited on a lock for more than 10 minutes.

The hang happens when our QE team run thier kernel tier 1 test which, I 
think, lasts several hours. The hang happens in some runs but not all of 
them. So it is kind of opportunistic. Mike should be able to provide a 
better idea about frequency and so on.

>
> I added a trace-printk each time a non-RT waiter got the lock stolen,
> kicked a kernel build and a package upgrade and took a look at the stats
> an hour later:
> - sh got its lock stolen 3416 times. I didn't lock the pid so I can't
>    look back and check how long it waited since the first time.
> - the median average of stolen locks is 173.
Maybe we should also more lock stealing per waiter than the 10 that I 
used in the patch. I am open to suggestion to what is a good value to use.
>
>> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
>> Reported-by: Mike Stowell <mstowell@redhat.com>
>> Signed-off-by: Waiman Long <longman@redhat.com>

Thanks for your time looking at the patch.

Cheers,
Longman

