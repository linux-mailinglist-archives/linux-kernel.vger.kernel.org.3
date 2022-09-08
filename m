Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB965B2899
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiIHVfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 17:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiIHVfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 17:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15C5476C1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 14:34:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F92F61E38
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 21:34:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B25CC433B5;
        Thu,  8 Sep 2022 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662672898;
        bh=mBGRYtyHJ9riaLHrZ69B0HeCHt0VDhbhoWL8rBkVsbw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=M3/5N9ga8sK+74ECLFbGY1lSjBnVotEmcyScNldLpHLEetrE6DW/d4jZWYabbr0Dg
         PB+YmxY3ctpvC15mAWI0qO/7yxSpTh4OFrGm8bw5i7orGT/Vefj8J0yNQbP0nuPuPn
         ZH+rKnp7xQPtKkOWM4zB2fVPc6HcA371QaIaW2ZmZKoKVVoiqkdiSOHXC+8+WaK+Ll
         S/OiwsxYcww7YePK/lugE0B7zHTfGtdQDFHjjroWMuLKkazzKjfxdCx1RV64suzObh
         tCRKMwzu+ILJqSwHuHxenfnvEJG5y8y8OQrpLmJlvqx6e2KQI412V8gYgM6Halo+DA
         jmKXTyAALFWHw==
Message-ID: <efab6249-186a-4613-5c8c-86c3e3d15d7f@kernel.org>
Date:   Thu, 8 Sep 2022 23:34:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v2] mm/slub: fix to return errno if kmalloc() fails
Content-Language: en-US
To:     Chao Yu <chao@kernel.org>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jaegeuk@kernel.org, Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com,
        Muchun Song <songmuchun@bytedance.com>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
References: <20220831145454.858200-1-chao@kernel.org>
From:   "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20220831145454.858200-1-chao@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/22 16:54, Chao Yu wrote:
> From: Chao Yu <chao.yu@oppo.com>
> 
> In create_unique_id(), kmalloc(, GFP_KERNEL) can fail due to
> out-of-memory, if it fails, return errno correctly rather than
> triggering panic via BUG_ON();
> 
> kernel BUG at mm/slub.c:5893!
> Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> 
> Call trace:
>  sysfs_slab_add+0x258/0x260 mm/slub.c:5973
>  __kmem_cache_create+0x60/0x118 mm/slub.c:4899
>  create_cache mm/slab_common.c:229 [inline]
>  kmem_cache_create_usercopy+0x19c/0x31c mm/slab_common.c:335
>  kmem_cache_create+0x1c/0x28 mm/slab_common.c:390
>  f2fs_kmem_cache_create fs/f2fs/f2fs.h:2766 [inline]
>  f2fs_init_xattr_caches+0x78/0xb4 fs/f2fs/xattr.c:808
>  f2fs_fill_super+0x1050/0x1e0c fs/f2fs/super.c:4149
>  mount_bdev+0x1b8/0x210 fs/super.c:1400
>  f2fs_mount+0x44/0x58 fs/f2fs/super.c:4512
>  legacy_get_tree+0x30/0x74 fs/fs_context.c:610
>  vfs_get_tree+0x40/0x140 fs/super.c:1530
>  do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
>  path_mount+0x358/0x914 fs/namespace.c:3370
>  do_mount fs/namespace.c:3383 [inline]
>  __do_sys_mount fs/namespace.c:3591 [inline]
>  __se_sys_mount fs/namespace.c:3568 [inline]
>  __arm64_sys_mount+0x2f8/0x408 fs/namespace.c:3568
> 
> Cc: <stable@kernel.org>
> Fixes: 81819f0fc8285 ("SLUB core")
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Signed-off-by: Chao Yu <chao.yu@oppo.com>

Added to slab.git for-6.0/fixes

> ---
> v2:
> - add more rvb tags and fixes line
>  mm/slub.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 862dbd9af4f5..e6f3727b9ad2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -5890,7 +5890,8 @@ static char *create_unique_id(struct kmem_cache *s)
>  	char *name = kmalloc(ID_STR_LENGTH, GFP_KERNEL);
>  	char *p = name;
>  
> -	BUG_ON(!name);
> +	if (!name)
> +		return ERR_PTR(-ENOMEM);
>  
>  	*p++ = ':';
>  	/*
> @@ -5948,6 +5949,8 @@ static int sysfs_slab_add(struct kmem_cache *s)
>  		 * for the symlinks.
>  		 */
>  		name = create_unique_id(s);
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
>  	}
>  
>  	s->kobj.kset = kset;

