Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48205973B5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbiHQQJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240845AbiHQQJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:09:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DDE60C9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:09:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75356158C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 16:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EED3C433B5;
        Wed, 17 Aug 2022 16:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660752545;
        bh=Fr5BK5q+jt50WHSkwoTNXLWBroAySOyM0j0vhn4tsHo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXmjnC+w3WIxoJ6B2CV0dvuG4o3oJa1N1qLw+oRW6EdETz/GNY2KBVIKS+8PvK96O
         BXB1m6Y/5Xi6grE2mnUZlnMTNeZH8ik/TUa6JrQgFg8rdFn0Q8eLQgwatUH1uWrqDK
         T3zgXMGmVF7fXXi4NzAwQ98Jg43WZ0CFKvkXIYQwLmqHyQv96p0zpvDrPV5oI9UWeE
         V60KIK3gm1iaTEJgPods84LibmBf4AbNI1rABrL1/Y0LcqC+c8B1LZNFv5mIIdDoVw
         oAI6pcuq0UnC8m2xFQd2uqTLxyKaEueVGXCjYEOrN7uu5yN/wL8TmmVOOwJbLNhHX1
         lDFCPnuvmXkvw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Validate if the pmd entry is present before accessing
Date:   Wed, 17 Aug 2022 16:09:02 +0000
Message-Id: <20220817160902.98613-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2838b6737bc259cf575ff11fd1c4b7fdb340fa73.1660717122.git.baolin.wang@linux.alibaba.com>
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

Hi Baolin,


Thank you always for your great patch!

On Wed, 17 Aug 2022 14:21:12 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> The pmd_huge() is used to validate if the pmd entry is mapped by a huge
> page, also including the case of non-present (migration or hwpoisoned)
> pmd entry on arm64 or x86 architectures. Thus we should validate if it
> is present before making the pmd entry old or getting young state,
> otherwise we can not get the correct corresponding page.

Maybe I'm missing something, but... I'm unsure if the page is present or not
really matters from the perspective of access checking.  In the case, DAMON
could simply report the page has accessed once for the first check after the
page being non-present if it really accessed before, and then report the page
as not accessed, which is true.

Please let me know if I'm missing something.


Thanks,
SJ

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/damon/vaddr.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 3c7b9d6..1d16c6c 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -304,6 +304,11 @@ static int damon_mkold_pmd_entry(pmd_t *pmd, unsigned long addr,
>  
>  	if (pmd_huge(*pmd)) {
>  		ptl = pmd_lock(walk->mm, pmd);
> +		if (!pmd_present(*pmd)) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
>  		if (pmd_huge(*pmd)) {
>  			damon_pmdp_mkold(pmd, walk->mm, addr);
>  			spin_unlock(ptl);
> @@ -431,6 +436,11 @@ static int damon_young_pmd_entry(pmd_t *pmd, unsigned long addr,
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	if (pmd_huge(*pmd)) {
>  		ptl = pmd_lock(walk->mm, pmd);
> +		if (!pmd_present(*pmd)) {
> +			spin_unlock(ptl);
> +			return 0;
> +		}
> +
>  		if (!pmd_huge(*pmd)) {
>  			spin_unlock(ptl);
>  			goto regular_page;
> -- 
> 1.8.3.1
