Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3D4CEF12
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:14:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiCGBPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiCGBO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:14:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29775A14D
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:14:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F300B80DF0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A66EC340EC;
        Mon,  7 Mar 2022 01:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646615642;
        bh=QyKxDogWlz/SuyW7MhbFirrHKLiSDLFcXuuEZeWILJk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J8JpYYKq28vY5bwKo94x/S8nl6X0grr5MZgqOP8y8gdVhR7Q4/JKIsxdLjv0Jfin2
         wDpyFHZOmXQZ5SDM7wq9846/YZ2Zx3hpj3hTX85mi9DHNHLwDtWrujPQl0RS0GIhEc
         ejjnW7EUn0nMN1PMSJDMGaaHzdbVs9GVfaGrjeWY=
Date:   Sun, 6 Mar 2022 17:14:00 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <mike.kravetz@oracle.com>, <shy828301@gmail.com>,
        <willy@infradead.org>, <ying.huang@intel.com>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/16] mm/migration: use helper macro min_t in
 do_pages_stat
Message-Id: <20220306171400.a5cbab665b6338391447e541@linux-foundation.org>
In-Reply-To: <20220304093409.25829-8-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-8-linmiaohe@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Fri, 4 Mar 2022 17:34:00 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> We could use helper macro min_t to help set the chunk_nr to simplify
> the code.
> 
> ...
>
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1858,9 +1858,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
>  	while (nr_pages) {
>  		unsigned long chunk_nr;
>  
> -		chunk_nr = nr_pages;
> -		if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
> -			chunk_nr = DO_PAGES_STAT_CHUNK_NR;
> +		chunk_nr = min_t(unsigned long, nr_pages, DO_PAGES_STAT_CHUNK_NR);
>  
>  		if (in_compat_syscall()) {
>  			if (get_compat_pages_array(chunk_pages, pages,

Getting the types correct is better than using min_t().

--- a/mm/migrate.c~mm-migration-use-helper-macro-min_t-in-do_pages_stat-fix
+++ a/mm/migrate.c
@@ -1844,14 +1844,12 @@ static int do_pages_stat(struct mm_struc
 			 const void __user * __user *pages,
 			 int __user *status)
 {
-#define DO_PAGES_STAT_CHUNK_NR 16
+#define DO_PAGES_STAT_CHUNK_NR 16UL
 	const void __user *chunk_pages[DO_PAGES_STAT_CHUNK_NR];
 	int chunk_status[DO_PAGES_STAT_CHUNK_NR];
 
 	while (nr_pages) {
-		unsigned long chunk_nr;
-
-		chunk_nr = min_t(unsigned long, nr_pages, DO_PAGES_STAT_CHUNK_NR);
+		unsigned long chunk_nr = min(nr_pages, DO_PAGES_STAT_CHUNK_NR);
 
 		if (in_compat_syscall()) {
 			if (get_compat_pages_array(chunk_pages, pages,
_

