Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D61A573BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbiGMRYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiGMRYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:24:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B48222B5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D5861CFA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 17:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061BEC34114;
        Wed, 13 Jul 2022 17:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657733039;
        bh=Ebkngg9p9IxQV+7npBekiepQ4m1KU1CM0m96Unovhqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ATqSlFhJmedu3hQ5GXXO+Ayc+NQhyjkTRrgWmFvc5QqqIzAOWBprNeIvJ4SxUlU9J
         11+UWBof/0fhLFWhae+tFrL/FDDRqS+cSujTuABKJZOpC1IO3kDWHakMjZkuDNWSWz
         BSth/7okSjDgcCRJc8dth0NJZC1cfExEnRzJwhL8=
Date:   Wed, 13 Jul 2022 10:23:57 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-Id: <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
In-Reply-To: <20220712130542.18836-1-linmiaohe@huawei.com>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 21:05:42 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> In MCOPY_ATOMIC_CONTINUE case with a non-shared VMA, pages in the page
> cache are installed in the ptes. But hugepage_add_new_anon_rmap is called
> for them mistakenly because they're not vm_shared. This will corrupt the
> page->mapping used by page cache code.

Well that sounds bad.  And theories on why this has gone unnoticed for
over a year?  I assume this doesn't have coverage in our selftests?

> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6038,7 +6038,7 @@ int hugetlb_mcopy_atomic_pte(struct mm_struct *dst_mm,
>  	if (!huge_pte_none_mostly(huge_ptep_get(dst_pte)))
>  		goto out_release_unlock;
>  
> -	if (vm_shared) {
> +	if (page_in_pagecache) {
>  		page_dup_file_rmap(page, true);
>  	} else {
>  		ClearHPageRestoreReserve(page);
> -- 
> 2.23.0
