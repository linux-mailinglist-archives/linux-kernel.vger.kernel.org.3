Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07464CEF17
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 02:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbiCGBWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 20:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbiCGBWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 20:22:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA795D1BF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 17:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C39461073
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 01:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F295BC340EC;
        Mon,  7 Mar 2022 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1646616082;
        bh=h83Y33RF7oFYfMTjMpePiE2v5flGLBtPS3zZbf52cOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NWQJGLCKb+iiOovlBpY9pafpCo06Ang51RY1NmaoMBmkPNgSpYpRIh/VPU02fadYd
         82ZDQDSX8ltQ9XqWZQ8px4dJLXRyeeyb+N61P0Pnc4tg64GSaZvUDUZwBh3WL8ji49
         y/h7H9b0WFCwWGiS6qvvxSIQXkOy9oLlCuAn4HiE=
Date:   Sun, 6 Mar 2022 17:21:21 -0800
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
Subject: Re: [PATCH 10/16] mm/migration: remove PG_writeback handle in
 folio_migrate_flags
Message-Id: <20220306172121.50d00e8b328a6bd1dea91ee7@linux-foundation.org>
In-Reply-To: <20220304093409.25829-11-linmiaohe@huawei.com>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-11-linmiaohe@huawei.com>
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

On Fri, 4 Mar 2022 17:34:03 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> When newfolio reaches here, it's guaranteed that PG_writeback is not set
> because caller ensures writeback must have been completed. Remove this
> unneeded check and cleanup the relevant comment.

What guarantees that writeback cannot start after the caller has checked?

I see no such check in iomap_migrate_page()?

> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -549,18 +549,6 @@ void folio_migrate_flags(struct folio *newfolio, struct folio *folio)
>  	if (!folio_test_hugetlb(folio))
>  		folio->private = NULL;
>  
> -	/*
> -	 * If any waiters have accumulated on the new page then
> -	 * wake them up.
> -	 */
> -	if (folio_test_writeback(newfolio))
> -		folio_end_writeback(newfolio);
> -
> -	/*
> -	 * PG_readahead shares the same bit with PG_reclaim.  The above
> -	 * end_page_writeback() may clear PG_readahead mistakenly, so set the
> -	 * bit after that.
> -	 */
>  	if (folio_test_readahead(folio))
>  		folio_set_readahead(newfolio);
>  

folio_migrate_flags() and folio_migrate_copy() are global,
export-to-modules functions but have no interface documentation.  That
was bad of us.  

I wonder why those two functions are exported to modules anyway.
