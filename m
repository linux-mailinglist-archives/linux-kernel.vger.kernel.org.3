Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2835353765B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiE3IIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiE3IIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:08:53 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EF0644F7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:08:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R801e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VEkLGFr_1653898123;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VEkLGFr_1653898123)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 30 May 2022 16:08:45 +0800
Date:   Mon, 30 May 2022 16:08:43 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Weizhao Ouyang <o451686892@gmail.com>
Cc:     Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: fix 'backmost' member of
 z_erofs_decompress_frontend
Message-ID: <YpR7izQ0H0DWaHzA@B-P7TQMD6M-0146.local>
References: <20220530075114.918874-1-o451686892@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220530075114.918874-1-o451686892@gmail.com>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 03:51:14PM +0800, Weizhao Ouyang wrote:
> Initialize 'backmost' to true in DECOMPRESS_FRONTEND_INIT.
> 
> Fixes: 5c6dcc57e2e5 ("erofs: get rid of `struct z_erofs_collector'")
> Signed-off-by: Weizhao Ouyang <o451686892@gmail.com>


Many thanks for the in-time catching! ;)

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

> ---
>  fs/erofs/zdata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 95efc127b2ba..94d2cb970644 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -214,7 +214,7 @@ struct z_erofs_decompress_frontend {
>  
>  #define DECOMPRESS_FRONTEND_INIT(__i) { \
>  	.inode = __i, .owned_head = Z_EROFS_PCLUSTER_TAIL, \
> -	.mode = COLLECT_PRIMARY_FOLLOWED }
> +	.mode = COLLECT_PRIMARY_FOLLOWED, .backmost = true }
>  
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);
> -- 
> 2.34.1
