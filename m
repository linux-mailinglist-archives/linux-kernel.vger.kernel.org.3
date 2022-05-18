Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CAB52B550
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbiERI5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiERI5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:57:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B242ADD
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:56:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D7D0021BC3;
        Wed, 18 May 2022 08:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652864210; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=criOZiMFw6OxUa9n7KuC0jcpPnGIpjQereGBGjQYi1Y=;
        b=Gf8+7UBNs9qJ1vft7M7F13PU7NMuIk1XlFshtcGo2jCoAZvwClz8KH/EoLer1KASBcMGG+
        vKgEQ6r1af6XuFpTU3qqFWSz33Bsbs+2VeyvIjyPFvSTrO82ssmyT18amhstMatldhB8vv
        9gTqprIboLSFmYIksLGiUkx6us3ITBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652864210;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=criOZiMFw6OxUa9n7KuC0jcpPnGIpjQereGBGjQYi1Y=;
        b=THrHaklwYq15wL9i34o83RidmGlLFjvReNxdjH9HtU42clbjZOPdAl8lsR9M8x6CLjXjEd
        bYjBNVdaUzgR1FAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D8413A6D;
        Wed, 18 May 2022 08:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GHanONG0hGIwegAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 08:56:49 +0000
Date:   Wed, 18 May 2022 10:56:48 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] mm/swap: fold __swap_info_get() into its sole
 caller
Message-ID: <YoSzrEOuQFnElkLW@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-4-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-4-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:04PM +0800, Miaohe Lin wrote:
> Fold __swap_info_get() into its sole caller to make code more clear.
> Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swapfile.c | 24 ++++++------------------
>  1 file changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 05ca79e68d63..0aee6286d6a7 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1123,7 +1123,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
>  	return n_ret;
>  }
>  
> -static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
> +static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
>  {
>  	struct swap_info_struct *p;
>  	unsigned long offset;
> @@ -1138,8 +1138,13 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
>  	offset = swp_offset(entry);
>  	if (offset >= p->max)
>  		goto bad_offset;
> +	if (data_race(!p->swap_map[swp_offset(entry)]))
> +		goto bad_free;
>  	return p;
>  
> +bad_free:
> +	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
> +	goto out;
>  bad_offset:
>  	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>  	goto out;
> @@ -1152,23 +1157,6 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
>  	return NULL;
>  }
>  
> -static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
> -{
> -	struct swap_info_struct *p;
> -
> -	p = __swap_info_get(entry);
> -	if (!p)
> -		goto out;
> -	if (data_race(!p->swap_map[swp_offset(entry)]))
> -		goto bad_free;
> -	return p;
> -
> -bad_free:
> -	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
> -out:
> -	return NULL;
> -}
> -
>  static struct swap_info_struct *swap_info_get_cont(swp_entry_t entry,
>  					struct swap_info_struct *q)
>  {
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
