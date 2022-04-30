Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F3515D70
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355323AbiD3NXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiD3NXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:23:02 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5257A76FC;
        Sat, 30 Apr 2022 06:19:40 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id k1so692690pll.4;
        Sat, 30 Apr 2022 06:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0SuQrAfcBYJGPjhTb8t3lZ1fTklP5mGBmOFSXiuMhmc=;
        b=guX6UFeGOXdCf7G4DGwuOBPyxqnjJ9tCzBu0mRaiqkNC3BSKW2ZIqgtjeZfOvgEbD9
         ZeQCYrikPLnMv/JMSNhbPiODTxSl6/modpzf+XACc4XWsMMEktlfhSHq2c6Q6gjaelcq
         6xEVzn4UECF6HlJJpYguuboiGQJlNUYNnSFcyr4bdgPnG+0n1F6LqZmikCbgocVqEOVd
         cWwE4snElvpQCSM8UaAxDBkn1mcfkf7bCtxUoNlZwrOotjC0JiK10oRSI5WTtxSd7YU1
         1qWAXjCn5U4/tMdnTZCw3Lp0m0EaJQ2JBbw12sUUjgQxv4ecVZTF472NuGrgPG5MNtrN
         8mZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0SuQrAfcBYJGPjhTb8t3lZ1fTklP5mGBmOFSXiuMhmc=;
        b=Yw1lvnKRbie3DWZnr9pQu0lSztb3pwdcuo3BzjeKAq9QQPi3McIc1Vh8DXc06mdGNL
         deOld4/TstJt2pZpxHDfK+vd/BdOAapYtf6kqpAdavPPkHWf0i+iA8w32jMbOio72a1N
         uFYyBN9RAk/75LGDJCmt+SdQE7T3Mt+20FXXVZapYg1xUbAtqwM+09/o382BHh1q2j1d
         q0KI+4EkAglTwkF6o6Yjvuuyh0SUDc1u6hsQ+MwEwSSiA4YJFMQk9ae3dj/uAGRfqVX7
         bjSHHZUHsFf8svmbVEfX5vtAkWt5fq8/WOK1MmiJrrySZ9Gpef7qrtGu6cCiij4WIq/K
         BFfA==
X-Gm-Message-State: AOAM531qjm0ZMXUkSpoFegemUEBkw0XzZfXYirn1SZqbIe99nEbU3eJZ
        s0opCfEoJiTBlL6TsAhfREo=
X-Google-Smtp-Source: ABdhPJwluFKZsRBqSdXxOv0+QMmM1ka3+CCPGlykURC3WPLkLxCSRzwTEHIoaPzaxD531XvUGDN88g==
X-Received: by 2002:a17:902:e74e:b0:15e:92bc:c27c with SMTP id p14-20020a170902e74e00b0015e92bcc27cmr1258558plf.8.1651324780169;
        Sat, 30 Apr 2022 06:19:40 -0700 (PDT)
Received: from localhost (subs32-116-206-28-15.three.co.id. [116.206.28.15])
        by smtp.gmail.com with ESMTPSA id j24-20020aa78d18000000b0050dc76281bbsm1552018pfe.149.2022.04.30.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 06:19:39 -0700 (PDT)
Date:   Sat, 30 Apr 2022 20:19:35 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, mika.penttila@nextfour.com,
        david@redhat.com, jgg@nvidia.com, tj@kernel.org, dennis@kernel.org,
        ming.lei@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        songmuchun@bytedance.com, zhouchengming@bytedance.com
Subject: Re: [RFC PATCH 18/18] Documentation: add document for pte_ref
Message-ID: <Ym03Z7FlgcCpwXCi@debian.me>
References: <20220429133552.33768-1-zhengqi.arch@bytedance.com>
 <20220429133552.33768-19-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429133552.33768-19-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi,

On Fri, Apr 29, 2022 at 09:35:52PM +0800, Qi Zheng wrote:
> +Now in order to pursue high performance, applications mostly use some
> +high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
> +These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
> +physical memory for the following reasons::
> +
> + First of all, we should hold as few write locks of mmap_lock as possible,
> + since the mmap_lock semaphore has long been a contention point in the
> + memory management subsystem. The mmap()/munmap() hold the write lock, and
> + the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
> + madvise() instead of munmap() to released physical memory can reduce the
> + competition of the mmap_lock.
> +
> + Secondly, after using madvise() to release physical memory, there is no
> + need to build vma and allocate page tables again when accessing the same
> + virtual address again, which can also save some time.
> +

I think we can use enumerated list, like below:

-- >8 --

diff --git a/Documentation/vm/pte_ref.rst b/Documentation/vm/pte_ref.rst
index 0ac1e5a408d7c6..67b18e74fcb367 100644
--- a/Documentation/vm/pte_ref.rst
+++ b/Documentation/vm/pte_ref.rst
@@ -10,18 +10,18 @@ Preface
 Now in order to pursue high performance, applications mostly use some
 high-performance user-mode memory allocators, such as jemalloc or tcmalloc.
 These memory allocators use madvise(MADV_DONTNEED or MADV_FREE) to release
-physical memory for the following reasons::
-
- First of all, we should hold as few write locks of mmap_lock as possible,
- since the mmap_lock semaphore has long been a contention point in the
- memory management subsystem. The mmap()/munmap() hold the write lock, and
- the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
- madvise() instead of munmap() to released physical memory can reduce the
- competition of the mmap_lock.
-
- Secondly, after using madvise() to release physical memory, there is no
- need to build vma and allocate page tables again when accessing the same
- virtual address again, which can also save some time.
+physical memory for the following reasons:
+
+1. We should hold as few write locks of mmap_lock as possible,
+   since the mmap_lock semaphore has long been a contention point in the
+   memory management subsystem. The mmap()/munmap() hold the write lock, and
+   the madvise(MADV_DONTNEED or MADV_FREE) hold the read lock, so using
+   madvise() instead of munmap() to released physical memory can reduce the
+   competition of the mmap_lock.
+
+2. After using madvise() to release physical memory, there is no
+   need to build vma and allocate page tables again when accessing the same
+   virtual address again, which can also save some time.
 
 The following is the largest user PTE page table memory that can be
 allocated by a single user process in a 32-bit and a 64-bit system.

> +The following is the largest user PTE page table memory that can be
> +allocated by a single user process in a 32-bit and a 64-bit system.
> +

We can say "assuming 4K page size" here,

> ++---------------------------+--------+---------+
> +|                           | 32-bit | 64-bit  |
> ++===========================+========+=========+
> +| user PTE page table pages | 3 MiB  | 512 GiB |
> ++---------------------------+--------+---------+
> +| user PMD page table pages | 3 KiB  | 1 GiB   |
> ++---------------------------+--------+---------+
> +
> +(for 32-bit, take 3G user address space, 4K page size as an example;
> + for 64-bit, take 48-bit address width, 4K page size as an example.)
> +

... instead of here.

> +There is also a lock-less scenario(such as fast GUP). Fortunately, we don't need
> +to do any additional operations to ensure that the system is in order. Take fast
> +GUP as an example::
> +
> +	thread A		thread B
> +	fast GUP		madvise(MADV_DONTNEED)
> +	========		======================
> +
> +	get_user_pages_fast_only()
> +	--> local_irq_save();
> +				call_rcu(pte_free_rcu)
> +	    gup_pgd_range();
> +	    local_irq_restore();
> +	    			/* do pte_free_rcu() */
> +

I see whitespace warning circa do pte_free_rcu() line above when
applying this series.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
