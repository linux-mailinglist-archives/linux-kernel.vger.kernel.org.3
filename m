Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4207252B782
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 12:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbiERJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234510AbiERJkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 05:40:39 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2719E14C76F
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 02:40:22 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A52901F9CF;
        Wed, 18 May 2022 09:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652866820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucsE3uapS7p1v2bugMuKZHGZtzp/VYWSq/V2Tc8LP0Q=;
        b=WjjzZgjv8srVBVMDw/LIsVX2F5t8kzQIJOWwqw+ZKKzgLUUdnJ0FA1FCXdWLqR9T9H7amR
        q1Al3cteALQzsgYD7Z3g2mpNzslcQJZa/TKEQprWwc8YuXtlhPOa4zv1ao+i5QL7PGlgR4
        slgfspmMZVmDESzu/TT8YyLfvTRT838=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652866820;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucsE3uapS7p1v2bugMuKZHGZtzp/VYWSq/V2Tc8LP0Q=;
        b=NKSX849TV7BCsr2i0xjBkAnMqcR8PxpsNIq87IWcf9GC8AO2f02u3FPJrv3QMGFKLWDmKw
        ayzJM8aZ8x1rCSAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41D78133F5;
        Wed, 18 May 2022 09:40:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id xN7yDAO/hGLnEwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 09:40:19 +0000
Date:   Wed, 18 May 2022 11:40:16 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/15] mm/swap: remove unneeded p != NULL check in
 __swap_duplicate
Message-ID: <YoS/APyetXRpPqnf@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-8-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-8-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:08PM +0800, Miaohe Lin wrote:
> If p is NULL, __swap_duplicate will already return -EINVAL. So if we
> reach here, p must be non-NULL.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swapfile.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d4b81ca887c0..7b4c99ca2aea 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3336,8 +3336,7 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
>  
>  unlock_out:
>  	unlock_cluster_or_swap_info(p, ci);
> -	if (p)
> -		put_swap_device(p);
> +	put_swap_device(p);
>  	return err;
>  }
>  
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
