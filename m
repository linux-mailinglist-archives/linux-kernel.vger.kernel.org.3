Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D0747BE01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 11:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbhLUKN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 05:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhLUKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 05:13:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68291C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 02:13:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B11061504
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 10:13:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9387BC36AE2;
        Tue, 21 Dec 2021 10:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640081636;
        bh=XUtUeesjUW0N0RTiH9C7BMgKdDECvFy8Vw2HjbvdAQE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=eO697KCL47SgmUOkcPCrG68fTNQL/xGwqlqGA6mBraT3ld0otqada4bKF3oB0t2GQ
         m4aJkFiZzDL4VmsCpiJja4IcHuGDdtRh6GB5/sqoGVTyy5xhSQsuvUpGE2BlyTGPzP
         hixIVJuACyh8WIVJtsq2P3Eb8Flv+rl5uJUjgN+vfm0atrsvZcpBEncGhdt0IU6I1K
         hdblL4kgOABB5vlwvGCx2EZ75gV+1UqPDtrqtvriWbyZYxdNT1t0MOeGb4IfbVNLh0
         AZgLHP2GWlhG/Mjb9wshxAqCVWG8FuHtYuv7UuSe1pMEZGFnVziiSTDYN/Wjceecmg
         Pkp3x3CAd2G9w==
From:   SeongJae Park <sj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, ying.huang@intel.com,
        dave.hansen@linux.intel.com, ziy@nvidia.com, shy828301@gmail.com,
        zhongjiang-ali@linux.alibaba.com, xlpang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Export the alloc_demote_page() function
Date:   Tue, 21 Dec 2021 10:13:41 +0000
Message-Id: <20211221101341.14345-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <611250978aa68c1fab6112a795e9c0e5b817d9ee.1640077468.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Dec 2021 17:18:03 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> Export the alloc_demote_page() function to the head file as a
> preparation to support page demotion for DAMON monitor.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

> ---
>  mm/internal.h | 1 +
>  mm/vmscan.c   | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index deb9bda..99ea5fb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -181,6 +181,7 @@ static inline void set_page_refcounted(struct page *page)
>  extern int isolate_lru_page(struct page *page);
>  extern void putback_lru_page(struct page *page);
>  extern void reclaim_throttle(pg_data_t *pgdat, enum vmscan_throttle_state reason);
> +extern struct page *alloc_demote_page(struct page *page, unsigned long node);
>  
>  /*
>   * in mm/rmap.c:
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index f3162a5..bf38327 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1458,7 +1458,7 @@ static void page_check_dirty_writeback(struct page *page,
>  		mapping->a_ops->is_dirty_writeback(page, dirty, writeback);
>  }
>  
> -static struct page *alloc_demote_page(struct page *page, unsigned long node)
> +struct page *alloc_demote_page(struct page *page, unsigned long node)
>  {
>  	struct migration_target_control mtc = {
>  		/*
> -- 
> 1.8.3.1
