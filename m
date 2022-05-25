Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1166533889
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233980AbiEYIeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiEYIeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:34:04 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD3CDF17
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:34:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 560D31F905;
        Wed, 25 May 2022 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653467641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaH39BgdZFLv03clfSyy/OuxxUwtGCud54HsOpFPD38=;
        b=k1xMH+7P2x++1wYvAHFCl1iClP7lpj84s0LJFpEgtNS5J8k2qdvgxABOXT7KZbruELQTYX
        o4KTlhZ7BXqMtwlGHBsvo/78UwFN5q9HN35MVcZNH7C62omzD0DVJsL++3+k/6qGUM4yhb
        Nbwa3eKArznbAu0YcixnH68fnhHA0Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653467641;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xaH39BgdZFLv03clfSyy/OuxxUwtGCud54HsOpFPD38=;
        b=AzSI7r8359ObglOZswaTCnqhc2MqekTcRDN57+fVKQ8jFDwziM85Uym/W6+s8zIJtnsHDm
        Z5YX8yPpW67RNRBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 24D6A13ADF;
        Wed, 25 May 2022 08:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id f83LBPjpjWKoOAAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 25 May 2022 08:34:00 +0000
Date:   Wed, 25 May 2022 10:33:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, peterx@redhat.com, apopple@nvidia.com,
        ying.huang@intel.com, david@redhat.com, songmuchun@bytedance.com,
        hch@lst.de, dhowells@redhat.com, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] mm/migration: remove unneeded lock page and
 PageMovable check
Message-ID: <Yo3p9qhDWmcoJXV6@localhost.localdomain>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
 <20220525081822.53547-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525081822.53547-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:18:20PM +0800, Miaohe Lin wrote:
> When non-lru movable page was freed from under us, __ClearPageMovable must
> have been done.  So we can remove unneeded lock page and PageMovable check
> here. Also free_pages_prepare() will clear PG_isolated for us, so we can
> further remove ClearPageIsolated as suggested by David.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/migrate.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e88ebb88fa6f..337336115e43 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1090,15 +1090,10 @@ static int unmap_and_move(new_page_t get_new_page,
>  		return -ENOSYS;
>  
>  	if (page_count(page) == 1) {
> -		/* page was freed from under us. So we are done. */
> +		/* Page was freed from under us. So we are done. */
>  		ClearPageActive(page);
>  		ClearPageUnevictable(page);
> -		if (unlikely(__PageMovable(page))) {
> -			lock_page(page);
> -			if (!PageMovable(page))
> -				ClearPageIsolated(page);
> -			unlock_page(page);
> -		}
> +		/* free_pages_prepare() will clear PG_isolated. */
>  		goto out;
>  	}
>  
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
