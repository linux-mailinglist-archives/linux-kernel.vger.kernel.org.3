Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDB70479FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbhLSIyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 03:54:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhLSIyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 03:54:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A1BAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 00:54:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4CDE60C8C
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 08:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75268C36AE8;
        Sun, 19 Dec 2021 08:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639904040;
        bh=z5TBNVZ279yBP2Gr+ocvS8LswwGW8gBcfOilhzacPrg=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=TdvZ+Nxp/75q46DM0qE6jfCXywWF6y7Z2byX1QX0/oBxo33kYpCEhtaeCguaoKK2Q
         i4PJEXdCjNHeLBFsN06et8q0YDXJGBB2yoErDxwMT8y1SJUaWkpHkqlVeGm6eVWI/7
         FIWhebThTkw0Gsw6ddvE9DvGlDOJo850AYqu8pJ5xxFVSpF2KjCAz52ovDpsC91j5Z
         UZKzFwzyvJx1KNK3vYaALAoO2veOEugcl9kbzLp0avsudUxyDz4VtGp6+qAVBDfw5v
         3roaUhPvt400iNAaX2L2AA68ol8JtbwfYzChzrPH8uoNAXQUk6Fk6j8Bp2YKnwuKR0
         5gRSZ1QrAdDcw==
Message-ID: <443927c3-8eaf-8f00-0e41-2173143fe166@kernel.org>
Date:   Sun, 19 Dec 2021 16:53:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20211214182435.2595176-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/12/15 2:24, Jaegeuk Kim wrote:
> Let's cache nat entry if there's no lock contention only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fs/f2fs/node.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 556fcd8457f3..b1bc7d76da3b 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -430,6 +430,10 @@ static void cache_nat_entry(struct f2fs_sb_info *sbi, nid_t nid,
>   	struct f2fs_nm_info *nm_i = NM_I(sbi);
>   	struct nat_entry *new, *e;
>   
> +	/* Let's mitigate lock contention of nat_tree_lock during checkpoint */
> +	if (rwsem_is_locked(&sbi->cp_global_sem))

Why not down_write_trylock(nat_tree_lock)? cp_global_sem lock coverage is larger than
nat_tree_lock's in f2fs_write_checkpoint().

Thanks,

> +		return;
> +
>   	new = __alloc_nat_entry(sbi, nid, false);
>   	if (!new)
>   		return;
