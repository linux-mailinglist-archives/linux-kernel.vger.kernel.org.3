Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF58F54CF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344363AbiFOQvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237952AbiFOQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:51:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D84340EC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 09:51:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42520619C0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:51:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74B0EC34115;
        Wed, 15 Jun 2022 16:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655311861;
        bh=hviysRKzBUvS5pn/sCyEVL+jhAwvyptL0s0z7P87qp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK0i2Gqw/eh/nvCxEP74o3yAHAesP2mLLk4ZCJEAfLWPSPRN/38Z5VENaXft/NVqK
         4TnzQSGLmHOkLThunEjUWHR1YfwhWablzW/5xT9UDrplw9iXgW51UzTJXfJb35XKho
         +mDrk8tBqzbjeFWuI700AN+6T4pMSsZH7EbztTQ0oRqdASnv/a8XSNLVvDVWmwsEgA
         EfbBsoCZNUs7h5rafqjpZJNBBIU2kBWIG05yjfcz/wGhcmk8PMFVebMLdk3QIEjNR8
         wYdy8BplSoOmQ/tfiejedqZcBG85FFsEg+5799AE/u9Fxj/Gg1IJmWXVJTnsJHm8RI
         M28utpvFAgYFA==
Date:   Wed, 15 Jun 2022 09:50:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Ren Zhijie <renzhijie2@huawei.com>
Cc:     chao@kernel.org, daehojeong@google.com,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] f2fs: fix build error too many arguments to
 functions
Message-ID: <YqoN8wZDJJUN4IDQ@google.com>
References: <20220615070422.214106-1-renzhijie2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220615070422.214106-1-renzhijie2@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, but I deqeued the buggy patch, so expect to get the right change
later.

On 06/15, Ren Zhijie wrote:
> If CONFIG_F2FS_FS_COMPRESSION is not set.
> 
> make ARCH=x86_64 CROSS_COMPILE=x86_64-linux-gnu-, will be failed, like this:
> fs/f2fs/data.c: In function ‘f2fs_finish_read_bio’:
> fs/f2fs/data.c:136:5: error: too many arguments to function ‘f2fs_end_read_compressed_page’
>      f2fs_end_read_compressed_page(page, true, 0,
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from fs/f2fs/data.c:25:0:
> fs/f2fs/f2fs.h:4228:20: note: declared here
>  static inline void f2fs_end_read_compressed_page(struct page *page,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> fs/f2fs/data.c:138:4: error: too many arguments to function ‘f2fs_put_page_dic’
>     f2fs_put_page_dic(page, in_softirq);
>     ^~~~~~~~~~~~~~~~~
> In file included from fs/f2fs/data.c:25:0:
> fs/f2fs/f2fs.h:4233:20: note: declared here
>  static inline void f2fs_put_page_dic(struct page *page)
>                     ^~~~~~~~~~~~~~~~~
> fs/f2fs/data.c: In function ‘f2fs_handle_step_decompress’:
> fs/f2fs/data.c:241:4: error: too many arguments to function ‘f2fs_end_read_compressed_page’
>     f2fs_end_read_compressed_page(page, PageError(page),
>     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from fs/f2fs/data.c:25:0:
> fs/f2fs/f2fs.h:4228:20: note: declared here
>  static inline void f2fs_end_read_compressed_page(struct page *page,
>                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> make[2]: *** [fs/f2fs/data.o] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [fs/f2fs] Error 2
> 
> Since commit 1b565702dffe ("f2fs: handle decompress only post processing in softirq") 
> had changed the definition of function "f2fs_end_read_compressed_page()" and "f2fs_put_page_dic()",
> but forgot the other definitions in f2fs.h warpped by #else /* CONFIG_F2FS_FS_COMPRESSION */.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 1b565702dffe("f2fs: handle decompress only post processing in softirq")
> Signed-off-by: Ren Zhijie <renzhijie2@huawei.com>
> ---
>  fs/f2fs/f2fs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index b42fcca030e2..0811a9335dde 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4225,12 +4225,12 @@ static inline struct page *f2fs_compress_control_page(struct page *page)
>  static inline int f2fs_init_compress_mempool(void) { return 0; }
>  static inline void f2fs_destroy_compress_mempool(void) { }
>  static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic) { }
> -static inline void f2fs_end_read_compressed_page(struct page *page,
> -						bool failed, block_t blkaddr)
> +static inline void f2fs_end_read_compressed_page(struct page *page, bool failed,
> +				block_t blkaddr, bool in_softirq)
>  {
>  	WARN_ON_ONCE(1);
>  }
> -static inline void f2fs_put_page_dic(struct page *page)
> +static inline void f2fs_put_page_dic(struct page *page, bool in_softirq)
>  {
>  	WARN_ON_ONCE(1);
>  }
> -- 
> 2.17.1
