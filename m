Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA8056783C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 22:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiGEUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiGEUPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 16:15:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0E00D66
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 13:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657052122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OzLayEmrqVInXISyaUabBF97skkzZbwG50mDsyOWEPE=;
        b=P1F6ZnL1d5WHU5hGo8H81A2YgecdAsHvQwx/dEp3Kd+fg6LmG7opRqYl2NFETf+p+5kHXg
        RQ/r8duTPV3nF+cxk/hGbDREmwlt9KSwv5CFJ0pUTxPj6zMv7FqhRZgWMOAuRBr/zLfuVG
        OpD2YzBIiB+uveXWYSaiRJnHeVRv1LA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-ITV0QU7pOSe1VKQSHG5Fww-1; Tue, 05 Jul 2022 16:15:19 -0400
X-MC-Unique: ITV0QU7pOSe1VKQSHG5Fww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20DC9811E75;
        Tue,  5 Jul 2022 20:15:19 +0000 (UTC)
Received: from [10.22.16.141] (unknown [10.22.16.141])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D092D2026D64;
        Tue,  5 Jul 2022 20:15:18 +0000 (UTC)
Message-ID: <8cdfa77a-87f3-71eb-4dd7-0ac474632327@redhat.com>
Date:   Tue, 5 Jul 2022 16:15:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/13] locking/qspinlock: Use queued_spin_trylock in
 pv_hybrid_queued_unfair_trylock
Content-Language: en-US
To:     Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
References: <20220704143820.3071004-1-npiggin@gmail.com>
 <20220704143820.3071004-12-npiggin@gmail.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220704143820.3071004-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/22 10:38, Nicholas Piggin wrote:
> Rather than open-code it as necessitated by the old function-renaming
> code generation that rendered queued_spin_trylock unavailable to use
> here.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   kernel/locking/qspinlock.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index cef0ca7d94e1..9db168753124 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -357,7 +357,7 @@ static inline bool pv_hybrid_queued_unfair_trylock(struct qspinlock *lock)
>   		int val = atomic_read(&lock->val);
>   
>   		if (!(val & _Q_LOCKED_PENDING_MASK) &&
> -		   (cmpxchg_acquire(&lock->locked, 0, _Q_LOCKED_VAL) == 0)) {
> +				queued_spin_trylock(lock)) {
>   			lockevent_inc(pv_lock_stealing);
>   			return true;
>   		}

I am not sure if the compiler will eliminate the duplicated 
atomic_read() in queued_spin_trylock(). So unless it can generate the 
same code, I would prefer to leave this alone.

Cheers,
Longman


