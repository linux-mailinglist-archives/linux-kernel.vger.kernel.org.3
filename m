Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82404A8CDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353932AbiBCUDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 15:03:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:51134 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353926AbiBCUDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:03:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B06C619EB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 20:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE22AC340E8;
        Thu,  3 Feb 2022 20:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643918616;
        bh=BYyFT3gy5b+xN2UQFHLCszX9c7Iabdr/TmYfxt+xQUI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QwAcCqAL/FVaQKM8cIMP+5ZlptqiakqUcwqpRfN6f+nVS99ComXMXrL96B4dyvDRT
         vzCKXRavC2X4Ea7OWwST1O4eZhwJMeNo3/IEuC3Bm54RVjXvaZG5S/9ROTalIpiMkO
         Jxmvbwr5ymrZR6K2J0Rg9mOBrtXyOT7LiMqKi/KTsLnQt8nJO3DF9yYvNq99h3+pFG
         v9N6WefJrpmJU8WSyB3+9WSPcexVU7AK/xhTERqXFeFz8laNvFTfJMcIQOSfoIh3Wk
         DcHVaLZclc250RHukoEqt5DZfEACEYc16iwXm5nrO0Wfj4NxNeZHJkd32PipNw7Qpi
         V/9uID0gXGKvA==
Date:   Thu, 3 Feb 2022 12:03:34 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Pavel Machek <pavel@denx.de>
Subject: Re: [PATCH] f2fs: fix to unlock page correctly in error path of
 is_alive()
Message-ID: <Yfw1FnkiO+U+zGS0@google.com>
References: <20220203144705.23528-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203144705.23528-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03, Chao Yu wrote:
> As Pavel Machek reported in below link [1]:
> 
> After commit 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()"),
> node page should be unlock via calling f2fs_put_page() in the error path
> of is_alive(), otherwise, f2fs may hang when it tries to lock the node
> page, fix it.
> 
> [1] https://lore.kernel.org/stable/20220124203637.GA19321@duo.ucw.cz/

Need -stable? It seems 4.19+?

> 
> Fixes: 77900c45ee5c ("f2fs: fix to do sanity check in is_alive()")
> Reported-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/gc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 0a6b0a8ae97e..2d53ef121e76 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1038,8 +1038,10 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  		set_sbi_flag(sbi, SBI_NEED_FSCK);
>  	}
>  
> -	if (f2fs_check_nid_range(sbi, dni->ino))
> +	if (f2fs_check_nid_range(sbi, dni->ino)) {
> +		f2fs_put_page(node_page, 1);
>  		return false;
> +	}
>  
>  	*nofs = ofs_of_node(node_page);
>  	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
> -- 
> 2.32.0
