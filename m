Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D964AC95F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 20:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238884AbiBGTSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 14:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiBGTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 14:14:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00921C0401DC
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 11:14:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB551B80EF6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:14:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440D8C004E1;
        Mon,  7 Feb 2022 19:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644261292;
        bh=HJoLZayjw9d/gTYyeZLWOIyycJnicgl+gCOYbWkZsXU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mtOs0UFvLFkypBmJJ4xlwyKBYH+C3cuBhr2TXU4kpDV9+q1LF8W1t++Gwl4Ejy9//
         xbD6K6t+PhFRAo0E9bK7c63F1EadKKIfN678kYPxoxlCKz/M++a5b1hdQU6q56lPQf
         A/G+HyzTi+1QQoBU0/VhUOx3ja68Klh4Yx9BHryHm6RE99SZvhzVQ9aS0ED7pwNVYA
         LAaA67j2ip7+Oop90XwqyRjxNe6N3/HPmvLTj94CBSZ/tXh8BjuGhhrIB1oeliy/TT
         6D3quwBsbKKrzomk2Lf/xp41Lbm0i4EB4eth6qu7VpDbCL+xHcS7N/N3jdZFEhjALr
         7BZMFQ5tFiuSA==
Date:   Mon, 7 Feb 2022 11:14:50 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: avoid unneeded preflush during checkpoint()
Message-ID: <YgFvqnoa61BspqmW@google.com>
References: <20220207113516.9489-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207113516.9489-1-chao@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07, Chao Yu wrote:
> During checkpoint, we have committed preflush command via f2fs_flush_device_cache()

 787 int f2fs_flush_device_cache(struct f2fs_sb_info *sbi)
 788 {
 789         int ret = 0, i;
 790 
 791         if (!f2fs_is_multi_device(sbi))
 792                 return 0;

Seems a wrong assumption.

> to persist all metadata pages except last #2 CP pack page, so we don't need to
> commit another preflush command in commit_checkpoint(), remove it to avoid unneeded
> write cache overhead.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8c417864c66a..15ac18bbbc8e 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -598,7 +598,7 @@ static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
>  		io->fio.op = REQ_OP_WRITE;
>  		io->fio.op_flags = REQ_META | REQ_PRIO | REQ_SYNC;
>  		if (!test_opt(sbi, NOBARRIER))
> -			io->fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
> +			io->fio.op_flags |= REQ_FUA;
>  	}
>  	__submit_merged_bio(io);
>  	up_write(&io->io_rwsem);
> -- 
> 2.32.0
