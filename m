Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75285553AB3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354067AbiFUTiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348473AbiFUTiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3CF42BF4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655840294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zPJLLkUtSAVprHdgm616Qa9Cd4BgwgzT31iWAkR7ouU=;
        b=K8TI2Z7qJIgu6kwuhCroIwRrr9OYeWvp4ewl9f85xX0c4odhl9pKM1VVsi6MotMTLFPxoq
        BLQxIb58BKujsFU9bzIVUiFpWuGdKTO/rCP3im/1aQL0VhHqujsRBNRCw/hzisk7R4tYDd
        FtxfFy4e7x2yRjCjsqLwy1w8+nSsO8Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-ix2vMpOMOAGIbr_VIO99Tw-1; Tue, 21 Jun 2022 15:38:11 -0400
X-MC-Unique: ix2vMpOMOAGIbr_VIO99Tw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3841C85A582;
        Tue, 21 Jun 2022 19:38:11 +0000 (UTC)
Received: from [10.22.17.95] (unknown [10.22.17.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF98740334F;
        Tue, 21 Jun 2022 19:38:10 +0000 (UTC)
Message-ID: <d38f8574-8b99-5871-1525-e87711276736@redhat.com>
Date:   Tue, 21 Jun 2022 15:38:10 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] locking/rtmutex: Limit # of lock stealing for non-RT
 waiters
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mike Stowell <mstowell@redhat.com>
References: <20220621193641.609712-1-longman@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220621193641.609712-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/22 15:36, Waiman Long wrote:
> Commit 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock
> stealing") allows unlimited number of lock stealing's for non-RT
> tasks. That can lead to lock starvation of non-RT top waiter tasks if
> there is a constant incoming stream of non-RT lockers. This can cause
> task lockup in PREEMPT_RT kernel. For example,
>
> [ 1249.921363] INFO: task systemd:2178 blocked for more than 622 seconds.
> [ 1872.984225] INFO: task kworker/6:4:63401 blocked for more than 622 seconds.
>
> Avoiding this problem and ensuring forward progress by limiting the
> number of times that a lock can be stolen from each waiter. This patch
> sets a threshold of 10. That number is arbitrary and can be changed
> if needed.
>
> With that change, the task lockups previously observed when running
> stressful workloads on PREEMPT_RT kernel disappeared.
>
> Fixes: 48eb3f4fcfd3 ("locking/rtmutex: Implement equal priority lock stealing")
> Reported-by: Mike Stowell <mstowell@redhat.com>
> Signed-off-by: Waiman Long <longman@redhat.com>

There is no code change in v2. I have only updated the patch description.

Cheers,
Longman

