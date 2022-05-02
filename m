Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632E516DD1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384515AbiEBKFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384502AbiEBKFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:05:08 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF0363F8;
        Mon,  2 May 2022 03:01:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VC-hchj_1651485680;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VC-hchj_1651485680)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 02 May 2022 18:01:22 +0800
Date:   Mon, 2 May 2022 18:01:20 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the folio tree
Message-ID: <Ym+r8OK3eWUihmr6@B-P7TQMD6M-0146.local>
References: <20220502180425.7305c335@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220502180425.7305c335@canb.auug.org.au>
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 02, 2022 at 06:04:25PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the folio tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> fs/erofs/fscache.c:255:10: error: 'const struct address_space_operations' has no member named 'readpage'
>   255 |         .readpage = erofs_fscache_meta_readpage,
>       |          ^~~~~~~~
> fs/erofs/fscache.c:255:21: error: initialization of 'int (*)(struct page *, struct writeback_control *)' from incompatible pointer type 'int (*)(struct file *, struct page *)' [-Werror=incompatible-pointer-types]
>   255 |         .readpage = erofs_fscache_meta_readpage,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/erofs/fscache.c:255:21: note: (near initialization for 'erofs_fscache_meta_aops.writepage')
> fs/erofs/fscache.c:259:10: error: 'const struct address_space_operations' has no member named 'readpage'
>   259 |         .readpage = erofs_fscache_readpage,
>       |          ^~~~~~~~
> fs/erofs/fscache.c:259:21: error: initialization of 'int (*)(struct page *, struct writeback_control *)' from incompatible pointer type 'int (*)(struct file *, struct page *)' [-Werror=incompatible-pointer-types]
>   259 |         .readpage = erofs_fscache_readpage,
>       |                     ^~~~~~~~~~~~~~~~~~~~~~
> fs/erofs/fscache.c:259:21: note: (near initialization for 'erofs_fscache_access_aops.writepage')
> 
> Caused by commit
> 
>   00da6d4b7219 ("mm,fs: Remove stray references to ->readpage")
> 
> interacting with commits
> 
>   60aa7e805f00 ("erofs: implement fscache-based metadata read")
>   e472f468adbe ("erofs: implement fscache-based data read for non-inline layout")
> 
> from the erofs tree.
> 
> I have applied the following merge fix patch.
> 

That looks good to me, will point out this conflict then.

Thanks,
Gao Xiang

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 2 May 2022 17:57:39 +1000
> Subject: [PATCH] fixup for "mm,fs: Remove stray references to ->readpage"
> 
> interacting with commits
> 
>   60aa7e805f00 ("erofs: implement fscache-based metadata read")
>   e472f468adbe ("erofs: implement fscache-based data read for non-inline layout")
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/erofs/fscache.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index a402d8f0a063..1bb2d0fc19c8 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -59,10 +59,9 @@ static int erofs_fscache_read_folios(struct fscache_cookie *cookie,
>  	return ret;
>  }
>  
> -static int erofs_fscache_meta_readpage(struct file *data, struct page *page)
> +static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>  {
>  	int ret;
> -	struct folio *folio = page_folio(page);
>  	struct super_block *sb = folio_mapping(folio)->host->i_sb;
>  	struct erofs_map_dev mdev = {
>  		.m_deviceid = 0,
> @@ -110,9 +109,8 @@ static int erofs_fscache_readpage_inline(struct folio *folio,
>  	return 0;
>  }
>  
> -static int erofs_fscache_readpage(struct file *file, struct page *page)
> +static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>  {
> -	struct folio *folio = page_folio(page);
>  	struct inode *inode = folio_mapping(folio)->host;
>  	struct super_block *sb = inode->i_sb;
>  	struct erofs_map_blocks map;
> @@ -252,11 +250,11 @@ static void erofs_fscache_readahead(struct readahead_control *rac)
>  }
>  
>  static const struct address_space_operations erofs_fscache_meta_aops = {
> -	.readpage = erofs_fscache_meta_readpage,
> +	.read_folio = erofs_fscache_meta_read_folio,
>  };
>  
>  const struct address_space_operations erofs_fscache_access_aops = {
> -	.readpage = erofs_fscache_readpage,
> +	.read_folio = erofs_fscache_read_folio,
>  	.readahead = erofs_fscache_readahead,
>  };
>  
> -- 
> 2.35.1
> 
> -- 
> Cheers,
> Stephen Rothwell


