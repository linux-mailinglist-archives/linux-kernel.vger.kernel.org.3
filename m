Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795752B767
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbiERJgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234414AbiERJgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:36:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA81A388
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:36:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 077F71FA46;
        Wed, 18 May 2022 09:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652866585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aius02DgTUuGeviB9+AqIcI4nipIhT22GK6S5UOA+yk=;
        b=IGWN2FNyGugiWSTqY0TKEiH0PjlVIrFtILuJWLkI3JZqqk7ZPr3Vmf9WJBhsxqpbckNsko
        5pkIhPqUPnXeuEm5TJJXDrMtkqj/lqtP/P2ovef0GT5Xhzi3JbnvXqopUSnK/Jo0IaKgmE
        rm46zXSPSKYeHZIIBSLyOYSppGu4MKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652866585;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aius02DgTUuGeviB9+AqIcI4nipIhT22GK6S5UOA+yk=;
        b=cfZ0vuRJZ3OqDPhUWukfWa1/F/xF37L3NLfwq2u+KS2bqFZejO7ddpruwkMwfgmnJz7iQn
        bj1Hg0tgfxCQHHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C60FC133F5;
        Wed, 18 May 2022 09:36:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rdr3Khe+hGJJEQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 09:36:23 +0000
Date:   Wed, 18 May 2022 11:36:21 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] mm/swap: print bad swap offset entry in
 get_swap_device
Message-ID: <YoS+FZMvUJcnhJhk@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-6-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-6-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:06PM +0800, Miaohe Lin wrote:
> If offset exceeds the si->max, print bad swap offset entry to help debug
> the unexpected case.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swapfile.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 0aee6286d6a7..d4b81ca887c0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1272,6 +1272,7 @@ struct swap_info_struct *get_swap_device(swp_entry_t entry)
>  out:
>  	return NULL;
>  put_out:
> +	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
>  	percpu_ref_put(&si->users);
>  	return NULL;
>  }
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
