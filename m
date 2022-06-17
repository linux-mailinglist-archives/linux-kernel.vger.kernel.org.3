Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6C554F5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382026AbiFQKo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236113AbiFQKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:44:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2936B649;
        Fri, 17 Jun 2022 03:44:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7CA631F86B;
        Fri, 17 Jun 2022 10:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655462692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61q2Dy+gZjuH4Bh0Xd2gu4uqaiCBzwX90MvJbzqaUOU=;
        b=KfxmhOgSgc2oQDKIMz6oIIAqpRyswGOkAWCzNgyVp9AbeV+0WT+7vija1JwYUmp9BCosX6
        hFI4tjQDgfKw8IdPpl2EErSllzYgxmWGzbyyVftU2CDjarm9cfgpMR81WSWKkR+l0+KHc4
        aq3TyyfWG7aUuU770QuMT6nLrwR7yWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655462692;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=61q2Dy+gZjuH4Bh0Xd2gu4uqaiCBzwX90MvJbzqaUOU=;
        b=UgbpnSTK0x8HK0BqJjnkWsv7lPyzpJHbc61J4zgxH2LmyaP4Br4Y9O8uK09VdOGKEQvwvU
        D38QdmekCR4nX9CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9D372C142;
        Fri, 17 Jun 2022 10:44:50 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E035AA0632; Fri, 17 Jun 2022 12:44:41 +0200 (CEST)
Date:   Fri, 17 Jun 2022 12:44:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Li Lingfeng <lilingfeng3@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-kernel@vger.kernel.org,
        jack@suse.cz, yi.zhang@huawei.com, yukuai3@huawei.com,
        libaokun2@huawei.com
Subject: Re: [PATCH -next] ext4: recover csum seed of tmp_inode after
 migrating to extents
Message-ID: <20220617104441.lfhuca6tflg2oxah@quack3.lan>
References: <20220617062515.2113438-1-lilingfeng3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617062515.2113438-1-lilingfeng3@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-06-22 14:25:15, Li Lingfeng wrote:
> When migrating to extents, the checksum seed of temporary inode
> need to be replaced by inode's, otherwise the inode checksums
> will be incorrect when swapping the inodes data.
> 
> However, the temporary inode can not match it's checksum to
> itself since it has lost it's own checksum seed.
> 
> mkfs.ext4 -F /dev/sdc
> mount /dev/sdc /mnt/sdc
> xfs_io -fc "pwrite 4k 4k" -c "fsync" /mnt/sdc/testfile
> chattr -e /mnt/sdc/testfile
> chattr +e /mnt/sdc/testfile
> umount /dev/sdc
> fsck -fn /dev/sdc
> 
> ========
> ...
> Pass 1: Checking inodes, blocks, and sizes
> Inode 13 passes checks, but checksum does not match inode.  Fix? no
> ...
> ========
> 
> The fix is simple, save the checksum seed of temporary inode, and
> recover it after migrating to extents.
> 
> Fixes: e81c9302a6c3 ("ext4: set csum seed in tmp inode while migrating to extents")
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>

Yeah, the migration code and checksums never quite worked together. That's
the reason why we'd decided to deprecate this code. But I guess this fix is
simple enough and improves things so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/migrate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
> index 49912814f3d8..04320715d61f 100644
> --- a/fs/ext4/migrate.c
> +++ b/fs/ext4/migrate.c
> @@ -417,7 +417,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	struct inode *tmp_inode = NULL;
>  	struct migrate_struct lb;
>  	unsigned long max_entries;
> -	__u32 goal;
> +	__u32 goal, tmp_csum_seed;
>  	uid_t owner[2];
>  
>  	/*
> @@ -465,6 +465,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	 * the migration.
>  	 */
>  	ei = EXT4_I(inode);
> +	tmp_csum_seed = EXT4_I(tmp_inode)->i_csum_seed;
>  	EXT4_I(tmp_inode)->i_csum_seed = ei->i_csum_seed;
>  	i_size_write(tmp_inode, i_size_read(inode));
>  	/*
> @@ -575,6 +576,7 @@ int ext4_ext_migrate(struct inode *inode)
>  	 * the inode is not visible to user space.
>  	 */
>  	tmp_inode->i_blocks = 0;
> +	EXT4_I(tmp_inode)->i_csum_seed = tmp_csum_seed;
>  
>  	/* Reset the extent details */
>  	ext4_ext_tree_init(handle, tmp_inode);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
