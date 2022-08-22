Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B83659BCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiHVJ0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHVJ02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:26:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5596193F7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 02:26:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 61BA21FAC8;
        Mon, 22 Aug 2022 09:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1661160386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ziw2z60GLw6fCIwzNKouC00bFO+5NDXAJ4kW14DHQN8=;
        b=b4+plMEVnC3WjOXEMxc+oeYCjB1sXa/8367lT9eai2Y5hNqiDSrfOlWNvjvMITBWl7SXyf
        JleJPiAKSipWAnrjGofOB8Ws0o0vWMHXCmP2OriZwK4fIr6Zs3WXa5+t4j0G04SuE8WWSf
        7zxyu5JTgCDdIputF09scTgrJ636u4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1661160386;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ziw2z60GLw6fCIwzNKouC00bFO+5NDXAJ4kW14DHQN8=;
        b=QjeKaFWEXNBMWAIURd6ajlldt3ZE6eC3e84BxlOwmD9RnLNIc5tVUZHpt83tJv88FQcz11
        IQt27FZATxDYiwDw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFFBB2C141;
        Mon, 22 Aug 2022 09:26:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C3DCA066D; Mon, 22 Aug 2022 11:26:25 +0200 (CEST)
Date:   Mon, 22 Aug 2022 11:26:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [RESEND PATCH v2] fs/isofs: Replace kmap() with kmap_local_page()
Message-ID: <20220822092625.ag2naoeuhhrq6pqz@quack3>
References: <20220821175012.6866-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220821175012.6866-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 21-08-22 19:50:12, Fabio M. De Francesco wrote:
> The use of kmap() is being deprecated in favor of kmap_local_page().
> 
> There are two main problems with kmap(): (1) It comes with an overhead as
> mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when the
> kmap’s pool wraps and it might block when the mapping space is fully
> utilized until a slot becomes available.
> 
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> Tasks can be preempted and, when scheduled to run again, the kernel
> virtual addresses are restored and still valid. It is faster than kmap()
> in kernels with HIGHMEM enabled.
> 
> Since kmap_local_page() can be safely used in compress.c, it should be
> called everywhere instead of kmap().
> 
> Therefore, replace kmap() with kmap_local_page() in compress.c. Where it
> is needed, use memzero_page() instead of open coding kmap_local_page()
> plus memset() to fill the pages with zeros. Delete the redundant
> flush_dcache_page() in the two call sites of memzero_page().
> 
> Tested with mkisofs on a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel
> with HIGHMEM64GB enabled.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jan Kara <jack@suse.cz>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks for the patch! It looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Some days ago Andrew requested a resend of this patch.[1]
> 
> v1->v2: Cast zisofs_sink_page to pointer to unsigned char.
> Reported-by: kernel test robot <lkp@intel.com>
> 
> Many thanks to Jan Kara for the comments and suggestions provided with
> replying to my previous RFC.[2] Furthermore, I want to thank Ira Weiny for
> the advices he provided, especially about how to use mkisofs to test that
> this patch is working properly.
> 
> [1] https://lore.kernel.org/all/20220801122709.8164-1-fmdefrancesco@gmail.com/
> [2] https://lore.kernel.org/lkml/20220726145024.rryvw7ot7j2c6tqv@quack3/
> 
>  fs/isofs/compress.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 95a19f25d61c..107007c38d08 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -67,8 +67,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  		for ( i = 0 ; i < pcount ; i++ ) {
>  			if (!pages[i])
>  				continue;
> -			memset(page_address(pages[i]), 0, PAGE_SIZE);
> -			flush_dcache_page(pages[i]);
> +			memzero_page(pages[i], 0, PAGE_SIZE);
>  			SetPageUptodate(pages[i]);
>  		}
>  		return ((loff_t)pcount) << PAGE_SHIFT;
> @@ -120,7 +119,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	       zerr != Z_STREAM_END) {
>  		if (!stream.avail_out) {
>  			if (pages[curpage]) {
> -				stream.next_out = page_address(pages[curpage])
> +				stream.next_out = kmap_local_page(pages[curpage])
>  						+ poffset;
>  				stream.avail_out = PAGE_SIZE - poffset;
>  				poffset = 0;
> @@ -176,6 +175,10 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  				flush_dcache_page(pages[curpage]);
>  				SetPageUptodate(pages[curpage]);
>  			}
> +			if (stream.next_out != (unsigned char *)zisofs_sink_page) {
> +				kunmap_local(stream.next_out);
> +				stream.next_out = NULL;
> +			}
>  			curpage++;
>  		}
>  		if (!stream.avail_in)
> @@ -183,6 +186,8 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	}
>  inflate_out:
>  	zlib_inflateEnd(&stream);
> +	if (stream.next_out && stream.next_out != (unsigned char *)zisofs_sink_page)
> +		kunmap_local(stream.next_out);
>  
>  z_eio:
>  	mutex_unlock(&zisofs_zlib_lock);
> @@ -283,9 +288,7 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  	}
>  
>  	if (poffset && *pages) {
> -		memset(page_address(*pages) + poffset, 0,
> -		       PAGE_SIZE - poffset);
> -		flush_dcache_page(*pages);
> +		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
>  		SetPageUptodate(*pages);
>  	}
>  	return 0;
> @@ -343,10 +346,8 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  	for (i = 0; i < pcount; i++, index++) {
>  		if (i != full_page)
>  			pages[i] = grab_cache_page_nowait(mapping, index);
> -		if (pages[i]) {
> +		if (pages[i])
>  			ClearPageError(pages[i]);
> -			kmap(pages[i]);
> -		}
>  	}
>  
>  	err = zisofs_fill_pages(inode, full_page, pcount, pages);
> @@ -357,7 +358,6 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  			flush_dcache_page(pages[i]);
>  			if (i == full_page && err)
>  				SetPageError(pages[i]);
> -			kunmap(pages[i]);
>  			unlock_page(pages[i]);
>  			if (i != full_page)
>  				put_page(pages[i]);
> -- 
> 2.37.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
