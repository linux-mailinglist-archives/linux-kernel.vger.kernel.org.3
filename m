Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7153C54D8C1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 05:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347286AbiFPDFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 23:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355476AbiFPDFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 23:05:17 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD659317
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:05:16 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id h8so239989iof.11
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 20:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ia8NRYuAyorF84NZn0AhWx3rPjmmPgwj0oxuUxbqGH0=;
        b=EjQ4Hm2C6KM/PT3daezaLxa16j4cevhGJMNxJEuc7R5D1EDHTKlhUb2gvOkVgSs6qD
         g4KwAL7QeRMJXDrUQBhEyrNLrP2J/h88gk86aP0IboOcS7GmeboLC6Ft1PUsFjLXs87J
         tyacGNu/D02GuMffl1Eic39yil72G/QR2OzkDzstOPW8hSOzcue6wZMQDNpE7l8lar8R
         GP+0HHMfK+s8lsCWuZE78qSaGzem/DmnHDPg6CYfsl9SBBz8oJflMSS0P9uIY9ZZbp8W
         174Q/Wdn/SSLCNp0Jeq5kSau3kaDTF+Cowm7zoO9lBbd1TWiXkekH7CL2AqLNZyUyYRE
         hWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ia8NRYuAyorF84NZn0AhWx3rPjmmPgwj0oxuUxbqGH0=;
        b=7I7NiruVLJ8SuacN31tZWG+f53ybWe04CNPtwSkq00ctDFWQ+UVT4V8RVECApgEMSK
         xqh8VPVK8H96wGHzIjiK0ZftrHTol3iZZi0hpDerFrjELhozH09on2Xg8QV63MlkR15L
         kNhtSpxWiJh0hPQMz0uRfYGgc7yETOZ5DnRRfqLLnwJcdnFD6mg4a+e+EhJm2828A3uo
         kuWzDMf94tS4mTknCG1qDRqkpycilBLcJCtI+qKTtCjA9PFMrq+LkdPYPm8VOKHXIt0O
         fenWxCiRUCGOOFi6A6lhurRRaCBJ5wZyjDSPfQ7ofmBQXlFCpgcWTbAybyStFGkk4Qv5
         Yapw==
X-Gm-Message-State: AJIora90+uEUiMglBLHOL4i+4I7ROIWm6UVdBXVXYYAqrnHbgFpqtkKf
        nQeALmj3+SJ/eXQQFsYBQA0YyA==
X-Google-Smtp-Source: AGRyM1tUhKipAam+v0qoTfTbqExpcugfO9yBLoMN9WRVDRYM5mW2/QyOGjHDwInDr7R0O1bo7yoNaw==
X-Received: by 2002:a05:6638:1342:b0:331:e382:b0af with SMTP id u2-20020a056638134200b00331e382b0afmr1676952jad.32.1655348715522;
        Wed, 15 Jun 2022 20:05:15 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:ca55:eadb:f716:c179])
        by smtp.gmail.com with ESMTPSA id 17-20020a921811000000b002d6596e02f6sm388146ily.48.2022.06.15.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 20:05:14 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:05:10 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
Message-ID: <Yqqd5nHeAT77C4D0@google.com>
References: <20220613125622.18628-1-mgorman@techsingularity.net>
 <20220613125622.18628-8-mgorman@techsingularity.net>
 <CGME20220615224855eucas1p1ea6d90c23ec9423dfe04b267f6dddd2a@eucas1p1.samsung.com>
 <e1c73640-3f29-bf57-b98d-84b1800cf4e3@samsung.com>
 <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615160446.be1f75fd256d67e57b27a9fc@linux-foundation.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 04:04:46PM -0700, Andrew Morton wrote:
> On Thu, 16 Jun 2022 00:48:55 +0200 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> 
> > In the logs I see lots of errors like:
> > 
> > BUG: sleeping function called from invalid context at 
> > ./include/linux/sched/mm.h:274
> > 
> > BUG: scheduling while atomic: systemd-udevd/288/0x00000002
> > 
> > BUG: sleeping function called from invalid context at mm/filemap.c:2647
> > 
> > however there are also a fatal ones like:
> > 
> > Unable to handle kernel paging request at virtual address 00000000017a87b4
> > 
> > 
> > The issues seems to be a bit random. Looks like memory trashing. 
> > Reverting $subject on top of current linux-next fixes all those issues.
> > 
> > 
> 
> This?
> 
> --- a/mm/page_alloc.c~mm-page_alloc-replace-local_lock-with-normal-spinlock-fix
> +++ a/mm/page_alloc.c
> @@ -183,8 +183,10 @@ static DEFINE_MUTEX(pcp_batch_high_lock)
>  	type *_ret;							\
>  	pcpu_task_pin();						\
>  	_ret = this_cpu_ptr(ptr);					\
> -	if (!spin_trylock_irqsave(&_ret->member, flags))		\
> +	if (!spin_trylock_irqsave(&_ret->member, flags)) {		\
> +		pcpu_task_unpin();					\
>  		_ret = NULL;						\
> +	}								\
>  	_ret;								\
>  })
>  
> 
> I'll drop Mel's patch for next -next.

While we are at it, please consider this cleanup:

 mm/page_alloc.c | 48 +++++++++---------------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e538dde2c1c0..a1b76d5fdf75 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -160,61 +160,31 @@ static DEFINE_MUTEX(pcp_batch_high_lock);
  * Generic helper to lookup and a per-cpu variable with an embedded spinlock.
  * Return value should be used with equivalent unlock helper.
  */
-#define pcpu_spin_lock(type, member, ptr)				\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	spin_lock(&_ret->member);					\
-	_ret;								\
-})
-
-#define pcpu_spin_lock_irqsave(type, member, ptr, flags)		\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	spin_lock_irqsave(&_ret->member, flags);			\
-	_ret;								\
-})
-
-#define pcpu_spin_trylock_irqsave(type, member, ptr, flags)		\
-({									\
-	type *_ret;							\
-	pcpu_task_pin();						\
-	_ret = this_cpu_ptr(ptr);					\
-	if (!spin_trylock_irqsave(&_ret->member, flags))		\
-		_ret = NULL;						\
-	_ret;								\
-})
-
-#define pcpu_spin_unlock(member, ptr)					\
-({									\
-	spin_unlock(&ptr->member);					\
-	pcpu_task_unpin();						\
-})
-
-#define pcpu_spin_unlock_irqrestore(member, ptr, flags)			\
-({									\
-	spin_unlock_irqrestore(&ptr->member, flags);			\
-	pcpu_task_unpin();						\
-})
-
-/* struct per_cpu_pages specific helpers. */
-#define pcp_spin_lock(ptr)						\
-	pcpu_spin_lock(struct per_cpu_pages, lock, ptr)
-
 #define pcp_spin_lock_irqsave(ptr, flags)				\
-	pcpu_spin_lock_irqsave(struct per_cpu_pages, lock, ptr, flags)
+({									\
+	struct per_cpu_pages *_ret;					\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	spin_lock_irqsave(&_ret->lock, flags);				\
+	_ret;								\
+})
 
 #define pcp_spin_trylock_irqsave(ptr, flags)				\
-	pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, ptr, flags)
-
-#define pcp_spin_unlock(ptr)						\
-	pcpu_spin_unlock(lock, ptr)
+({									\
+	struct per_cpu_pages *_ret;					\
+	pcpu_task_pin();						\
+	_ret = this_cpu_ptr(ptr);					\
+	if (!spin_trylock_irqsave(&_ret->lock, flags))			\
+		_ret = NULL;						\
+	_ret;								\
+})
 
 #define pcp_spin_unlock_irqrestore(ptr, flags)				\
-	pcpu_spin_unlock_irqrestore(lock, ptr, flags)
+({									\
+	spin_unlock_irqrestore(&ptr->lock, flags);			\
+	pcpu_task_unpin();						\
+})
+
 #ifdef CONFIG_USE_PERCPU_NUMA_NODE_ID
 DEFINE_PER_CPU(int, numa_node);
 EXPORT_PER_CPU_SYMBOL(numa_node);
@@ -3488,7 +3458,7 @@ void free_unref_page(struct page *page, unsigned int order)
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
-	pcp = pcpu_spin_trylock_irqsave(struct per_cpu_pages, lock, zone->per_cpu_pageset, flags);
+	pcp = pcp_spin_trylock_irqsave(zone->per_cpu_pageset, flags);
 	if (pcp) {
 		free_unref_page_commit(pcp, zone, page, migratetype, order);
 		pcp_spin_unlock_irqrestore(pcp, flags);
