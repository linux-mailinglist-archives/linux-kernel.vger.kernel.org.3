Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87186574A30
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238149AbiGNKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbiGNKMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:12:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21DE501B6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:12:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2DAD1FADB;
        Thu, 14 Jul 2022 10:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657793529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VX//aeJx0d8DjNGTlh0QNBOe0MYsqoOxy69wWtb3e9M=;
        b=d1TbqnONavoXAV+tHuJNtc4e7AI+JKCEkI2hF/0mzli5mKraIa/wpohStZnb7M+Tkvw1W9
        RC8WaE/xoaqGxqGayGOr57l5qi55grod/Winys8Tt3j/ijbZfu5JPZOJwXmFtdnVGs3TPJ
        L2yyYkdoW9y8wZaG2McxKDABGjSZsgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657793529;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VX//aeJx0d8DjNGTlh0QNBOe0MYsqoOxy69wWtb3e9M=;
        b=ltZ5WX5tJrK4p15RQJaZKV+igpq6QBDp8kR/Yniy5+VRxSGC+1nmf6z5qVdemgr4WzRh5r
        ZFbwEHTIkqyEmTAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFC3A2C143;
        Thu, 14 Jul 2022 10:12:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5A116A05FB; Thu, 14 Jul 2022 12:12:07 +0200 (CEST)
Date:   Thu, 14 Jul 2022 12:12:07 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, neilb@suse.de,
        johannes.thumshirn@wdc.com, jack@suse.cz, willy@infradead.org,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] writeback: Cleanup inode_to_wb_is_valid()
Message-ID: <20220714101207.5qh3bfvadqrorerp@quack3>
References: <20220714084147.140324-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714084147.140324-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-07-22 16:41:47, Xiu Jianfeng wrote:
> inode_to_wb_is_valid() is no longer used since commit fe55d563d417
> ("remove inode_congested()"), remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev.h | 17 -----------------
>  1 file changed, 17 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index d452071db572..f9f14e385582 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -235,18 +235,6 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
>  	return wb;
>  }
>  
> -/**
> - * inode_to_wb_is_valid - test whether an inode has a wb associated
> - * @inode: inode of interest
> - *
> - * Returns %true if @inode has a wb associated.  May be called without any
> - * locking.
> - */
> -static inline bool inode_to_wb_is_valid(struct inode *inode)
> -{
> -	return inode->i_wb;
> -}
> -
>  /**
>   * inode_to_wb - determine the wb of an inode
>   * @inode: inode of interest
> @@ -345,11 +333,6 @@ wb_get_create_current(struct backing_dev_info *bdi, gfp_t gfp)
>  	return &bdi->wb;
>  }
>  
> -static inline bool inode_to_wb_is_valid(struct inode *inode)
> -{
> -	return true;
> -}
> -
>  static inline struct bdi_writeback *inode_to_wb(struct inode *inode)
>  {
>  	return &inode_to_bdi(inode)->wb;
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
