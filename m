Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7F4E9002
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239289AbiC1IWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239268AbiC1IWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:22:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5775371A;
        Mon, 28 Mar 2022 01:20:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7221F1F37E;
        Mon, 28 Mar 2022 08:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648455640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wdWMli+ploY7Tbm8LOf/p2w8O/NqqHCNuCB1Aq96EE=;
        b=CzglI/ISsO+h5aC3Hr8632CF2Fp6FxIReWHhdmG24ZMlboCo7XB6ds4Qpao2QkGf0wutOL
        Ee5YqH3L5iO2Uf/JY1QXS73h59tMlBEfsPJ1KJsUrp+VWPeuPg88w52y+/JrKZq++cYesU
        o6WjqD0UYVf7ag7wthne3BCbgeXpNo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648455640;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6wdWMli+ploY7Tbm8LOf/p2w8O/NqqHCNuCB1Aq96EE=;
        b=gugwsrZvrDwoymYqqJKLXeXxgs3okqqQklju/cu1/lxSoNA8oMhvlVD7BIRb1IwZZ0wM8g
        r8pn5YPjzJv02/Cw==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 57E8BA3B9B;
        Mon, 28 Mar 2022 08:20:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14580A0610; Mon, 28 Mar 2022 10:20:40 +0200 (CEST)
Date:   Mon, 28 Mar 2022 10:20:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>,
        Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-block@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] block: Fix the maximum minor value is
 blk_alloc_ext_minor()
Message-ID: <20220328082040.h7pmagyaacttxhda@quack3.lan>
References: <cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc17199798312406b90834e433d2cefe8266823d.1648306232.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 26-03-22 15:50:46, Christophe JAILLET wrote:
> ida_alloc_range(..., min, max, ...) returns values from min to max,
> inclusive.
> 
> So, NR_EXT_DEVT is a valid idx returned by blk_alloc_ext_minor().
> 
> This is an issue because in device_add_disk(), this value is used in:
>    ddev->devt = MKDEV(disk->major, disk->first_minor);
> and NR_EXT_DEVT is '(1 << MINORBITS)'.
> 
> So, should 'disk->first_minor' be NR_EXT_DEVT, it would overflow.
> 
> Fixes: 22ae8ce8b892 ("block: simplify bdev/disk lookup in blkdev_get")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Indeed. The patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> ---
> #define MKDEV(ma,mi)	(((ma) << MINORBITS) | (mi))
> 
> This patch is completely speculative, but it seems that idr_alloc() and
> ida_alloc_range() don't have the same semantic regarding the upper bound.
> idr_alloc() looks exclusive, while ida_alloc_range() is inclusive.
> 
> We changed from the first one to the other one in the commit in Fixes:.

Yes, this difference is really a landmine. Matthew, why is the semantics of
max parameter for idr_alloc() different from ida_alloc_range() or say
idr_alloc_u32()? It is really easy to introduce subtle bugs with this...

								Honza

> ---
>  block/genhd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/genhd.c b/block/genhd.c
> index c9a4fc90d3e9..b8b6759d670f 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -335,7 +335,7 @@ int blk_alloc_ext_minor(void)
>  {
>  	int idx;
>  
> -	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT, GFP_KERNEL);
> +	idx = ida_alloc_range(&ext_devt_ida, 0, NR_EXT_DEVT - 1, GFP_KERNEL);
>  	if (idx == -ENOSPC)
>  		return -EBUSY;
>  	return idx;
> -- 
> 2.32.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
