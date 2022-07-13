Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3E457384B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235453AbiGMODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiGMODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:03:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7742DFBF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:03:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 842EE1F951;
        Wed, 13 Jul 2022 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657721021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8wwNCdeR6ZXQHhQGSd5zJ5tYLZ2OOnr0dfjRRY1LEs=;
        b=0FC0jmRius9362YJzh1gXAhUmjpZtoiTKsBtuX2OGtfV2lH6Dnl0lgnhwMjHm7gCcdl02b
        sJxV5O/VantbHN4da5VnopOPwFEsPz/5jjI4qYfMRYYyLgxjQ2GbzABDl2AJrEIzhLu7sg
        b2CzFMOoc3evLmUgslB7AVm5o5bD1Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657721021;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8wwNCdeR6ZXQHhQGSd5zJ5tYLZ2OOnr0dfjRRY1LEs=;
        b=103g3t0RrGBEmnoGXpv89O8m/ruVLbMRF4n90BYXUbxnGo5Mc2UQOyAtgvc2tzFXoDlcgI
        Eqz5eKocgY3JevAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2339E2C141;
        Wed, 13 Jul 2022 14:03:40 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9BA3DA0635; Wed, 13 Jul 2022 16:03:08 +0200 (CEST)
Date:   Wed, 13 Jul 2022 16:03:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     akpm@linux-foundation.org, axboe@kernel.dk, neilb@suse.de,
        johannes.thumshirn@wdc.com, jack@suse.cz, willy@infradead.org,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] writeback: Cleanup bdi_sched_wait()
Message-ID: <20220713140308.5je2p3zz4vm4fvjb@quack3>
References: <20220713125314.171345-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220713125314.171345-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 13-07-22 20:53:14, Xiu Jianfeng wrote:
> bdi_sched_wait() is no longer used since commit 839a8e8660b6 ("writeback:
> replace custom worker pool implementation with unbound workqueue"),
> so remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index d452071db572..e84b745a6811 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -140,12 +140,6 @@ static inline bool mapping_can_writeback(struct address_space *mapping)
>  	return inode_to_bdi(mapping->host)->capabilities & BDI_CAP_WRITEBACK;
>  }
>  
> -static inline int bdi_sched_wait(void *word)
> -{
> -	schedule();
> -	return 0;
> -}
> -
>  #ifdef CONFIG_CGROUP_WRITEBACK
>  
>  struct bdi_writeback *wb_get_lookup(struct backing_dev_info *bdi,
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
