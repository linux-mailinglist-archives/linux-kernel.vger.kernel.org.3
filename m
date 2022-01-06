Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC02C485F41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 04:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiAFDen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 22:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58324 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229593AbiAFDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 22:34:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641440081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u+HGFdmIXdJmHP9QK0j9Uw9SU9GiyJhQU7QWjrfmCXg=;
        b=EAJMAW41+ondLxzg7y98tDV7b2VW9PlChi/KFMDwdG5JA4vXdJg96vULfXE4mvHm3K88xy
        3w/5Juy0wZjQiE5h+5hJn8oLCGTYbSL3n96bySExioPkqlzpg/HYkpQcTptiD8w7PQwLh4
        2GZCjQrsWAq2d71qB9EFR8lpvgyQ/wc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-TIruUn19OxG2DzyDCxiCEw-1; Wed, 05 Jan 2022 22:34:38 -0500
X-MC-Unique: TIruUn19OxG2DzyDCxiCEw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BDA61083F68;
        Thu,  6 Jan 2022 03:34:37 +0000 (UTC)
Received: from [10.22.16.135] (unknown [10.22.16.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 914EAE2FF;
        Thu,  6 Jan 2022 03:34:31 +0000 (UTC)
Message-ID: <00c4c55b-7fa6-d29c-4a80-c196922ef527@redhat.com>
Date:   Wed, 5 Jan 2022 22:34:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] locking/local_lock: Make the empty local_lock_*()
 function a macro.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220105202623.1118172-1-bigeasy@linutronix.de>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220105202623.1118172-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/22 15:26, Sebastian Andrzej Siewior wrote:
> It has been said that local_lock() does not add any overhead compared to
> preempt_disable() in a !LOCKDEP configuration. A microbenchmark showed
> an unexpected result which can be reduced to the fact that local_lock()
> was not entirely optimized away.
> In the !LOCKDEP configuration local_lock_acquire() is an empty static
> inline function. On x86 the this_cpu_ptr() argument of that function is
> fully evaluated leading to an additional mov+add instructions which are
> not needed and not used.
>
> Replace the static inline function with a macro. The typecheck() macro
> ensures that the argument is of proper type while the resulting
> disassembly shows no traces of this_cpu_ptr().
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> On -rc8, size says:
> |     text    data     bss      dec     filename
> | 19656718 8681015 3764440 32102173 vmlinux.old
> | 19656218 8681015 3764440 32101673 vmlinux.new
>
> Which is -500 text, not much but still.
>
>   include/linux/local_lock_internal.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
> index 975e33b793a77..6d635e8306d64 100644
> --- a/include/linux/local_lock_internal.h
> +++ b/include/linux/local_lock_internal.h
> @@ -44,9 +44,9 @@ static inline void local_lock_debug_init(local_lock_t *l)
>   }
>   #else /* CONFIG_DEBUG_LOCK_ALLOC */
>   # define LOCAL_LOCK_DEBUG_INIT(lockname)
> -static inline void local_lock_acquire(local_lock_t *l) { }
> -static inline void local_lock_release(local_lock_t *l) { }
> -static inline void local_lock_debug_init(local_lock_t *l) { }
> +# define local_lock_acquire(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
> +# define local_lock_release(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
> +# define local_lock_debug_init(__ll)  do { typecheck(local_lock_t *, __ll); } while (0)
>   #endif /* !CONFIG_DEBUG_LOCK_ALLOC */
>   
>   #define INIT_LOCAL_LOCK(lockname)	{ LOCAL_LOCK_DEBUG_INIT(lockname) }

I try out this patch and it indeed helps to reduce the object size of 
functions that use local_lock(). However, the extra code isn't an 
additional mov+add.

Using folio_add_lru() as an example,

Without the patch:

466        local_lock(&lru_pvecs.lock);
    0x00000000000032ee <+14>:    mov    $0x1,%edi
    0x00000000000032f3 <+19>:    callq  0x32f8 <folio_add_lru+24>
    0x00000000000032f8 <+24>:    callq  0x32fd <folio_add_lru+29>

With the patch:

466             local_lock(&lru_pvecs.lock);
    0x00000000000032ae <+14>:    mov    $0x1,%edi
    0x00000000000032b3 <+19>:    callq  0x32b8 <folio_add_lru+24>

There is one less placeholder for tracing. Maybe it depends on the 
compiler and the exact config options.

Anyway,

Reviewed-by: Waiman Long <longman@redhat.com>

