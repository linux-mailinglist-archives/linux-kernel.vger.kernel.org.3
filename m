Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9C4D25BC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiCIBIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiCIBIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:08:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33AF3141FE8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646786956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1eWWygYqRs8r9/W14PM2EEm1/2DPyShF2lrMpAUnZw=;
        b=DNhVT/fqUiiWh0SnvhpAwr0pcO9QAqElKxgELByJKKrYSOABfhCT7o71jNtKJ+Ko6A1Xiw
        fsjjPI6vgRzT5wHFQTVy3wt8IBSB/1iq0UCLl3vOT/3bcHFo14qSjs2fXaMmaYChPh09nG
        OpVxwW6UXE/BN5c26bBv7Hc8d4nxisc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-E5kCM6r3OzGotQCLRK3XaQ-1; Tue, 08 Mar 2022 19:49:11 -0500
X-MC-Unique: E5kCM6r3OzGotQCLRK3XaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12103180FD72;
        Wed,  9 Mar 2022 00:49:09 +0000 (UTC)
Received: from [10.22.11.135] (unknown [10.22.11.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 220CD131FF;
        Wed,  9 Mar 2022 00:48:12 +0000 (UTC)
Message-ID: <8dc145f2-7195-05a1-40c5-533301ffca8b@redhat.com>
Date:   Tue, 8 Mar 2022 19:48:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4] mm/oom_kill.c: futex: Don't OOM reap a process with a
 futex robust list
Content-Language: en-US
To:     Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Rafael Aquini <aquini@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, tglx@linutronix.de,
        mingo@redhat.com, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, peterz@infradead.org,
        Joel Savitz <jsavitz@redhat.com>
References: <20220309002550.103786-1-npache@redhat.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20220309002550.103786-1-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/22 19:25, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is also used to store the futex
> robust list; the kernel does not keep a copy of the robust list and instead
> references a userspace address to maintain the robustness during a process
> death. A race can occur between exit_mm and the oom reaper that allows
> the oom reaper to clear the memory of the futex robust list before the
> exit path has handled the futex death.
>
> Prevent the OOM reaper from concurrently reaping the mappings if the dying
> process contains a robust_list. If the dying task_struct does not contain
> a pointer in tsk->robust_list, we can assume there was either never one
> setup for this task struct, or futex_cleanup has properly handled the
> futex death and we can safely reap this memory.
>
> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>
> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
>
> Fixes: 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> Cc: Rafael Aquini <aquini@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Christoph von Recklinghausen <crecklin@redhat.com>
> Cc: Don Dutile <ddutile@redhat.com>
> Cc: Herton R. Krzesinski <herton@redhat.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: <tglx@linutronix.de>
> Cc: <mingo@redhat.com>
> Cc: <dvhart@infradead.org>
> Cc: <dave@stgolabs.net>
> Cc: <andrealmeid@collabora.com>
> Cc: <peterz@infradead.org>
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/oom_kill.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
>
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 989f35a2bbb1..37af902494d8 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -587,6 +587,25 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>   		goto out_unlock;
>   	}
>   
> +	/* Don't reap a process holding a robust_list as the pthread
> +	 * struct is allocated in userspace using PRIVATE | ANONYMOUS
> +	 * memory which when reaped before futex_cleanup() can leave
> +	 * the waiting process stuck.
> +	 */
> +#ifdef CONFIG_FUTEX
> +	bool robust = false;
> +
> +	robust = tsk->robust_list != NULL;
> +#ifdef CONFIG_COMPAT
> +	robust |= tsk->compat_robust_list != NULL;
> +#endif
> +	if (robust) {
> +		trace_skip_task_reaping(tsk->pid);
> +		pr_info("oom_reaper: skipping task as it contains a robust list");
> +		goto out_finish;
> +	}
> +#endif
> +
>   	trace_start_task_reaping(tsk->pid);
>   
>   	/* failed to reap part of the address space. Try again later */

I believe it will be easier to read if you define a helper function like

#ifdef CONFIG_FUTEX
static inline bool has_robust_list(struct task_struct *tsk)
{
         bool robust = !!tsk->robust_list;

#ifdef CONFIG_COMPAT
         robust |= !!tsk->compat_robust_list
#endif
         return robust;
}
#else
static inline bool has_robust_list(struct task_struct *tsk)
{
         return false;
}
#endif

Then you don't need any #if/endif in oom_reap_task_mm().

Cheers,
Longman

