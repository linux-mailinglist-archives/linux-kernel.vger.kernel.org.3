Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A027459984F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 11:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347734AbiHSJGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 05:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347388AbiHSJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 05:06:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C38FEE6AA;
        Fri, 19 Aug 2022 02:06:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CA5EB375E0;
        Fri, 19 Aug 2022 09:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660900001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1k6Pm+SvbBY62QEofoW7g6l7h0lzojfDX5HDxLdLHU=;
        b=lbnYwsbtyrnMuUNpFxFU0guvzqLFci8KCRCMsh2j01sk4m+ej0q+grl3ZeOCvCFXwTn5UQ
        bKLhpV2eGfMds8MA5uOQIU0RzVsgq5yn1DnKD7RqIVKEkwevg+o7vyBa6L7neYd9NL115u
        PcPMCcBtrP+mV6dyWNjENbzys/AlWzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660900001;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1k6Pm+SvbBY62QEofoW7g6l7h0lzojfDX5HDxLdLHU=;
        b=55ayS2WgkhIWYhOv3qj3RAq57e3GpsCPA/oxyJhMYoi/wal43reLcL/nPGDx+Remm/mjJy
        +1XNF3YryqEYqbAw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2EDED2C145;
        Fri, 19 Aug 2022 09:06:41 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 95DE9A0635; Fri, 19 Aug 2022 11:06:40 +0200 (CEST)
Date:   Fri, 19 Aug 2022 11:06:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     jack@suse.cz, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: Re: [PATCH] fs/reiserfs: replace ternary operator with min() and
 min_t()
Message-ID: <20220819090640.lhp5esp7mbcpu53i@quack3>
References: <20220819075240.3199477-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220819075240.3199477-1-13667453960@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 19-08-22 15:52:40, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> 
> Fix the following coccicheck warning:
> 
> fs/reiserfs/prints.c:459: WARNING opportunity for min().
> fs/reiserfs/resize.c:100: WARNING opportunity for min().
> fs/reiserfs/super.c:2508: WARNING opportunity for min().
> fs/reiserfs/super.c:2557: WARNING opportunity for min().
> 
> min() and min_t() macro is defined in include/linux/minmax.h.
> It avoids multiple evaluations of the arguments when non-constant and
> performs strict type-checking.
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>

Thanks for the cleanup. I've added the patch to my tree.

								Honza

> ---
>  fs/reiserfs/prints.c | 2 +-
>  fs/reiserfs/resize.c | 2 +-
>  fs/reiserfs/super.c  | 7 ++-----
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/reiserfs/prints.c b/fs/reiserfs/prints.c
> index 30319dc33c18..84a194b77f19 100644
> --- a/fs/reiserfs/prints.c
> +++ b/fs/reiserfs/prints.c
> @@ -456,7 +456,7 @@ static int print_internal(struct buffer_head *bh, int first, int last)
>  		to = B_NR_ITEMS(bh);
>  	} else {
>  		from = first;
> -		to = last < B_NR_ITEMS(bh) ? last : B_NR_ITEMS(bh);
> +		to = min_t(int, last, B_NR_ITEMS(bh));
>  	}
>  
>  	reiserfs_printk("INTERNAL NODE (%ld) contains %z\n", bh->b_blocknr, bh);
> diff --git a/fs/reiserfs/resize.c b/fs/reiserfs/resize.c
> index 8096c74c38ac..7b498a0d060b 100644
> --- a/fs/reiserfs/resize.c
> +++ b/fs/reiserfs/resize.c
> @@ -97,7 +97,7 @@ int reiserfs_resize(struct super_block *s, unsigned long block_count_new)
>  		 * using the copy_size var below allows this code to work for
>  		 * both shrinking and expanding the FS.
>  		 */
> -		copy_size = bmap_nr_new < bmap_nr ? bmap_nr_new : bmap_nr;
> +		copy_size = min(bmap_nr_new, bmap_nr);
>  		copy_size =
>  		    copy_size * sizeof(struct reiserfs_list_bitmap_node *);
>  		for (i = 0; i < JOURNAL_NUM_BITMAPS; i++) {
> diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
> index c88cd2ce0665..da1e72494e30 100644
> --- a/fs/reiserfs/super.c
> +++ b/fs/reiserfs/super.c
> @@ -2504,9 +2504,7 @@ static ssize_t reiserfs_quota_read(struct super_block *sb, int type, char *data,
>  		len = i_size - off;
>  	toread = len;
>  	while (toread > 0) {
> -		tocopy =
> -		    sb->s_blocksize - offset <
> -		    toread ? sb->s_blocksize - offset : toread;
> +		tocopy = min_t(unsigned long, sb->s_blocksize - offset, toread);
>  		tmp_bh.b_state = 0;
>  		/*
>  		 * Quota files are without tails so we can safely
> @@ -2554,8 +2552,7 @@ static ssize_t reiserfs_quota_write(struct super_block *sb, int type,
>  		return -EIO;
>  	}
>  	while (towrite > 0) {
> -		tocopy = sb->s_blocksize - offset < towrite ?
> -		    sb->s_blocksize - offset : towrite;
> +		tocopy = min_t(unsigned long, sb->s_blocksize - offset, towrite);
>  		tmp_bh.b_state = 0;
>  		reiserfs_write_lock(sb);
>  		err = reiserfs_get_block(inode, blk, &tmp_bh, GET_BLOCK_CREATE);
> -- 
> 2.25.1
> 
> 
> No virus found
> 		Checked by Hillstone Network AntiVirus
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
