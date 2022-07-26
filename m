Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915E558111F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238521AbiGZKZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiGZKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:25:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A852655F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:25:47 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 765881FB6F;
        Tue, 26 Jul 2022 10:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658831146; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTjslqHC2m5bjtlcrxgFzfyWtGUdFSOkhfUlim1OkZo=;
        b=10C2b64q8sQX5uZ0fiiNqkYAyzg7kEANHN2lPQgcfB73OTDwVgV6AWFUT7OocY0ZkjTwnp
        2uRvWk1di0w0q4folY7PlD+c5KI2OateGxhlI5J3oLwzsR/QO1IpHMHjszj622HD3aOfwF
        eUfBSKKAAvbroDRcBBZ4yjZtZOyCpEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658831146;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dTjslqHC2m5bjtlcrxgFzfyWtGUdFSOkhfUlim1OkZo=;
        b=7tAGV9rsgznkHibpivxpiStEksga1YolBNQTnDk7UZwz0fLjlcIB57iRFv4HJlsyAcZf9Y
        Mr+Cbiyg8X99MZBQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6482C2C15D;
        Tue, 26 Jul 2022 10:25:46 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C616DA0664; Tue, 26 Jul 2022 12:25:42 +0200 (CEST)
Date:   Tue, 26 Jul 2022 12:25:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz, neilb@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] bdi: remove enum wb_congested_state
Message-ID: <20220726102542.fnf37ypbbhnudonj@quack3>
References: <20220719083349.87547-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719083349.87547-1-xiujianfeng@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19-07-22 16:33:49, Xiu Jianfeng wrote:
> enum wb_congested_state and the member 'congested' in bdi_writeback is
> useless since commit a88f2096d5a2 ("remove congestion tracking framework"),
> so remove it.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev-defs.h | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
> index e863c88df95f..ae12696ec492 100644
> --- a/include/linux/backing-dev-defs.h
> +++ b/include/linux/backing-dev-defs.h
> @@ -28,11 +28,6 @@ enum wb_state {
>  	WB_start_all,		/* nr_pages == 0 (all) work pending */
>  };
>  
> -enum wb_congested_state {
> -	WB_async_congested,	/* The async (write) queue is getting full */
> -	WB_sync_congested,	/* The sync queue is getting full */
> -};
> -
>  enum wb_stat_item {
>  	WB_RECLAIMABLE,
>  	WB_WRITEBACK,
> @@ -122,8 +117,6 @@ struct bdi_writeback {
>  	atomic_t writeback_inodes;	/* number of inodes under writeback */
>  	struct percpu_counter stat[NR_WB_STAT_ITEMS];
>  
> -	unsigned long congested;	/* WB_[a]sync_congested flags */
> -
>  	unsigned long bw_time_stamp;	/* last time write bw is updated */
>  	unsigned long dirtied_stamp;
>  	unsigned long written_stamp;	/* pages written at bw_time_stamp */
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
