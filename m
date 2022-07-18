Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F4233578D71
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 00:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234706AbiGRWT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 18:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiGRWT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 18:19:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 941F0220D6;
        Mon, 18 Jul 2022 15:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=iN+8ckeB+moKTuuo5xeEEoN4N4ajBlWTzFr+sY0u/zk=; b=A5/4af9dxXQ8ntBSgoGZGyzwFP
        1wknE3xceMJ46Gvk8mIRYD6PiSgL4IOVKNo/juSig7ZnVyDs8whTQ3nQDPeT/ZhDjNGlPzCjvlZqd
        Dv44aB9nqAzwzjlZnwdTvznrb6uN0LLN6WEALbYwPuG/v7NyNrnuW8+tINZWVYjzL5nUFUFCo7tsb
        ZKnvP78rBOVE3J+tNqBuOklRM/dwqZb4XHLEnR5N06io8aTwvYn/xR01HRr4KDEf6bgOoXBT6k2By
        C1iAL0GknWxIuDEHXidJ9c7fgkowMQm+1YHN/SZQTTEzEq097K7OtE7TNUT/Rj55mkJmu2yAaaIk3
        t5xFTtHQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDZ5i-00241Q-6z; Mon, 18 Jul 2022 22:19:50 +0000
Date:   Mon, 18 Jul 2022 15:19:50 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Song Liu <song@kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] module: Replace kmap() with kmap_local_page()
Message-ID: <YtXchtEwetMvKrKY@bombadil.infradead.org>
References: <20220718002645.28817-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220718002645.28817-1-fmdefrancesco@gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 02:26:45AM +0200, Fabio M. De Francesco wrote:
> kmap() is being deprecated in favor of kmap_local_page().
> 
> Two main problems with kmap(): (1) It comes with an overhead as mapping
> space is restricted and protected by a global lock for synchronization and
> (2) it also requires global TLB invalidation when the kmap’s pool wraps
> and it might block when the mapping space is fully utilized until a slot
> becomes available.

Neat!

> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).

Yes but the mapping can only be accessed from within this thread and the
thread is bound to the CPU while the mapping is active. So, what if we
get a preemption during decompression here? What happens?

> It is faster than kmap() in kernels with HIGHMEM enabled. Its use in
> module_gzip_decompress() and in module_xz_decompress() is safe and
> should be preferred.
> 
> Therefore, replace kmap() with kmap_local_page().

While this churn is going on everywhere I was wondering why not
go ahead and adopt kmap_local_folio() instead?

  Luis

> Tested on a QEMU/KVM x86_32 VM with 4GB RAM, booting kernels with
> HIGHMEM64GB enabled. Modules compressed with XZ or GZIP decompress
> properly.
> 
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  kernel/module/decompress.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/module/decompress.c b/kernel/module/decompress.c
> index 2fc7081dd7c1..4d0bcb3d9e44 100644
> --- a/kernel/module/decompress.c
> +++ b/kernel/module/decompress.c
> @@ -119,10 +119,10 @@ static ssize_t module_gzip_decompress(struct load_info *info,
>  			goto out_inflate_end;
>  		}
>  
> -		s.next_out = kmap(page);
> +		s.next_out = kmap_local_page(page);
>  		s.avail_out = PAGE_SIZE;
>  		rc = zlib_inflate(&s, 0);
> -		kunmap(page);
> +		kunmap_local(s.next_out);
>  
>  		new_size += PAGE_SIZE - s.avail_out;
>  	} while (rc == Z_OK);
> @@ -178,11 +178,11 @@ static ssize_t module_xz_decompress(struct load_info *info,
>  			goto out;
>  		}
>  
> -		xz_buf.out = kmap(page);
> +		xz_buf.out = kmap_local_page(page);
>  		xz_buf.out_pos = 0;
>  		xz_buf.out_size = PAGE_SIZE;
>  		xz_ret = xz_dec_run(xz_dec, &xz_buf);
> -		kunmap(page);
> +		kunmap_local(xz_buf.out);
>  
>  		new_size += xz_buf.out_pos;
>  	} while (xz_buf.out_pos == PAGE_SIZE && xz_ret == XZ_OK);
> -- 
> 2.37.1
> 
