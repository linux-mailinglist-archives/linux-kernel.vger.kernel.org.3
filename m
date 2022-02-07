Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8704AC952
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236838AbiBGTSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238377AbiBGTQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:16:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939D8C0401DA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:16:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAE1161029
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:16:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03219C004E1;
        Mon,  7 Feb 2022 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644261365;
        bh=FX8ZhpIlZF+4RHH0iTaQPztnxFU3gZjZlumdpdlOJzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nH2L/yXFXkWChhV3VCclL8E2NfMRs46hGDZfdUS+NeLk26ueq9blVUKofZcMxyJuv
         4XSqNwJkk+WwgY36/WpUrWh4l08REKDiDGmOkITBFVgrOU1hLnvfQu6XYh5Y7pTpyB
         F7wIc2ybYsHimr8PEUjZt4aB44qTn40Bx2yZ9IUZxFYfx/kbZv+BR3SDHq9ZQ4c+rg
         4+Y613Qu9HMtCaNlXYe/hQ+VIyrmoglIWRABM9RlbME4zgJ926w4K3T6Tg6OEyI8CX
         RlGyGXC6RTViKQ3aj80lNq4WqY8wlPQpNvTw9TU4oENNPiHPRf70MUg5/Em7N818wr
         PfXLlO3vAFlKg==
Date:   Mon, 7 Feb 2022 11:16:03 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: skip f2fs_preallocate_blocks() for overwrite
 case
Message-ID: <YgFv85dH0dWFTZBx@google.com>
References: <20220204091005.49407-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220204091005.49407-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04, Chao Yu wrote:
> There is potential hangtask happened during swapfile's writeback:
> 
> - loop_kthread_worker_fn		- do_checkpoint
>   - kthread_worker_fn
>    - loop_queue_work
>     - lo_rw_aio
>      - f2fs_file_write_iter
>       - f2fs_preallocate_blocks
>        - f2fs_map_blocks
> 					 - down_write
>         - down_read
>          - rwsem_down_read_slowpath
>           - schedule
> 
> One cause is f2fs_preallocate_blocks() will always be called no matter
> the physical block addresses are allocated or not.
> 
> This patch tries to check whether block addresses are all allocated with
> i_size and i_blocks of inode, it's rough because blocks can be allocated
> beyond i_size, however, we can afford skipping block preallocation in this
> condition since it's not necessary to do preallocation all the time.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - check overwrite case with i_size and i_blocks roughly.
>  fs/f2fs/file.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index cfdc41f87f5d..09565d10611d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -4390,6 +4390,16 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
>  	int flag;
>  	int ret;
>  
> +	/*
> +	 * It tries to check whether block addresses are all allocated,
> +	 * it's rough because blocks can be allocated beyond i_size,
> +	 * however, we can afford skipping block preallocation since
> +	 * it's not necessary all the time.
> +	 */
> +	if (F2FS_BLK_ALIGN(i_size_read(inode)) ==
> +			SECTOR_TO_BLOCK(inode->i_blocks))

Do we count i_blocks only for data?

> +		return 0;
> +
>  	/* If it will be an out-of-place direct write, don't bother. */
>  	if (dio && f2fs_lfs_mode(sbi))
>  		return 0;
> -- 
> 2.32.0
