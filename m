Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E334A9102
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 00:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355896AbiBCXMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 18:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238866AbiBCXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 18:11:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A89C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 15:11:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D70261554
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 23:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAE8BC340E8;
        Thu,  3 Feb 2022 23:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643929917;
        bh=y5nr/++kCTv/1eYPXjSUtMA7ZAyuHZosRKaaT4urjdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o1k8u9wnw7NWbcegn4kKmVKvXftbtsYgvGcVbdhl90catqBDYZn/HC8M7K7F8Z/81
         k6dPihoih1b5Osg73DZIwTlkO3gpPS1Ok3K5RexrrpYv6PGQ7zNfKuHyEAQEK0ZOXA
         x8ZXeA83ZDcxastoUUmmY0TiJnlEafJ5MEuZOl98=
Date:   Thu, 3 Feb 2022 15:11:57 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Justin Forbes <jforbes@redhat.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2] mm/sparsemem: Fix 'mem_section' will never be NULL
 gcc 12 warning
Message-Id: <20220203151157.659f382c76056d883fa80ec6@linux-foundation.org>
In-Reply-To: <20220202003550.698768-1-longman@redhat.com>
References: <20220202003550.698768-1-longman@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  1 Feb 2022 19:35:50 -0500 Waiman Long <longman@redhat.com> wrote:

> The gcc 12 compiler reports a "'mem_section' will never be NULL"
> warning on the following code:
> 
>     static inline struct mem_section *__nr_to_section(unsigned long nr)
>     {
>     #ifdef CONFIG_SPARSEMEM_EXTREME
>         if (!mem_section)
>                 return NULL;
>     #endif
>         if (!mem_section[SECTION_NR_TO_ROOT(nr)])
>                 return NULL;
>        :
> 
> It happens with both CONFIG_SPARSEMEM_EXTREME on and off. The mem_section
> definition is
> 
>     #ifdef CONFIG_SPARSEMEM_EXTREME
>     extern struct mem_section **mem_section;
>     #else
>     extern struct mem_section mem_section[NR_SECTION_ROOTS][SECTIONS_PER_ROOT];
>     #endif
> 
> In the CONFIG_SPARSEMEM_EXTREME case, mem_section obviously cannot
> be NULL, but *mem_section can be if memory hasn't been allocated for
> the dynamic mem_section[] array yet. In the !CONFIG_SPARSEMEM_EXTREME
> case, mem_section is a static 2-dimensional array and so the check
> "!mem_section[SECTION_NR_TO_ROOT(nr)]" doesn't make sense.
> 
> Fix this warning by checking for "!*mem_section" instead of
> "!mem_section" and moving the "!mem_section[SECTION_NR_TO_ROOT(nr)]"
> check up inside the CONFIG_SPARSEMEM_EXTREME block.
> 
> ...
>
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1390,11 +1390,9 @@ static inline unsigned long *section_to_usemap(struct mem_section *ms)
>  static inline struct mem_section *__nr_to_section(unsigned long nr)
>  {
>  #ifdef CONFIG_SPARSEMEM_EXTREME
> -	if (!mem_section)
> +	if (!*mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
>  		return NULL;
>  #endif
> -	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
> -		return NULL;
>  	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
>  }
>  extern size_t mem_section_usage_size(void);

What does the v1->v2 change do?

--- a/include/linux/mmzone.h~mm-sparsemem-fix-mem_section-will-never-be-null-gcc-12-warning-v2
+++ a/include/linux/mmzone.h
@@ -1390,11 +1390,9 @@ static inline unsigned long *section_to_
 static inline struct mem_section *__nr_to_section(unsigned long nr)
 {
 #ifdef CONFIG_SPARSEMEM_EXTREME
-	if (!*mem_section)
+	if (!*mem_section || !mem_section[SECTION_NR_TO_ROOT(nr)])
 		return NULL;
 #endif
-	if (!mem_section[SECTION_NR_TO_ROOT(nr)])
-		return NULL;
 	return &mem_section[SECTION_NR_TO_ROOT(nr)][nr & SECTION_ROOT_MASK];
 }
 extern size_t mem_section_usage_size(void);
_

