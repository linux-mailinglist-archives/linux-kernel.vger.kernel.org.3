Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2EB5A7EF8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiHaNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbiHaNev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:34:51 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2699FD571A
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:33:56 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id x80so9947243pgx.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=1PE3GKnhwOhRif7fn1enjVH8DVXVUvhYKrLN724969I=;
        b=BDicR5TJvL5oR2CfoULAhbPtsjdaQUo8LupEgctXNvDRwIdsaxZVxk3GBI3Erzm4vk
         aCYL0FK9UAa4d751uPbhSGOVQLb0E5V+/9+zN2P+pfgn58Te4w2jJ+geGwfNLM8wQYt1
         ruQNla7c/YWtBBlAJ8wxKBaBOsNNDhvAFLM2wkK1VEnF7sqNw4dwUyun7xT11TmgwUp9
         rE+/GTAen/+frXJ3pcZ8s8nWEZZiu1fgC49WIdMaW+rwKMCqe19QG+uaJvutr2PnTaxH
         C9cbKyr3IhIae0cxmQLNUUt1HhQvdiha6n8HF5vaUf7hJGsEATD/PErOya2PB4zTlQdC
         iPeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=1PE3GKnhwOhRif7fn1enjVH8DVXVUvhYKrLN724969I=;
        b=IPoT/Lk5YZOydo4/kBYNxH0RkZfvBEP/IPIHOe5lrr+TgIRRgnym2w5zTKyoxOHGwn
         QnvO95IzRSBm78a5fhwpayGgb7ZqZsA2wBytLNRb1pXZo7O9uu41Kwc9nu8mlrquDZfa
         5u3k0dlpWy/42FLvHKpKJ5FVC7fa4uHHcRHqOGxHN5E9fJHwYWfY+aNZlAiNehrD7sxS
         VWKQioHKrsXxFz5Ku0nNNSfO2BAFYAGf/QHR1UrNu46ku/eXAXzNfB5jgKz3oTyLfvXQ
         4IyUZd5VXtnRTvCUsmH+SVOorHbPYR1qc9e+I56M0vDGf9UAy/IuktT/eEjkNKGiO32c
         YYew==
X-Gm-Message-State: ACgBeo3iQB/p0BS65UMqIO251gqCjzHWKZwp4bUI2YT6QqxmoGSP1rOl
        WPZNEDT2BJeV/1coRstEt9Rz1LBIonc=
X-Google-Smtp-Source: AA6agR6KmyTMobUbdXA3xUzSjKLI551KM+BCVV/L16aTZhKH4J0yQhveyLp/PO5lreFFBmR8UrBsdA==
X-Received: by 2002:a65:6d93:0:b0:42c:50ec:8025 with SMTP id bc19-20020a656d93000000b0042c50ec8025mr9689713pgb.62.1661952834522;
        Wed, 31 Aug 2022 06:33:54 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id pj7-20020a17090b4f4700b001fb277223bdsm1306189pjb.2.2022.08.31.06.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 06:33:53 -0700 (PDT)
Date:   Wed, 31 Aug 2022 22:33:48 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org,
        Chao Yu <chao.yu@oppo.com>, stable@kernel.org,
        syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/slub: fix to return errno if kmalloc() fails
Message-ID: <Yw9jPJn7uUAl6uf1@hyeyoo>
References: <20220830141009.150075-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220830141009.150075-1-chao@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 10:10:09PM +0800, Chao Yu wrote:
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
> Reported-by: syzbot+81684812ea68216e08c5@syzkaller.appspotmail.com

Fixes: 81819f0fc8285 ("SLUB core")

> Signed-off-by: Chao Yu <chao.yu@oppo.com>
> ---
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
> -- 
> 2.25.1
> 
> 

Looks good to me.

Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

-- 
Thanks,
Hyeonggon
