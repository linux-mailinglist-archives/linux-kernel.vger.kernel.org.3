Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE261568AA3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbiGFODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiGFODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:03:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 515B22183C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657116196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iYaOlN2hgT9X78xdNrOhC2A8F3Gqf4dqEm+z4iEoffE=;
        b=gagDBcWP47fwMUvxzW5/oiV2bUfEVGGjO5Y3dRoeI5Kh/DmmkytVGlwIQ/uQLolNsVyjMN
        MuLuC6I1FvLox0mN1XBL7jwpayRiEw5wAokYm5/r1XvB9JQpbqEx12pM3lS5rzJcwx418Y
        JNJ/mqTjUHmC0e4XbRbBD+k1BYN0nX4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-491-s_PPMIjMN964brXyMhMyLg-1; Wed, 06 Jul 2022 10:03:11 -0400
X-MC-Unique: s_PPMIjMN964brXyMhMyLg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B3369693A4;
        Wed,  6 Jul 2022 14:03:11 +0000 (UTC)
Received: from [10.22.8.95] (unknown [10.22.8.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1BF4401E54;
        Wed,  6 Jul 2022 14:03:10 +0000 (UTC)
Message-ID: <f3051cbb-313c-ba88-66c9-3f8f8d88d806@redhat.com>
Date:   Wed, 6 Jul 2022 10:03:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220706135916.980580-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220706135916.980580-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/22 09:59, Waiman Long wrote:
> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> stealing") allows unlimited number of lock stealing's for non-RT
> tasks. That can lead to lock starvation of non-RT top waiter tasks if
> there is a constant incoming stream of non-RT lockers. This can cause
> rcu_preempt self-detected stall or even task lockup in PREEMPT_RT kernel.
> For example,
>
> [77107.424943] rcu: INFO: rcu_preempt self-detected stall on CPU
> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
>
> Avoiding this problem and ensuring forward progress by limiting the
> number of times that a lock can be stolen from each waiter. This patch
> sets a threshold of 32. That number is arbitrary and can be changed
> if needed.
>
> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/locking/rtmutex.c        | 9 ++++++---
>   kernel/locking/rtmutex_common.h | 8 ++++++++
>   2 files changed, 14 insertions(+), 3 deletions(-)
>
>   [v3: Increase threshold to 32 and add rcu_preempt self-detected stall]

Note that I decided to increase the threshold to 32 from 10 to reduce 
the potential performance impact of this change, if any. We also found 
out that this patch can fix some of the rcu_preempt self-detected stall 
problems that we saw with the PREEMPT_RT kernel. So I added that 
information in the patch description.

Cheers,
Longman

