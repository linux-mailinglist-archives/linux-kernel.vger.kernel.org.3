Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C945338AF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbiEYImC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiEYIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:41:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE44CFD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:41:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E6A1219B9;
        Wed, 25 May 2022 08:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653468113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jePr5VZ+W+l9RSA8ra4ij2xbn2TevRksWLlauTlE47w=;
        b=HPIJ7TIVTH1Neu0j9iQY2qOxzjd3OLblvIm0qwqJJCng9cYlkniJdvDw38RBTXAWK5P+sm
        9qBU95jW/qHhTLKlbtwBh7pbkEyZFvU/3paAr2n7s09ovn0JnJJn2V9cDxc6uAiZ+cepfu
        JI6aUTBFEeS2ph8YoSdmxS8ygvxuWUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653468113;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jePr5VZ+W+l9RSA8ra4ij2xbn2TevRksWLlauTlE47w=;
        b=JSdQSz5MpNsONqrQkFkCm+KZ4w871BS4eF6IPX6up4upZ4OvZadxucsMQGdolrEIXPJLy5
        wIT2fY2src7pEmAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0208E13ADF;
        Wed, 25 May 2022 08:41:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4dZ5OM/rjWKRPAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 25 May 2022 08:41:51 +0000
Date:   Wed, 25 May 2022 10:41:47 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, peterx@redhat.com, apopple@nvidia.com,
        ying.huang@intel.com, david@redhat.com, songmuchun@bytedance.com,
        hch@lst.de, dhowells@redhat.com, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] mm/migration: return errno when isolate_huge_page
 failed
Message-ID: <Yo3ry9rRDa5jznHC@localhost.localdomain>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
 <20220525081822.53547-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525081822.53547-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:18:21PM +0800, Miaohe Lin wrote:
> We might fail to isolate huge page due to e.g. the page is under migration
> which cleared HPageMigratable. We should return errno in this case rather
> than always return 1 which could confuse the user, i.e. the caller might
> think all of the memory is migrated while the hugetlb page is left behind.
> We make the prototype of isolate_huge_page consistent with isolate_lru_page
> as suggested by Huang Ying and rename isolate_huge_page to isolate_hugetlb
> as suggested by Muchun to improve the readability.
> 
> Fixes: e8db67eb0ded ("mm: migrate: move_pages() supports thp migration")
> Suggested-by: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Looks good to me, one thing below though:

> ---
>  include/linux/hugetlb.h |  6 +++---
>  mm/gup.c                |  2 +-
>  mm/hugetlb.c            | 11 +++++------
>  mm/memory-failure.c     |  2 +-
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  5 +++--
>  6 files changed, 14 insertions(+), 14 deletions(-)
> 
...
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1627,8 +1627,9 @@ static int add_page_for_migration(struct mm_struct *mm, unsigned long addr,
>  
>  	if (PageHuge(page)) {
>  		if (PageHead(page)) {
> -			isolate_huge_page(page, pagelist);
> -			err = 1;
> +			err = isolate_hugetlb(page, pagelist);
> +			if (!err)
> +				err = 1;
>  		}

We used to always return 1 which means page has been queued for migration, as we
did not check isolate_huge_page() return value.
Now, we either return 1 or 0 depending on isolate_hugetlb(). 
I guess that was fine because in the end, if isolate_huge_page() failed,
the page just does not get added to 'pagelist', right? So, it is just
confusing for the user because he might not get an error so he thinks
the page will be migrated, and yet will not?


-- 
Oscar Salvador
SUSE Labs
