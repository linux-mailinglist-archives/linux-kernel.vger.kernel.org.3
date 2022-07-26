Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420D5815B5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbiGZOub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbiGZOu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:50:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00998B846
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:50:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 544BD1FFA8;
        Tue, 26 Jul 2022 14:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1658847026; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMbYNXlYCOado8vk5f0A62nAbjrK4L6WkkolNQZ0YQY=;
        b=FKHYeJpVfzn72dDFKgB9pbqNXY6fQV69GgXPoCRkan1XIWAADQN5vYZcvVfP+IB6wz1K4a
        LlYr0b8y9nBmhabYcSdWIcw7kQVspeyGaKASG5+o0ARdx+avsWLy8aFbLPJJMlNAucUVcS
        HXNk8Mhu8igs2z9ifBxTjKXFygQyZiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1658847026;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XMbYNXlYCOado8vk5f0A62nAbjrK4L6WkkolNQZ0YQY=;
        b=oynh6E9lXkJHbDanj1kFNi3Vs0jIpOZcMK40FzOrkqDujFs6zvREg2xphDOj7beLPKphzp
        OCQppNNgu1eue0Aw==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 26A3F2C141;
        Tue, 26 Jul 2022 14:50:25 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8C4B2A0680; Tue, 26 Jul 2022 16:50:24 +0200 (CEST)
Date:   Tue, 26 Jul 2022 16:50:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Jan Kara <jack@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] fs/isofs: Replace kmap() with kmap_local_page()
Message-ID: <20220726145024.rryvw7ot7j2c6tqv@quack3>
References: <20220725162331.9825-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725162331.9825-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 25-07-22 18:23:31, Fabio M. De Francesco wrote:
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
> This is an RFC because these changes have not been tested (tests are
> welcome!), therefore I'm not entirely sure whether these conversions work
> properly. I'd like to hear comments from more experienced developers
> before sending a real patch. Suggestions about how to run tests would
> also be much appreciated.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

What you propose makes sense to me. But the lack of testing is troublesome.
You can always at least test your patch without highmem on isofs image with
compression (mkisofs seems to support creating such filesystems). Even that
would detect a bug in your patch ;) - see below.

> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 95a19f25d61c..a1562124bb91 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -120,8 +119,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	       zerr != Z_STREAM_END) {
>  		if (!stream.avail_out) {
>  			if (pages[curpage]) {
> -				stream.next_out = page_address(pages[curpage])
> -						+ poffset;
> +				stream.next_out = kmap_local_page(pages[curpage] + poffset);

This is wrong. Most importantly because you need to add 'poffset' to the
final address provided by kmap_local_page(), not to the struct page pointer.

Secondly please wrap the line to fit into 80 chars.

>  				stream.avail_out = PAGE_SIZE - poffset;
>  				poffset = 0;
>  			} else {
> @@ -170,6 +168,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  			}
>  		}
>  
> +		if (stream.next_out)
> +			if (stream.next_out != (char *)zisofs_sink_page) {
> +				kunmap_local(stream.next_out);
> +				stream.next_out = NULL;
> +			}
> +

This looks buggy as well. If we mapped page above, we'll unmap it here even
if stream.avail_out > 0 and we want to still write to it. I think you
should unmap the page here only if stream.avail_out == 0 and we are going
to switch to the next page...

>  		if (!stream.avail_out) {
>  			/* This page completed */
>  			if (pages[curpage]) {
> @@ -183,6 +187,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	}
>  inflate_out:
>  	zlib_inflateEnd(&stream);
> +	if (stream.next_out)
> +		if (stream.next_out != (char *)zisofs_sink_page)
> +			kunmap_local(stream.next_out);

This is correct but I'd simplify it to:

	if (stream.next_out && stream.next_out != (char *)zisofs_sink_page)
		kunmap_local(stream.next_out);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
