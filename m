Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA50570137
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiGKLws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiGKLwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:52:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1367123BE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:52:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B5926202F3;
        Mon, 11 Jul 2022 11:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657540355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdFY1RWwGYvBePPQsPedAbt4Dp/hBwt/0QCbIDf8xuw=;
        b=xSvia/5kjnsgiJTeS1+fnuBLnvUcBv36rtCfS7WIITz0oa/2oUbO7QBdPgDJHRbsnLAu23
        OSZjd7R4m+dDBcrCfboDKQHUGndAsgjHGUvh0Uu3f6p7D2TZmyrvUeDFXAyglK7odwySjF
        F6WQwSEPc6GZPis4SvofV6als9x5WYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657540355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdFY1RWwGYvBePPQsPedAbt4Dp/hBwt/0QCbIDf8xuw=;
        b=nadu+SnQgfvxOj2JXvvu2dsqQgtx7xswMcDR1BVYnm2uo/8CuykxWfZV2Uwk1sdX3uOYI8
        58A41V7jd8QdtaBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8B75413524;
        Mon, 11 Jul 2022 11:52:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8fjpIAMPzGK1fwAAMHmgww
        (envelope-from <osalvador@suse.de>); Mon, 11 Jul 2022 11:52:35 +0000
Date:   Mon, 11 Jul 2022 13:52:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V2 1/7] migrate: fix syscall move_pages() return value
 for failure
Message-ID: <YswPApwvAjvX1VEd@localhost.localdomain>
References: <20220711084948.274787-1-ying.huang@intel.com>
 <20220711084948.274787-2-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711084948.274787-2-ying.huang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 04:49:42PM +0800, Huang Ying wrote:
>  	return store_status(status, start, node, i - start);
> @@ -1768,8 +1768,12 @@ static int do_pages_move(struct mm_struct *mm, nodemask_t task_nodes,
>  
>  		err = move_pages_and_store_status(mm, current_node, &pagelist,
>  				status, start, i, nr_pages);
> -		if (err)
> +		if (err) {
> +			/* We have stored status of page i */

IMHO, "We have accounted for page i" gives a more clear statement.

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> +			if (err > 0)
> +				err--;
>  			goto out;
> +		}
>  		current_node = NUMA_NO_NODE;
>  	}
>  out_flush:
> -- 
> 2.30.2
> 
> 

-- 
Oscar Salvador
SUSE Labs
