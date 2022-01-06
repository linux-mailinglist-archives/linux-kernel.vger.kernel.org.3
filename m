Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0807B4863CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 12:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbiAFLky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 06:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiAFLkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 06:40:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A1CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 03:40:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 366A1B82075
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A96C36AE5;
        Thu,  6 Jan 2022 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641469249;
        bh=X7RCdm4O2Lg49wWZJYOAi9ONRA/1tcdB/DbJujlUhZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=DdtwxWliuf1CU/ygEXsjMEGxbjQyW9Rv0OvlDjPgEay4teB0iFTKD8cmEToDAbZik
         lrODjzXhBGLXvmTzmEc16EjybEYk+bTRfQQkummblvBwAmbfMpoWWLAKlg6TV0JF9v
         6M5/gIt54sGtFkBtuZ0y0U9FqYnNIVE4+VGHiw++RjCmn+ZQlNvfV+ovqAjXTpKs5w
         u1tgnRASm9VdjVZOZuJcQnlyXmQv0/5U0ZQOuf3tBa7Bn0zq6Ypi0EDrjcCPWZLeMG
         76ZlV9dEIwDEBcVBJL9Vgqf2LJVvC/wfhNXTAiujDO3c6Ya14LifjrGEBmZOcIcxVZ
         1/VFmPAST/iJw==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, dan.carpenter@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Remove redundant page validation
Date:   Thu,  6 Jan 2022 11:40:47 +0000
Message-Id: <20220106114047.6595-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cd28052e89166d4ab90e360cce3421748076a0fc.1641465458.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,


Thank you always for your great contribution!  As always, trivial comments
below.

On Thu, 6 Jan 2022 18:40:11 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> It will never get a NULL page by pte_page(), thus remove the redundant
> page validation to fix below Smatch static checker warning.

I guess the issue has reported in the open place[1], right?  I think it would
be better to add the link in this commit message, so that future readers can
read and learn from your discussion in the mail thread.

[1] https://lore.kernel.org/linux-mm/20220106091200.GA14564@kili/

> 
> mm/damon/vaddr.c:405 damon_hugetlb_mkold()
> warn: 'page' can't be NULL.

Sorry for continuously obsessing about this trivial and personal taste, but...
Could you please indent quoting blocks like above (hopefully with 4 spaces)?
That makes the message much easier to read for me, and I'd like to keep the
commit messages for DAMON consistent and easy to read, at least for me.

Other than that,

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/damon/vaddr.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
> index 89b6468d..8a52e00 100644
> --- a/mm/damon/vaddr.c
> +++ b/mm/damon/vaddr.c
> @@ -402,9 +402,6 @@ static void damon_hugetlb_mkold(pte_t *pte, struct mm_struct *mm,
>  	pte_t entry = huge_ptep_get(pte);
>  	struct page *page = pte_page(entry);
>  
> -	if (!page)
> -		return;
> -
>  	get_page(page);
>  
>  	if (pte_young(entry)) {
> @@ -564,9 +561,6 @@ static int damon_young_hugetlb_entry(pte_t *pte, unsigned long hmask,
>  		goto out;
>  
>  	page = pte_page(entry);
> -	if (!page)
> -		goto out;
> -
>  	get_page(page);
>  
>  	if (pte_young(entry) || !page_is_idle(page) ||
> -- 
> 1.8.3.1
