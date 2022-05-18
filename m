Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594C52B511
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbiERIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiERIbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:31:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995064C7BF
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:31:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 524D21F9B0;
        Wed, 18 May 2022 08:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652862696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clHMZp1vlTxFjg2PbSC20KdrMGXGOqwY/UgJfCLMkCk=;
        b=oGeFYrFgtziEZt8WTwwCH2Q4fx8hjN4wHcvTldIY5BKjkC/eJbdIHi39fmrGWNZIDsUdKL
        sQ6MVSM1Nc5m27RLx77P57pqtVdkrxSnE3sg7ydRO6M2fz3dwBPQfzAgAidcssP9g+7mcb
        BLXm2yF4b+eq5bJbO15mBKhyMVTdA+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652862696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=clHMZp1vlTxFjg2PbSC20KdrMGXGOqwY/UgJfCLMkCk=;
        b=ailfFGbikuR24eepb4GmtM1ajAW3yj+5CmVd5bclqJ0iQRHeTV6xZ1Jdr2F/4BCH7tEvRy
        WGoM7VlTstnvX6Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 492EF13A6D;
        Wed, 18 May 2022 08:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2NJUDueuhGJwbQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 08:31:35 +0000
Date:   Wed, 18 May 2022 10:31:28 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/15] mm/swap: use helper is_swap_pte() in
 swap_vma_readahead
Message-ID: <YoSu4ClIm/suFAFH@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:02PM +0800, Miaohe Lin wrote:
> Use helper is_swap_pte() to check whether pte is swap entry to make code
> more clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swap_state.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 577c2848ae49..240b39ed5922 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -818,9 +818,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
>  	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
>  	     i++, pte++) {
>  		pentry = *pte;
> -		if (pte_none(pentry))
> -			continue;
> -		if (pte_present(pentry))
> +		if (!is_swap_pte(pentry))
>  			continue;
>  		entry = pte_to_swp_entry(pentry);
>  		if (unlikely(non_swap_entry(entry)))
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
