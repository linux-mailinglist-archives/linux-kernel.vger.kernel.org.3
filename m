Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7E35046DF
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 08:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233518AbiDQGof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbiDQGod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 02:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085681839F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 23:41:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A14D6114C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:41:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6F1C385A7;
        Sun, 17 Apr 2022 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650177717;
        bh=mYmF9fQB39PB7wD2m8YVDgKopxt1nEx/PGkPkAA44DM=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=MkcMF+JDLeCM/KSUIJThnRk4twIjI24+ffYlgu9RwlCuRjcNUImasCaDQVd+2deIM
         igjTUSkZKpbBKV8U+bSv8YhJppBS9Nx0Y1EqW5xS04YOg2pwT8jXVwvIyBl06qthAF
         hzx/+wa6AqeIEMpIIfI2LniPPvdxn4JB0we3TXe1rsyYloV/R4Jc8AxxVgBtpR+9ae
         AwZvANFSpdvEpN5pxDPGikti3p3ZGK6GSYLH+k3N38pHBVSRBbSFkhQ60Uv7Zgsy6f
         BVqsvdp5YN9QxdgyBLL6Ho16k9xvMvRrJcPiAwc0pHmpHLjW0/UYR64ExbKN9cK2tg
         UY/Qjzvz6vzzw==
Message-ID: <d6d5f865-a7da-cd4c-1390-a22374f387c7@kernel.org>
Date:   Sun, 17 Apr 2022 14:41:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs: avoid infinite loop to flush node
 pages
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220411212141.1775589-1-jaegeuk@kernel.org>
 <20220411212141.1775589-2-jaegeuk@kernel.org> <Ylif523qTzL9eq1C@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <Ylif523qTzL9eq1C@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 6:27, Jaegeuk Kim wrote:
> xfstests/generic/475 can give EIO all the time which give an infinite loop
> to flush node page like below. Let's avoid it.
> 
> [16418.518551] Call Trace:
> [16418.518553]  ? dm_submit_bio+0x48/0x400
> [16418.518574]  ? submit_bio_checks+0x1ac/0x5a0
> [16418.525207]  __submit_bio+0x1a9/0x230
> [16418.525210]  ? kmem_cache_alloc+0x29e/0x3c0
> [16418.525223]  submit_bio_noacct+0xa8/0x2b0
> [16418.525226]  submit_bio+0x4d/0x130
> [16418.525238]  __submit_bio+0x49/0x310 [f2fs]
> [16418.525339]  ? bio_add_page+0x6a/0x90
> [16418.525344]  f2fs_submit_page_bio+0x134/0x1f0 [f2fs]
> [16418.525365]  read_node_page+0x125/0x1b0 [f2fs]
> [16418.525388]  __get_node_page.part.0+0x58/0x3f0 [f2fs]
> [16418.525409]  __get_node_page+0x2f/0x60 [f2fs]
> [16418.525431]  f2fs_get_dnode_of_data+0x423/0x860 [f2fs]
> [16418.525452]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [16418.525458]  ? __mod_memcg_state.part.0+0x2a/0x30
> [16418.525465]  ? __mod_memcg_lruvec_state+0x27/0x40
> [16418.525467]  ? __xa_set_mark+0x57/0x70
> [16418.525472]  f2fs_do_write_data_page+0x10e/0x7b0 [f2fs]
> [16418.525493]  f2fs_write_single_data_page+0x555/0x830 [f2fs]
> [16418.525514]  ? sysvec_apic_timer_interrupt+0x4e/0x90
> [16418.525518]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [16418.525523]  f2fs_write_cache_pages+0x303/0x880 [f2fs]
> [16418.525545]  ? blk_flush_plug_list+0x47/0x100
> [16418.525548]  f2fs_write_data_pages+0xfd/0x320 [f2fs]
> [16418.525569]  do_writepages+0xd5/0x210
> [16418.525648]  filemap_fdatawrite_wbc+0x7d/0xc0
> [16418.525655]  filemap_fdatawrite+0x50/0x70
> [16418.525658]  f2fs_sync_dirty_inodes+0xa4/0x230 [f2fs]
> [16418.525679]  f2fs_write_checkpoint+0x16d/0x1720 [f2fs]
> [16418.525699]  ? ttwu_do_wakeup+0x1c/0x160
> [16418.525709]  ? ttwu_do_activate+0x6d/0xd0
> [16418.525711]  ? __wait_for_common+0x11d/0x150
> [16418.525715]  kill_f2fs_super+0xca/0x100 [f2fs]
> [16418.525733]  deactivate_locked_super+0x3b/0xb0
> [16418.525739]  deactivate_super+0x40/0x50
> [16418.525741]  cleanup_mnt+0x139/0x190
> [16418.525747]  __cleanup_mnt+0x12/0x20
> [16418.525749]  task_work_run+0x6d/0xa0
> [16418.525765]  exit_to_user_mode_prepare+0x1ad/0x1b0
> [16418.525771]  syscall_exit_to_user_mode+0x27/0x50
> [16418.525774]  do_syscall_64+0x48/0xc0
> [16418.525776]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
> 
> Change log from v1:
>   - cover one more error case
> 
>   fs/f2fs/checkpoint.c |  8 +-------
>   fs/f2fs/f2fs.h       | 20 ++++++++++++++++----
>   fs/f2fs/node.c       |  2 ++
>   3 files changed, 19 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 909085a78f9c..319903c2b34f 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -98,13 +98,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
>   	}
>   
>   	if (unlikely(!PageUptodate(page))) {
> -		if (page->index == sbi->metapage_eio_ofs) {
> -			if (sbi->metapage_eio_cnt++ == MAX_RETRY_META_PAGE_EIO)
> -				set_ckpt_flags(sbi, CP_ERROR_FLAG);
> -		} else {
> -			sbi->metapage_eio_ofs = page->index;
> -			sbi->metapage_eio_cnt = 0;
> -		}
> +		f2fs_handle_page_eio(sbi, page->index, META);
>   		f2fs_put_page(page, 1);
>   		return ERR_PTR(-EIO);
>   	}
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index cd1e65bcf0b0..977826a22568 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -579,8 +579,8 @@ enum {
>   /* maximum retry quota flush count */
>   #define DEFAULT_RETRY_QUOTA_FLUSH_COUNT		8
>   
> -/* maximum retry of EIO'ed meta page */
> -#define MAX_RETRY_META_PAGE_EIO			100
> +/* maximum retry of EIO'ed page */
> +#define MAX_RETRY_PAGE_EIO			100
>   
>   #define F2FS_LINK_MAX	0xffffffff	/* maximum link count per file */
>   
> @@ -1621,8 +1621,8 @@ struct f2fs_sb_info {
>   	/* keep migration IO order for LFS mode */
>   	struct f2fs_rwsem io_order_lock;
>   	mempool_t *write_io_dummy;		/* Dummy pages */
> -	pgoff_t metapage_eio_ofs;		/* EIO page offset */
> -	int metapage_eio_cnt;			/* EIO count */
> +	pgoff_t page_eio_ofs[NR_PAGE_TYPE];	/* EIO page offset */
> +	int page_eio_cnt[NR_PAGE_TYPE];		/* EIO count */
>   
>   	/* for checkpoint */
>   	struct f2fs_checkpoint *ckpt;		/* raw checkpoint pointer */
> @@ -4543,6 +4543,18 @@ static inline void f2fs_io_schedule_timeout(long timeout)
>   	io_schedule_timeout(timeout);
>   }
>   
> +static inline void f2fs_handle_page_eio(struct f2fs_sb_info *sbi, pgoff_t ofs,
> +					enum page_type type)
> +{

If we have already set cp_error, it doesn't need to process below logic
redundantly?

if (f2fs_cp_error())
	return;

> +	if (ofs == sbi->page_eio_ofs[type]) {
> +		if (sbi->page_eio_cnt[type]++ == MAX_RETRY_PAGE_EIO)
> +			set_ckpt_flags(sbi, CP_ERROR_FLAG);
> +	} else {
> +		sbi->page_eio_ofs[type] = ofs;
> +		sbi->page_eio_cnt[type] = 0;
> +	}
> +}
> +
>   #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
>   #define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
>   
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index c45d341dcf6e..c280f482c741 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1416,6 +1416,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>   
>   	err = read_node_page(page, 0);
>   	if (err < 0) {
> +		f2fs_handle_page_eio(sbi, page->index, NODE);

How about:

goto out_put;

>   		f2fs_put_page(page, 1);
>   		return ERR_PTR(err);
>   	} else if (err == LOCKED_PAGE) {
> @@ -1452,6 +1453,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
>   		err = -EINVAL;
>   out_err:
>   		ClearPageUptodate(page);

out_put:

Thanks,

> +		f2fs_handle_page_eio(sbi, page->index, NODE);
>   		f2fs_put_page(page, 1);
>   		return ERR_PTR(err);
>   	}
