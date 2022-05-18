Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2830A52B541
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiERIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbiERIrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:47:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400201339FC
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:47:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 85EE71F9AC;
        Wed, 18 May 2022 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1652863626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlPkdgn8or7cOD0dFZAp9xWwMym0uxOvLKSBp6Vy4SY=;
        b=JWjY8wypHUQjmwOfc3uhxtY8Kaxzz5tmnZFvjQuREInRLCmnp+G6VSGeIFZcevjkw1rptv
        JdiZHLM8BlEEZrXEm7PyEzBNla7TLogbnkrXECeo7NtAkYiTg9A9wRB0Uu/N8zD08nEhuc
        zCGLDnUPfRsQyvOvbJGrSUT8JRrxZdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1652863626;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FlPkdgn8or7cOD0dFZAp9xWwMym0uxOvLKSBp6Vy4SY=;
        b=na6pnh0W5X/r+JL2Dk8w6pClreKVv6/8TAhnoyFN90NO9b8/0doTEzPvbc6QVb54Sxacgm
        ViG9vspk5VpjVPAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90CB213A6D;
        Wed, 18 May 2022 08:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id /kxMIIeyhGKNdQAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 18 May 2022 08:47:03 +0000
Date:   Wed, 18 May 2022 10:46:58 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, vbabka@suse.cz,
        dhowells@redhat.com, neilb@suse.de, apopple@nvidia.com,
        david@redhat.com, surenb@google.com, peterx@redhat.com,
        naoya.horiguchi@nec.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/15] mm/swap: use helper macro __ATTR_RW
Message-ID: <YoSxfiUm4X+ktuhy@localhost.localdomain>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
 <20220509131416.17553-3-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509131416.17553-3-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2022 at 09:14:03PM +0800, Miaohe Lin wrote:
> Use helper macro __ATTR_RW to define vma_ra_enabled_attr to make code more
> clear. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/swap_state.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 240b39ed5922..9f99d8137ffd 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -881,9 +881,7 @@ static ssize_t vma_ra_enabled_store(struct kobject *kobj,
>  
>  	return count;
>  }
> -static struct kobj_attribute vma_ra_enabled_attr =
> -	__ATTR(vma_ra_enabled, 0644, vma_ra_enabled_show,
> -	       vma_ra_enabled_store);
> +static struct kobj_attribute vma_ra_enabled_attr = __ATTR_RW(vma_ra_enabled);
>  
>  static struct attribute *swap_attrs[] = {
>  	&vma_ra_enabled_attr.attr,
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
