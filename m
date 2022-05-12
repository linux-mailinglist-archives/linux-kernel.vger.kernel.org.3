Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83255525882
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359551AbiELXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359534AbiELXjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:39:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5012E286FE7
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 16:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0EE8BB82BB9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DAEC34114;
        Thu, 12 May 2022 23:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652398743;
        bh=a3XDOUB9VZEdL/qmAz+db5Tw1Rvx5NWZ7c0BuRE+hCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gg1eeorwkof0x/0Hw7YyFEZpnqETBiwE7FCiOYkigQwowSQ/8oEusNpkCbwG1Vbtk
         lULYu4bYk6NL70MOvNMOYaKBbsIubBEGlf0JfIjQRJ2jJPVbe4eNRnvbByub5RtgCw
         dGGMiB5aTE/5ua3LEOdd/I6VgisrGIEA7GamCkk4=
Date:   Thu, 12 May 2022 16:39:02 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <shy828301@gmail.com>
Cc:     willy@infradead.org, songmuchun@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: pvmw: check possible huge PMD map by
 transhuge_vma_suitable()
Message-Id: <20220512163902.5e128f6dd5dd6e44afa53259@linux-foundation.org>
In-Reply-To: <20220512174551.81279-2-shy828301@gmail.com>
References: <20220512174551.81279-1-shy828301@gmail.com>
        <20220512174551.81279-2-shy828301@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:45:51 -0700 Yang Shi <shy828301@gmail.com> wrote:

> IIUC PVMW checks if the vma is possibly huge PMD mapped by
> transparent_hugepage_active() and "pvmw->nr_pages >= HPAGE_PMD_NR".
> 
> Actually pvmw->nr_pages is returned by compound_nr() or
> folio_nr_pages(), so the page should be THP as long as "pvmw->nr_pages
> >= HPAGE_PMD_NR".  And it is guaranteed THP is allocated for valid VMA
> in the first place.  But it may be not PMD mapped if the VMA is file
> VMA and it is not properly aligned.  The transhuge_vma_suitable()
> is used to do such check, so replace transparent_hugepage_active() to
> it, which is too heavy and overkilling.
> 
> ...
>
> --- a/mm/page_vma_mapped.c
> +++ b/mm/page_vma_mapped.c
> @@ -237,13 +237,14 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>  			spin_unlock(pvmw->ptl);
>  			pvmw->ptl = NULL;
>  		} else if (!pmd_present(pmde)) {
> +			unsigned long haddr = pvmw->address & HPAGE_PMD_MASK;

This hits

	#define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })

when CONFIG_TRANSPARENT_HUGEPAGE=n (x86_64 allnoconfig).

