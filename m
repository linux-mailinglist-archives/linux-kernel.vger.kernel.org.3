Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D725A2D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343829AbiHZRIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiHZRIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:08:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F202CE305
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CE5D61BA2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C1CC433C1;
        Fri, 26 Aug 2022 17:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661533702;
        bh=JNWgzqw2tKu/IX/8pc1hZ71PjLuc8vnbXaaTYzYOVqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rDfBAJ8bVPWABbCjjYIv+k1fEpTx6a0eLEdqz6XZPoY4zq1SYEerpdmETH7OYZt9M
         skgKatTSN3AEbor1Jpr5W4kAg2K6F/3J41YYTw6WdXJTffyFhCkAq0pH+Haqp52TCj
         cBvv1jI+l6WqHrm7h+021WQI8cG0F9ml5IKlfAKV4oqMzejBdSdbC9naewR1liiSc5
         h6m3rHVBLI7u5INQH6nCWf2ol7XuKMpMKQA4SpQBJ48A/ZGBD/x28RAmYIHyfFjwwG
         e5j1wkbTWkitMUR/gUjdTHiyQ/41Z1kHRD7psMqHbb9DjwJshs20F/R46RFYK7CJR3
         R0zOBzVXNl8kQ==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 1/2] mm/damon: simplify the parameter passing for 'check_accesses'
Date:   Fri, 26 Aug 2022 17:08:18 +0000
Message-Id: <20220826170818.50050-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1661502678-19336-2-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kaixu,

On Fri, 26 Aug 2022 16:31:17 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> The parameter 'struct damon_ctx *ctx' is unnecessary in damon
> 'check_accesses' callback operation, so we can remove it.

Thank you for the finding, but this wording is not 100% perfect, strictly
speaking.  The callback operations indeed use the parameter, but the internal
functions called by the callbacks (__damon_{p,v}a_check_access()) aren't.

Could you please update the message?

> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> ---
>  mm/damon/paddr.c | 5 ++---
>  mm/damon/vaddr.c | 5 ++---
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index dc131c6a5403..6b0d9e6aa677 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -166,8 +166,7 @@ static bool damon_pa_young(unsigned long paddr, unsigned long *page_sz)
>  	return result.accessed;
>  }
>  
> -static void __damon_pa_check_access(struct damon_ctx *ctx,
> -				    struct damon_region *r)
> +static void __damon_pa_check_access(struct damon_region *r)
>  {
>  	static unsigned long last_addr;
>  	static unsigned long last_page_sz = PAGE_SIZE;
> @@ -196,7 +195,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
>  
>  	damon_for_each_target(t, ctx) {
>  		damon_for_each_region(r, t) {
> -			__damon_pa_check_access(ctx, r);
> +			__damon_pa_check_access(r);
>  			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
>  		}
>  	}
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6dca95..c8c2f306bb6d 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -532,8 +532,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
>   * mm	'mm_struct' for the given virtual address space
>   * r	the region to be checked
>   */
> -static void __damon_va_check_access(struct damon_ctx *ctx,
> -			       struct mm_struct *mm, struct damon_region *r)
> +static void __damon_va_check_access(struct mm_struct *mm, struct damon_region *r)

I still prefer 80 columns rule[1].  Could you please break this line?


[1] https://docs.kernel.org/process/coding-style.html#breaking-long-lines-and-strings

>  {
>  	static struct mm_struct *last_mm;
>  	static unsigned long last_addr;
> @@ -568,7 +567,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
>  		if (!mm)
>  			continue;
>  		damon_for_each_region(r, t) {
> -			__damon_va_check_access(ctx, mm, r);
> +			__damon_va_check_access(mm, r);
>  			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
>  		}
>  		mmput(mm);
> -- 
> 2.27.0


Thanks,
SJ
