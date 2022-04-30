Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF11515D8E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382738AbiD3Nfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345995AbiD3Nfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:35:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF15A94E0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:32:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso12768666pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 06:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=dbDWgmPkPLStp/l8kRXyOJz5NyE5KuQFyXl2VDskwyU=;
        b=nxXKBufS8v7zlmdyBhrIqOI6zYhkk5YZIBkJiU12Zysh/RGlGNgqQYhx5g1z5j2AhE
         ujAPtVqtDXU0WrK5k8bDm10KlHjZMnTHcJERL0TD/hNud6NQ69sCO4ivlgRbMSqsfWUF
         1VtYQ2CSj0fWyKVw/UarmeZwlHQrtMTS8aH8PqdF2AMtUZjoafNoGybi0/3GpVD6hCUF
         qPdixGrPflNOGw8cnppv+b8kl+2BFgtYNRjnYyCGLCo7zDjtDUcQX6RV7zVbXV5MrWf/
         3SJSgdtSOruQiqVhb2QhvcKWrglLGmnLNGAxlKEjjDtAeQk23qgt986PvDycdWdhYnsn
         sXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=dbDWgmPkPLStp/l8kRXyOJz5NyE5KuQFyXl2VDskwyU=;
        b=1ZsZ5KMwX1rmbmF2AqXPEGptdOEDzMBy6zyQ3y4fajn5Xk3YnwEGwp8sBHk82W4k47
         umTQsjroYxaG2O4EmXN2GSd28mNQi4FSoe9Bm5wU5TP6Kqx4TbcJzvUcYlbzqHgP443E
         LYZt+HlYhBoVmwL/vlH6t7rqQcPYE8t/8sOyxN+bIysBeRrCd3lkrgq6r+LQxvRJbAyp
         rLB9fgIO3Ywg813TeNYfJX3Dc5m15dJlo+pHAdgcgzwThlAziGfYGVt2OSWrwnlyT5Vv
         ak0PJWvkkkY/hrBvMnokIEZbbKo5/VoNfBnMfpGXHkohwR+OaHiIoYqD3YbOlh8hN8GY
         QyrQ==
X-Gm-Message-State: AOAM5326kCnRkCZk2XvFsrrqwsjeNiUig72+G6aaVQDsH9H0/1gza9Xq
        fciuHpGCY4qkDH3hH3hVvpko7w==
X-Google-Smtp-Source: ABdhPJxfWSvO+6m1XvVr6FutuZE6Ik/Z5TJmpD/tUHd14ymyAHBgC6TYIizTQ14p2WFMZ1ZUk1AGqg==
X-Received: by 2002:a17:90b:1e4c:b0:1db:cbc5:e031 with SMTP id pi12-20020a17090b1e4c00b001dbcbc5e031mr4280582pjb.62.1651325530190;
        Sat, 30 Apr 2022 06:32:10 -0700 (PDT)
Received: from [10.254.246.218] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id q26-20020a63505a000000b003aa8b87feb5sm8503912pgl.0.2022.04.30.06.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Apr 2022 06:32:09 -0700 (PDT)
Message-ID: <8e4d1e8a-6bf7-df07-2cc6-01d840db2757@bytedance.com>
Date:   Sat, 30 Apr 2022 21:32:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 18/18] Documentation: add document for pte_ref
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <20220429133552.33768-19-zhengqi.arch@bytedance.com>
 <Ym03Z7FlgcCpwXCi@debian.me>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Ym03Z7FlgcCpwXCi@debian.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/30 9:19 PM, Bagas Sanjaya wrote:
> Hi Qi,
> 
> On Fri, Apr 29, 2022 at 09:35:52PM +0800, Qi Zheng wrote:
>> +Now in order to pursue high performance, applications mostly use some
>> +high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
>> +These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
>> +physical memory for the following reasons::
>> +
>> + First of all, we should hold as few write locks of mmap_lock as possible,
>> + since the mmap_lock semaphore has long been a contention point in the
>> + memory management subsystem. The mmap()/munmap() hold the write lock, and
>> + the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
>> + madvise() instead of munmap() to released physical memory can reduce the
>> + competition of the mmap_lock.
>> +
>> + Secondly, after using madvise() to release physical memory, there is no
>> + need to build vma and allocate page tables again when accessing the same
>> + virtual address again, which can also save some time.
>> +
> 
> I think we can use enumerated list, like below:

Thanks for your review, LGTM, will do.

> 
> -- >8 --
> 
> diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
> index 0ac1e5a408d7c6..67b18e74fcb367 100644
> --- a/Documentation/vm/pte_ref.rst
> +++ b/Documentation/vm/pte_ref.rst
> @@ -10,18 +10,18 @@ Preface
>   Now in order to pursue high performance, applications mostly use some
>   high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
>   These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
> -physical memory for the following reasons::
> -
> - First of all, we should hold as few write locks of mmap_lock as possible,
> - since the mmap_lock semaphore has long been a contention point in the
> - memory management subsystem. The mmap()/munmap() hold the write lock, and
> - the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
> - madvise() instead of munmap() to released physical memory can reduce the
> - competition of the mmap_lock.
> -
> - Secondly, after using madvise() to release physical memory, there is no
> - need to build vma and allocate page tables again when accessing the same
> - virtual address again, which can also save some time.
> +physical memory for the following reasons:
> +
> +1. We should hold as few write locks of mmap_lock as possible,
> +   since the mmap_lock semaphore has long been a contention point in the
> +   memory management subsystem. The mmap()/munmap() hold the write lock, and
> +   the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
> +   madvise() instead of munmap() to released physical memory can reduce the
> +   competition of the mmap_lock.
> +
> +2. After using madvise() to release physical memory, there is no
> +   need to build vma and allocate page tables again when accessing the same
> +   virtual address again, which can also save some time.
>   
>   The following is the largest user PTE page table memory that can be
>   allocated by a single user process in a 32-bit and a 64-bit system.
> 
>> +The following is the largest user PTE page table memory that can be
>> +allocated by a single user process in a 32-bit and a 64-bit system.
>> +
> 
> We can say "assuming 4K page size" here,
> 
>> ++---------------------------+--------+---------+
>> +|                           | 32-bit | 64-bit  |
>> ++===========================+========+=========+
>> +| user PTE page table pages | 3 MiB  | 512 GiB |
>> ++---------------------------+--------+---------+
>> +| user PMD page table pages | 3 KiB  | 1 GiB   |
>> ++---------------------------+--------+---------+
>> +
>> +(for 32-bit, take 3G user address space, 4K page size as an example;
>> + for 64-bit, take 48-bit address width, 4K page size as an example.)
>> +
> 
> ... instead of here.

will do.

> 
>> +There is also a lock-less scenario(such as fast GUP). Fortunately, we don't need
>> +to do any additional operations to ensure that the system is in order. Take fast
>> +GUP as an example::
>> +
>> +	thread A		thread B
>> +	fast GUP		madvise(MADV_DONTNEED)
>> +	========		======================
>> +
>> +	get_user_pages_fast_only()
>> +	--> local_irq_save();
>> +				call_rcu(pte_free_rcu)
>> +	    gup_pgd_range();
>> +	    local_irq_restore();
>> +	    			/* do pte_free_rcu() */
>> +
> 
> I see whitespace warning circa do pte_free_rcu() line above when
> applying this series.

will fix.

Thanks,
Qi

> 
> Thanks.
> 

-- 
Thanks,
Qi
